local version = "1.5"
local abilitySequence
local ini=false

function OnTick()
		Start()
		if ini then
			AutoLevel()
		end
end

function Start()

	if Menu.start then 
		Carry()
	end
end
	

function AutoLevel()
    autoLevelSetSequence(abilitySequence)
end
 
 function Carry()
    local sequence = Menu.sequenceSpells
		  ini = true
		  
        if sequence == 1 then        abilitySequence = { 1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
	elseif sequence == 2 then        abilitySequence = { 1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
	elseif sequence == 3 then        abilitySequence = { 2, 1, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
	elseif sequence == 4 then        abilitySequence = { 2, 3, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
	elseif sequence == 5 then        abilitySequence = { 3, 2, 1, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
	elseif sequence == 6 then        abilitySequence = { 3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
    else PrintChat(string.format(" >> AutoLevelSpell Script disabled for %s", Menu.sequenceSpells))
    end
end

function OnLoad()

	PrintChat(" >> Loading Tyler1 Auto Level Spells "..version.."")
	Menu = scriptConfig("["..myHero.charName.." - AutoLevel]", player.charName)

	Menu:addParam("sep1", "2 - Define Sequence for "..myHero.charName, SCRIPT_PARAM_INFO, "")
    Menu:addParam("sequenceSpells", "Sequence Spells", SCRIPT_PARAM_LIST, 1, { 'RQWE', 'RQEW', 'RWQE', 'RWEQ', 'REWQ', 'REQW' })
	Menu:addParam("sep3", "3 - for load Script... ", SCRIPT_PARAM_INFO, "")
	Menu:addParam("start", "Just Press Key ", SCRIPT_PARAM_ONKEYDOWN, false, 76)

	PrintChat(" >> Tyler1 Auto Level Spells Loaded..")
end