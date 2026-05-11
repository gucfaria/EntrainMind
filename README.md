# EntrainMind

**Ferramenta de neuromodulação multimodal**

Flicker fótico + ruído AM + binaural beats — PWA configurável e offline.

![EntrainMind icon](icon-192.png)

## Funcionalidades

- **Flicker visual** em qualquer frequência 1–40 Hz via `requestAnimationFrame`
- **Tipos de ruído:** branco, rosa (−3 dB/oitava), marrom (−6 dB/oitava)
- **Modulação AM** do ruído na frequência selecionada (profundidade ajustável)
- **Binaural beats** — portadora 200 Hz esquerdo / 200+f Hz direito
- **Cores de flicker:** branco, âmbar (luz azul reduzida), vermelho (luz azul mínima)
- **6 presets de uso:** TDAH/Foco · Meditação · Relaxamento · Sono · Gamma · 40Hz Pesquisa
- **2 slots personalizados** salvos localmente
- **Timer infinito** com cronômetro progressivo
- **Histórico de sessões** com feedback pós-sessão
- Roda inteiramente no browser — sem servidor, sem backend
- Instalável como PWA (iOS Safari: Compartilhar → Adicionar à Tela de Início)

## Acesso

### GitHub Pages

**App:** `https://gucfaria.github.io/EntrainMind/entrainmind.html`

**Manual:** `https://gucfaria.github.io/EntrainMind/manual.html`

No iOS: **Compartilhar → Adicionar à Tela de Início** para instalar como app.

### Local (via a-Shell no iPhone)

```bash
cd ~/Documents
python -m http.server 8080
```

Abrir `http://localhost:8080/entrainmind.html` no Chrome.

## ⚠️ Segurança

**Epilepsia fotossensível:** não use o flicker se você ou familiares têm epilepsia ou histórico de convulsões.

Interrompa se sentir desconforto, tontura ou náusea.

Modo binaural requer fones de ouvido.

## Arquivos

| Arquivo | Descrição |
|---------|-----------|
| `entrainmind.html` | Aplicação principal |
| `manual.html` | Manual de uso |
| `manifest.json` | PWA manifest |
| `sw.js` | Service Worker (cache offline) |
| `icon-192.png` | Ícone PWA 192×192 |
| `icon-512.png` | Ícone PWA 512×512 |

## Contexto científico

Baseado em Woods et al. (2024, *Communications Biology*) — estimulação sensorial rítmica a 16 Hz em indivíduos com pontuação elevada na ASRS.

Protocolo gamma (40 Hz) inspirado em Tsai et al. (2016, *Nature*) — GENUS.

## Licença

MIT — uso pessoal e clínico experimental permitido.

---
*Criado por Gustavo C. de Faria — gucfaria@me.com*
