-- Tyler1 Auto Level Spells --
local version = "0.2"
 
local abilitySequence
local qOff, wOff, eOff, rOff = 0,0,0,0

function OnTick()
    if Menu.Ads.AutoLevelspells then
	Carry()
        AutoLevel()
    end
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
        PrintChat(" >> Auto Level Spells 0.1 ")
    else
        PrintChat(" >> Error")
        OnTick = function() end
        return
    end
end

function AutoLevel()
    local qL, wL, eL, rL = player:GetSpellData(_Q).level + qOff, player:GetSpellData(_W).level + wOff, player:GetSpellData(_E).level + eOff, player:GetSpellData(_R).level + rOff
    if qL + wL + eL + rL < player.level then
        local spellSlot = { SPELL_1, SPELL_2, SPELL_3, SPELL_4, }
        local level = { 0, 0, 0, 0 }
        for i = 1, player.level, 1 do
            level[abilitySequence[i]] = level[abilitySequence[i]] + 1
        end
        for i, v in ipairs({ qL, wL, eL, rL }) do
            if v < level[i] then LevelSpell(spellSlot[i]) end
        end
    end
end
 
function OnLoad()
	Menu = scriptConfig("AutoLevel", player.charName)
	Menu:addSubMenu("["..myHero.charName.." - AutoLevel]", "Ads")
	Menu.Ads:addParam("sequenceSpells", "Sequence Spells", SCRIPT_PARAM_LIST, 1, { 'RQWE', 'RQEW', 'RWQE', 'RWEQ', 'REWQ', 'REQW' })
	Menu.Ads:addParam("AutoLevelspells", "Auto-Level Spells", SCRIPT_PARAM_ONOFF, false)
end
