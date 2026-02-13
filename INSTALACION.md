# MFL-Dialogue - Sistema de Diálogos para NPCs

## ✅ Instalación Completada

El sistema de diálogos ha sido instalado correctamente.

### 📍 NPC de Basura Configurado

**Ubicación:** Depósito de Basura (-321.45, -1545.86, 31.02)
**NPC:** Carlos Rodríguez (Modelo: s_m_y_garbage)

### 🎮 Funcionalidades del NPC de Basura:

1. **Iniciar ruta** - Comienza a trabajar recogiendo basura ($250 depósito)
2. **Cobrar paga** - Recoge tu salario al terminar
3. **Información** - Aprende cómo funciona el trabajo
4. **Salir** - Cierra el diálogo

### 🚀 Cómo Probar:

1. Asegúrate de que el servidor esté iniciado
2. Ejecuta en la consola del servidor:
   ```
   ensure mfl-dialogue
   ```
3. Ve a las coordenadas del depósito de basura
4. Interactúa con el NPC Carlos Rodríguez
5. Selecciona "Iniciar ruta" para comenzar a trabajar

### 🔧 Integración con qbx_garbagejob:

El NPC está completamente integrado con el sistema de basura existente:
- ✅ Usa los mismos eventos que el sistema original
- ✅ No requiere cityhall
- ✅ Maneja el depósito de $250
- ✅ Gestiona las rutas y pagos automáticamente

### 📝 Agregar Más NPCs:

Edita `config/config.lua` y agrega nuevos NPCs siguiendo el formato:

```lua
['mi_npc_id'] = {
    name = 'Nombre del NPC',
    model = 'modelo_ped',
    coords = vector4(x, y, z, heading),
    dialogue = {
        text = 'Texto del diálogo',
        options = {
            {
                label = 'Opción 1',
                description = 'Descripción',
                action = function()
                    -- Tu código aquí
                end
            }
        }
    }
}
```

### 🎨 Diseño:

- Tema oscuro moderno
- Botones numerados (1-4)
- Animaciones suaves
- Responsive
- Compatible con teclado y mouse

### ⌨️ Controles:

- **Click** - Seleccionar opción
- **1-4** - Selección rápida con teclado
- **ESC** - Cerrar diálogo

---

**Creado por:** MFL Scripts
**Versión:** 1.0.0
