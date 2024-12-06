local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UNIT_AURA")

local function GetPrayerOfMendingTarget()
    -- Include "player" and all party members
    local units = {"player"}
    for i = 1, 4 do
        table.insert(units, "party"..i)
    end

    -- Check for Prayer of Mending
    for _, unit in ipairs(units) do
        for i = 1, 40 do -- Iterate through buffs
            local name = UnitAura(unit, i, "HELPFUL")
            if not name then break end -- No more buffs
            if name == "Prayer of Mending" then
                return unit
            end
        end
    end

    return nil
end

local function UpdateIndicators()
    local target = GetPrayerOfMendingTarget()
    if target then
        print(target .. " has Prayer of Mending!") -- Example: print target unit name
        -- Implement your custom UI changes here
        -- Unit frame customization would require additional libraries (e.g., oUF, WeakAuras)
    else
        print("No Prayer of Mending found.")
    end
end

f:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_AURA" then
        UpdateIndicators()
    end
end)
