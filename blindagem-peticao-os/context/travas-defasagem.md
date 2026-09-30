# Travas de defasagem — o `validador-blindagem-vigente`

> Distintas das travas invioláveis (`travas-blindagem.md`): estas pegam "o fato mudou e o modelo
> não sabe" — a marca d'água é de 6 dias antes da pesquisa, a norma do CNJ foi atualizada, o texto
> de lei tem de bater com a captura. Cada uma tem origem na DESIGN-SPEC §7 (19/08/2026) e na
> pesquisa-meta de 18/08/2026.

| # | Trava | Origem |
|---|---|---|
| **TV1** | **Marca d'água Anthropic:** existe (12/08/2026), só Claude pós-02/08/2026, edição pesada remove, ruim em texto curto/factual, **API de terceiros NÃO pública** — reavaliar a cada release; qualquer mudança é 🔴 até confirmada em fonte primária | pesquisa §1.1 |
| **TV2** | **Res. CNJ 615/2025 atualizou a 332/2020** — citar a 615 como norma vigente de IA no Judiciário, nunca a 332 sozinha | pesquisa §4.1 |
| **TV3** | **CPC arts. 77, 79-81 verbatim** contra `context/` no build (reusar captura do `civel-adv-os`/`execucao-adv-os`) — a pesquisa confirmou teor por busca, não por fetch | pesquisa §3.3 |
| **TV4** | **CP arts. 299 e 347 verbatim** contra `context/` do `criminal-adv-os` no build | pesquisa §3.3 |
| **TV5** | Números de acurácia de detectores comerciais (GPTZero etc.) são **inconsistentes entre estudos** — nunca citar acurácia de vendor como fato | pesquisa §1.2 |
| **TV6** | Casos-âncora só com o que está confirmado: TRT-8 ATOrd 0001062-55.2025.5.08.0130 (10%, ~R$ 84,2 mil) · TJ/PR 0108267-74.2025.8.16.0000 (2%) · TST 6ª Turma (1%) · TSE (R$ 2 mil + 9 condenações). **TJSC sem número de processo coletado → citar sem número ou localizar no build** | pesquisa §3.2 |
| **TV7** | Grep de frase literal contra `context/` normaliza espaço (Planalto quebra linha no meio da frase); âncora de caput, não última ocorrência | herança opositor TV10 |

**Status de TV3/TV4 neste build (19/08/2026): CUMPRIDAS.** Os anexos `cpc-litigancia-ma-fe.md` e
`cp-falsidade-fraude.md` deste `context/` foram copiados verbatim das capturas verificadas do
`civel-adv-os` (`cpc-13105-15.md`) e do `criminal-adv-os` (`cp-2848-40.md`), com verificação por
grep de trecho literal contra a fonte + controle negativo.
