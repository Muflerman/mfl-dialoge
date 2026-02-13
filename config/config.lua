Config = {}

-- Configuración general
Config.UseTarget = true               -- Usar ox_target (true) o distancia (false)
Config.InteractionDistance = 2.5      -- Distancia para interactuar sin target
Config.TargetIcon = 'fas fa-comments' -- Icono de ox_target
Config.TargetLabel = 'Hablar'         -- Etiqueta de ox_target

-- Ejemplos de NPCs con diálogos
Config.NPCs = {
    -- Trabajo de basura (Gestionado por qbx_garbagejob)
    -- ['garbage_boss'] = { ... }

    -- Ejemplo: Tienda
    ['tienda_24_7'] = {
        name = 'John Doe',
        model = 'mp_m_shopkeep_01',
        coords = vector4(25.74, -1347.32, 29.49, 266.0),
        dialogue = {
            text = 'Hej! Vad kan jag hjälpa dig med idag?',
            options = {
                {
                    label = 'Jag vill handla',
                    description = 'Öppna butiken',
                    action = function()
                        -- Aquí puedes abrir la tienda
                        TriggerEvent('mfl-dialogue:openShop', '24_7')
                    end
                },
                {
                    label = 'Information',
                    description = 'Få information om butiken',
                    action = function()
                        lib.notify({
                            title = 'Información',
                            description = 'Esta es una tienda 24/7. Vendemos de todo.',
                            type = 'info'
                        })
                    end
                },
                {
                    label = 'Uppdrag',
                    description = 'Fråga om uppdrag',
                    action = function()
                        -- Aquí puedes iniciar una misión
                        TriggerEvent('mfl-dialogue:startMission', 'delivery')
                    end
                },
                {
                    label = 'Avsluta',
                    description = 'Avsluta konversationen',
                    action = function()
                        -- Cierra el diálogo
                    end
                }
            }
        }
    },

    -- Ejemplo: Trabajo de mecánico
    ['mecanico'] = {
        name = 'Mike Johnson',
        model = 's_m_y_construct_01',
        coords = vector4(-347.93, -133.28, 39.01, 70.0),
        dialogue = {
            text = '¿Necesitas ayuda con tu vehículo?',
            options = {
                {
                    label = 'Reparar vehículo',
                    description = 'Reparar tu vehículo ($500)',
                    action = function()
                        TriggerEvent('mfl-dialogue:repairVehicle')
                    end
                },
                {
                    label = 'Solicitar trabajo',
                    description = 'Trabajar como mecánico',
                    action = function()
                        TriggerEvent('mfl-dialogue:startJob', 'mechanic')
                    end
                },
                {
                    label = 'Salir',
                    description = 'Cerrar conversación',
                    action = function()
                        -- Cierra el diálogo
                    end
                }
            }
        }
    }
}
