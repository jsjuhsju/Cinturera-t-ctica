-- ==========================================================
-- SCRIPT: SISTEMA TÁCTICO INTEGRADO (SERVIDOR)
-- LÓGICA DE ITEMS Y MUNICIÓN - PARA JSJUHSJU
-- ==========================================================

local ox_inventory = exports.ox_inventory

-- 1. REGISTRO DE ITEMS (Cinto y Chaleco)
ESX.RegisterUsableItem('cinto_tactico', function(source)
    TriggerClientEvent('tactical:usarEquipo', source, 'cinto')
end)

ESX.RegisterUsableItem('chaleco_tactico', function(source)
    TriggerClientEvent('tactical:usarEquipo', source, 'chaleco')
end)

-- 2. LÓGICA DE CARGADORES (Unir Balas + Cargador Vacio)
-- Ejemplo para 9mm (Pistola)
exports('use_ammo_9mm', function(event, item, inventory, slot, data)
    if event == 'usingItem' then
        local player = inventory.id
        local emptyMag = ox_inventory:GetSlotWithItem(player, Config.Ammo['9mm'].item_mag_empty)

        if emptyMag then
            -- Quitamos 1 cargador vacío y las balas
            ox_inventory:RemoveItem(player, Config.Ammo['9mm'].item_mag_empty, 1)
            
            -- Creamos el cargador lleno con METADATA (Balas reales)
            local metadata = {
                ammo = Config.Ammo['9mm'].capacity,
                type = '9mm',
                description = 'Cargador lleno: '..Config.Ammo['9mm'].capacity..' proyectiles'
            }
            ox_inventory:AddItem(player, Config.Ammo['9mm'].item_mag_full, 1, metadata)
            
            TriggerClientEvent('esx:showNotification', player, '~g~Has llenado un cargador de 9mm')
        else
            TriggerClientEvent('esx:showNotification', player, '~r~No tienes cargadores vacíos compatibles')
        end
        return false -- Detiene el uso normal para que no desaparezcan las balas sin el cargador
    end
end)

-- 3. VERIFICACIÓN DE MUNICIÓN AL RECARGAR (Hooks de Ox)
-- Este hook detecta cuando el jugador intenta recargar
exports('ox_inventory:onKey', function(source, key, down)
    if key == 'r' and down then -- Si presiona la R
        -- Aquí podrías añadir lógica extra para verificar si el cargador en el cinto es el correcto
    end
end)

-- 4. PERSISTENCIA DE ARMADURA (Placas de Cerámica)
ESX.RegisterUsableItem('placa_ceramica', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    -- Añadimos armadura al jugador a través del cliente
    TriggerClientEvent('tactical:addArmor', source, 50) -- Añade 50 de armadura
    ox_inventory:RemoveItem(source, 'placa_ceramica', 1)
    TriggerClientEvent('esx:showNotification', source, '~b~Placa de cerámica insertada en el chaleco')
end)

-- 5. BONIFICACIÓN DE PESO
-- Ox_inventory maneja el peso automáticamente si configuras el item en el data/items.lua
-- Pero aquí podemos forzar un refresco si es necesario.
