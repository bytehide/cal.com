# 🔧 Configurar Repositorio Git para Deployment

Actualmente tu repo local está vinculado al repositorio oficial de Cal.com. Para deployar en Railway desde **tu propio repositorio**, necesitas cambiar esto.

## 🎯 Opción 1: Fork en GitHub (Recomendado)

**Ventajas:**
- ✅ Más fácil y rápido
- ✅ Puedes sincronizar actualizaciones del repo oficial si quieres
- ✅ GitHub mantiene la referencia al proyecto original

**Pasos:**

1. **Ve al repo original en GitHub:**
   - https://github.com/calcom/cal.com

2. **Click en "Fork"** (esquina superior derecha)
   - Se creará una copia en tu cuenta: `https://github.com/TU_USUARIO/cal.com`

3. **Actualiza el remote en tu repo local:**
   ```bash
   # Renombra el origin actual a "upstream"
   git remote rename origin upstream

   # Agrega tu fork como nuevo origin
   git remote add origin https://github.com/TU_USUARIO/cal.com.git

   # Verifica que esté correcto
   git remote -v
   ```

   Deberías ver algo como:
   ```
   origin    https://github.com/TU_USUARIO/cal.com.git (fetch)
   origin    https://github.com/TU_USUARIO/cal.com.git (push)
   upstream  https://github.com/calcom/cal.com.git (fetch)
   upstream  https://github.com/calcom/cal.com.git (push)
   ```

4. **Push a tu fork:**
   ```bash
   git push -u origin main
   ```

5. **Continúa con Railway Deployment** siguiendo `RAILWAY_DEPLOYMENT.md`

---

## 🆕 Opción 2: Nuevo Repositorio (Desvinculado)

**Ventajas:**
- ✅ Completamente independiente del repo original
- ✅ Mejor para proyectos privados o muy customizados
- ✅ Sin referencias al repo original

**Pasos:**

1. **Crea un nuevo repositorio en GitHub:**
   - Ve a https://github.com/new
   - Nombre: `bytehide-cal` (o el que prefieras)
   - Visibilidad: Privado o Público (según prefieras)
   - **NO** inicialices con README, .gitignore, o license
   - Click **Create repository**

2. **GitHub te mostrará las instrucciones.** En tu repo local, ejecuta:
   ```bash
   # Elimina el remote actual
   git remote remove origin

   # Agrega tu nuevo repo
   git remote add origin https://github.com/TU_USUARIO/bytehide-cal.git

   # Verifica
   git remote -v
   ```

3. **Push inicial:**
   ```bash
   # Primera vez (con -u para establecer tracking)
   git push -u origin main
   ```

4. **Continúa con Railway Deployment** siguiendo `RAILWAY_DEPLOYMENT.md`

---

## 🔄 Sincronizar Actualizaciones (Solo Opción 1)

Si usaste la **Opción 1 (Fork)** y quieres actualizar con cambios del repo oficial:

```bash
# Descarga cambios del repo oficial
git fetch upstream

# Revisa qué cambios hay
git log upstream/main --oneline -10

# Mergea los cambios (cuidado con conflictos si modificaste archivos)
git merge upstream/main

# O haz rebase (más limpio pero más avanzado)
git rebase upstream/main

# Push a tu fork
git push origin main
```

**⚠️ CUIDADO:** Si personalizaste logos/colores, puede haber conflictos. Revisa cuidadosamente antes de mergear.

---

## 📝 Script Rápido de Setup

### Para Fork (Opción 1):

```bash
# Paso 1: Haz el fork en GitHub primero
# Paso 2: Ejecuta esto (reemplaza TU_USUARIO)

git remote rename origin upstream
git remote add origin https://github.com/TU_USUARIO/cal.com.git
git push -u origin main

echo "✅ Repo configurado! Verifica con: git remote -v"
```

### Para Nuevo Repo (Opción 2):

```bash
# Paso 1: Crea el repo en GitHub primero
# Paso 2: Ejecuta esto (reemplaza TU_USUARIO y NOMBRE_REPO)

git remote remove origin
git remote add origin https://github.com/TU_USUARIO/NOMBRE_REPO.git
git push -u origin main

echo "✅ Repo configurado! Verifica con: git remote -v"
```

---

## ✅ Verificación

Después de configurar, verifica que todo esté correcto:

```bash
# Ver configuración de remotes
git remote -v

# Ver último commit
git log --oneline -1

# Ver estado
git status
```

---

## 🚂 Siguiente Paso: Railway

Una vez que tu repo esté en GitHub:

1. Ve a `RAILWAY_DEPLOYMENT.md`
2. Sigue las instrucciones desde **Paso 2: Crear Servicio Cal.com**
3. Railway se conectará a **tu repositorio** ahora

---

## 💡 Recomendación

Para **ByteHide Meetings**, te recomiendo:

- **Si es privado/interno:** Opción 2 (repo nuevo privado)
- **Si quieres contribuir de vuelta a Cal.com:** Opción 1 (fork)
- **Si solo customizas branding:** Cualquiera funciona bien

---

## 🆘 Problemas Comunes

**Error: `remote origin already exists`**
```bash
git remote remove origin
# Luego vuelve a agregar tu nuevo origin
```

**Error: `failed to push some refs`**
```bash
# Si el repo remoto tiene commits que no tienes local
git pull origin main --rebase
git push origin main
```

**Quiero cambiar de opción**
```bash
# Ver qué remotes tienes
git remote -v

# Eliminar todos
git remote remove origin
git remote remove upstream  # si existe

# Agregar el que quieras siguiendo las instrucciones
```

---

**¿Listo?** Elige tu opción y ejecuta los comandos. Luego continúa con `RAILWAY_DEPLOYMENT.md` 🚀
