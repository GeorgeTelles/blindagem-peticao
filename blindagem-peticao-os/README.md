# blindagem-peticao-os

**Triagem de integridade da peça processual — o que está escondido, inventado ou fora de contexto,
antes de você responder.**

Chegou uma petição inicial, contestação ou recurso da parte contrária? Antes de gastar horas
respondendo, rode a triagem:

1. **Texto oculto / prompt injection** — fonte branca, corpo mínimo, comando escondido dirigido à IA
   do tribunal ou à sua (caso real: multa de ~R$ 84 mil no TRT-8).
2. **Unicode invisível e homóglifos** — caracteres que o olho não vê e o filtro não pega.
3. **Jurisprudência inventada** — cada citação da peça adversária conferida com fetch real na fonte
   (padrão consolidado de sanção em TST, TJ/PR, TJSC e TSE — multa + ofício à OAB/MPF por padrão;
   multas observadas nos casos-âncora de 1% a 10% do valor da causa, o intervalo do CPC art. 81).
4. **Dispositivo de lei inexistente ou deturpado** — artigo conferido contra a fonte oficial.
5. **Metadados e anexos** — autor real ≠ assinante, revisões esquecidas, hash divergente.
6. **Gaps da tese** — o que a peça deixou de enfrentar, mapeado para a sua peça de resposta
   (análise estratégica, rotulada como tal — não fundamenta pedido de multa).

E antes de protocolar a **sua** peça: `/blindagem-propria` roda as mesmas varreduras + higiene de
metadados.

**Honestidade técnica por design:** o produto **sinaliza com evidência** — nunca vende "detector de
IA" (não existe detector confiável, e a marca d'água da Anthropic não tem API pública). Parser
determinístico decide o fato; você conclui o direito.

## Instalação

Via marketplace público (Settings → Plugins → colar a URL do repositório do marketplace).

## Uso

- `/blindagem` — triagem completa da peça recebida
- `/blindagem-propria` — auditoria da sua peça antes do protocolo
- `/citacoes-adversario` — só a camada de citações
- `/dossie-integridade` — consolida os achados no relatório final

---

© IA Combativa — uso conforme licença. Conferência humana final é sempre do advogado.
