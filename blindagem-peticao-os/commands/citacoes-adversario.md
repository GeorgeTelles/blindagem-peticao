---
description: Só a camada de citações — cada súmula, tema e acórdão da peça adversária conferido com fetch real na fonte.
---

# /citacoes-adversario

Extrai **todas** as citações de jurisprudência da peça recebida e confere cada uma contra a fonte
oficial, com o motor anti-alucinação do `juris-adv-os`: WebFetch real na URL, número do processo na
página, trecho de ementa presente. Status ✅ VALIDADA · ⚠️ PARCIAL · 🔴 NÃO ENCONTRADA · ⬜ NÃO
VERIFICADA (falha técnica de fetch — nunca vira 🔴 por palpite) — **nunca ✅ sem fetch
bem-sucedido** (trava T2).

**Skill a acionar:** `citacoes-da-peca-recebida`

Complementos no mesmo passo: `dispositivos-da-peca-recebida` (artigos/leis citados conferidos contra
fonte oficial — pega "base de lei criada" e teor deturpado).

Um 🔴 confirmado aqui é munição: o padrão de sanção já está consolidado (TST 1% · TJ/PR 2% · TJSC ·
TSE — multa + ofício à OAB/MPF por padrão, CPC arts. 79-81; ver `context/casos-ancora-sancoes.md`). Para transformar em
tópico de peça: `gerador-topico-impugnacao`.
