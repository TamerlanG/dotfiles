---
description: Explain a topic as a self-contained HTML page and open it
argument-hint: "<topic, PR, file, or 'the problem'>"
---

Explain this for me: $ARGUMENTS
If the topic is empty or refers to "this", explain what we are currently discussing.

Research it in the code first. Then write one self-contained HTML file to a temporary path (inline CSS, no external assets) that covers:
- the problem or purpose, in plain words, at the top
- how it works, with a diagram where structure matters
- the key code paths, with file:line references
- tradeoffs or open questions

Keep it readable for a human skimming it. Open it with `open <file>` and give me the path.
