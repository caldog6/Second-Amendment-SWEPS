SWEP.PrintName			= "M67"	
SWEP.Slot				= 4
SWEP.SlotPos			= 1

SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment"

SWEP.Spawnable			= true

SWEP.Primary.Damage		= 15
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone		= 0
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 500

SWEP.Primary.MagSize		= 1
SWEP.Primary.DefaultClip	= 3
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "cmb_m67"

SWEP.ReloadLength 		= 1.5
SWEP.FullReloadLength	= 2

SWEP.AimDownSights = false
SWEP.PermanentCrosshair = true

SWEP.DrawAmmo = false

SWEP.VMData = {
	["Model"] = "models/weapons/danny/cmb/v_cmb_m67.mdl",

	["Anim"] = {
		["Draw"] = "draw",
		["Pull"] = "pin_pull",
		["Throw"] = "pin_throw",
		["Hip"] = "origin_to_pin",
		["Origin"] = "pin_to_origin",
		["Sprint"] = "sprint",
	},

	["Activity"] = {
		["Pull"] = "CMB_M67.PullPin",
		["Draw"] = "CMB_Uni.Deploy1",
		["Throw"] = "CMB_M67.Throw"
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-2.95,-3,0.65),
			["Ang"] = Vector(0.6,0,0)
		},
		["Sprint"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Origin"] = {
			["Pos"] = Vector(-1.5,0,-1),
			["Ang"] = Vector(0,0,0)
		},
		["Recoil"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)	
		}
	}
}

SWEP.ViewModel = SWEP.VMData.Model

SWEP.HipRecoil		= -1
SWEP.HipSpread		= 0.005
SWEP.AimSpread		= 0
SWEP.HipVelSpread	= 1
SWEP.AimVelSpread	= 1
SWEP.HipSpreadAdd	= 0.5
SWEP.AimSpreadAdd	= 0.2
SWEP.CrouchAccuracy = 0.8
SWEP.DeployTime 	= 0.2

SWEP.DotSight 		= false
SWEP.WallDistance	= 25

SWEP.AimFOV = 80
SWEP.HipFOV = 85

function SWEP:PrimaryAttack()
	--[[if self:Clip1() <= 0 or !self:CanFire() or !self:GetAiming() or (self.PumpAction and self:GetPump()) then return end

	self:SetNextFire(60/self.Primary.RPM)

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:TakePrimaryAmmo(1)

	if SP and SERVER or CLIENT then
		if IsFirstTimePredicted() then
			self:PlayAnimation("Fire")

			if !self.PumpAction then
				self:EmitShell()
			end
			

			local effectdata = EffectData()
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			util.Effect("cmb_muzzleflash", effectdata)
		end
	end
	
	self:ShootBullet()

	self:Recoil()

	if self.PumpAction then
		self:SetPump(true)
	end

	if (SP and SERVER) or (!SP and IsFirstTimePredicted()) then self:EmitSound(self.VMData.Activity.Fire) end]]
end

function SWEP:Reload()
end

function SWEP:Throw()
	local CT = CurTime()
	self:SetPin(false)
	
	if IsFirstTimePredicted() then
		self:PlayAnimation("Throw")
		self:EmitSound(self.VMData.Activity.Throw)
	end
	
	self:Recoil()
	
	if SERVER then
		self:TakePrimaryAmmo(1)
	end
	

	if SERVER then
		local m67 = ents.Create("cmb_grenade")

		local ang = self.Owner:GetAngles() + self.Owner:GetViewPunchAngles()
		
		ang.p = ang.p - 3

		m67:SetOwner(self.Owner)
		m67:SetPos(self.Owner:EyePos() + ang:Right() * 3 - ang:Up() + ang:Forward())	
		m67:SetAngles(ang)
		m67:Spawn()
		m67:Activate()

		local dir = ang:Forward()

		local phys = m67:GetPhysicsObject()
		phys:ApplyForceCenter(dir * 5000)
	end
		
	self:SetThrow(true)
	self:SetAiming(false)
	self:SetActTime(CT + 0.5)
	self:SetNextFire(0.5)
end

local LastHip = false
local LastSprint = false
function SWEP:Think()
	local CT = CurTime()

	local hold = self.Owner:KeyDown(IN_ATTACK)
	if !self:GetPin() and self:GetAiming() and hold and !self:GetSprinting() and self:GetNextFire() < CT then
		self:SetPin(true)

		if IsFirstTimePredicted() then
			self:PlayAnimation("Pull")
			self:EmitSound(self.VMData.Activity.Pull)
		end

		self:SetActTime(CT + 0.5)
		self:SetNextFire(0.5)
	elseif self:GetPin() and (!hold or self:GetSprinting()) and self:GetNextFire() < CT then
		self:Throw()
	end
	
	local hold = self.Owner:KeyDown(IN_ATTACK2)
	if !self:GetAiming() and hold and !self:GetSprinting() and !self:GetReloading() and self:GetNextFire() < CT and !self:GetPin() and !self:GetThrow() then
		self:SetAiming(true)

		if IsFirstTimePredicted() then
			self:PlayAnimation("Hip")
		end

		self:SetActTime(CurTime() + self.DeployTime)
		self:SetNextFire(self.DeployTime)
	elseif self:GetAiming() and (!hold or self:GetSprinting() or self:GetReloading()) and self:GetNextFire() < CT and !self:GetPin() and !self:GetThrow() then
		self:SetAiming(false)

		if IsFirstTimePredicted() and (!self:GetSprinting() or !self.VMData.Anim["Sprint"]) then
			self:PlayAnimation("Origin")
		end

		self:SetActTime(CurTime() + self.DeployTime)
		self:SetNextFire(self.DeployTime)
	end
	
	local walkSpeed = self.Owner:GetWalkSpeed()
	if !self:GetSprinting() and self.Owner:GetVelocity():Length2D() > walkSpeed and self.Owner:OnGround() and self.Owner:KeyDown(IN_SPEED) and !self:GetReloading() and self:GetNextFire() < CT and !self:GetThrow() then
		self:SetSprinting(true)
	elseif self:GetSprinting() and (self.Owner:GetVelocity():Length2D() <= walkSpeed or self:GetReloading() or !self.Owner:OnGround() or !self.Owner:KeyDown(IN_SPEED)) and self:GetNextFire() < CT and !self:GetThrow() then
		self:SetSprinting(false)
		if !self:GetReloading() then
			self:SetNextFire(0.2)
		end
	end

	if self:GetSprinting() != LastSprint and self.VMData.Anim["Sprint"] then
		LastSprint = self:GetSprinting()

		if IsFirstTimePredicted() and !self:GetReloading() then
			if self:GetSprinting() then
				self:PlayAnimation("Sprint")
			else
				self:PlayAnimation("Origin", 0, 1)
			end
		end
	end

	self:HandleSoundSequence()
	
	if self:GetThrow() and self:GetNextFire() < CT and IsFirstTimePredicted() then
		self:SetThrow(false)
		if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
			if IsFirstTimePredicted() then
				self:Deploy()
				
				if SERVER then
					self.Owner:RemoveAmmo(1, "cmb_m67")
					self:SetClip1(1)
				end
			end
		else
			if SERVER then
				self.Owner:StripWeapon("cmb_m67")
			end
		end
	end
end