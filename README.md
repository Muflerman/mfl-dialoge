# MFL Dialogue System
![ebd272a09361e8158e12c3204363cb32](https://github.com/user-attachments/assets/0d789b5e-59e8-4fb0-9df8-6d14ebbdbf8c)

Sistema moderno de diálogos para NPCs en FiveM con diseño elegante y funcionalidad completa.

## Características

✅ Diseño moderno y elegante con tema oscuro  
✅ Soporte para múltiples opciones de diálogo  
✅ Integración con ox_target o interacción por distancia  
✅ Sistema de eventos para conectar con trabajos, tiendas, etc.  
✅ Totalmente configurable  
✅ Animaciones suaves  
✅ Soporte para teclado numérico  

## Instalación

1. Coloca el recurso en tu carpeta `resources/[add]/`
2. Agrega `ensure mfl-dialogue` a tu `server.cfg`
3. Configura tus NPCs en `config/config.lua`
4. Reinicia el servidor

## Configuración

### Agregar un NPC con diálogo

Edita `config/config.lua` y agrega un nuevo NPC:

```lua
Config.NPCs = {
    ['mi_npc'] = {
        name = 'Nombre del NPC',
        model = 'modelo_del_ped', -- Ejemplo: 'mp_m_shopkeep_01'
        coords = vector4(x, y, z, heading),
        dialogue = {
            text = 'Texto del diálogo que dirá el NPC',
            options = {
                {
                    label = 'Opción 1',
                    description = 'Descripción de la opción',
                    action = function()
                        -- Código que se ejecutará al seleccionar esta opción
                        TriggerEvent('mi_evento')
                    end
                },
                {
                    label = 'Opción 2',
                    description = 'Otra descripción',
                    action = function()
                        -- Otro código
                    end
                }
            }
        }
    }
}
```

## Ejemplos de uso

### Trabajo de basura (qbx_garbagejob)

El NPC `garbage_boss` ya está configurado y listo para usar:

```lua
['garbage_boss'] = {
    name = 'Carlos Rodríguez',
    model = 's_m_y_garbage',
    coords = vector4(-321.45, -1545.86, 31.02, 180.0),
    dialogue = {
        text = '¡Hola! ¿Buscas trabajo recogiendo basura? Paga bien y es fácil.',
        options = {
            {
                label = 'Iniciar ruta',
                description = 'Comenzar a trabajar ($250 depósito)',
                action = function()
                    TriggerEvent('qb-garbagejob:client:RequestRoute')
                end
            },
            {
                label = 'Cobrar paga',
                description = 'Recoger tu salario',
                action = function()
                    TriggerEvent('qb-garbagejob:client:RequestPaycheck')
                end
            }
        }
    }
}
```

Este NPC reemplaza la necesidad del cityhall y permite:
- ✅ Iniciar una ruta de basura
- ✅ Cobrar el salario
- ✅ Ver información del trabajo

### Abrir una tienda

```lua
{
    label = 'Comprar',
    description = 'Abrir la tienda',
    action = function()
        exports.ox_inventory:openInventory('shop', { type = '24_7' })
    end
}
```

### Iniciar un trabajo

```lua
{
    label = 'Solicitar trabajo',
    description = 'Trabajar como mecánico',
    action = function()
        TriggerEvent('qb-jobs:client:startJob', 'mechanic')
    end
}
```

### Mostrar notificación

```lua
{
    label = 'Información',
    description = 'Obtener información',
    action = function()
        lib.notify({
            title = 'Título',
            description = 'Mensaje',
            type = 'info'
        })
    end
}
```

### Abrir un menú

```lua
{
    label = 'Ver opciones',
    description = 'Abrir menú de opciones',
    action = function()
        lib.registerContext({
            id = 'mi_menu',
            title = 'Mi Menú',
            options = {
                -- Opciones del menú
            }
        })
        lib.showContext('mi_menu')
    end
}
```

## Controles

- **Click izquierdo**: Seleccionar opción
- **Teclas numéricas (1-4)**: Seleccionar opción rápidamente
- **ESC**: Cerrar diálogo

## Exportaciones

### Abrir un diálogo desde otro recurso

```lua
exports['mfl-dialogue']:OpenDialogue('id_del_npc', Config.NPCs['id_del_npc'])
```

## Dependencias

- ox_lib
- ox_target (opcional, si Config.UseTarget = true)

## Créditos

Creado por MFL Scripts

