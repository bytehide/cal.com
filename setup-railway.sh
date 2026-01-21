#!/bin/bash

# 🚂 ByteHide Meetings - Setup Rápido para Railway
# Este script te ayuda a configurar el repositorio para deployment

set -e  # Salir en caso de error

echo "🚂 ByteHide Meetings - Setup para Railway"
echo "=========================================="
echo ""

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar que estamos en el directorio correcto
if [ ! -f "railway.json" ]; then
    echo -e "${RED}❌ Error: railway.json no encontrado${NC}"
    echo "Ejecuta este script desde la raíz del proyecto cal.com"
    exit 1
fi

echo -e "${BLUE}📋 Verificando configuración actual...${NC}"
echo ""

# Verificar git remote actual
CURRENT_REMOTE=$(git remote get-url origin 2>/dev/null || echo "none")
echo -e "Git remote actual: ${YELLOW}${CURRENT_REMOTE}${NC}"
echo ""

# Preguntar qué tipo de setup quiere hacer
echo -e "${BLUE}¿Cómo quieres configurar tu repositorio?${NC}"
echo ""
echo "1) Fork - Crear fork del repo oficial (recomendado)"
echo "2) Nuevo repo - Repositorio completamente independiente"
echo "3) Saltar - Ya tengo mi repo configurado"
echo ""
read -p "Selecciona una opción (1-3): " REPO_OPTION

case $REPO_OPTION in
    1)
        echo ""
        echo -e "${YELLOW}⚠️  PRIMERO debes crear el fork en GitHub:${NC}"
        echo "   1. Ve a https://github.com/calcom/cal.com"
        echo "   2. Click en 'Fork' (esquina superior derecha)"
        echo "   3. Espera a que se cree el fork"
        echo ""
        read -p "Tu usuario de GitHub: " GH_USER

        if [ -z "$GH_USER" ]; then
            echo -e "${RED}❌ Usuario no puede estar vacío${NC}"
            exit 1
        fi

        FORK_URL="https://github.com/${GH_USER}/cal.com.git"

        echo ""
        echo -e "${BLUE}Configurando fork...${NC}"

        # Renombrar origin a upstream
        git remote rename origin upstream 2>/dev/null || true

        # Agregar fork como origin
        git remote add origin "$FORK_URL" 2>/dev/null || git remote set-url origin "$FORK_URL"

        echo -e "${GREEN}✅ Fork configurado correctamente${NC}"
        ;;

    2)
        echo ""
        echo -e "${YELLOW}⚠️  PRIMERO debes crear el repo en GitHub:${NC}"
        echo "   1. Ve a https://github.com/new"
        echo "   2. Crea un repo nuevo (ej: bytehide-cal)"
        echo "   3. NO inicialices con README"
        echo ""
        read -p "URL de tu nuevo repo (ej: https://github.com/usuario/bytehide-cal.git): " NEW_REPO_URL

        if [ -z "$NEW_REPO_URL" ]; then
            echo -e "${RED}❌ URL no puede estar vacía${NC}"
            exit 1
        fi

        echo ""
        echo -e "${BLUE}Configurando nuevo repo...${NC}"

        # Eliminar origin actual
        git remote remove origin 2>/dev/null || true

        # Agregar nuevo repo
        git remote add origin "$NEW_REPO_URL"

        echo -e "${GREEN}✅ Nuevo repo configurado correctamente${NC}"
        ;;

    3)
        echo ""
        echo -e "${GREEN}✅ Saltando configuración de repo${NC}"
        ;;

    *)
        echo -e "${RED}❌ Opción inválida${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${BLUE}📦 Verificando archivos necesarios...${NC}"

# Verificar archivos
FILES=(
    "railway.json"
    ".env.railway"
    "RAILWAY_DEPLOYMENT.md"
    "CUSTOMIZATION_GUIDE.md"
    "GIT_SETUP.md"
    "Dockerfile"
)

ALL_OK=true
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅${NC} $file"
    else
        echo -e "${RED}❌${NC} $file (faltante)"
        ALL_OK=false
    fi
done

echo ""

if [ "$ALL_OK" = false ]; then
    echo -e "${RED}❌ Algunos archivos necesarios no existen${NC}"
    exit 1
fi

# Preguntar si quiere commitear cambios
echo ""
echo -e "${BLUE}¿Quieres commitear y pushear ahora?${NC}"
read -p "(y/n): " COMMIT_NOW

if [ "$COMMIT_NOW" = "y" ] || [ "$COMMIT_NOW" = "Y" ]; then
    echo ""
    echo -e "${BLUE}📝 Commiteando cambios...${NC}"

    git add .
    git status

    echo ""
    read -p "Mensaje de commit (Enter para usar default): " COMMIT_MSG

    if [ -z "$COMMIT_MSG" ]; then
        COMMIT_MSG="feat: setup Railway deployment for ByteHide Meetings"
    fi

    git commit -m "$COMMIT_MSG" || echo "No hay cambios para commitear"

    echo ""
    echo -e "${BLUE}🚀 Pusheando a GitHub...${NC}"
    git push -u origin main || git push origin main

    echo ""
    echo -e "${GREEN}✅ Código pusheado exitosamente!${NC}"
fi

# Resumen final
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✅ Setup Completado!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${BLUE}📚 Próximos pasos:${NC}"
echo ""
echo "1. 🎨 (Opcional) Customiza branding:"
echo "   - Ver CUSTOMIZATION_GUIDE.md"
echo "   - Edita logos en apps/web/public/"
echo "   - Edita colores en packages/platform/atoms/globals.css"
echo ""
echo "2. 🚂 Deploy en Railway:"
echo "   - Ve a https://railway.app"
echo "   - New → GitHub Repo"
echo "   - Selecciona tu repositorio"
echo "   - Configura variables (ver .env.railway)"
echo "   - Railway deployará automáticamente"
echo ""
echo "3. 📖 Documentación completa:"
echo "   - DEPLOYMENT_README.md (overview)"
echo "   - RAILWAY_DEPLOYMENT.md (paso a paso)"
echo "   - CUSTOMIZATION_GUIDE.md (branding)"
echo ""
echo -e "${YELLOW}⚡ Tiempo estimado de deployment: 10-15 minutos${NC}"
echo ""
echo -e "${GREEN}¡Éxito! 🎉${NC}"
echo ""
