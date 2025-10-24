-- config.lua
-- Centralised configuration for LeaveEngineRunning
-- Loads locale files from locales/<code>.lua which must return a table

Config = {}

-- Which locale to use by default (key must match a file in locales/)
Config.Locale = "en"

-- List of locale codes to attempt to load. Add new codes when you add files.
-- Keep this in sync with files inside the locales/ folder.
Config.AvailableLocales = { "en", "fr" }

Config.Locales = {}

local function safeLoadLocale(code)
    local path = ("locales/%s.lua"):format(code)
    local fileContents = LoadResourceFile(GetCurrentResourceName(), path)
    if not fileContents then
        print(("^1[LeaveEngineRunning] Failed to read locale file %s^0"):format(path))
        return nil
    end

    local f, err = load(fileContents, "="..path)
    if not f then
        print(("^1[LeaveEngineRunning] Failed to load locale file %s: %s^0"):format(path, err))
        return nil
    end

    local ok, res = pcall(f)
    if not ok then
        print(("^1[LeaveEngineRunning] Error executing locale file %s: %s^0"):format(path, res))
        return nil
    end

    if type(res) ~= "table" then
        print(("^1[LeaveEngineRunning] Locale file %s did not return a table.^0"):format(path))
        return nil
    end

    return res
end

-- load all locales
for _, code in ipairs(Config.AvailableLocales) do
    local tbl = safeLoadLocale(code)
    if tbl then
        Config.Locales[code] = tbl
    end
end

if not Config.Locales["en"] then
    print("^1[LeaveEngineRunning] Warning: English locale (en) not loaded — localisation may fallback to keys.^0")
end


-- Other non-localisation config options (kept as before)
Config.RestrictEmer = false
Config.KeepDoorOpen = true
Config.HighBeams = true
Config.Debug = false
