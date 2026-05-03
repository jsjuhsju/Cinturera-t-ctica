-- ==========================================================
-- SCRIPT: SISTEMA TÁCTICO INTEGRADO (CLIENTE)
-- DESARROLLADO PARA JSJUHSJU - VERSIÓN ELITE 2.0
-- ==========================================================

local hasBelt, hasVest = false, false
local currentWeapon = nil
local attachedProps = {}

-- 1. DETECCIÓN DE TRABAJO (Legal vs Ilegal)
function GetUserType()
    local xPlayer = ESX.GetPlayerData()
    if Config.LegalJobs[xPlayer.job.name] then
        return "Legal"
    else
        return "Illegal"
    end
end

-- 2. SISTEMA DE DESENFUNDADO (Pierna/Pecho)
Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local weapon = GetSelectedPedWeapon(playerPed)

        if weapon ~= `WEAPON_UNARMED` and currentWeapon ~= weapon then
            currentWeapon = weapon
            local isPistol = IsPedArmed(playerPed, 2) -- Armas cortas
            local isRifle = IsPedArmed(playerPed, 4)  -- Armas largas

            -- Animación según tipo de arma
            if isPistol then
                -- Movimiento a la cintura/pierna
                RequestAnimDict("reaction@intimidation@1h")
                while not HasAnimDictLoaded("reaction@intimidation@1h") do Wait(0) end
                TaskPlayAnim(playerPed, "reaction@intimidation@1h", "intro", 8.0, 2.0, Config.DrawTime, 48, 10, 0, 0, 0)
                PlaySoundFrontend(-1, "WEAPON_PICKUP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            elseif isRifle then
                -- Movimiento al pecho
                RequestAnimDict("anim@weapons@pistol@aim@assault_rifle")
                while not HasAnimDictLoaded("anim@weapons@pistol@aim@assault_rifle") do Wait(0) end
                TaskPlayAnim(playerPed, "anim@weapons@pistol@aim@assault_rifle", "aim", 8.0, 2.0, Config.DrawTime, 48, 10, 0, 0, 0)
            end
            
            -- Actualizamos Holster Visual
            UpdateHolsterVisual(true)
        elseif weapon == `WEAPON_UNARMED` and currentWeapon ~= nil then
            currentWeapon = nil
            UpdateHolsterVisual(false)
        end
        Wait(500)
    end
end)

-- 3. ACTUALIZACIÓN VISUAL DE FUNDAS
function UpdateHolsterVisual(isArmed)
    local playerPed = PlayerPedId()
    local type = GetUserType()
    local clothing = Config.Clothing[type]

    if hasBelt then
        if isArmed then
            -- Funda vacía si el arma está en la mano
            SetPedComponentVariation(playerPed, 9, clothing.holster_empty, 0, 0)
        else
            -- Funda llena si el arma está guardada
            SetPedComponentVariation(playerPed, 9, clothing.holster_full, 0, 0)
        end
    end
end

-- 4. COMANDO DE AJUSTE PERSONALIZADO (/ajustar)
RegisterCommand('ajustar', function()
    -- Aquí abriremos un menú simple para mover coordenadas (X, Y, Z)
    -- Por ahora, resetea la posición al estándar para evitar bugs
    local playerPed = PlayerPedId()
    ESX.ShowNotification('~y~Modo ajuste: Usa flechas para posicionar (Próximamente UI)')
end)

-- 5. EQUIPAR CINTO / CHALECO
RegisterNetEvent('tactical:usarEquipo')
AddEventHandler('tactical:usarEquipo', function(itemType)
    local playerPed = PlayerPedId()
    local type = GetUserType()
    
    -- Animación de reajuste (Idle)
    RequestAnimDict("clothingtie")
    while not HasAnimDictLoaded("clothingtie") do Wait(0) end
    TaskPlayAnim(playerPed, "clothingtie", "try_tie_neutral_a", 8.0, 1.0, 2000, 49, 0, 0, 0, 0)
    
    if itemType == 'cinto' then
        if not hasBelt then
            SetPedComponentVariation(playerPed, 9, Config.Clothing[type].belt.id, Config.Clothing[type].belt.texture, 0)
            hasBelt = true
            ESX.ShowNotification('~g~Cinturera equipada')
        else
            SetPedComponentVariation(playerPed, 9, 0, 0, 0)
            hasBelt = false
            ESX.ShowNotification('~r~Cinturera guardada')
        end
    elseif itemType == 'chaleco' then
        -- Lógica de chaleco
        if not hasVest then
            SetPedComponentVariation(playerPed, 8, Config.Clothing[type].vest.id, Config.Clothing[type].vest.texture, 0)
            hasVest = true
            ESX.ShowNotification('~b~Chaleco táctico puesto')
        else
            SetPedComponentVariation(playerPed, 8, 0, 0, 0)
            hasVest = false
            ESX.ShowNotification('~r~Chaleco quitado')
        end
    end
end)

-- 6. EFECTO DE PESO (Cansancio)
Citizen.CreateThread(function()
    while true do
        if hasBelt and hasVest then
            local playerPed = PlayerPedId()
            if IsPedSprinting(playerPed) then
                RestorePlayerStamina(PlayerId(), -0.5) -- Cansa más rápido si corre con todo
            end
        end
        Wait(1000)
    end
end)
-- COMANDO PARA REVISAR EL EQUIPO (MIRA LA CINTURA)
RegisterCommand('checkcinto', function()
    local playerPed = PlayerPedId()
    
    -- Animación de mirar la cintura
    RequestAnimDict("amb@world_human_stand_fire@male@idle_a")
    while not HasAnimDictLoaded("amb@world_human_stand_fire@male@idle_a") do Wait(0) end
    TaskPlayAnim(playerPed, "amb@world_human_stand_fire@male@idle_a", "idle_a", 8.0, 1.0, 3000, 49, 0, 0, 0, 0)
    
    ESX.ShowNotification('~b~[SISTEMA]~s~ Revisando cargadores y placas...')
    
    Wait(3000)
    ClearPedTasks(playerPed)
    
    -- Aquí podrías sumar un contador de items de Ox_Inventory
    ESX.ShowNotification('~g~Equipo en buen estado. Cargadores listos.')
end)

