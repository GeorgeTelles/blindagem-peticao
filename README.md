# Blindagem de Petição OS — Marketplace

**Triagem de integridade de peça processual com IA** — audite a petição recebida da parte
contrária, e a sua antes do protocolo.

## O que o plugin faz

1. **Texto oculto / prompt injection** — fonte branca, corpo mínimo, comando escondido dirigido a
   sistema de IA (parsing local determinístico; caso real já sancionado na Justiça do Trabalho).
2. **Unicode invisível e homóglifos** — caracteres invisíveis e trocas de alfabeto que enganam
   filtros.
3. **Jurisprudência inventada** — cada citação da peça adversária conferida com fetch real na fonte
   oficial (padrão de sanção já consolidado nos tribunais: multas de 1% a 10% do valor da causa).
4. **Dispositivo de lei inexistente ou deturpado** — artigo conferido contra a fonte oficial.
5. **Metadados e anexos** — autor real ≠ assinante, revisões esquecidas, hash divergente.
6. **Gaps da tese** — o que a peça deixou de enfrentar, pronto para virar tópico de impugnação.

**Honestidade técnica por design:** o produto sinaliza com evidência — **não** é "detector de IA"
(não existe detector confiável, e é dito com todas as letras no manual). Parser determinístico
decide o fato; o advogado conclui o direito.

## Instalação (Claude Cowork / Claude Code)

1. Abra **Settings → Plugins**.
2. Na aba **Pessoal**, clique **"+"** (Uploads locais / Adicionar marketplace).
3. Cole a URL deste repositório.
4. Instale o plugin `blindagem-peticao-os` e abra uma nova conversa.

## Uso

- `/blindagem` — triagem completa da peça recebida
- `/blindagem-propria` — auditoria da sua peça antes do protocolo
- `/citacoes-adversario` — só a camada de citações
- `/dossie-integridade` — relatório final consolidado

---

© IA Combativa. Conferência humana final é sempre do advogado responsável.
