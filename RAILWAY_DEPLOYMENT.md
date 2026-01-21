# 🚂 Cal.com Deployment en Railway

Esta guía te ayudará a deployar tu versión customizada de Cal.com en Railway desde este repositorio de GitHub.

## 📋 Pre-requisitos

- [ ] Cuenta en Railway (https://railway.app)
- [ ] Este repositorio en tu cuenta de GitHub
- [ ] PostgreSQL service en Railway (o listo para crear)
- [ ] Variables de entorno preparadas (ver `.env.railway`)

## 🚀 Paso 1: Configurar PostgreSQL en Railway

Si aún no tienes PostgreSQL:

1. En Railway Dashboard → **New** → **Database** → **PostgreSQL**
2. Railway creará automáticamente las variables:
   - `PGHOST`, `PGPORT`, `PGDATABASE`, `PGUSER`, `PGPASSWORD`
   - `DATABASE_URL` (connection string completo)
3. Anota el nombre del servicio (ej: `Postgres`)

## 🔧 Paso 2: Crear Servicio Cal.com

1. **Railway Dashboard** → **New** → **GitHub Repo**
2. Autoriza Railway a acceder a tu GitHub si es la primera vez
3. Selecciona **este repositorio** (`cal.com`)
4. Railway detectará automáticamente el `Dockerfile`

## 🔐 Paso 3: Configurar Variables de Entorno

En Railway → Tu servicio Cal.com → **Variables**, agrega las siguientes:

### Variables Obligatorias

```bash
# Database (Railway las resuelve automáticamente)
DATABASE_URL=${{Postgres.DATABASE_URL}}
DATABASE_DIRECT_URL=${{Postgres.DATABASE_URL}}
DATABASE_HOST=${{Postgres.PGHOST}}:${{Postgres.PGPORT}}

# Security (usa los valores de .env.railway o genera nuevos)
NEXTAUTH_SECRET=<genera-con-openssl-rand-base64-32>
CALENDSO_ENCRYPTION_KEY=<genera-con-openssl-rand-base64-32>

# Public URL (Railway lo asigna automáticamente)
NEXT_PUBLIC_WEBAPP_URL=https://${{RAILWAY_PUBLIC_DOMAIN}}

# License
NEXT_PUBLIC_LICENSE_CONSENT=agree
```

### Variables de Branding (ByteHide)

```bash
NEXT_PUBLIC_APP_NAME=ByteHide Meetings
NEXT_PUBLIC_COMPANY_NAME=ByteHide
NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS=support@bytehide.com
NEXT_PUBLIC_WEBSITE_PRIVACY_POLICY_URL=https://bytehide.com/privacy
NEXT_PUBLIC_WEBSITE_TERMS_URL=https://bytehide.com/terms
```

### Variables de Features

```bash
NEXT_PUBLIC_DISABLE_SIGNUP=true
ORGANIZATIONS_ENABLED=true
NEXT_PUBLIC_SINGLE_ORG_SLUG=false
CALCOM_TELEMETRY_DISABLED=false
```

### Variables de Performance

```bash
MAX_OLD_SPACE_SIZE=4096
PORT=3000
```

### Google Calendar Integration (opcional)

```bash
GOOGLE_API_CREDENTIALS={"web":{"client_id":"TU_CLIENT_ID","project_id":"tu-proyecto","auth_uri":"https://accounts.google.com/o/oauth2/auth","token_uri":"https://oauth2.googleapis.com/token","auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs","client_secret":"TU_CLIENT_SECRET","redirect_uris":["https://tu-dominio.com/api/integrations/googlecalendar/callback"],"javascript_origins":["https://tu-dominio.com"]}}
```

**⚠️ IMPORTANTE:** Si usas Google Calendar, actualiza las URLs en `redirect_uris` y `javascript_origins` con tu dominio final.

## 🎨 Paso 4: Customizar Branding (Opcional)

Antes de hacer deploy, puedes customizar:

### Logos

Reemplaza estos archivos (mantén los nombres):

```
apps/web/public/cal-com-icon.svg          → Tu icono
apps/web/public/cal-logo-word.svg         → Tu logo con texto
apps/web/public/cal-logo-word-dark.svg    → Logo para dark mode
apps/web/public/favicon.ico               → Favicon
apps/web/public/apple-touch-icon.png      → Icono iOS
apps/web/public/android-chrome-512x512.png → Icono Android
```

### Colores

Edita `packages/platform/atoms/globals.css` (línea ~10056):

```css
/* Modo Claro */
:root {
  --cal-brand: #3B82F6;           /* Tu color principal */
  --cal-brand-emphasis: #2563EB;  /* Variante oscura */
  --cal-brand-text: #fff;         /* Color de texto sobre brand */
}

/* Modo Oscuro */
:is(.dark *) {
  --cal-brand: #60A5FA;
  --cal-brand-emphasis: #3B82F6;
  --cal-brand-text: #000;
}
```

Ver `CUSTOMIZATION_GUIDE.md` para más detalles.

## 📦 Paso 5: Deploy

1. **Commit tus cambios** (si modificaste logos/colores):
   ```bash
   git add .
   git commit -m "feat: customize branding for ByteHide"
   git push origin main
   ```

2. Railway **detectará el push** y comenzará el build automáticamente

3. **Monitorea el deployment**:
   - Railway Dashboard → Tu servicio → **Deployments**
   - Click en el deployment activo → **View Logs**

4. **Tiempos esperados**:
   - Build: ~8-12 minutos (primera vez)
   - Startup: ~2-3 minutos (migraciones + seed)

## ✅ Paso 6: Verificar Deployment

Una vez que el estado sea **Active**:

1. Click en el dominio generado (ej: `cal-com-production-xxxx.up.railway.app`)
2. Deberías ver la pantalla de login con tu branding
3. Verifica:
   - [ ] Logo personalizado visible
   - [ ] Colores correctos
   - [ ] Nombre de app correcto en header
   - [ ] Login funcional

## 🌐 Paso 7: Dominio Custom (Opcional)

Para usar `cal.bytehide.com` en lugar del dominio de Railway:

1. Railway → Tu servicio → **Settings** → **Domains**
2. Click **Custom Domain** → Ingresa `cal.bytehide.com`
3. Railway te dará registros DNS (CNAME o A)
4. Agrega esos registros en tu proveedor DNS (ej: Cloudflare)
5. Espera propagación (~5-30 min)
6. **Actualiza variables de entorno**:
   ```bash
   # Ya no necesitas esta variable, usa tu dominio directamente
   NEXT_PUBLIC_WEBAPP_URL=https://cal.bytehide.com
   ```
7. **Actualiza Google Calendar credentials** si aplica (redirect_uris)

## 🔄 Actualizaciones Futuras

Para actualizar tu deployment:

1. Haz cambios en tu repo local
2. Commit y push a GitHub:
   ```bash
   git add .
   git commit -m "feat: update feature XYZ"
   git push origin main
   ```
3. Railway re-deployará automáticamente

## 🐛 Troubleshooting

### Build falla

**Error:** `yarn build` falla
- **Solución:** Ejecuta `yarn type-check:ci --force` localmente para ver errores
- Verifica que no haya errores de TypeScript

**Error:** `Out of memory` / `JavaScript heap out of memory`
- **Causa:** El build de Next.js + TypeScript consume mucha RAM
- **Solución automática:** El Dockerfile ahora usa 8192 MB por defecto
- **Si aún falla:**
  1. Railway → Tu servicio → **Settings** → **Build Arguments**
  2. Agrega: `MAX_OLD_SPACE_SIZE=10240` (10 GB)
  3. Redeploy (Deployments → ⋮ → Redeploy)
- **Nota:** Railway debe tener suficiente RAM disponible (verifica tu plan)

### Startup falla

**Error:** `Cannot connect to database`
- **Solución:** Verifica que `DATABASE_URL` use la referencia correcta `${{Postgres.DATABASE_URL}}`
- Asegúrate de que el servicio PostgreSQL esté **Online**

**Error:** `NEXTAUTH_SECRET is required`
- **Solución:** Verifica que todas las variables obligatorias estén configuradas

### Runtime errors

**Error:** `Invalid redirect_uri` (Google Calendar)
- **Solución:** Actualiza `GOOGLE_API_CREDENTIALS` con tu dominio final
- Verifica en Google Cloud Console que las redirect URIs coincidan

## 📚 Archivos Importantes

| Archivo | Propósito |
|---------|-----------|
| `Dockerfile` | Build instructions para Railway |
| `railway.json` | Configuración de deployment |
| `.env.railway` | Template de variables (NO commitear) |
| `CUSTOMIZATION_GUIDE.md` | Guía detallada de customización |
| `scripts/start.sh` | Script de inicio (migraciones, seed) |

## 🔒 Seguridad

- ✅ Nunca commitees `.env.railway` (ya está en `.gitignore`)
- ✅ Regenera `NEXTAUTH_SECRET` y `CALENDSO_ENCRYPTION_KEY` para producción
- ✅ Usa `NEXT_PUBLIC_DISABLE_SIGNUP=true` si no quieres registros públicos
- ✅ Revisa periódicamente las Google API credentials y rótalo si es necesario

## 🎯 Migración desde Imagen Docker Pública

Si ya tienes Cal.com corriendo con la imagen `calcom/cal.com`:

1. **NO elimines** el servicio antiguo todavía
2. Crea el nuevo servicio siguiendo esta guía
3. **Verifica** que el nuevo funcione correctamente
4. **Exporta datos** del antiguo si es necesario:
   - Bookings, usuarios, configuraciones
5. **Cambia el dominio** al nuevo servicio
6. Mantén el antiguo como backup ~1 semana
7. Elimina el servicio antiguo cuando estés seguro

## 💡 Tips

- **Logs en tiempo real:** Railway → Deployments → View Logs
- **Health check:** El servicio espera a que `/` responda antes de marcar como healthy
- **Rebuilds:** Puedes forzar un rebuild en Deployments → ⋮ → Redeploy
- **Rollback:** Deployments → Click en versión anterior → Redeploy

## 🆘 Soporte

- **Railway Docs:** https://docs.railway.app
- **Cal.com Docs:** https://cal.com/docs/self-hosting/docker
- **Issues:** Reporta problemas en el repo de GitHub

---

**Listo!** Tu Cal.com customizado debería estar corriendo en Railway 🎉
