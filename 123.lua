require('Inspired')
if GetObjectName(myHero) ~= "Kog'Maw" then return end

Kog'Maw = MenuConfig("Kog'Maw", "Kog'Maw")
Kog'Maw:KeyBinding("Combo", "Combo", 32)

Kog'Maw:Menu("Spells", "Spells")
Kog'Maw.Spells:Info("InfoSpells", "En-/Disable Spells to use in Combo")
Kog'Maw.Spells:Boolean("C", "Q", true)
Kog'Maw.Spells:Boolean("W", "W", true)
Kog'Maw.Spells:Boolean("E", "E", true)
Kog'Maw.Spells:Boolean("R", "R", true)

Kog'Maw:Menu("KS", "Ks")
Kog'Maw.KS:Info("InfoKS", "AutoIgnite")
Kog'Maw.KS:Boolean("I", "Ignite", true)
Kog'Maw.KS:Boolean("KS", "Killsteal", true)

Kog'Maw:Menu("Draw", "Drawings")
Kog'Maw.Draw:Boolean("Draw", "Draw", true)
Kog'Maw.Draw:Boolean("Q", "Draw Q", true)
Kog'Maw.Draw:Boolean("W", "Draw W", true)
Kog'Maw.Draw:Boolean("E", "Draw E", true)
Kog'Maw.Draw:Boolean("R", "Draw E", false)

------------------------------------------
--Variables
------------------------------------------
local myHero = GetMyHero()
local myTeam = GetTeam(myHero)

------------------------------------------
--Ignite Stuff
------------------------------------------
local function IsIgnited(o)
  return GotBuff(o, "summonerdot") ~= 0 and 1 or 0
end
local function IsOrWillBeIgnited(o)
  return IRDY == 1 and 1 or IsIgnited(o) == 1 and 1 or 0
end

------------------------------------------
--COMBO
------------------------------------------

OnTick(function(myHero)
 
        if IOW:Mode() == "Combo" then
                       
                        local target = GetCurrentTarget()
        local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),1200,250,925,80,false,false)


             			   
                        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1
						and ValidTarget(target, 1300) and LuluMenu.Combo.Q:Value() then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	       				end
                        if CanUseSpell(myHero, _W) == READY and ValidTarget(target, 700) and Kog'Maw.Spells.W:Value() then
                        CastTargetSpell(target, _W)
                        end
			if CanUseSpell(myHero, _R) == READY and ValidTarget(target, 1000) and Kog'Maw.Spells.R:Value() then
                        CastTargetSpell(target, _R)
                        end
                    end


        end
