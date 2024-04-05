local markeriMostrati = {
    raccolta = false,                     -- False mostra il Marker | True non lo mostra
    processo = false,                     -- False mostra il Marker | True non lo mostra
}

local ox = exports.ox_inventory

Citizen.CreateThread(function()
    for k, v in ipairs(Config.Droghe) do
        CreaMarker("raccolta", k, v.posizione_raccolta, "RACCOLTA " .. v.nome, function()
            TriggerEvent("peppegnegne:progressbarraccolta", k)
            markeriMostrati.raccolta = true
        end)
        CreaMarker("processo", k, v.posizione_processo, "PROCESSO " .. v.nome, function()
            TriggerEvent("peppegnegne:cercaitemprocesso", k)
            markeriMostrati.processo = true
        end)       
    end
end)


function CreaMarker(categoria, indice, posizione, messaggio, azione)
    local nomeMarker = categoria .. "droga" .. indice
    if not markeriMostrati[categoria] then
        TriggerEvent('gridsystem:registerMarker', {
            name = nomeMarker,
            pos = posizione,
            scale = vector3(1.0, 1.0, 1.0),
            msg = messaggio,
            control = 'E',
            type = Config.Tipo,
            texture = Config.NomeTexture,
            color = { r = 0, g = 255, b = 0 },
            action = azione
        })
    end
end


-- PROGRESS BAR
function MostraProgressBar(etichetta, alCompletamento, durata)
    local opzioni = {
        Async = true,
        canCancel = true,
        cancelKey = 178,
        x = 0.5,
        y = 0.5,
        From = 0,
        To = 100,
        Duration = durata or 1000,
        Radius = 60,
        Stroke = 10,
        Cap = 'butt',
        Padding = 0,
        MaxAngle = 360,
        Rotation = 0,
        Width = 300,
        Height = 40,
        ShowTimer = true,
        ShowProgress = false,
        Easing = "easeLinear",
        Label = etichetta,
        LabelPosition = "bottom",
        Color = "rgba(255, 255, 255, 1.0)",
        BGColor = "rgba(0, 0, 0, 0.4)",
        Animation = {
            animationDictionary = "mini@repair",
            animationName = "fixing_a_ped",
        },
        DisableControls = {
            Vehicle = true
        },    
        onStart = function()
        end,
        onComplete = alCompletamento
    }
    
    if Config.rprogress then
        exports.rprogress:Custom(opzioni)
    else
        lib.progressCircle({
            duration = opzioni.Duration,
            position = 'middle',
            label = etichetta,
            useWhileDead = false,
            canCancel = opzioni.canCancel,
            disable = opzioni.DisableControls,
            anim = {
                dict = opzioni.Animation.animationDictionary,
                clip = opzioni.Animation.animationName
            }
        })
        if alCompletamento then
            alCompletamento()
        end
    end
end



RegisterNetEvent("peppegnegne:progressbarraccolta")
AddEventHandler("peppegnegne:progressbarraccolta", function(drogaId)
    local alCompletamento = function(annullato)
        TriggerServerEvent("peppegnegne:daiitemdroga", drogaId)
    end
    MostraProgressBar("Stai raccogliendo della droga", alCompletamento, Config.Durata)
end)

RegisterNetEvent("peppegnegne:cercaitemprocesso")
AddEventHandler("peppegnegne:cercaitemprocesso", function(drogaId)
    local ID = source
    local droga = Config.Droghe[drogaId]
    local alCompletamento = function(annullato)
        TriggerServerEvent("peppegnegne:daiitemprocesso", drogaId)
    end
    local haDroga = ox:Search('count', droga.itemDaRaccogliere) 
    if haDroga < droga.quantitaProcesso then
        ESX.ShowNotification("Non hai abbastanza droga da processare!")
    else
        MostraProgressBar("Stai processando della droga", alCompletamento, Config.Durata)
    end
end)

Citizen.CreateThread(function()
    -- Aggiungi blip per le posizioni di raccolta, processo e vendita
    for _, droga in ipairs(Config.Droghe) do
        -- Blip per la posizione di raccolta
        if Config.BlipRaccoltaAttivo then
            local blipRaccolta = AddBlipForCoord(droga.posizione_raccolta)
            SetBlipSprite(blipRaccolta, 496) --cambia il codice del blip in base a quello che vuoi mostrare in minimap
            SetBlipDisplay(blipRaccolta, 4)
            SetBlipScale(blipRaccolta, 1.3)
            SetBlipColour(blipRaccolta, 2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Raccolta di Cannabis")
            EndTextCommandSetBlipName(blipRaccolta)
        end

        -- Blip per la posizione di processo
        if Config.BlipProcessoAttivo then
            local blipProcesso = AddBlipForCoord(droga.posizione_processo)
            SetBlipSprite(blipProcesso, 469)     --cambia il codice del blip in base a quello che vuoi mostrare in minimap
            SetBlipDisplay(blipProcesso, 4)
            SetBlipScale(blipProcesso, 1.3)
            SetBlipColour(blipProcesso, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Processo di Hashish " )
            EndTextCommandSetBlipName(blipProcesso)
        end        
    end
end)
