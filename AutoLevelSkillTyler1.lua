if not VIP_USER then _G.LevelSpell = function() end return end
print("LevelSpell override is active")

_G.LevelSpell = function(id)
	local offsets = {
		[_Q] = 0xFB,
		[_W] = 0xEB,
		[_E] = 0xDB,
		[_R] = 0xCB,
	}
	local p = CLoLPacket(0x10A)
	p.vTable = 0xEDD384
	p:EncodeF(myHero.networkID)
	for i = 1, 4 do	p:Encode1(0x13)	end
	p:Encode1(0x9E)
	p:Encode1(offsets[id])
	for i = 1, 4 do	p:Encode1(0x81)	end
	for i = 1, 4 do	p:Encode1(0x57)	end
	for i = 1, 4 do	p:Encode1(0x00)	end
	SendPacket(p)
end

local abilitySequence
local ini=false
local _autoLevel = { spellsSlots = { SPELL_1, SPELL_2, SPELL_3, SPELL_4 }, levelSequence = {}, nextUpdate = 0, tickUpdate = 5 }
local __autoLevel__OnTick
local rOFF=0
--update func--
local version = "2.18"
local AUTOUPDATE = true
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/prado1506/Bol1/master/AutoLevelSkillTyler1.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

function _AutoupdaterMsg(msg) print("<b><font color=\"#FF0000\">Tyler1 Auto Level Spells:</font></b> <font color=\"#FFFFFF\">"..msg.."</font>") end
if AUTOUPDATE then
	local ServerData = GetWebResult(UPDATE_HOST, "/prado1506/Bol1/master/AutoLevelSkillTyler1.version")
	if ServerData then
		ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
		if ServerVersion then
			if tonumber(version) < ServerVersion then
				_AutoupdaterMsg("New version available "..ServerVersion)
				_AutoupdaterMsg("Updating, please don't press F9")
				DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () _AutoupdaterMsg("Successfully updated. ("..version.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 3)
			else
				_AutoupdaterMsg("You have got the latest version ("..ServerVersion..")")
			end
		end
	else
		_AutoupdaterMsg("Error downloading version info")
	end
end
--end updt


function OnTick()
		Start()
		if ini then
			AutoLevel()
		end
end

function Start()
	if Menu.start then
		if player.charName == "Jayce" then CarryRoff()
		else CarryRon() 
		end	
	end
end

function AutoLevel()
	autoLevelSetSequenceCustom(abilitySequence)
end

 function CarryRon()
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

 function CarryRoff()
    local sequence = Menu.sequenceSpells
		  ini = true
		  
        if sequence == 1 then        abilitySequence = { 1, 2, 3, 1, 1, 1, 2, 2, 1, 2, 1, 2, 2, 3, 3, 3, 3, 3, }
	elseif sequence == 2 then        abilitySequence = { 1, 3, 2, 1, 1, 1, 3, 3, 1, 3, 1, 3, 3, 2, 2, 2, 2, 2, }
	elseif sequence == 3 then        abilitySequence = { 2, 1, 3, 2, 2, 2, 1, 1, 2, 1, 2, 1, 1, 3, 3, 3, 3, 3, }
	elseif sequence == 4 then        abilitySequence = { 2, 3, 1, 2, 2, 2, 3, 3, 2, 3, 2, 3, 3, 1, 1, 1, 1, 1, }
	elseif sequence == 5 then        abilitySequence = { 3, 2, 1, 3, 3, 3, 2, 2, 3, 2, 3, 2, 2, 1, 1, 1, 1, 1, }
	elseif sequence == 6 then        abilitySequence = { 3, 1, 2, 3, 3, 3, 1, 1, 3, 1, 3, 1, 1, 2, 2, 2, 2, 2, }
    else PrintChat(string.format(" >> AutoLevelSpell Script disabled for %s", Menu.sequenceSpells))
    end
end

local function autoLevel__OnLoad()
    if not __autoLevel__OnTick then
        function __autoLevel__OnTick()
            local tick = os.clock()
            if _autoLevel.nextUpdate > tick then return end
            _autoLevel.nextUpdate = tick + Menu.DelayTime
            local realLevel = rOFF + GetHeroLeveled()
            if player.level > realLevel and _autoLevel.levelSequence[realLevel + 1] ~= nil then
                local splell = _autoLevel.levelSequence[realLevel + 1]
                if splell == 0 and type(_autoLevel.onChoiceFunction) == "function" then splell = _autoLevel.onChoiceFunction() end
                if type(splell) == "number" and splell >= 1 and splell <= 4 then LevelSpell(_autoLevel.spellsSlots[splell]) end
            end
        end

        AddTickCallback(__autoLevel__OnTick)
    end
end

function autoLevelSetSequenceCustom(sequence)
    assert(sequence == nil or type(sequence) == "table", "autoLevelSetSequence : wrong argument types (<table> or nil expected)")
    autoLevel__OnLoad()
    local sequence = sequence or {}
    for i = 1, 18 do
        local spell = sequence[i]
        if type(spell) == "number" and spell >= 0 and spell <= 4 then
            _autoLevel.levelSequence[i] = spell
       -- else
     --       _autoLevel.levelSequence[i] = nil
        end
    end
end

function RLoad()
	if player.charName == "Jayce" 
	or player.charName == "Elise" 
	or player.charName == "Karma" 
	or player.charName == "Nidalee" then
		rOFF=-1
	else
		rOFF=0
	end
end

function OnLoad()
	print("<b><font color=\"#FF0000\">Tyler1 Auto Level Spells:</font></b> <font color=\"#FFFFFF\">Loading...</font>"..version)
	Menu = scriptConfig("["..myHero.charName.." - AutoLevel]", player.charName.."AutoLevel")
	Menu:addParam("sep1", "1 - Change for Humanizer "..myHero.charName, SCRIPT_PARAM_INFO, "")
	Menu:addParam("DelayTime", "Humanizer Time", SCRIPT_PARAM_SLICE, 1, 1, 60, 0)
	Menu:addParam("sep2", "2 - Define Sequence for "..myHero.charName, SCRIPT_PARAM_INFO, "")
	Menu:addParam("sequenceSpells", "Sequence Spells", SCRIPT_PARAM_LIST, 1, { 'R-Q-W-E', 'R-Q-E-W', 'R-W-Q-E', 'R-W-E-Q', 'R-E-W-Q', 'R-E-Q-W' })
	Menu:addParam("sep3", "3 - for load Script... ", SCRIPT_PARAM_INFO, "")
	Menu:addParam("start", "Just Press Key ", SCRIPT_PARAM_ONKEYDOWN, false, 76)
	Menu:addParam("sep4", "Version Info: ", SCRIPT_PARAM_INFO, version)
	
	RLoad()
	print("<b><font color=\"#FF0000\">Tyler1 Auto Level Spells:</font></b> <font color=\"#FFFFFF\">Sucessfully Loaded..!</font>")
end
