AddCSLuaFile()

IncludeCS("SecondAmendment/cmb_vm.lua")
IncludeCS("SecondAmendment/cmb_hud.lua")
IncludeCS("SecondAmendment/cmb_bullet.lua")
IncludeCS("SecondAmendment/cmb_holdtypes.lua")

local SP = game.SinglePlayer()
local math = math

SWEP.SecondAmendment = true

SWEP.Category 			= ""
SWEP.PrintName			= "Second Amendment Base"
SWEP.Slot				= -1
SWEP.SlotPos			= 1

SWEP.DrawCrosshair 		= false
SWEP.DrawAmmo 			= false
SWEP.UseHands 			= false

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/v_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"

SWEP.ViewModelFOV 		= 75
SWEP.BobScale 			= 0
SWEP.SwayScale 			= 0

SWEP.HoldType			= "ar2"
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil		= 0
SWEP.Primary.Damage		= 35
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone		= 0.01
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 600
SWEP.Primary.Force 		= 5

SWEP.Primary.ChamberSize = 1

SWEP.Primary.MagSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "smg1"
SWEP.Ammo 					= "smg1"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.Ammo 		= "none"

SWEP.m_WeaponDeploySpeed 	= 10

SWEP.AimFOV = 70
SWEP.HipFOV = 85

SWEP.HolsterReloadTimeOffset = 0

SWEP.SprintSeed = 0

SWEP.HoldTypes = {
	["Aiming"] = "ar2",
	["Hip"] = "passive",
}

SWEP.VMData = {
	["Model"] = "models/weapons/v_pistol.mdl",

	["Anim"] = {
		["Draw"] = "draw",
		["Fire"] = "hip_shoot",
		["Reload"] = "reload",
		["HipReload"] = "hip_reload",
		["FullReload"] = "reload_full",
		["FullHipReload"] = "hip_reload_full",
		["Hip"] = "origin_to_hip",
		["Origin"] = "hip_to_origin",
		["Sprint"] = "sprint",
		["Nade"] = "grenade",
		["HipNade"] = "hip_grenade"
	},

	["Activity"] = {
		["Fire"] = "",
		["Draw"] = "",
		["Reload"] = {},
		["FullReload"] = {},
		["Aim"] = {},
		["Sprint"] = {}
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Sprint"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Origin"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["World"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		}
	},

	["Shell"] = {
		["Model"] = "models/shells/shell_12gauge.mdl"
	}
}

SWEP.AimDownSights = true
SWEP.PermanentCrosshair = false

SWEP.UseMagazine = true
SWEP.PumpAction = false

SWEP.ReloadLength 		= 2
SWEP.FullReloadLength	= 3

SWEP.HipRecoil		= 0.8
SWEP.AimRecoil		= 0.5
SWEP.HipSpread		= 0.02
SWEP.AimSpread		= 0.01
SWEP.HipVelSpread	= 3
SWEP.AimVelSpread	= 1.5
SWEP.HipSpreadAdd	= 0.5
SWEP.AimSpreadAdd	= 0.2
SWEP.CrouchAccuracy = 0.7
SWEP.DeployTime 	= 0.2

SWEP.HipSpeed 		= 0.8
SWEP.AimSpeed 		= 0.6
SWEP.DotSight 		= false
SWEP.WallDistance	= 50

SWEP.UseParticleMuzzle = false // set this to true if you want to disable the default muzzle effect and use particles as muzzle instead
SWEP.ParticleMuzzle = {} // table of particles, or can be a single string
SWEP.ParticleMuzzleToStop = "" // same thing, either a table or a single string, these particles get stopped when firing the next shot (best used on muzzle smoke to prevent unrealistic ammounts of it)

function SWEP:SetNextFire(time) self:SetNextPrimaryFire(CurTime() + time) end
function SWEP:GetNextFire() return self:GetNextPrimaryFire() end

function SWEP:Initialize()
	if CLIENT then
		self:SetViewModel(self.VMData.Model)
	end

	self.Primary.ClipSize = self.Primary.MagSize

	self:SetClip1(self.Primary.MagSize)

	timer.Simple(0, function() if self.Owner then self:Deploy() end end)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Aiming")
	self:NetworkVar("Bool", 1, "Sprinting")
	self:NetworkVar("Bool", 2, "Reloading")
	self:NetworkVar("Bool", 4, "Hip")
	self:NetworkVar("Bool", 5, "Pump")
	self:NetworkVar("Bool", 6, "Pin")
	self:NetworkVar("Bool", 7, "Throw")

	self:NetworkVar("Float", 0, "ActTime")
end

function SWEP:Reload()
	if self:GetNextFire()+0.05 >= CurTime() or self:GetReloading() then return end

	if self.PumpAction and self:GetPump() and self:GetAiming() then
		self:Pump()
		return
	end

	if self.Owner:GetAmmoCount(self.Primary.Ammo) == 0 or self:Clip1() >= self.Primary.MagSize+self.Primary.ChamberSize then return end

	if self.UseMagazine then
		self:MagReload()
	else
		self:StartReload()
	end
end

function SWEP:StartReload()
	if self:Clip1() >= self.Primary.MagSize then return end
	if self:GetReloading() then return end
	self:SetReloading(true)

	if (SP and SERVER or CLIENT) and IsFirstTimePredicted() then
		if self:GetAiming() then
			self:PlayAnimation("StartHipReload")
			self:PlaySoundSequence("StartHipReload")
		else
			self:PlayAnimation("StartReload")
			self:PlaySoundSequence("StartReload")
		end

	end

	self.StartReloadClip = self:Clip1()

	self:SetNextFire(0.5)
	self:SetActTime(CurTime() + 0.5)
end

function SWEP:Pump()
	self:SetPump(false)

	if (SP and SERVER or CLIENT) and IsFirstTimePredicted() then
		self:PlayAnimation("Pump")
		self:PlaySoundSequence("Pump")
		self:EmitShell()
	end

	self:SetNextFire(self.PumpTime)
	self:SetActTime(CurTime() + self.PumpTime)
end

function SWEP:ReloadThink()
	if self:GetNextPrimaryFire() >= CurTime() then return end

	if self:Clip1() >= self.Primary.ClipSize or self.Owner:KeyDown(IN_ATTACK) then
		self:ReloadEnd()
		return
	end

	if (SP and SERVER or CLIENT) and IsFirstTimePredicted() then
		self:PlayAnimation("MiddleReload")
		self:PlaySoundSequence("MiddleReload")
		--self:EmitSound(self.InsertSound)
	end

	self.Owner:RemoveAmmo(1, self.Primary.Ammo)
	self:SetClip1(self:Clip1() + 1)

	self:SetNextFire(0.5)
	self:SetActTime(CurTime() + 0.5)
end

function SWEP:ReloadEnd()
	if (SP and SERVER or CLIENT) and IsFirstTimePredicted() then
		self:PlaySoundSequence("EndReload")
		if self:GetAiming() then
			self:PlayAnimation("EndHipReload")
		else
			self:PlayAnimation("EndReload")
		end
	end

	self:SetReloading(false)

	self:SetNextFire(1)
	self:SetActTime(CurTime() + 1)
end

function SWEP:MagReload()
	local FullReload = self:Clip1() == 0
	local Aiming = self:GetAiming()

	self:SetReloading(true)
	self:SetSprinting(false)

	if (SP and SERVER or CLIENT) and IsFirstTimePredicted() then
		if FullReload then
			if Aiming then
				self:PlayAnimation("FullHipReload")
			else
				self:PlayAnimation("FullReload")
			end
		else
			if Aiming then
				self:PlayAnimation("HipReload")
			else
				self:PlayAnimation("Reload")
			end
		end
	end

	if IsFirstTimePredicted() then
		self:PlaySoundSequence(FullReload and "FullReload" or "Reload")
	end

	self.Primary.ClipSize = FullReload and self.Primary.MagSize or (self.Primary.MagSize + self.Primary.ChamberSize)

	local len = FullReload and self.FullReloadLength or self.ReloadLength

	self:SetActTime(CurTime() + len)

	self:SetNextFire(len)
end

SWEP._soundSequence = {}
SWEP._soundTime = 0
function SWEP:PlaySoundSequence(snd)
	self._soundSequence = self.VMData.Activity[snd]

	for k, v in pairs(self._soundSequence) do
		v.played = false
	end

	self._soundTime = self:GetAiming() and CurTime() or CurTime() + self.HolsterReloadTimeOffset
end

function SWEP:StopSoundSequence()
	for k, v in pairs(self._soundSequence) do
		v.played = true
	end
end

function SWEP:HandleSoundSequence()
	if IsFirstTimePredicted() then
		local CT = CurTime()

		for k, v in pairs(self._soundSequence) do
			if !v.played and ((v.time or 0)+self._soundTime) < CT then
				if v.snd then
					self:EmitSound(v.snd)
				end

				if v.callback then
					v.callback(self)
				end

				v.played = true
			end
		end
	end
end

function SWEP:Holster()
	self:SetReloading(false)
	self:SetAiming(false)
	self:SetSprinting(false)

	self:StopSoundSequence()
	return true
end

function SWEP:FillMag()
	local mag, ammoCount = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)

	if ammoCount >= self.Primary.ClipSize then
		self:SetClip1(math.Clamp(self.Primary.ClipSize, 0, self.Primary.ClipSize))
		self.Owner:RemoveAmmo(self.Primary.ClipSize - mag, self.Primary.Ammo)
	else
		self:SetClip1(math.min(mag + ammoCount, self.Primary.ClipSize))
		self.Owner:RemoveAmmo(ammoCount, self.Primary.Ammo)
	end
end

function SWEP:SendAimMode(bool)
	net.Start("cmb_AimMode")
		net.WriteBool(bool)
	net.SendToServer()
end

function SWEP.PlayerBindPress(ply, bind, pressed)
	wep = ply:GetActiveWeapon()

	if wep.SecondAmendment and wep:GetAiming() and wep.AimDownSights then
		if bind == "invprev" then
			wep:SendAimMode(true)
			return true
		elseif bind == "invnext" then
			wep:SendAimMode(false)
			return true
		end
	end
end

hook.Add("PlayerBindPress", "SecondAmendment.PlayerBindPress", SWEP.PlayerBindPress)

if SERVER then
	util.AddNetworkString("cmb_AimMode")

	function SWEP.SetAimMode(len, ply)
		local wep = ply:GetActiveWeapon()

		if wep.SecondAmendment and !wep:GetReloading() then
			local hip = net.ReadBool()
			wep:SetHip(hip)
		end
	end

	net.Receive("cmb_AimMode", SWEP.SetAimMode)
end

local LastHip = false
local LastSprint = false
function SWEP:Think()
	local CT = CurTime()

	if !self.UseMagazine and self:GetReloading() then
		self:ReloadThink()
	end

	if IsFirstTimePredicted() then
		if self:GetReloading() and self:GetNextFire() < CT then
			self:SetReloading(false)

			if SERVER then
				self:FillMag()
			end
		end
	end

	if self:GetHip() != LastHip then
		LastHip = self:GetHip()

		self:Foley()
	end

	local walkSpeed = self.Owner:GetWalkSpeed()
	if !self:GetSprinting() and self.Owner:GetVelocity():Length2D() > walkSpeed and self.Owner:OnGround() and self.Owner:KeyDown(IN_SPEED) and !self:GetReloading() and self:GetNextFire() < CT then
		self:SetSprinting(true)
	elseif self:GetSprinting() and (self.Owner:GetVelocity():Length2D() <= walkSpeed or self:GetReloading() or !self.Owner:OnGround() or !self.Owner:KeyDown(IN_SPEED)) and self:GetNextFire() < CT then
		self:SetSprinting(false)
		if !self:GetReloading() then
			self:SetNextFire(0.2)
		end
	end

	local hold = self.Owner:KeyDown(IN_ATTACK2)
	if !self:GetAiming() and hold and !self:GetSprinting() and !self:GetReloading() and self:GetNextFire() < CT then
		self:SetAiming(true)

		if (SP and SERVER or CLIENT) and IsFirstTimePredicted() then
			self:PlayAnimation("Hip")
			self:PlaySoundSequence("Aim")

			self:Foley()
		end

		self:SetActTime(CurTime() + self.DeployTime)
		self:SetNextFire(self.DeployTime)
	elseif self:GetAiming() and (!hold or self:GetSprinting() or self:GetReloading()) and self:GetNextFire() < CT then
		self:SetAiming(false)

		if (SP and SERVER or CLIENT) and IsFirstTimePredicted() and (!self:GetSprinting() or !self.VMData.Anim["Sprint"]) then
			self:PlayAnimation("Origin")
			self:Foley()
		end

		self:SetActTime(CurTime() + self.DeployTime)
		self:SetNextFire(self.DeployTime)
	end

	if self:GetSprinting() != LastSprint and self.VMData.Anim["Sprint"] then
		LastSprint = self:GetSprinting()

		if (SP and SERVER or CLIENT) and IsFirstTimePredicted() and !self:GetReloading() then
			if self:GetSprinting() then
				self:PlayAnimation("Sprint")
				self:PlaySoundSequence("Sprint")
			else
				self:PlayAnimation("Origin", 0, 1)
			end
		end
	end

	self:SecondThink()
	self:HandleSoundSequence()
	self:HandleHoldTypes()
end

function SWEP:SecondThink()
end

local FoleyTab = {"CMB_Uni.Foley1", "CMB_Uni.Foley2", "CMB_Uni.Foley3", "CMB_Uni.Foley4", "CMB_Uni.Foley5", "CMB_Uni.Foley6"}
function SWEP:Foley()
	if IsFirstTimePredicted() and (SP and SERVER or CLIENT) then
		self:EmitSound(FoleyTab[math.random(1,6)])
	end
end

function SWEP:Deploy()
	if IsFirstTimePredicted() and (SP and SERVER or CLIENT) then
		self:PlayAnimation("Draw", 0.7)
		self:EmitSound(self.VMData.Activity.Draw)
	end

	self:SetNextFire(0.5)
	self:SetActTime(CurTime() + 0.5)

	return true
end

function util_Clamp(a)
	local s = a * 1

	a.x = math.Clamp(a.x, -5, 5)
	a.y = math.Clamp(a.y, -5, 5)

	return s - a
end

function SWEP:Tick()
	local punchAng = self.Owner:GetViewPunchAngles()*0.1
	punchAng.r = 0

	if (SP and SERVER or CLIENT) and IsFirstTimePredicted() then
		self.Owner:SetEyeAngles(self.Owner:EyeAngles() + punchAng*0.2)
	end
end

function SWEP:CanFire()
	return !(self:GetSprinting() or self:GetReloading())
end


function SWEP:PrimaryAttack()
	if self:Clip1() <= 0 or !self:CanFire() or !self:GetAiming() or (self.PumpAction and self:GetPump()) then return end

	self:SetNextFire(60/self.Primary.RPM)

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:TakePrimaryAmmo(1)

	if SP and SERVER or CLIENT then
		if IsFirstTimePredicted() then
			self:PlayAnimation("Fire")

			if !self.PumpAction then
				self:EmitShell()
			end

			self:StopParticleMuzzle()

			if self.UseParticleMuzzle then
				self:PerformParticleMuzzle()
			else
				local effectdata = EffectData()
				effectdata:SetEntity(self)
				effectdata:SetAttachment(1)
				util.Effect("cmb_muzzleflash", effectdata)
			end
		end
	end

	self:ShootBullet()

	self:Recoil()

	if self.PumpAction then
		self:SetPump(true)
	end

	if (SP and SERVER) or (!SP and IsFirstTimePredicted()) then self:EmitSound(self.VMData.Activity.Fire) end
end

local punchAng = Angle(0,0,0)
function SWEP:Recoil()
	math.randomseed(CurTime())

	local Recoil = self:CalcRecoil()

	punchAng.p = math.Rand(-1, -1)/2 * Recoil + math.Rand(-.1, .1)
	punchAng.y = math.Rand(-0.5, 0.5)/2 * Recoil
	punchAng.r = -punchAng.y*0.3

	self.Owner:SetViewPunchAngles(self.Owner:GetViewPunchAngles() + punchAng*3)
end

function SWEP:CalcSpread()
	local BaseSpread = (self:GetHip() and self.AimSpread or self.HipSpread)
	local VelocityMul = (self.Owner:GetVelocity():Length()/10000 * (self:GetHip() and self.AimVelSpread or self.HipVelSpread))
	local SpreadAdd = math.max(-self.Owner:GetViewPunchAngles().p, 0)/50*(self:GetHip() and self.AimSpreadAdd or self.HipSpreadAdd)

	return (BaseSpread) + VelocityMul + SpreadAdd
end

function SWEP:CalcRecoil()
	local BaseRecoil = (self:GetHip() and self.AimRecoil or self.HipRecoil)
	local CrouchRecoil = self.Owner:Crouching() and self.CrouchAccuracy or 1
	return BaseRecoil * CrouchRecoil
end

function SWEP:SecondaryAttack()
	return
end


function SWEP:PlayAnimation(seq, speed, cycle)
	local speed = speed or 1
	local cycle = cycle or 0
	local vm = self.vm

	if CLIENT then
		local seq = self.VMData.Anim[seq]
		vm:SetSequence(vm:LookupSequence(seq))
		vm:SetCycle(cycle)
		vm:SetPlaybackRate(speed)
	elseif SP and SERVER then
		if self.Owner and IsValid(self.Owner) then
			umsg.Start("CMB_PLAYANIM", self.Owner)
				umsg.String(seq)
				umsg.Float(speed)
				umsg.Float(cycle)
			umsg.End()
		end
	end
end

function SWEP:PerformParticleMuzzle()
	if SP and SERVER then
		if !self.Owner:IsPlayer() then return end
		SendUserMessage("CMB_PARTICLE_MUZZLE_EFFECTS_UMSG", self.Owner)
		return
	end

	self:_performParticleMuzzle()
end

function SWEP:_performParticleMuzzle()
	if SERVER then return end

	if self.Owner:ShouldDrawLocalPlayer() then
		return
	end

	local vm = self.vm
	if !IsValid(vm) then return end

	local muz = vm:GetAttachment(1)
	if !muz then return end

	local muzTab = self.ParticleMuzzle
	if !muzTab then return end

	// either list of particles, or just a single particle
	if type(muzTab) == "table" then
		for _, particle in pairs(muzTab) do
			if type(particle) == "string" then
				ParticleEffectAttach(particle, PATTACH_POINT_FOLLOW, vm, 1)
			end
		end
	elseif type(muzTab) == "string" then
		ParticleEffectAttach(muzTab, PATTACH_POINT_FOLLOW, vm, 1)
	end

	local dlight = DynamicLight(self:EntIndex())
	dlight.r = 250
	dlight.g = 250
	dlight.b = 50
	dlight.Brightness = 5
	dlight.Pos = muz.Pos + self.Owner:GetAimVector() * 3
	dlight.Size = 128
	dlight.Decay = 1000
	dlight.DieTime = CurTime() + 1
end

function SWEP:StopParticleMuzzle()
	if SP and SERVER then
		if !self.Owner:IsPlayer() then return end
		SendUserMessage("CMB_STOPVMPARTICLES_UMSG", self.Owner)
		return
	end
	self:_stopParticleMuzzle()
end

function SWEP:_stopParticleMuzzle()
	if SERVER then return end

	local muzTab = self.ParticleMuzzleToStop
	if !muzTab then return end

	local vm = self.vm
	if !IsValid(vm) then return end

	if type(muzTab) == "table" then
		for _, particle in pairs(muzTab) do
			if type(particle) == "string" then
				vm:StopParticlesNamed(particle)
			end
		end
	elseif type(muzTab) == "string" then
		vm:StopParticlesNamed(muzTab)
	end
end

if CLIENT then
	local function CMB_PARTICLE_MUZZLE_EFFECTS()
		local ply = LocalPlayer()
		if !IsValid(ply) then return end

		local wep = ply:GetActiveWeapon()

		if not IsValid(wep) or not wep.SecondAmendment then
			return
		end

		wep:_performParticleMuzzle()
	end
	usermessage.Hook("CMB_PARTICLE_MUZZLE_EFFECTS_UMSG", CMB_PARTICLE_MUZZLE_EFFECTS)

	local function CMB_STOPVMPARTICLES()
		local ply = LocalPlayer()
		if !IsValid(ply) then return end

		local wep = ply:GetActiveWeapon()

		if not IsValid(wep) or not wep.SecondAmendment then
			return
		end

		wep:_stopParticleMuzzle()
	end
	usermessage.Hook("CMB_STOPVMPARTICLES_UMSG", CMB_STOPVMPARTICLES)
end
