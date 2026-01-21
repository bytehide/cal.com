# 🔧 Fix: Out of Memory en Railway Build

Si ves este error durante el build en Railway:

```
FATAL ERROR: Ineffective mark-compacts near heap limit
Allocation failed - JavaScript heap out of memory
```

## ✅ Solución Rápida

El Dockerfile ya está configurado para usar **8 GB de RAM** durante el build (MAX_OLD_SPACE_SIZE=8192).

### Paso 1: Verificar Plan de Railway

Railway necesita suficiente RAM disponible para el build:

- **Hobby Plan:** 8 GB RAM (suficiente)
- **Pro Plan:** 32 GB RAM (más que suficiente)
- **Free Trial:** 512 MB-1 GB (NO suficiente)

Si estás en Free Trial, necesitas upgrade a Hobby o Pro.

### Paso 2: Redeploy

1. Railway Dashboard → Tu servicio
2. **Deployments** → Click en el deployment fallido
3. ⋮ (tres puntos) → **Redeploy**

El nuevo build usará 8 GB de RAM automáticamente.

### Paso 3: Si Aún Falla (Opcional)

Si con 8 GB sigue fallando:

1. Railway → Tu servicio → **Settings**
2. Scroll hasta **Build Arguments**
3. Click **Add Argument**:
   - **Key:** `MAX_OLD_SPACE_SIZE`
   - **Value:** `10240` (10 GB)
4. Guarda y **Redeploy**

## 📊 Explicación Técnica

### ¿Por qué consume tanta memoria?

El build de Cal.com incluye:
- **TypeScript compilation** (~2 GB)
- **Next.js build** (~3 GB)
- **Turborepo pruning** (~1 GB)
- **Embed builds** (~1 GB)
- **App store metadata** (~1 GB)

**Total:** ~8 GB de RAM necesaria

### Variables de Memoria

| Variable | Dónde | Valor | Propósito |
|----------|-------|-------|-----------|
| `MAX_OLD_SPACE_SIZE` (Dockerfile ARG) | Build time | 8192 MB | Memoria para TypeScript/Next.js build |
| `MAX_OLD_SPACE_SIZE` (ENV var) | Runtime | 4096 MB | Memoria para app en ejecución |

**Importante:** Son dos configuraciones diferentes:
- **Build time** (Dockerfile ARG): Controla memoria durante `docker build`
- **Runtime** (ENV var): Controla memoria cuando la app está corriendo

## 🚀 Cambios Realizados

He actualizado tu repo con:

1. ✅ `Dockerfile`: `MAX_OLD_SPACE_SIZE=8192` (aumentado de 6144)
2. ✅ `RAILWAY_DEPLOYMENT.md`: Documentación del error expandida

## 🔄 Próximo Build

Después de commitear estos cambios:

```bash
git add Dockerfile RAILWAY_DEPLOYMENT.md RAILWAY_BUILD_FIX.md
git commit -m "fix: increase MAX_OLD_SPACE_SIZE to 8192 for Railway builds"
git push origin main
```

Railway detectará el push y hará rebuild automáticamente con más memoria.

## ⏱️ Tiempo de Build Esperado

Con 8 GB de RAM:
- **TypeScript compilation:** ~1-2 min
- **Next.js build:** ~3-4 min
- **Resto (turbo, embeds):** ~2-3 min

**Total:** ~8-12 minutos (primera vez puede ser más)

## 🆘 Si Continúa Fallando

1. **Verifica el plan de Railway:**
   ```
   Railway Dashboard → Settings → Plan
   ```
   Debe ser Hobby ($5/mes) o superior.

2. **Revisa los logs completos:**
   ```
   Deployments → Click en build fallido → View Logs
   ```
   Busca otros errores además de OOM.

3. **Contacta soporte de Railway:**
   Si tienes plan pago y sigue fallando, puede ser un issue temporal de Railway.

## 💡 Tips para Reducir Memoria (Avanzado)

Si quieres optimizar el uso de memoria:

1. **Deshabilitar Turbopack en build:**
   ```dockerfile
   # En el Dockerfile, cambiar:
   RUN NODE_OPTIONS="--max-old-space-size=${MAX_OLD_SPACE_SIZE}" yarn build
   ```

2. **Build en fases separadas:**
   ```bash
   # Dividir el build en múltiples stages más pequeños
   ```

3. **Usar caché de Railway:**
   Railway cachea `node_modules` y `.next/cache` entre builds.

---

**Listo!** El error de memoria debería estar resuelto. Si tienes dudas, revisa `RAILWAY_DEPLOYMENT.md` sección Troubleshooting.
