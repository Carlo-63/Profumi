local ESX = exports['es_extended']:getSharedObject()

-- Variabile per tracciare l'odore corrente
local currentSmell = nil
local notifiedPlayers = {}

-- Distanza per notifiche
local notificationDistance = Config.NotificationDistance;

-- Funzione di debug
local function Debug(message)
    print("^3[DEBUG - Smell Script]: ^7" .. message)
end

-- Usa il profumo
RegisterNetEvent('smell:usePerfume')
AddEventHandler('smell:usePerfume', function(itemName)
    Debug("Tentativo di usare il profumo: " .. itemName)

    -- Cerca il profumo nel Config
    local foundPerfume = nil
    for _, perfume in pairs(Config.Perfumes) do
        if perfume.itemName == itemName then
            foundPerfume = perfume
            break
        end
    end

    if foundPerfume then
        Debug("Profumo trovato: " .. foundPerfume.smell)
        TriggerServerEvent('smell:setSmell', foundPerfume.smell)
        ESX.ShowNotification("Hai applicato il profumo ~y~" .. foundPerfume.smell .. "~s~.")

        -- Salva il tempo iniziale
        local startTime = GetGameTimer()

        -- Ciclo che esegue operazioni per 15 secondi
        while GetGameTimer() - startTime < Config.Time do
            -- Inserisci qui l'operazione che desideri eseguire
            RestorePlayerStamina(PlayerId(), 1.0)
            print("La stamina sta venendo impostata al 100%... (" .. (GetGameTimer() - startTime) .. ")")
    
            Citizen.Wait(0) -- La funzione Citizen.Wait() permette di non bloccare il thread
        end
    else
        Debug("Profumo non trovato nel Config.")
        ESX.ShowNotification("~r~Errore: profumo non trovato.")
    end
end)

-- Imposta l'odore corrente
RegisterNetEvent('smell:set')
AddEventHandler('smell:set', function(smell)
    currentSmell = smell
    notifiedPlayers = {}
    Debug("Olfatto impostato: " .. smell)
    ESX.ShowNotification("Hai un nuovo odore: ~y~" .. smell)
end)

-- Mostra il proprio odore
RegisterNetEvent('smell:get')
AddEventHandler('smell:get', function()
    if currentSmell then
        ESX.ShowNotification("Attualmente odori di ~y~" .. currentSmell)
    else
        ESX.ShowNotification("~r~Non hai nessun odore impostato.")
    end
end)

-- Notifica altri giocatori vicini
RegisterNetEvent('smell:notify')
AddEventHandler('smell:notify', function(smell)
    ESX.ShowNotification("Noti l'odore di ~y~" .. smell .. " ~s~su un altro giocatore.")
end)

-- Thread per notificare i giocatori vicini
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if currentSmell then
            local players = GetNearbyPlayers(notificationDistance)
            for _, player in ipairs(players) do
                local playerId = GetPlayerServerId(player)
                if not has_value(notifiedPlayers, playerId) then
                    TriggerServerEvent('smell:notifyPlayer', playerId, currentSmell)
                    table.insert(notifiedPlayers, playerId)
                end
            end
        end
    end
end)

-- Funzioni ausiliarie
function GetNearbyPlayers(distance)
    local players = GetActivePlayers()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    local returnablePlayers = {}

    for _, player in ipairs(players) do
        local target = GetPlayerPed(player)
        if target ~= ply then
            local targetCoords = GetEntityCoords(target)
            local dist = #(plyCoords - targetCoords)
            if dist < distance then
                table.insert(returnablePlayers, player)
            end
        end
    end
    return returnablePlayers
end

function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end
