SWEP.PrintName			= "Taurus Raging Bull"
SWEP.Slot				= 1
SWEP.SlotPos			= 1

SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment"

SWEP.Spawnable			= true

SWEP.Primary.Damage		= 83
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone		= 0
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 250
SWEP.Primary.Force 		= 1

SWEP.Primary.MagSize		= 6
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "cmb_44"

SWEP.ReloadLength 		= 3.5
SWEP.FullReloadLength	= 3.5

SWEP.VMData = {
	["Model"] = "models/weapons/danny/cmb/v_cmb_taurus.mdl",

	["Anim"] = {
		["Draw"] = "draw",
		["Fire"] = "hip_shoot",
		["Reload"] = "hip_reload",
		["HipReload"] = "hip_reload",
		["FullReload"] = "hip_reload",
		["FullHipReload"] = "hip_reload",
		["Hip"] = "origin_to_hip",
		["Origin"] = "hip_to_origin",
		["Sprint"] = "sprint",
		["Nade"] = "grenade",
		["HipNade"] = "hip_grenade"
	},

	["Activity"] = {
		["Fire"] = "CMB_Taurus.Fire",
		["Draw"] = "CMB_Uni.Deploy1",
		["Reload"] = {
			{time = 0.3, snd = "CMB_Taurus.Open"},
			{time = 0.55, snd = "CMB_Taurus.Out"},
			{time = 0.7, snd = "CMB_AKM.ClipOutRattle"},
			{time = 1.9, snd = "CMB_Taurus.In"},
			{time = 2.8, snd = "CMB_Taurus.Close"},
			{time = 3.4, snd = "CMB_Uni.Tap"}
		},
		["HipReload"] = {
			{time = 0.3, snd = "CMB_Taurus.Open"},
			{time = 0.55, snd = "CMB_Taurus.Out"},
			{time = 0.7, snd = "CMB_AKM.ClipOutRattle"},
			{time = 1.9, snd = "CMB_Taurus.In"},
			{time = 2.8, snd = "CMB_Taurus.Close"},
			{time = 3.4, snd = "CMB_Uni.Tap"}
		},
		["FullReload"] = {
			{time = 0.3, snd = "CMB_Taurus.Open"},
			{time = 0.55, snd = "CMB_Taurus.Out"},
			{time = 0.7, snd = "CMB_AKM.ClipOutRattle"},
			{time = 1.9, snd = "CMB_Taurus.In"},
			{time = 2.8, snd = "CMB_Taurus.Close"},
			{time = 3.4, snd = "CMB_Uni.Tap"}
		},
		["FullHipReload"] = {
			{time = 0.3, snd = "CMB_Taurus.Open"},
			{time = 0.55, snd = "CMB_Taurus.Out"},
			{time = 0.7, snd = "CMB_AKM.ClipOutRattle"},
			{time = 1.9, snd = "CMB_Taurus.In"},
			{time = 2.8, snd = "CMB_Taurus.Close"},
			{time = 3.4, snd = "CMB_Uni.Tap"}
		},
		["Aim"] = {
			{time = 0.15, snd = "CMB_Uni.Tap"}
		}
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-2.75,-3,0.65),
			["Ang"] = Vector(0.4,-0.65,0)
		},
		["Sprint"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Origin"] = {
			["Pos"] = Vector(-1,0,-0.5),
			["Ang"] = Vector(0,0,0)
		},
		["World"] = {
			["Pos"] = Vector(-4,12,-7),
			["Ang"] = Vector(-40,2,0)
		},
		["Recoil"] = {
			["Pos"] = Vector(0,1,0.1),
			["Ang"] = Vector(-1.6,0,0)
		}
	},

	["Shell"] = {
		["Model"] = "models/shells/shell_9mm.mdl"
	}
}

SWEP.HoldTypes = {
	["Aiming"] = "revolver",
	["Hip"] = "normal",
}

SWEP.ViewModel = SWEP.VMData.Model
SWEP.WorldModel = "models/weapons/danny/cmb/w_cmb_browning.mdl"

SWEP.HipRecoil		= 5
SWEP.AimRecoil		= 4
SWEP.HipSpread		= 0
SWEP.AimSpread		= 0
SWEP.HipVelSpread	= 4
SWEP.AimVelSpread	= 4
SWEP.HipSpreadAdd	= 0.55
SWEP.AimSpreadAdd	= 0.25
SWEP.CrouchAccuracy = 0.8
SWEP.DeployTime 	= 0.2

SWEP.DotSight 		= false
SWEP.WallDistance	= 25

SWEP.AimFOV = 80
SWEP.HipFOV = 85

SWEP.Primary.ChamberSize = 0

function SWEP:MagReload()
	self:SetAiming(true)
	self.BaseClass.MagReload(self)
end

function SWEP:PrimaryAttack()
	self.BaseClass.PrimaryAttack(self)
end
