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
AkaliMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

AkaliMenu:Menu("Killsteal", "Killsteal")
AkaliMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
AkaliMenu.Killsteal:Boolean("W", "Killsteal with W", true)
AkaliMenu.Killsteal:Boolean("R", "Killsteal with R", true)



AkaliMenu:Menu("Drawings", "Drawings")
AkaliMenu.Drawings:Boolean("Q", "Draw Q Range", true)
AkaliMenu.Drawings:Boolean("W", "Draw W Range", true)
AkaliMenu.Drawings:Boolean("E", "Draw E Range", true)
AkaliMenu.Drawings:Boolean("R", "Draw R Range", true)
AkaliMenu.Drawings:Boolean("DrawAlly", "Draw Selected Ally", true)
AkaliMenu.Drawings:Boolean("DrawText", "Draw Selected Text", true)

OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if AkaliMenu.Drawings.Q:Value() then DrawCircle(pos,1000,1,25,GoS.Pink) end
if AkaliMenu.Drawings.E:Value() then DrawCircle(pos,515,1,25,GoS.Blue) end
if AkaliMenu.Drawings.R:Value() then DrawCircle(pos,420,1,25,GoS.Green) end
  if ThreshMenu.Drawings.DrawText:Value() then
  DrawText("Selected Ally: " .. GetObjectName(Wtarget), 18, 100, 100, 4294967040) 
  end
end
end)
  end
end
end)

OnTick(function(myHero)
    local target = GetCurrentTarget()
    local Qtarget = target1:GetTarget()
    local Wtarget = ally1:GetTarget()
	
    if IOW:Mode() == "Combo" then
	
      if IsReady(_E) and AkaliMenu.Combo.E:Value() and ValidTarget(target,515) then
        if AkaliMenu.Combo.EMode:Value() == 1 then
        CastE(target)
	elseif AkaliMenu.Combo.EMode:Value() == 2 then
        Cast(_E,target)
	end
      end
      
      if IsReady(_R) and TAkaliMenu.Combo.R:Value() and EnemiesAround(GetOrigin(myHero),450) >= ThreshMenu.Combo.Rmin:Value() then
      CastSpell(_R)
  end
  
  
  PrintChat(string.format("<font color='#1244EA'>Thresh:</font> <font color='#FFFFFF'> By trooper Loaded, Have A Good Game ! </font>"))
PrintChat("Have Fun Using trooper Scripts: " ..GetObjectBaseName(myHero)) 