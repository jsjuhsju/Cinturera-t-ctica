-- ==========================================================
-- SCRIPT: CINTURERA TÁCTICA PRO (ESX)
-- REESCRITO TOTALMENTE POR GEMINI PARA JSJUHSJU
-- ==========================================================

local hasBelt = false -- Variable para saber si lo llevamos puesto
local cintoPolicia = 10 -- ID del cinturón de LSPD
local cintoCriminal = 6  -- ID de una cartuchera más simple

-- Función para la animación de ponerse/quitarse el cinto
function AnimacionCinto()
    local playerPed = PlayerPedId()
    -- Carga la animación
    RequestAnimDict("clothingtie")
    while not HasAnimDictLoaded("clothingtie") do
        Wait(10)
    end
    -- Ejecuta la animación (dura unos 2 segundos)
    TaskPlayAnim(playerPed, "clothingtie", "try_tie_neutral_a", 8.0, 1.0, 2000, 49, 0, 0, 0, 0)
    Wait(2000) -- Esperamos a que termine la animación
    ClearPedTasks(playerPed)
end

-- EVENTO PRINCIPAL PARA USAR EL CINTO
RegisterNetEvent('tactical_belt:usarCinto')
AddEventHandler('tactical_belt:usarCinto', function()
    local playerPed = PlayerPedId()
    local xPlayer = ESX.GetPlayerData()

    -- Iniciamos la animación antes de cambiar la ropa
    AnimacionCinto()

    if not hasBelt then
        -- Si es policía, usa el modelo de LSPD
        if xPlayer.job and xPlayer.job.name == 'police' then
            SetPedComponentVariation(playerPed, 9, cintoPolicia, 0, 0)
        else
            -- Si es civil/criminal, usa el modelo básico
            SetPedComponentVariation(playerPed, 9, cintoCriminal, 0, 0)
        end
        hasBelt = true
        ESX.ShowNotification('Cintura táctica equipada')
    else
        -- Quitar el componente (0 es vacío)
        SetPedComponentVariation(playerPed, 9, 0, 0, 0)
        hasBelt = false
        ESX.ShowNotification('Cintura táctica guardada')
    end
end)

-- COMANDO PARA PODER PROBARLO SIN DEPENDER DE ITEMS
RegisterCommand('cinto', function()
    TriggerEvent('tactical_belt:usarCinto')
end, false)


