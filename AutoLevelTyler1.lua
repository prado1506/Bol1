local version = "0.4"
local abilitySequence
local qOff, wOff, eOff, rOff = 0,0,0,0

function OnTick()

    if Menu.Ads.AutoLevelspells and Menu.start then
		Carry()
        AutoLevel()
    end
end	

function AutoLevel()
    autoLevelSetSequence(abilitySequence)
end
 
 function Carry()
    local sequence = Menu.Ads.sequenceSpells
	
        if sequence == 1 then        abilitySequence = { 1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
	elseif sequence == 2 then        abilitySequence = { 1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
	elseif sequence == 3 then        abilitySequence = { 2, 1, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
	elseif sequence == 4 then        abilitySequence = { 2, 3, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
	elseif sequence == 5 then        abilitySequence = { 3, 2, 1, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
	elseif sequence == 6 then        abilitySequence = { 3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
    else PrintChat(string.format(" >> AutoLevelSpell Script disabled for %s", Menu.Ads.sequenceSpells))
    end
	if abilitySequence and #abilitySequence == 18 then
        PrintChat(" >> Carry Tyler1 Auto Level Spells "..version.."")
    else
        PrintChat(" >> Error")
        OnTick = function() end
        return
    end
end

function OnLoad()

	PrintChat(" >> Loading Tyler1 Auto Level Spells "..version.."")
	Menu = scriptConfig("AutoLevel", player.charName)
	Menu:addSubMenu("["..myHero.charName.." - AutoLevel]", "Ads")
    Menu.Ads:addParam("sequenceSpells", "Sequence Spells", SCRIPT_PARAM_LIST, 1, { 'RQWE', 'RQEW', 'RWQE', 'RWEQ', 'REWQ', 'REQW' })
	Menu.Ads:addParam("AutoLevelspells", "Auto-Level Spells", SCRIPT_PARAM_ONOFF, false)
	Menu:addParam("sep", "-- Active Script --", SCRIPT_PARAM_INFO, "")
	Menu.addParam("start", "Auto-Level Start", SCRIPT_PARAM_ONOFF, false)
	PrintChat(" >> Tyler1 Auto Level Spells Loaded..")
end
