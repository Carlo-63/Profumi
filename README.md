# Script per profumi Fivem

## Introduzione

Questo script per il framework **ESX** in FiveM aggiunge la possibilità di applicare profumi personalizzati ai personaggi dei giocatori.
I profumi influenzano l'interazione con gli altri giocatori, che possono percepire l'odore quando si trovano vicini.

---

## Funzionalità

- **Applicazione dei profumi**: I giocatori possono applicare profumi specifici attraverso il proprio inventario.
- **Notifica agli altri giocatori**: I giocatori vicini riceveranno una notifica con l'odore del profumo applicato.
- **Configurazione personalizzabile**: Supporta una vasta gamma di profumi configurabili tramite il file `Config`.

---

## Requisiti

- **FiveM Server** con framework **ESX** installato.
- **MySQL** o un database compatibile per la gestione dell'inventario.
- Una risorsa per la gestione degli oggetti (esempio: `ox_inventory`).

---

## Installazione

### Passaggi

1. **Scarica e installa lo script**:
   - Inserisci la cartella dello script nella directory `resources` del tuo server FiveM.

2. **Configura gli oggetti**:
   - Aggiungi i profumi al tuo file di configurazione per il sistema di inventario (esempio: `ox_inventory` o altro). Esempio di configurazione per `ox_inventory`:
     ```lua
     ["profumo1"] = {
         label = "Profumo 1",
         weight = 0,
         stack = true,
     }
     ```

3. **Aggiungi il file di configurazione**:
   - Configura il file `config.lua` con i profumi desiderati. Esempio:
     ```lua
     Config.Perfumes = {
         { itemName = "profumo1", smell = "Odore Profumo 1", label = "Profumo 1" },
     }
     ```

4. **Avvia lo script**:
   - Aggiungi il nome dello script al file `server.cfg` del tuo server FiveM:

---

## Configurazione

### Configurazione del file `config.lua`

Nel file `config.lua`, puoi definire i profumi disponibili. Ogni profumo richiede:
- `itemName`: Il nome dell'oggetto (deve corrispondere al nome usato nel sistema di inventario).
- `smell`: L'odore che sarà visibile ai giocatori.
- `label`: Il nome visualizzato nel gioco.

Esempio:
```lua
Config.Perfumes = {
    { itemName = "profumo1", smell = "Odore Profumo 1", label = "Profumo 1" },
    { itemName = "profumo2", smell = "Odore Profumo 2", label = "Profumo 2" },
    { itemName = "profumo3", smell = "Odore Profumo 3", label = "Profumo 3" }
}
```

### Configurazione degli oggetti nell'inventario

Nel tuo script di inventario (esempio: `ox_inventory`), devi definire gli oggetti corrispondenti ai profumi. Esempio:
```lua
["profumo1"] = {
    label = "Profumo 1",
    weight = 0,
    stack = true,
},
["profumo2"] = {
    label = "Profumo 2",
    weight = 0,
    stack = true,
},
["profumo3"] = {
    label = "Profumo 3",
    weight = 0,
    stack = true,
}
```

---

## Utilizzo

### Comandi

- **Applicare un profumo**:
  - Apri il tuo inventario e utilizza uno degli oggetti profumo.
  - Il profumo verrà applicato al tuo personaggio e gli altri giocatori nelle vicinanze potranno percepirlo.

- **Notifica automatica**:
  - I giocatori vicini saranno automaticamente notificati dell'odore del profumo.

- **Aumento stamina**:
  - La stamina del giocatore verrà impostata al 100% per la il tempo impostato dal config (standard 15 secondi).

---

## Note Aggiuntive

- Puoi personalizzare il raggio delle notifiche nel config:
  ```lua
  Config.NotifiationDistance = 3
  ```

- Puoi personalizzare la durata degli effetti dei profumi nel config:
  ```lua
  -- Durata in millisecondi
  Config.Time = 15000
  ```
---

## Crediti

Script sviluppato da Carlo 63.  
Supporto ESX grazie al framework di base fornito da **es_extended**.  

---