#!/bin/bash
# ─────────────────────────────────────────────────────────────
#  commit-entrainmind.command
#  Duplo-clique no Finder para: bumpar a versão do cache no
#  sw.js, revisar as mudanças e enviar o commit para o GitHub.
#
#  Repositório: ~/Projetos/entrainmind (ajuste REPO_DIR se mudar)
# ─────────────────────────────────────────────────────────────

REPO_DIR="$HOME/Projetos/entrainmind"

# Cor(es) para deixar a saída mais legível no Terminal
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}  EntrainMind — commit assistido${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo ""

# ── 1. Localizar o repositório ─────────────────────────────
if [ ! -d "$REPO_DIR" ]; then
  echo -e "${RED}✗ Pasta não encontrada: $REPO_DIR${NC}"
  echo "  Edite a variável REPO_DIR no início deste script se o"
  echo "  projeto estiver em outro caminho."
  echo ""
  read -p "Pressione Enter para fechar..."
  exit 1
fi

cd "$REPO_DIR" || exit 1

if [ ! -d ".git" ]; then
  echo -e "${RED}✗ Esta pasta não é um repositório git: $REPO_DIR${NC}"
  read -p "Pressione Enter para fechar..."
  exit 1
fi

echo -e "${GREEN}✓${NC} Repositório: $REPO_DIR"
echo ""

# ── 2. Nada para commitar? avisa e sai ─────────────────────
if [ -z "$(git status --porcelain)" ]; then
  echo -e "${YELLOW}Nenhuma mudança detectada — nada para commitar.${NC}"
  echo ""
  read -p "Pressione Enter para fechar..."
  exit 0
fi

echo "Mudanças detectadas:"
git status --short
echo ""

# ── 3. Bump automático da versão de cache no sw.js ─────────
if [ -f "sw.js" ]; then
  CURRENT=$(grep -oE "entrainmind-v[0-9]+" sw.js | head -1)
  if [ -n "$CURRENT" ]; then
    NUM=$(echo "$CURRENT" | grep -oE "[0-9]+$")
    NEXT=$((NUM + 1))
    read -p "Bumpar cache do sw.js de v$NUM para v$NEXT? [S/n] " BUMP
    BUMP=${BUMP:-S}
    if [[ "$BUMP" =~ ^[SsYy]$ ]]; then
      # sed -i '' é a sintaxe do BSD sed (macOS); GNU sed usaria só -i
      sed -i '' "s/entrainmind-v${NUM}/entrainmind-v${NEXT}/g" sw.js
      echo -e "${GREEN}✓${NC} sw.js atualizado para entrainmind-v${NEXT}"
    else
      echo -e "${YELLOW}⚠${NC}  Pulei o bump — lembre de fazer manualmente se necessário."
    fi
  else
    echo -e "${YELLOW}⚠${NC}  Não encontrei o padrão 'entrainmind-vN' em sw.js — pulei o bump automático."
  fi
  echo ""
fi

# ── 4. Mensagem de commit ──────────────────────────────────
DEFAULT_MSG="Atualização $(date '+%Y-%m-%d %H:%M')"
read -p "Mensagem do commit [Enter para usar: '$DEFAULT_MSG']: " MSG
MSG=${MSG:-$DEFAULT_MSG}

# ── 5. Commit + push ───────────────────────────────────────
git add -A
git commit -m "$MSG"

if [ $? -ne 0 ]; then
  echo -e "${RED}✗ Commit falhou — confira a mensagem acima.${NC}"
  read -p "Pressione Enter para fechar..."
  exit 1
fi

echo ""
echo "Enviando para o GitHub..."
git push

if [ $? -eq 0 ]; then
  echo ""
  echo -e "${GREEN}✓ Commit e push concluídos com sucesso!${NC}"
  echo "  O GitHub Pages deve atualizar em ~1 minuto."
else
  echo ""
  echo -e "${RED}✗ Push falhou — confira a mensagem acima${NC}"
  echo "  (autenticação expirada? sem internet? conflito remoto?)"
fi

echo ""
read -p "Pressione Enter para fechar..."
