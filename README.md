# MFL Dialogue System

![ebd272a09361e8158e12c3204363cb32](https://github.com/user-attachments/assets/412d9945-8c66-4996-8152-2ec8750d6985)

A modern and elegant NPC dialogue system for FiveM with a clean design and full functionality.

## Features

✅ Modern and elegant design with a dark theme  
✅ Support for multiple dialogue options  
✅ Integration with `ox_target` or distance-based interaction  
✅ Event system to connect with jobs, shops, and more  
✅ Fully configurable  
✅ Smooth animations  
✅ Numeral key support for quick selection

## Installation

1. Place the resource in your `resources/[mfl]/` folder.
2. Add `ensure mfl-dialogue` to your `server.cfg`.
3. Configure your NPCs in `config/config.lua`.
4. Restart the server or start the resource.

## Configuration

### Adding an NPC with Dialogue

Edit `config/config.lua` and add a new NPC to `Config.NPCs`:

```lua
Config.NPCs = {
    ['my_npc_id'] = {
        name = 'NPC name',
        model = 'ped_model', -- Example: 'mp_m_shopkeep_01'
        coords = vector4(x, y, z, heading),
        dialogue = {
            text = 'Dialogue text spoken by the NPC',
            options = {
                {
                    label = 'Option 1',
                    description = 'Description of the option',
                    action = function()
                        -- Code executed when selecting this option
                        TriggerEvent('my_event')
                    end
                },
                {
                    label = 'Option 2',
                    description = 'Another description',
                    action = function()
                        -- Another code block
                    end
                }
            }
        }
    }
}
```

## Usage Examples

### Garbage Job Integration (qbx_garbagejob)

The `garbage_boss` NPC comes pre-integrated and ready to use:

```lua
['garbage_boss'] = {
    name = 'Carlos Rodríguez',
    model = 's_m_y_garbage',
    coords = vector4(-321.45, -1545.86, 31.02, 180.0),
    dialogue = {
        text = 'Hello! Looking for work picking up trash? It pays well and it is easy.',
        options = {
            {
                label = 'Start Route',
                description = 'Begin working ($250 deposit)',
                action = function()
                    TriggerEvent('qb-garbagejob:client:RequestRoute')
                end
            },
            {
                label = 'Collect Pay',
                description = 'Collect your salary',
                action = function()
                    TriggerEvent('qb-garbagejob:client:RequestPaycheck')
                end
            }
        }
    }
}
```

This NPC replaces the need for the city hall for garbage jobs and allows:
- ✅ Starting a garbage route
- ✅ Collecting salary
- ✅ Getting job information

### Opening a Shop

```lua
{
    label = 'Buy Items',
    description = 'Open the local shop',
    action = function()
        exports.ox_inventory:openInventory('shop', { type = '24_7' })
    end
}
```

### Starting a Job

```lua
{
    label = 'Apply for Job',
    description = 'Start working as a mechanic',
    action = function()
        TriggerEvent('qb-jobs:client:startJob', 'mechanic')
    end
}
```

### Showing a Notification

```lua
{
    label = 'Information',
    description = 'Get more details',
    action = function()
        lib.notify({
            title = 'Info',
            description = 'This is an information message from the NPC.',
            type = 'info'
        })
    end
}
```

### Opening a Context Menu (ox_lib)

```lua
{
    label = 'See Options',
    description = 'Open a menu with more options',
    action = function()
        lib.registerContext({
            id = 'my_menu',
            title = 'Options Menu',
            options = {
                {
                    title = 'Sub-option 1',
                    description = 'Do something else',
                    onSelect = function()
                        print('Sub-option selected')
                    end
                }
            }
        })
        lib.showContext('my_menu')
    end
}
```

## Controls

- **Left Mouse Click**: Select an option.
- **Numeral Keys (1-4)**: Quick option selection.
- **ESC**: Close the dialogue.

## Exports

### Open dialogue from another resource

```lua
exports['mfl-dialogue']:OpenDialogue('npc_id', npcData)
```

## Dependencies

- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target](https://github.com/overextended/ox_target) (optional, if `Config.UseTarget = true`)

## Credits

Created by **MFL Scripts**
