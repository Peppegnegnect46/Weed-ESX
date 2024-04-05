RegisterNetEvent("peppegnegne:daiitemprocesso")
AddEventHandler("peppegnegne:daiitemprocesso", function(drogaId)
    local ID = source
    local droga = Config.Droghe[drogaId]
    exports.ox_inventory:RemoveItem(ID, droga.itemDaRaccogliere, droga.quantitaProcesso)
    exports.ox_inventory:AddItem(ID, droga.itemProcessato, droga.quantitaProcessoFrutto)
    TriggerClientEvent('okokNotify:Alert', ID, 'Droga', 'Droga processata con successo', 2000, 'success', true)    -- Cambia l export in base al tuo utilizzo
end)

RegisterNetEvent("peppegnegne:daiitemdroga")
AddEventHandler("peppegnegne:daiitemdroga", function(drogaId)
    local ID = source
    local droga = Config.Droghe[drogaId]
    if droga then
        exports.ox_inventory:AddItem(ID, droga.itemDaRaccogliere, droga.quantitaRaccolta)
        TriggerClientEvent('okokNotify:Alert', ID, 'Droga', 'Droga raccolta con successo', 2000, 'info', true) -- Cambia l export in base al tuo utilizzo
    end
end)