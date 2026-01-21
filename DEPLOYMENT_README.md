# 🚀 ByteHide Meetings - Deployment en Railway

Este repositorio está listo para deployar en Railway con tu branding customizado.

## 📁 Archivos Importantes Creados

| Archivo | Descripción |
|---------|-------------|
| `railway.json` | ✅ Configuración de deployment para Railway |
| `.env.railway` | 📝 Template con tus variables de entorno actuales |
| `GIT_SETUP.md` | 🔧 Guía para configurar tu repositorio en GitHub |
| `RAILWAY_DEPLOYMENT.md` | 🚂 Guía completa de deployment paso a paso |
| `CUSTOMIZATION_GUIDE.md` | 🎨 Guía detallada para customizar logos y colores |

## 🎯 Pasos Rápidos

### 1️⃣ Configurar Repositorio Git (PRIMERO)

El repo actual apunta a `calcom/cal.com`. Necesitas tu propio repo:

```bash
# Opción A: Fork (recomendado)
# 1. Haz fork en GitHub: https://github.com/calcom/cal.com
# 2. Ejecuta:
git remote rename origin upstream
git remote add origin https://github.com/TU_USUARIO/cal.com.git
git push -u origin main

# Opción B: Nuevo repo (independiente)
# 1. Crea repo nuevo en GitHub
# 2. Ejecuta:
git remote remove origin
git remote add origin https://github.com/TU_USUARIO/bytehide-cal.git
git push -u origin main
```

Ver detalles completos en: **`GIT_SETUP.md`**

### 2️⃣ Customizar Branding (Opcional)

Si quieres cambiar logos y colores:

#### Logos
```bash
# Reemplaza estos archivos (mantén los nombres):
apps/web/public/cal-logo-word.svg          → Tu logo
apps/web/public/cal-com-icon.svg           → Tu icono
apps/web/public/favicon.ico                → Tu favicon
apps/web/public/apple-touch-icon.png       → Icono iOS
apps/web/public/android-chrome-512x512.png → Icono Android
```

#### Colores
Edita `packages/platform/atoms/globals.css` (línea ~10056):

```css
/* Modo Claro */
:root {
  --cal-brand: #3B82F6;           /* Tu color principal */
  --cal-brand-emphasis: #2563EB;  /* Variante oscura */
  --cal-brand-text: #FFFFFF;
}

/* Modo Oscuro (línea ~10162) */
:is(.dark *) {
  --cal-brand: #60A5FA;
  --cal-brand-emphasis: #3B82F6;
  --cal-brand-text: #000000;
}
```

Ver detalles completos en: **`CUSTOMIZATION_GUIDE.md`**

### 3️⃣ Commit y Push

```bash
# Si hiciste cambios de branding
git add .
git commit -m "feat: customize ByteHide branding"
git push origin main
```

### 4️⃣ Deploy en Railway

1. **Railway Dashboard** → **New** → **GitHub Repo**
2. Selecciona tu repositorio
3. Railway detecta `Dockerfile` automáticamente
4. **Configura Variables** (pestaña "Variables"):

   Copia las de `.env.railway` o usa estas directamente:

   ```bash
   DATABASE_URL=${{Postgres.DATABASE_URL}}
   DATABASE_DIRECT_URL=${{Postgres.DATABASE_URL}}
   DATABASE_HOST=${{Postgres.PGHOST}}:${{Postgres.PGPORT}}
   NEXTAUTH_SECRET=<genera-con-openssl-rand-base64-32>
   CALENDSO_ENCRYPTION_KEY=<genera-con-openssl-rand-base64-32>
   NEXT_PUBLIC_WEBAPP_URL=https://${{RAILWAY_PUBLIC_DOMAIN}}
   NEXT_PUBLIC_APP_NAME=ByteHide Meetings
   NEXT_PUBLIC_COMPANY_NAME=ByteHide
   NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS=support@bytehide.com
   NEXT_PUBLIC_WEBSITE_PRIVACY_POLICY_URL=https://bytehide.com/privacy
   NEXT_PUBLIC_WEBSITE_TERMS_URL=https://bytehide.com/terms
   NEXT_PUBLIC_LICENSE_CONSENT=agree
   NEXT_PUBLIC_DISABLE_SIGNUP=true
   ORGANIZATIONS_ENABLED=true
   NEXT_PUBLIC_SINGLE_ORG_SLUG=false
   CALCOM_TELEMETRY_DISABLED=false
   MAX_OLD_SPACE_SIZE=4096
   PORT=3000
   GOOGLE_API_CREDENTIALS={"web":{...}}  # Tu config actual
   ```

5. **Deploy** → Railway build automáticamente
6. **Monitorea logs** en Deployments → View Logs
7. **Verifica** cuando esté Active

Ver detalles completos en: **`RAILWAY_DEPLOYMENT.md`**

---

## ⏱️ Tiempo Estimado

- **Configurar Git:** 2 minutos
- **Customizar branding:** 15-30 minutos (opcional)
- **Configurar Railway:** 5 minutos
- **Build & Deploy:** 10-15 minutos (automático)

**Total:** ~30-50 minutos (con customización)

---

## 📚 Documentación Completa

| Guía | Cuándo Usarla |
|------|---------------|
| `GIT_SETUP.md` | **PRIMERO** - Configurar tu repo en GitHub |
| `RAILWAY_DEPLOYMENT.md` | Deployment paso a paso en Railway |
| `CUSTOMIZATION_GUIDE.md` | Personalizar logos, colores, fuentes |
| `.env.railway` | Referencia de variables de entorno |

---

## ✅ Checklist Pre-Deployment

- [ ] Repo configurado en GitHub (tu usuario, no calcom/cal.com)
- [ ] Logos customizados (opcional)
- [ ] Colores actualizados (opcional)
- [ ] Cambios commiteados y pusheados
- [ ] PostgreSQL service listo en Railway
- [ ] Variables de entorno configuradas
- [ ] Google Calendar credentials actualizadas (si usas dominio custom)

---

## 🔧 Configuración Actual

Tus variables actuales (de `.env.railway`):

- ✅ Database: PostgreSQL de Railway
- ✅ Security: NEXTAUTH_SECRET, CALENDSO_ENCRYPTION_KEY configurados
- ✅ Branding: ByteHide Meetings
- ✅ Domain: Usa variable de Railway `${{RAILWAY_PUBLIC_DOMAIN}}`
- ✅ Google Calendar: Integración configurada
- ✅ Features: Signup deshabilitado, Organizations enabled
- ✅ Performance: 4GB RAM, puerto 3000

---

## 🐛 Troubleshooting

### Build Falla

```bash
# Verifica type errors localmente
yarn type-check:ci --force

# Si falla por memoria
# Aumenta MAX_OLD_SPACE_SIZE=8192 en Railway
```

### Startup Falla

```bash
# Verifica que DATABASE_URL esté correcto
# Debe ser: ${{Postgres.DATABASE_URL}}

# Verifica que PostgreSQL esté Online
```

### Google Calendar No Funciona

```bash
# Si cambiaste de dominio, actualiza redirect_uris en GOOGLE_API_CREDENTIALS
# Debe coincidir con NEXT_PUBLIC_WEBAPP_URL
```

Ver troubleshooting completo en: **`RAILWAY_DEPLOYMENT.md`**

---

## 🆘 Soporte

- **Railway Docs:** https://docs.railway.app
- **Cal.com Docs:** https://cal.com/docs/self-hosting
- **GitHub Issues:** Reporta problemas en tu repo

---

## 📦 Estado del Proyecto

- ✅ `Dockerfile` listo y optimizado
- ✅ `railway.json` configurado
- ✅ Scripts de startup (`start.sh`) funcionando
- ✅ Health checks configurados
- ✅ Variables de entorno documentadas
- ✅ Migraciones automáticas en startup
- ✅ Multi-stage build optimizado

---

## 🎯 Próximos Pasos Recomendados

1. **Ahora:** Configurar Git y hacer primer deploy
2. **Después:** Customizar branding si no lo hiciste
3. **Luego:** Configurar dominio custom (`cal.bytehide.com`)
4. **Finalmente:** Migrar datos del servicio antiguo (si aplica)

---

## 💡 Tips

- Usa **draft deployments** en Railway para testing
- Mantén el servicio antiguo como backup ~1 semana
- Verifica logs durante primer deployment
- Prueba login, booking y calendar sync
- Configura alertas en Railway para downtime

---

**¿Listo para comenzar?** Empieza con **`GIT_SETUP.md`** 🚀
