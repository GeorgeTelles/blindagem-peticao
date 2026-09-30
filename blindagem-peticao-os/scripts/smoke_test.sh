#!/usr/bin/env bash
#
# smoke_test.sh — Controle POSITIVO e NEGATIVO dos parsers de integridade.
#
# Disciplina "verificar com isca antes de confiar no silencio": um parser que nao
# acha nada so vale depois de provar, num controle negativo, que ele acharia se
# houvesse. Este smoke roda gerar_isca.py, depois cada parser contra a isca (deve
# ACHAR) e contra o controle limpo (deve dar total_achados 0).
#
# USO (a partir da raiz do plugin OU de qualquer lugar):
#     bash scripts/smoke_test.sh
#
# Sai com 0 se todos os checks passarem; 1 se qualquer um falhar.

set -u

# raiz do plugin = pasta-mae do diretorio deste script
AQUI="$(cd "$(dirname "$0")" && pwd)"
RAIZ="$(cd "$AQUI/.." && pwd)"
cd "$RAIZ"

PY="python3"
SCR="scripts"
FIX="scripts/fixtures"
OUT="$(mktemp -d)"
FAILS=0

trap 'rm -rf "$OUT"' EXIT

echo "== blindagem-peticao-os :: smoke dos parsers =="
echo "raiz: $RAIZ"
echo

# ---------------------------------------------------------------------------
# 0. gerar as fixtures
# ---------------------------------------------------------------------------
if ! $PY "$SCR/gerar_isca.py" > "$OUT/gerar.log" 2>&1; then
    echo "FAIL: gerar_isca.py nao rodou"
    cat "$OUT/gerar.log"
    exit 1
fi
echo "PASS: gerar_isca.py gerou as fixtures"

# helpers -------------------------------------------------------------------
run() {  # run <parser.py> <arquivo> <nome_saida> [args...]
    local parser="$1"; local arq="$2"; local nome="$3"; shift 3
    $PY "$SCR/$parser" "$arq" "$@" > "$OUT/$nome" 2> "$OUT/$nome.err"
}

assert_contem() {  # assert_contem <desc> <nome_saida> <padrao>
    if grep -qF "$3" "$OUT/$2"; then
        echo "PASS: $1"
    else
        echo "FAIL: $1  (esperava conter: $3)"
        echo "      --- saida ($2) ---"
        sed 's/^/      /' "$OUT/$2"
        FAILS=$((FAILS + 1))
    fi
}

# ---------------------------------------------------------------------------
# 1. isca.pdf -> pdf_integridade deve achar TEXTO BRANCO/OCULTO e CONTEUDO ATIVO
# ---------------------------------------------------------------------------
run "pdf_integridade.py" "$FIX/isca.pdf" "pdf_isca.json"
assert_contem "isca.pdf: pdf_integridade status ok"       "pdf_isca.json" '"status": "ok"'
assert_contem "isca.pdf: acha texto oculto"                "pdf_isca.json" '"tipo": "texto_oculto"'
assert_contem "isca.pdf: acha conteudo ativo (/OpenAction/JS)" "pdf_isca.json" '"tipo": "conteudo_ativo"'

# ---------------------------------------------------------------------------
# 2. isca.docx -> unicode_scan acha os 3 plantados; metadados acha autor+comentario
# ---------------------------------------------------------------------------
run "unicode_scan.py" "$FIX/isca.docx" "uni_isca.json"
assert_contem "isca.docx: unicode_scan acha zero-width/invisivel" "uni_isca.json" '"tipo": "zero_width_ou_invisivel"'
assert_contem "isca.docx: unicode_scan acha Tags (ASCII smuggling)" "uni_isca.json" '"tipo": "tag_ascii_smuggling"'
assert_contem "isca.docx: unicode_scan acha homoglifo"            "uni_isca.json" '"tipo": "homoglifo"'

run "metadados.py" "$FIX/isca.docx" "meta_isca.json"
assert_contem "isca.docx: metadados acha autor interno"           "meta_isca.json" '"tipo": "autor"'
assert_contem "isca.docx: metadados acha comentarios internos"    "meta_isca.json" '"tipo": "comentarios_internos"'

# ---------------------------------------------------------------------------
# 3. CONTROLES LIMPOS -> total_achados 0 (unicode / oculto)
# ---------------------------------------------------------------------------
run "unicode_scan.py" "$FIX/controle_limpo.txt" "uni_ctrl_txt.json"
assert_contem "controle.txt: unicode_scan total_achados 0"        "uni_ctrl_txt.json" '"total_achados": 0'

run "unicode_scan.py" "$FIX/controle_limpo.docx" "uni_ctrl_docx.json"
assert_contem "controle.docx: unicode_scan total_achados 0"       "uni_ctrl_docx.json" '"total_achados": 0'

run "pdf_integridade.py" "$FIX/controle_limpo.pdf" "pdf_ctrl.json"
assert_contem "controle.pdf: pdf_integridade status ok"           "pdf_ctrl.json" '"status": "ok"'
assert_contem "controle.pdf: pdf_integridade total_achados 0"     "pdf_ctrl.json" '"total_achados": 0'

# ---------------------------------------------------------------------------
# 4. hash_check basico + divergencia declarada
# ---------------------------------------------------------------------------
run "hash_check.py" "$FIX/isca.pdf" "hash_isca.json"
assert_contem "isca.pdf: hash_check emite sha256"                 "hash_isca.json" '"tipo": "hash"'

$PY "$SCR/hash_check.py" "$FIX/isca.pdf" --declarado deadbeef > "$OUT/hash_div.json" 2>&1
assert_contem "hash divergente vira ALERTA (nao fraude)"          "hash_div.json" '"tipo": "hash_divergente"'

# ---------------------------------------------------------------------------
# 5. arquivo inexistente -> JSON de erro limpo (sem traceback), status error
# ---------------------------------------------------------------------------
$PY "$SCR/pdf_integridade.py" "$FIX/nao_existe.pdf" > "$OUT/err_pdf.json" 2>&1
assert_contem "arquivo inexistente: status error limpo"          "err_pdf.json" '"status": "error"'
if grep -qF "Traceback" "$OUT/err_pdf.json"; then
    echo "FAIL: arquivo inexistente vazou traceback cru"
    FAILS=$((FAILS + 1))
else
    echo "PASS: arquivo inexistente nao vazou traceback"
fi

# ---------------------------------------------------------------------------
echo
if [ "$FAILS" -eq 0 ]; then
    echo "== TODOS OS CHECKS PASSARAM =="
    exit 0
else
    echo "== $FAILS CHECK(S) FALHARAM =="
    exit 1
fi
