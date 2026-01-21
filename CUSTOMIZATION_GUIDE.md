# 🎨 Guía de Customización - ByteHide Meetings

Esta guía te ayudará a personalizar completamente Cal.com con tu branding (logos, colores, textos).

## 📋 Índice

1. [Logos y Favicons](#logos-y-favicons)
2. [Colores de Marca](#colores-de-marca)
3. [Textos y Branding](#textos-y-branding)
4. [Fuentes](#fuentes)
5. [Testing Local](#testing-local)

---

## 🖼️ Logos y Favicons

### Archivos a Reemplazar

Todos los logos están en `apps/web/public/`. **Mantén los nombres de archivo exactos**.

#### Logo Principal (SVG)

```bash
# Logo con icono + texto
apps/web/public/cal-logo-word.svg          # Modo claro
apps/web/public/cal-logo-word-dark.svg     # Modo oscuro
apps/web/public/cal-logo-word-black.svg    # Variante negra

# Solo icono
apps/web/public/cal-com-icon.svg           # Icono principal
apps/web/public/cal-com-icon-white.svg     # Icono blanco
```

**Recomendaciones:**
- Formato: SVG (vectorial, escalable)
- Dimensiones recomendadas:
  - Logo completo: 200x50px (aprox)
  - Icono: 40x40px (cuadrado)
- Optimiza con [SVGOMG](https://jakearchibald.github.io/svgomg/)

#### Favicons

```bash
apps/web/public/favicon.ico                 # 16x16, 32x32, 48x48
apps/web/public/favicon-16x16.png
apps/web/public/favicon-32x32.png
```

**Herramienta:** Genera todos los tamaños con [RealFaviconGenerator](https://realfavicongenerator.net/)

#### Iconos PWA/Mobile

```bash
# iOS
apps/web/public/apple-touch-icon.png       # 180x180px

# Android
apps/web/public/android-chrome-192x192.png # 192x192px
apps/web/public/android-chrome-256x256.png # 256x256px
apps/web/public/android-chrome-384x384.png # 384x384px
apps/web/public/android-chrome-512x512.png # 512x512px

# Windows Tiles
apps/web/public/mstile-144x144.png
apps/web/public/mstile-150x150.png
apps/web/public/mstile-310x150.png
apps/web/public/mstile-310x310.png
apps/web/public/mstile-70x70.png
```

#### Safari Pinned Tab

```bash
apps/web/public/safari-pinned-tab.svg      # SVG monocromático
```

### Ejemplo: Reemplazar Logo ByteHide

```bash
# 1. Prepara tus archivos (ejemplo)
~/Downloads/bytehide-logo.svg         → cal-logo-word.svg
~/Downloads/bytehide-logo-dark.svg    → cal-logo-word-dark.svg
~/Downloads/bytehide-icon.svg         → cal-com-icon.svg

# 2. Copia a la carpeta correcta
cp ~/Downloads/bytehide-logo.svg apps/web/public/cal-logo-word.svg
cp ~/Downloads/bytehide-logo-dark.svg apps/web/public/cal-logo-word-dark.svg
cp ~/Downloads/bytehide-icon.svg apps/web/public/cal-com-icon.svg
cp ~/Downloads/bytehide-icon.svg apps/web/public/cal-com-icon-white.svg

# 3. Genera favicons online y cópialos
cp ~/Downloads/favicon-package/* apps/web/public/
```

---

## 🎨 Colores de Marca

Cal.com usa **CSS Custom Properties** (variables CSS). El archivo principal es:

```
packages/platform/atoms/globals.css
```

### Colores Principales

Busca la línea **~10056** (o busca `:root {` en el archivo):

```css
/* MODO CLARO (Light Mode) */
:root {
  /* Color principal de marca */
  --cal-brand: #111827;           /* ← CAMBIA ESTO */
  --cal-brand-emphasis: #0f0f0f;  /* ← Variante más oscura */
  --cal-brand-text: #fff;         /* ← Color de texto sobre brand */

  /* Variantes adicionales */
  --cal-brand-muted: rgba(17, 24, 39, 0.1);
  --cal-brand-subtle: #9CA3AF;
  --cal-brand-accent: white;
}
```

Busca la línea **~10162** (o busca `:is(.dark *)` en el archivo):

```css
/* MODO OSCURO (Dark Mode) */
:is(.dark *) {
  --cal-brand: #fff;              /* ← CAMBIA ESTO */
  --cal-brand-emphasis: #9ca3b0;  /* ← Variante clara */
  --cal-brand-text: #000;         /* ← Texto negro sobre blanco */
}
```

### Ejemplos de Paletas

#### ByteHide Azul

```css
/* Modo Claro */
:root {
  --cal-brand: #3B82F6;           /* Blue-500 */
  --cal-brand-emphasis: #2563EB;  /* Blue-600 */
  --cal-brand-text: #FFFFFF;
  --cal-brand-muted: rgba(59, 130, 246, 0.1);
  --cal-brand-subtle: #DBEAFE;
  --cal-brand-accent: #FFFFFF;
}

/* Modo Oscuro */
:is(.dark *) {
  --cal-brand: #60A5FA;           /* Blue-400 */
  --cal-brand-emphasis: #3B82F6;  /* Blue-500 */
  --cal-brand-text: #000000;
}
```

#### Verde

```css
/* Modo Claro */
:root {
  --cal-brand: #10B981;           /* Green-500 */
  --cal-brand-emphasis: #059669;  /* Green-600 */
  --cal-brand-text: #FFFFFF;
}

/* Modo Oscuro */
:is(.dark *) {
  --cal-brand: #34D399;           /* Green-400 */
  --cal-brand-emphasis: #10B981;
  --cal-brand-text: #000000;
}
```

#### Morado

```css
/* Modo Claro */
:root {
  --cal-brand: #8B5CF6;           /* Purple-500 */
  --cal-brand-emphasis: #7C3AED;  /* Purple-600 */
  --cal-brand-text: #FFFFFF;
}

/* Modo Oscuro */
:is(.dark *) {
  --cal-brand: #A78BFA;           /* Purple-400 */
  --cal-brand-emphasis: #8B5CF6;
  --cal-brand-text: #000000;
}
```

### Herramientas para Elegir Colores

- **Tailwind Colors:** https://tailwindcss.com/docs/customizing-colors
- **Coolors:** https://coolors.co/ (generador de paletas)
- **Adobe Color:** https://color.adobe.com/
- **Contrast Checker:** https://webaim.org/resources/contrastchecker/ (accesibilidad)

### Colores Adicionales (Opcional)

Si quieres personalizar más colores, busca estas variables en `globals.css`:

```css
/* Backgrounds */
--cal-bg: #ffffff;                    /* Fondo principal */
--cal-bg-emphasis: #f3f4f6;           /* Fondo enfatizado */
--cal-bg-subtle: #f9fafb;             /* Fondo sutil */
--cal-bg-muted: #e5e7eb;              /* Fondo muted */

/* Textos */
--cal-text: #111827;                  /* Texto principal */
--cal-text-emphasis: #000000;         /* Texto enfatizado */
--cal-text-subtle: #6b7280;           /* Texto secundario */
--cal-text-muted: #9ca3af;            /* Texto deshabilitado */

/* Bordes */
--cal-border: #e5e7eb;                /* Borde principal */
--cal-border-emphasis: #d1d5db;       /* Borde enfatizado */
--cal-border-subtle: #f3f4f6;         /* Borde sutil */

/* Semánticos */
--cal-bg-success: #10b981;            /* Verde éxito */
--cal-bg-error: #ef4444;              /* Rojo error */
--cal-bg-attention: #f59e0b;          /* Naranja atención */
--cal-bg-info: #3b82f6;               /* Azul info */
```

---

## ✍️ Textos y Branding

Los textos se configuran mediante **variables de entorno** (ya configuradas en Railway):

### Variables Principales

```bash
# Nombre de la aplicación (aparece en header, emails, etc.)
NEXT_PUBLIC_APP_NAME="ByteHide Meetings"

# Nombre de la compañía (footer, legales)
NEXT_PUBLIC_COMPANY_NAME="ByteHide"

# Email de soporte (contacto, notificaciones)
NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS="support@bytehide.com"

# URLs legales (footer)
NEXT_PUBLIC_WEBSITE_PRIVACY_POLICY_URL="https://bytehide.com/privacy"
NEXT_PUBLIC_WEBSITE_TERMS_URL="https://bytehide.com/terms"
```

### Donde Aparecen

| Variable | Ubicación en UI |
|----------|-----------------|
| `NEXT_PUBLIC_APP_NAME` | Header, título de página, emails |
| `NEXT_PUBLIC_COMPANY_NAME` | Footer, copyright |
| `NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS` | Links de soporte, notificaciones |
| URLs legales | Footer (Privacy Policy, Terms) |

### Traducciones (Opcional)

Si quieres cambiar textos en la UI:

```bash
# Archivo principal de traducciones
apps/web/public/static/locales/en/common.json
```

Ejemplo - Cambiar "Book a meeting":

```json
{
  "book_a_meeting": "Agenda una reunión",
  "schedule_event": "Programar evento",
  ...
}
```

**Nota:** Cal.com tiene internacionalización completa. Ver carpetas `locales/` para otros idiomas.

---

## 🔤 Fuentes

Cal.com usa fuentes personalizadas definidas en CSS variables.

### Fuente Principal

Por defecto usa **Inter** (Google Fonts). Para cambiar:

1. **Opción 1: Google Fonts**

   Edita `apps/web/app/fonts.ts` o el layout principal:

   ```typescript
   import { Inter, Roboto } from 'next/font/google'

   const roboto = Roboto({
     subsets: ['latin'],
     weight: ['400', '500', '600', '700'],
     variable: '--font-sans',
   })
   ```

2. **Opción 2: Fuente Custom**

   Agrega archivos `.woff2` en `apps/web/public/fonts/`:

   ```css
   /* En globals.css */
   @font-face {
     font-family: 'ByteHide Sans';
     src: url('/fonts/bytehide-sans.woff2') format('woff2');
     font-weight: 400;
     font-style: normal;
   }

   :root {
     --font-sans: 'ByteHide Sans', system-ui, sans-serif;
   }
   ```

---

## 🧪 Testing Local

Antes de deployar, prueba tus cambios localmente:

### Con Docker (Recomendado)

```bash
# 1. Build la imagen
docker build -t mi-calcom-custom .

# 2. Corre con variables básicas
docker run -p 3000:3000 \
  -e DATABASE_URL="postgresql://user:pass@host:5432/db" \
  -e NEXTAUTH_SECRET="test123secret" \
  -e CALENDSO_ENCRYPTION_KEY="test456encryption" \
  -e NEXT_PUBLIC_WEBAPP_URL="http://localhost:3000" \
  -e NEXT_PUBLIC_APP_NAME="ByteHide Meetings" \
  mi-calcom-custom

# 3. Abre http://localhost:3000
```

### Con Yarn (Desarrollo)

```bash
# 1. Instala dependencias
yarn install

# 2. Setup database (necesitas PostgreSQL local)
yarn workspace @calcom/prisma db-migrate

# 3. Crea .env.local con variables mínimas
cat > .env.local << EOF
DATABASE_URL="postgresql://localhost:5432/calendso"
NEXTAUTH_SECRET="secret"
CALENDSO_ENCRYPTION_KEY="secret"
NEXT_PUBLIC_WEBAPP_URL="http://localhost:3000"
NEXT_PUBLIC_APP_NAME="ByteHide Meetings"
EOF

# 4. Run dev server
yarn dev

# 5. Abre http://localhost:3000
```

### Checklist Visual

Verifica estos elementos en el navegador:

- [ ] Logo en header (esquina superior izquierda)
- [ ] Favicon en pestaña del navegador
- [ ] Colores de botones primarios (deben usar --cal-brand)
- [ ] Nombre de app en título de página
- [ ] Footer con tu compañía y links legales
- [ ] Modo oscuro (toggle en settings)
- [ ] Email de soporte en páginas de error

---

## 📦 Commit y Deploy

Una vez que estés satisfecho:

```bash
# 1. Ver cambios
git status

# 2. Commit de customización
git add apps/web/public/*.svg apps/web/public/*.png apps/web/public/*.ico
git add packages/platform/atoms/globals.css
git commit -m "feat: customize ByteHide branding (logos, colors)"

# 3. Push al repo
git push origin main

# 4. Railway deployará automáticamente
```

---

## 🎯 Checklist Completo

### Logos

- [ ] `cal-logo-word.svg` (logo principal)
- [ ] `cal-logo-word-dark.svg` (logo dark mode)
- [ ] `cal-com-icon.svg` (icono)
- [ ] `cal-com-icon-white.svg` (icono blanco)
- [ ] `favicon.ico`
- [ ] `apple-touch-icon.png`
- [ ] `android-chrome-*.png` (todos los tamaños)

### Colores

- [ ] `--cal-brand` (light mode)
- [ ] `--cal-brand-emphasis` (light mode)
- [ ] `--cal-brand-text` (light mode)
- [ ] `--cal-brand` (dark mode)
- [ ] `--cal-brand-emphasis` (dark mode)
- [ ] `--cal-brand-text` (dark mode)

### Variables de Entorno (Railway)

- [ ] `NEXT_PUBLIC_APP_NAME`
- [ ] `NEXT_PUBLIC_COMPANY_NAME`
- [ ] `NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS`
- [ ] `NEXT_PUBLIC_WEBSITE_PRIVACY_POLICY_URL`
- [ ] `NEXT_PUBLIC_WEBSITE_TERMS_URL`

### Testing

- [ ] Build local exitoso
- [ ] Logo visible en UI
- [ ] Colores aplicados correctamente
- [ ] Dark mode funcional
- [ ] Footer con branding correcto

---

## 📚 Recursos Adicionales

- **Cal.com Branding Docs:** https://cal.com/docs/self-hosting/branding
- **Tailwind Colors:** https://tailwindcss.com/docs/customizing-colors
- **Favicon Generator:** https://realfavicongenerator.net/
- **SVG Optimizer:** https://jakearchibald.github.io/svgomg/
- **Contrast Checker:** https://webaim.org/resources/contrastchecker/

---

## 💡 Tips

1. **Mantén los SVGs simples** - Elimina elementos innecesarios para mejor performance
2. **Usa HEX o RGB** - Evita colores con nombres (usa `#3B82F6` en vez de `blue`)
3. **Prueba accesibilidad** - Mínimo contraste 4.5:1 para textos
4. **Optimiza PNGs** - Usa [TinyPNG](https://tinypng.com/) para reducir tamaño
5. **Versiona cambios** - Commit logo/colores por separado para mejor tracking

---

**¡Listo!** Tu Cal.com ahora tiene el branding completo de ByteHide 🎨
