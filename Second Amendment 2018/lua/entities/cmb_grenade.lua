AddCSLuaFile()

DEFINE_BASECLASS("base_anim")

ENT.PrintName		= "M67"

ENT.Editable			= false
ENT.Spawnable			= false
ENT.AdminOnly			= false
ENT.RenderGroup 		= RENDERGROUP_TRANSLUCENT

function ENT:Think()
	if self.Timer <= CurTime() and SERVER then
		self:Explosion()
	end
end

function ENT:Explosion()
	util.Decal("Scorch", self:GetPos() - Vector(0,0,5), self:GetPos()) 
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale(1.5)
	util.Effect("cmb_explosion", effectdata)
	util.BlastDamage( self:GetOwner(), self:GetOwner(), self:GetPos(), 350, 150)
	self:Remove()
end

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/weapons/w_eq_fraggrenade_thrown.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
	
		self:PhysicsInitSphere(0.01, "metal_bouncy")
		
		local phys = self:GetPhysicsObject()
		
		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(5)
			phys:EnableDrag(true)
			phys:EnableGravity(true)
			phys:SetBuoyancyRatio(1)
			phys:AddAngleVelocity(VectorRand()*300)
		end
	end
	
	self.Timer = CurTime() + 3
end

function ENT:PhysicsCollide(data, physobj)
	physobj:SetVelocity(physobj:GetVelocity() * 0.6)
	SafeRemoveEntityDelayed(self, 10)
	
	self:EmitSound("<weapons/cmb/m67/m67_bounce_0"..math.random(1, 4)..".wav", 80, 100)
	
	local dmginfo = DamageInfo()
	
	local attacker = self:GetOwner()
	dmginfo:SetAttacker(attacker)

	dmginfo:SetInflictor(self)
	dmginfo:SetDamage(40)

	dmginfo:SetDamageForce(data.HitNormal * 9998)

	data.HitEntity:TakeDamageInfo(dmginfo)
end

function ENT:PhysicsUpdate(phys)

end

function ENT:OnTakeDamage(dmginfo)

end

function ENT:Use(activator, caller)

end