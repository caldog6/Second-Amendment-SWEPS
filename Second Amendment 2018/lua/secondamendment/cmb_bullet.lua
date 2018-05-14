local bullet = {}
local spread = Vector()

function SWEP:ShootBullet()
	local src = self.Owner:GetShootPos()

	local ang = self.Owner:EyeAngles() + self.Owner:GetViewPunchAngles()

	local Spread = self:CalcSpread()
	spread.x = Spread
	spread.y = Spread

	bullet.Num 		= self.Primary.NumShots
	bullet.Src 		= src
	bullet.Dir 		= ang:Forward()
	bullet.Spread 	= spread
	bullet.Tracer	= 0
	bullet.TracerName = "Tracer"
	bullet.Force	= self.Primary.Force
	bullet.Damage	= self.Primary.Damage
	bullet.PenTime 	= 0
	bullet.Callback	= function(attacker, tr, dmginfo)
		return bullet:penetrate(attacker, tr, dmginfo)
	end

	self.Owner:FireBullets(bullet)
end

local Density = {
	[MAT_GLASS] = 4,
	[MAT_PLASTIC] = 3.5,
	[MAT_WOOD] = 2,
	[MAT_FLESH] = 4,
	[MAT_ALIENFLESH] = 4,
	[MAT_METAL] = 1,
	[MAT_CONCRETE] = 2
}
function bullet:penetrate(attacker, tr, dmginfo)

	if self.PenTime > 5 then return end

	local maxPenetration = self.Force

	local density = Density[tr.MatType] or 3
	penPos = tr.Normal * (maxPenetration*(density*2))
		
	local trace 	= {}
	trace.endpos 	= tr.HitPos
	trace.start 	= tr.HitPos + penPos
	trace.mask 		= MASK_SHOT
	trace.filter 	= {}
	   
	trace 	= util.TraceLine(trace)

	if (trace.StartSolid or trace.Fraction >= 1.0 or tr.Fraction <= 0.0) then return end
	
	local penDamage = (density/4)

	self.Num 		= 1
	self.Src 		= trace.HitPos
	self.Dir 		= tr.Normal
	self.Spread 	= Vector(0, 0, 0)
	self.Tracer 	= 0
	self.Force		= self.Force
	self.PenTime 	= self.PenTime + 1
	self.Damage		= (dmginfo:GetDamage() * penDamage)
	self.Callback   = function(a, b, c) self:penetrate(a, b, c) end

	local bul2 = {	
		Num 		= 1,
		Src 		= trace.HitPos + tr.Normal,
		Dir 		= -tr.Normal,	
		Spread 	= Vector(0, 0, 0),
		Tracer	= 0,
		Force		= 0,
		Damage	= 0
	}
	
	
	if IsFirstTimePredicted() then
		timer.Simple(0.001, function() 
			attacker.FireBullets(attacker, self, true)
			attacker.FireBullets(attacker, bul2, true)
		end)
	end
end
