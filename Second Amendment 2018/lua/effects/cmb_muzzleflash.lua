AddCSLuaFile()

function EFFECT:Init(data)
	
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	
	self.Position = self:GetTracerShootPos2(data:GetOrigin(), self.WeaponEnt, self.Attachment)

	self.Forward = data:GetNormal()
	self.Angle = self.Forward:Angle()
	self.Right = self.Angle:Right()
	self.Up = self.Angle:Up()

	local AddVel = self.WeaponEnt:GetOwner():GetVelocity()
	local emitter = ParticleEmitter(self.Position)

	math.randomseed(CurTime())
	local particle = emitter:Add("cmb/muzzle/muzzleflash"..math.random(1,4), self.Position)
	particle:SetDieTime(0.1)
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(5)
	particle:SetEndSize(6)
	particle:SetRoll(math.Rand(-180, 180))
	particle:SetColor(255,255,255)	

	local particle = emitter:Add("particle/particle_smokegrenade", self.Position)
	--particle:SetVelocity(100 * self.Forward + 8 * VectorRand())
	particle:SetAirResistance(200)
	particle:SetGravity(Vector(0, 0, math.Rand(25, 100)))
	particle:SetDieTime(math.Rand(1, 3))
	particle:SetStartAlpha(100)
	particle:SetEndAlpha(0)
	particle:SetStartSize(math.Rand(2, 7))
	particle:SetEndSize(math.Rand(15, 25))
	particle:SetRoll(math.Rand(-25, 25))
	particle:SetRollDelta(math.Rand(-0.05, 0.05))
	particle:SetColor(255, 255, 255)
	particle:SetLighting(true)

	emitter:Finish()

	local dlight = DynamicLight(self:EntIndex())
		
	dlight.r = 255 
	dlight.g = 120
	dlight.b = 60
	dlight.Brightness = 2
	dlight.Pos = self.Position
	dlight.Size = 100
	dlight.Decay = 1000
	dlight.DieTime = CurTime() + 0.01
end

function EFFECT:GetTracerShootPos2(pos, ent, att)

	self.ViewModelTracer = false
	
	if !IsValid( ent ) then return pos end
	if !ent:IsWeapon() then return pos end

	-- Shoot from the viewmodel
	if (ent:IsCarriedByLocalPlayer() && !LocalPlayer():ShouldDrawLocalPlayer()) then
	
		local ViewModel = ent.vm
		
		if ViewModel:IsValid() then
			
			local att = ViewModel:GetAttachment(att)
			if att then
				pos = att.Pos
				self.ViewModelTracer = true
			end
			
		end
	
	-- Shoot from the world model
	else
	
		local att = ent:GetAttachment(att)
		if att then
			pos = att.Pos
		end
	
	end

	return pos

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
