require('Inspired')
if GetObjectName(myHero) ~= "KogMaw" then return end

Kog'Maw = MenuConfig("KogMaw", "KogMaw")
Kog'Maw:KeyBinding("Combo", "Combo", 32)

KogMaw:Menu("Spells", "Spells")
KogMaw.Spells:Info("InfoSpells", "En-/Disable Spells to use in Combo")
KogMaw.Spells:Boolean("C", "Q", true)
KogMaw.Spells:Boolean("W", "W", true)
KogMaw.Spells:Boolean("E", "E", true)
KogMaw.Spells:Boolean("R", "R", true)

KogMaw:Menu("KS", "Ks")
KogMaw.KS:Info("InfoKS", "AutoIgnite")
KogMaw.KS:Boolean("I", "Ignite", true)
KogMaw.KS:Boolean("KS", "Killsteal", true)

KogMaw:Menu("Draw", "Drawings")
KogMaw.Draw:Boolean("Draw", "Draw", true)
KogMaw.Draw:Boolean("Q", "Draw Q", true)
KogMaw.Draw:Boolean("W", "Draw W", true)
KogMaw.Draw:Boolean("E", "Draw E", true)
KogMaw.Draw:Boolean("R", "Draw E", false)

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
						and ValidTarget(target, 1300) and KogMaw.Spells.Q:Value() then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	       				end
                        if CanUseSpell(myHero, _W) == READY and ValidTarget(target, 700) and KogMaw.Spells.W:Value() then
                        CastTargetSpell(target, _W)
                        end
			if CanUseSpell(myHero, _R) == READY and ValidTarget(target, 1000) and KogMaw.Spells.R:Value() then
                        CastTargetSpell(target, _R)
                        end
                    end


        end
