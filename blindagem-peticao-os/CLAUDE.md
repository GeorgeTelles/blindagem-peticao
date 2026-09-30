# blindagem-peticao-os — regras internas

## Identidade
**Ferramenta** de triagem de integridade de peça processual (padrão `calculosjudiciais-adv-os`: motor
determinístico + auditoria, não domínio jurídico). Dois usos, comunicados desde a primeira tela:
**defesa** (a peça que chegou da parte contrária) e **prevenção** (a sua, antes do protocolo).
Público: advogado individual **+ departamento jurídico PJ**. Orquestrador `blindagem-master`.
20 skills em 6 camadas. Autoria "IA Combativa".

## Invioláveis (as 8 travas — `context/travas-blindagem.md`)
1. **Nenhum selo de achado estrutural sem o parser ter rodado** e retornado o dado bruto — nunca
   "parece suspeito" por leitura do LLM. Parser não disponível → a skill DECLARA que não varreu.
2. **Nenhuma citação recebe ✅/🔴 sem WebFetch real** (herda a trava do `juris-adv-os` sem exceção).
3. **Nunca** "detectamos que foi escrito por IA", nunca score %, nunca "confirmamos a marca d'água"
   (API de detecção da Anthropic não é pública). Sinal heurístico, rotulado como tal, sempre.
4. **Hash divergente e metadado estranho = alerta, nunca veredito de fraude** — fraude é conclusão
   jurídica/pericial, não técnica.
5. **Conferência humana final é do advogado** — aviso em toda entrega.
6. **Fronteira com o prisma:** blindagem nunca avalia se tese/citação real convence ou como o juiz
   decide — só se é íntegra e verdadeira (integridade × mérito).
7. **Res. CNJ 615/2025 rege o Judiciário, não o advogado** — nunca vender "conformidade CNJ";
   PL 2338/2023 não é citado como lei vigente sem confirmação primária.
8. **O produto não é o Galileu nem o STJ Logos** — sem integração ou reconhecimento oficial de
   tribunal; dito com todas as letras.

## Motor — determinístico decide, LLM julga (nunca o contrário)
Parsers em `scripts/` (contrato: `python3 "${CLAUDE_PLUGIN_ROOT}/scripts/<parser>.py" <arquivo>` →
JSON no stdout com `status: ok | missing_dependency | error | formato_nao_suportado` +
`achados[]`). Cadeia com degradação graciosa
(`pikepdf` → `PyMuPDF` → `pdfplumber`; DOCX via stdlib). Sem lib → `missing_dependency` com
instrução de instalação — **nunca finge ter varrido**. O LLM entra só onde é julgamento: intenção
do comando achado, relevância da divergência, nexo citação-tese, redação do dossiê.

## Defasagem (`context/travas-defasagem.md` — governa o `validador-blindagem-vigente`)
Marca d'água Anthropic (12/08/2026, só Claude, API não pública) · Res. CNJ 615/2025 (atualizou a
332/2020) · CPC 77/79-81 e CP 299/347 verbatim nos anexos · acurácia de detector comercial nunca
citada como fato · casos-âncora só com número confirmado.

## Fronteiras — apontar, nunca duplicar
`prisma-julgador` (a fronteira central: integridade × mérito — blindagem nunca avalia persuasão;
prisma nunca declara autenticidade) · `juris-adv-os` (motor de validação reaproveitado — juris audita
a SUA citação; blindagem roda o rigor na peça RECEBIDA) · `civel-adv-os` (incidente de má-fé como
peça completa) · `criminal-adv-os` (fraude processual como crime) · `calculosjudiciais-adv-os`
(padrão parser; cálculo de multa).

## Regras técnicas de plugin
- Pasta de skill contém **apenas** `SKILL.md`.
- `SKILL.md` ≤ 11.264 bytes · `description` ≤ 1024 caracteres.
- `hooks.json` no schema **WRAPPED** com `SessionStart` rodando `echo` — **nunca `python`**.
- `plugin.json` com os 4 campos canônicos.
- PT-BR com acentuação correta em todo conteúdo.

## Gate antes de qualquer entrega
`bash PLAYBOOK/templates/gate-cowork.sh plugin-blindagem <marketplace>` — FAIL não empacota.
+ smoke dos parsers com **PDF-isca** (controle positivo: o parser tem que ACHAR a fonte branca e o
unicode plantados — "verificar com isca antes de confiar no silêncio").
