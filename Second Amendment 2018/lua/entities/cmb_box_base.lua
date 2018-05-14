AddCSLuaFile()

ENT.Type 			= "anim"
ENT.PrintName		= "Ammo Crate"
ENT.Category		= "Second Amendment"

ENT.Spawnable		= false

ENT.Model 			= "models/Items/ammocrate_ar2.mdl"

ENT.TextSize = 1
ENT.TextPos = Vector(0,0,0)
ENT.Uses = 0

function ENT:Use(activator, caller)
	if (activator:IsPlayer()) then
		self:Refill(activator)
	end
end

function ENT:Refill(ply)
	if self.NextUse > CurTime() then
		return
	end
	
	self.NextUse = CurTime() + 0.5
	self:EmitSound("items/ammo_pickup.wav")
	self:SetUses(self:GetUses() + 1)
	
	for k, v in pairs(self.AmmoTypes) do
		ply:GiveAmmo(v, k)
	end
	
	if self:GetUses() >= self.Uses then
		self:Remove()
	end
end

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "Uses")
end

if CLIENT then
	surface.CreateFont( "CMBAmmoDisplay", {
		font = "Arial",
		size = 45,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = true,
		additive = false,
		outline = true,
	} )
	
	function ENT:Draw()
		self:DrawModel()
		
		local pos, ang = self:GetPos(), self:GetAngles()
		
		ang:RotateAroundAxis(ang:Up(), 90)
		cam.Start3D2D( pos + ang:Right() * self.TextPos[1] + ang:Forward() * self.TextPos[2] + ang:Up() * self.TextPos[3], ang, self.TextSize )
			surface.SetFont("CMBAmmoDisplay")
			surface.SetTextColor( 255, 255, 255, 255 )
			surface.SetTextPos(0, 0)
			surface.DrawText(self.PrintName)
			surface.SetTextPos(0, 50)
			surface.DrawText("Uses Left: "..self.Uses-self:GetUses())
		cam.End3D2D()
	end
end

if SERVER then
	function ENT:SpawnFunction(ply, tr, ClassName)

		if (!tr.Hit) then return end
		
		local SpawnPos = tr.HitPos + tr.HitNormal * 16
		local ent = ents.Create(ClassName)
		ent:SetPos(SpawnPos + Vector(0,0,5))
		
		local ang = tr.Normal:Angle()
		ang.p = 180
		ang:RotateAroundAxis(ang:Forward(), 180)
		
		ent:SetAngles(ang)
		ent:Spawn()
		ent:Activate()
		
		return ent
	end

	function ENT:Initialize()
		self.NextUse = 0
		
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:DrawShadow(true)

		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		
		local phys = self:GetPhysicsObject()
		
		if (phys:IsValid()) then
			phys:Wake()
		end

		self:SetUseType(SIMPLE_USE)
	end

	function ENT:PhysicsCollide(data, physobj)
		if (data.Speed > 80 and data.DeltaTime > 0.2) then
			self:EmitSound("Default.ImpactSoft")
		end
	end

	function ENT:OnTakeDamage(dmginfo)
		self:TakePhysicsDamage(dmginfo)
	end
end