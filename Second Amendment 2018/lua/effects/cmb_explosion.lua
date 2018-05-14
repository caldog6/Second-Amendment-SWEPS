
AddCSLuaFile()

local fre = "effects/fire_cloud1"
function EFFECT:Init(data)
	
	local vOffset = data:GetOrigin()
	local scale = data:GetScale()

	sound.Play("<weapons/cmb/m67/m67_detonate.wav", vOffset, 90)

	local emitter = ParticleEmitter(vOffset)

	local particle = emitter:Add( "effects/fire_cloud1", vOffset )
	if particle then		
		particle:SetLifeTime(0)
		particle:SetDieTime(0.1)
				
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)

		particle:SetStartSize(60*scale)
		particle:SetEndSize(120*scale)

		particle:SetRoll(1)
		particle:SetRollDelta(0)

		particle:SetAirResistance(500)

		particle:SetColor(255, 255, 255, 255)
	end

	for i= 0, 30 do
		local Pos = VectorRand()
		
		local smoke = emitter:Add("particle/smokesprites_0010", vOffset)
		if particle then
			smoke:SetVelocity(Pos*700*scale)
			
			smoke:SetLifeTime(0)
			smoke:SetDieTime(10)
				
			smoke:SetStartAlpha(50)
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(90*scale)
			smoke:SetEndSize(60*scale)

			smoke:SetRoll(1)
			smoke:SetRollDelta(math.Rand(-1, 1))

			smoke:SetAirResistance(500)

			smoke:SetColor(30, 30, 30)
		end
	end


	for i = 0, 5 do
		local particle = emitter:Add("Effects/spark", vOffset)
		particle:SetVelocity(VectorRand()*1200*scale)
		particle:SetDieTime(0.2)
		particle:SetStartAlpha(255)
		particle:SetStartSize(5*scale)
		particle:SetEndSize(0)
		particle:SetRoll(0)
		particle:SetGravity(Vector(0, 0, 0))
		particle:SetCollide(true)
		particle:SetBounce(0.8)
		particle:SetAirResistance(120)
		particle:SetStartLength(0)
		particle:SetEndLength(0.1)
		particle:SetVelocityScale(true)
		particle:SetCollide(true)
		particle:SetColor(160,120,0)
	end

	local dlight = DynamicLight()
		
	dlight.r = 255 
	dlight.g = 120
	dlight.b = 60
	dlight.Brightness = 5
	dlight.Pos = vOffset
	dlight.Size = 250
	dlight.Decay = 1000
	dlight.DieTime = CurTime() + 0.2

	emitter:Finish()
end


function EFFECT:Think()
	return false
end


function EFFECT:Render()
end



