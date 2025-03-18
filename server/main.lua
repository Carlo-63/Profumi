local ESX = exports['es_extended']:getSharedObject()

-- Funzione di debug
local function Debug(message)
    print("^3[DEBUG - Smell Script]: ^7" .. message)
end

-- Registra gli item direttamente da Config
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for _, perfume in pairs(Config.Perfumes) do
            ESX.RegisterUsableItem(perfume.itemName, function(source)
                local xPlayer = ESX.GetPlayerFromId(source)
                if xPlayer.getInventoryItem(perfume.itemName).count > 0 then
                    -- Rimuove l'item e attiva il profumo
                    xPlayer.removeInventoryItem(perfume.itemName, 1)
                    TriggerClientEvent('smell:usePerfume', source, perfume.itemName)
                    Debug("Profumo usato: " .. perfume.itemName .. " da ID: " .. source)
                else
                    Debug("Tentativo di usare un item non presente nell'inventario: " .. perfume.itemName)
                    TriggerClientEvent('esx:showNotification', source, "~r~Non hai questo profumo nel tuo inventario.")
                end
            end)
            Debug("Item registrato: " .. perfume.itemName .. " (" .. perfume.smell .. ")")
        end
    end
end)

-- Imposta l'odore sul giocatore
RegisterNetEvent('smell:setSmell')
AddEventHandler('smell:setSmell', function(smell)
    local xPlayer = ESX.GetPlayerFromId(source)
    Debug("Impostazione odore '" .. smell .. "' per il giocatore ID: " .. source)
    TriggerClientEvent('smell:set', source, smell)
end)

-- Notifica altri giocatori vicini
RegisterNetEvent('smell:notifyPlayer')
AddEventHandler('smell:notifyPlayer', function(player, smell)
    Debug("Invio notifica a ID: " .. player .. " sull'odore: " .. smell)
    TriggerClientEvent('smell:notify', player, smell)
end)
