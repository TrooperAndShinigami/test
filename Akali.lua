if GetObjectName(GetMyHero()) ~= "Akali" then return end

require('Inspired')


local AkaliMenu = MenuConfig("Akali", "Akali")
AkaliMenu:Menu("Combo", "Combo")
AkaliMenu.Combo:Boolean("Q", "Use Q", true)
AkaliMenu.Combo:Boolean("W", "Use W", true)
AkaliMenu.Combo:Boolean("R", "Use R", true)

AkaliMenu:Menu("Harass", "Harass")
AkaliMenu.Harass:Boolean("Q", "Use Q", true)
AkaliMenu.Harass:Boolean("W", "Use W", true)

AkaliMenu:Menu("Killsteal", "Killsteal")
AkaliMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
AkaliMenu.Killsteal:Boolean("R", "Killsteal with R", true)



AkaliMenu:Menu("Drawings", "Drawings")
AkaliMenu.Drawings:Boolean("Q", "Draw Q Range", true)
AkaliMenu.Drawings:Boolean("W", "Draw W Range", true)
AkaliMenu.Drawings:Boolean("E", "Draw E Range", true)
AkaliMenu.Drawings:Boolean("R", "Draw R Range", true)


AkaliMenu:Menu("LaneClear", "LaneClear")
AkaliMenu.LaneClear:Boolean("Q", "Use Q", true)
AkaliMenu.LaneClear:Boolean("W", "Use W", false)
AkaliMenu.LaneClear:Slider("Mana", "if Mana % >", 30, 0, 80, 1)


DelayAction(function()
  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
  for i, spell in pairs(CHANELLING_SPELLS) do
    for _,k in pairs(GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
        AkaliMenu.Interrupt:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        end
    end
  end
end, 1)

OnProcessSpell(function(unit, spell)
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) then
      if CHANELLING_SPELLS[spell.name] then
        if ValidTarget(unit, 950) and IsReady(_w) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and AkaliMenu.Interrupt[GetObjectName(unit).."Inter"]:Value() and AkaliMenu.Interrupt.SupportedSpells.w:Value() then
        Cast(_w,unit)
        end
      end
    end
end)

local target1 = TargetSelector(1075,TARGET_LESS_CAST_PRIORITY,DAMAGE_MAGIC,true,false)
local target2 = TargetSelector(650,TARGET_LESS_CAST_PRIORITY,DAMAGE_MAGIC,true,false)
  
OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if AkaliMenu.Drawings.Q:Value() then DrawCircle(pos,950,1,25,GoS.Pink) end
if AkaliMenu.Drawings.W:Value() then DrawCircle(pos,650,1,25,GoS.Yellow) end
if AkaliMenu.Drawings.R:Value() then DrawCircle(pos,235,1,25,GoS.Green) end
end)

OnTick(function(myHero)
    local target = GetCurrentTarget()
    local Qtarget = target1:GetTarget()
    local Rtarget = target2:GetTarget()
    
    if IOW:Mode() == "Combo" then

        if IsReady(_Q) and AkaliMenu.Combo.Q:Value() then
        Cast(_Q,Qtarget)
        end
	       
	if IsReady(_R) and AkaliMenu.Combo.W:Value() then
        Cast(_R,Rtarget)
        end
        
        if IsReady(_R) and ValidTarget(target,235) and AkaliMenu.Combo.R:Value() and GetHP2(target) < getdmg("R", target) then
        CastTargetSpell(target, _R)
        end
        
    end
	
    if IOW:Mode() == "Harass" and GetPercentMP(myHero) >= AkaliMenu.Harass.Mana:Value() then

        if IsReady(_Q) and AkaliMenuHarass.Q:Value() then
        Cast(_Q,Qtarget)
        end
	       
	if IsReady(_R) and AkaliMenu.Harass.W:Value() then
        Cast(_R,Rtarget)
        end
        
    end
	
  for i,enemy in pairs(GetEnemyHeroes()) do
    	
	if Ignite and AkaliMenu.Misc.AutoIgnite:Value() then
          if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetHP(enemy)+GetHPRegen(enemy)*3 and ValidTarget(enemy, 600) then
          CastTargetSpell(enemy, Ignite)
          end
        end
                
	if IsReady(_R) and ValidTarget(enemy, 235) and AkaliMenu.Killsteal.R:Value() and GetHP2(enemy) < getdmg("R",enemy) then
	CastTargetSpell(enemy, _R)
	elseif IsReady(_Q) and ValidTarget(enemy, 950) and AkaliMenu.Killsteal.Q:Value() and GetHP2(enemy) < getdmg("Q",enemy) then
	Cast(_Q,enemy)
        end

    end
     
    if IOW:Mode() == "LaneClear" then
        if GetPercentMP(myHero) >= AkaliMenuu.LaneClear.Mana:Value() then
       	
         if IsReady(_Q) and AkaliMenu.LaneClear.Q:Value() then
           local BestPos, BestHit = GetFarmPosition(950, 250, MINION_ENEMY)
           if BestPos and BestHit > 0 then 
           CastSpell(_Q, BestPos)
           end
	 end

         if IsReady(_W) and AkaliMenu.LaneClear.W:Value() then
           local BestPos, BestHit = GetLineFarmPosition(650, 210, MINION_ENEMY)
           if BestPos and BestHit > 0 then 
           CastSkillShot(_W, BestPos)
           end
	 end
        
        end
    end
         
    for i,mobs in pairs(minionManager.objects) do
        if IOW:Mode() == "LaneClear" and GetTeam(mobs) == 300 and GetPercentMP(myHero) >= AkaliMenu.JungleClear.Mana:Value() then
          if IsReady(_Q) and AkaliMenu.JungleClear.Q:Value() and ValidTarget(mobs, 950) then
          CastSpell(_E)
	  end
		
	  if IsReady(_E) and AkaliMenu.JungleClear.W:Value() and ValidTarget(mobs, 650) then
	  CastSpell(_E)
	  end
		
	  if IsReady(_R) and AkaliMenu.JungleClear.R:Value() and ValidTarget(mobs, 235) and GetCurrentHP(mobs) < getdmg("R",mobs) then
	  CastTargetSpell(mobs, _R)
          end
        end
    end       

end)
 

PrintChat(string.format("<font color='#1244EA'>Akali:</font> <font color='#FFFFFF'> By Deftsu Loaded, Have A Good Game ! </font>"))
PrintChat("Have Fun Using D3Carry Scripts: " ..GetObjectBaseName(myHero)) 