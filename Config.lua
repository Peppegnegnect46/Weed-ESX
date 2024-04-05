Config = {}

-- Impostazioni generali
Config.Tipo = 2  -- Tipo di marker
Config.NomeTexture = "general" -- Nome della texutre
Config.rprogress = true  -- Vuoi utilizzare lo script rprogress? se impostato su false utilizzerà la progressBar di LIB
Config.Durata = 2000 -- Durata della progressBar per ogni processo

-- Impostazioni delle droghe
Config.Droghe = {
    {
        nome = "Marijuana",
        posizione_raccolta = vector3(2220.2971, 5578.0869, 53.7254),  -- Configura le coordinate 
        posizione_processo = vector3(-1.0923, -2497.3513, -8.9624),
        itemDaRaccogliere = "marijuana_da_processare",
        itemProcessato = "marijuana_processata",
        quantitaProcesso = 2,
        quantitaProcessoFrutto = 1,
        quantitaRaccolta = 1,
        prezzoUnitario = 300,
    },
     --[[{
        nome = "nome della droga",
        posizione_raccolta = vector3(coordinate),
        posizione_processo = vector3(coordinate),
        posizione_vendita = vector3(coordinate),
        itemDaRaccogliere = "nome_item",
        itemProcessato = "nome_item",
        quantitaProcesso = X,
        quantitaProcessoFrutto = X,
        quantitaRaccolta = X,
    },]]
    -- Puoi aggiungere quante droghe vuoi!
}

-- Impostazioni per abilitare o disabilitare i blip
Config.BlipRaccoltaAttivo = true  
Config.BlipProcessoAttivo = true
