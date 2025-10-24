# LeaveEngineRunning

**LeaveEngineRunning** is a modern FiveM resource that lets players leave their vehicle engine running when exiting. It features full networked engine and lights states, optimised performance, and localisation support.

---

## Key Features

- **Networked Engine & Lights:** All players see engine and light states in real time.  
- **Optimised Performance:** Idle threads minimise CPU/resmon impact.  
- **One-Time Notification:** Localised message appears once per session.  
- **Auto Light-Off:** Turns off lights when leaving vehicle without leaving engine running.  
- **Configurable Options:** Emergency restriction, door open, high beams, debug mode.  
- **Localisation Support:** `en.lua`, `fr.lua`, easy to add more languages.  
- **Original Behaviour Preserved:** Hold `F` to leave engine running.

---

## Installation

1. Clone/download to your `resources` folder:

```bash
git clone https://github.com/<your-username>/LeaveEngineRunning.git
```

2. Add to `server.cfg`:

```bash
ensure LeaveEngineRunning
```

## Configuration

Settings are in `config.lua`:

```bash
Config = {}

Config.RestrictEmer = false    -- Only allow feature for emergency vehicles
Config.KeepDoorOpen = true     -- Keep doors open when exiting
Config.HighBeams = true        -- Keep full-beam lights on
Config.Debug = false           -- Enable debug messages

Config.Locale = 'en'           -- Default language
Config.AvailableLocales = {'en', 'fr'}
Config.Locales = {}            -- Loaded automatically from locales/
```

## Controls

- Hold F while exiting a vehicle to leave the engine running.
- Lights and engine state sync automatically.
- Auto light-off triggers if engine is not left running.

## Changelog (v2.0.0)

- Networked engine and lights.
- Full localisation support.
- Optimised threads (near-zero CPU impact).
- Auto-turn-off lights.
- Config moved to config.lua.
- Notification shows once per session.

## License

MIT License — free to use and modify in your FiveM projects.
