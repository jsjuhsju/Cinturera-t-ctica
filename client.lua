-- Configuración de los Props por defecto de GTA V
local cintoPolicia = 10 -- ID del cinturón de LSPD
local cintoCriminal = 6  -- ID de una cartuchera más simple

RegisterNetEvent('tactical_belt:usarCinto')
AddEventHandler('tactical_belt:usarCinto', function()
    local playerPed = PlayerPedId()
    local xPlayer = ESX.GetPlayerData()

    if not hasBelt then
        -- Si es policía, usa el modelo de LSPD
        if xPlayer.job.name == 'police' then
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
