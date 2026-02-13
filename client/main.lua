local spawnedNPCs = {}
local spawnedBlips = {}
local currentDialogue = nil

-- Función para crear NPCs
local function SpawnNPC(npcData, npcId)
    local model = GetHashKey(npcData.model)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    local npc = CreatePed(4, model, npcData.coords.x, npcData.coords.y, npcData.coords.z - 1.0, npcData.coords.w, false,
        true)

    SetEntityAsMissionEntity(npc, true, true)
    SetPedFleeAttributes(npc, 0, false)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)

    spawnedNPCs[npcId] = npc

    -- Aplicar animación si está configurada
    if npcData.animation then
        if npcData.animation.scenario then
            -- Usar scenario (como WORLD_HUMAN_CLIPBOARD)
            TaskStartScenarioInPlace(npc, npcData.animation.scenario, 0, true)
        elseif npcData.animation.dict and npcData.animation.anim then
            -- Usar animación personalizada
            lib.requestAnimDict(npcData.animation.dict)
            TaskPlayAnim(npc, npcData.animation.dict, npcData.animation.anim, 8.0, 8.0, -1, 1, 0, false, false, false)
        end
    end

    -- Crear blip si está configurado
    if npcData.blip then
        local blip = AddBlipForCoord(npcData.coords.x, npcData.coords.y, npcData.coords.z)
        SetBlipSprite(blip, npcData.blip.sprite or 1)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, npcData.blip.scale or 0.7)
        SetBlipColour(blip, npcData.blip.color or 3)
        SetBlipAsShortRange(blip, npcData.blip.shortRange or false)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(npcData.blip.label or npcData.name)
        EndTextCommandSetBlipName(blip)

        spawnedBlips[npcId] = blip
    end

    -- Configurar ox_target o interacción por distancia
    if Config.UseTarget then
        exports.ox_target:addLocalEntity(npc, {
            {
                name = 'dialogue_' .. npcId,
                icon = Config.TargetIcon,
                label = Config.TargetLabel,
                onSelect = function()
                    OpenDialogue(npcId, npcData)
                end
            }
        })
    end

    return npc
end

-- Función para abrir el diálogo
function OpenDialogue(npcId, npcData)
    if currentDialogue then return end

    currentDialogue = npcId

    -- Preparar datos para enviar al NUI
    local dialogueData = {
        name = npcData.name,
        text = npcData.dialogue.text,
        options = {}
    }

    -- Convertir opciones para el NUI
    for i, option in ipairs(npcData.dialogue.options) do
        table.insert(dialogueData.options, {
            id = i,
            label = option.label,
            description = option.description
        })
    end

    -- Abrir NUI
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openDialogue',
        data = dialogueData
    })

    -- Guardar las acciones para ejecutarlas después
    currentDialogue = {
        id = npcId,
        actions = npcData.dialogue.options
    }
end

-- Callback del NUI cuando se selecciona una opción
RegisterNUICallback('selectOption', function(data, cb)
    cb('ok')

    if currentDialogue and currentDialogue.actions[data.optionId] then
        local action = currentDialogue.actions[data.optionId].action

        -- Cerrar NUI
        SetNuiFocus(false, false)
        currentDialogue = nil

        -- Ejecutar la acción
        if action then
            action()
        end
    end
end)

-- Callback del NUI para cerrar el diálogo
RegisterNUICallback('closeDialogue', function(data, cb)
    cb('ok')
    SetNuiFocus(false, false)
    currentDialogue = nil
end)

-- Cerrar con ESC
RegisterCommand('+cancelDialogue', function()
    if currentDialogue then
        SendNUIMessage({
            action = 'closeDialogue'
        })
        SetNuiFocus(false, false)
        currentDialogue = nil
    end
end)

RegisterKeyMapping('+cancelDialogue', 'Cerrar diálogo', 'keyboard', 'ESCAPE')

-- Thread para interacción sin target
if not Config.UseTarget then
    CreateThread(function()
        while true do
            local sleep = 1000
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for npcId, npcData in pairs(Config.NPCs) do
                local distance = #(playerCoords - vector3(npcData.coords.x, npcData.coords.y, npcData.coords.z))

                if distance < Config.InteractionDistance then
                    sleep = 0

                    -- Mostrar texto de ayuda
                    lib.showTextUI('[E] ' .. Config.TargetLabel)

                    if IsControlJustPressed(0, 38) then -- E key
                        lib.hideTextUI()
                        OpenDialogue(npcId, npcData)
                    end
                elseif distance < Config.InteractionDistance + 1.0 then
                    lib.hideTextUI()
                end
            end

            Wait(sleep)
        end
    end)
end

-- Spawn de NPCs al iniciar el recurso
CreateThread(function()
    Wait(1000) -- Esperar a que el juego cargue

    for npcId, npcData in pairs(Config.NPCs) do
        SpawnNPC(npcData, npcId)
    end
end)

-- Limpiar NPCs y blips al detener el recurso
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    for _, npc in pairs(spawnedNPCs) do
        if DoesEntityExist(npc) then
            DeleteEntity(npc)
        end
    end

    for _, blip in pairs(spawnedBlips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
end)

-- Exportar función para abrir diálogos desde otros recursos
exports('OpenDialogue', OpenDialogue)
