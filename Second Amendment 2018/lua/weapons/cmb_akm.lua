SWEP.PrintName			= "AKM"	
SWEP.Slot				= 2
SWEP.SlotPos			= 1

SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment"

SWEP.Spawnable			= true

SWEP.Primary.Damage		= 45
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone		= 0
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 600
SWEP.Primary.Force 		= 6

SWEP.Primary.MagSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "cmb_762"

SWEP.ReloadLength 		= 2.5
SWEP.FullReloadLength	= 3.5

SWEP.SprintSeed = 0

SWEP.CustomRecoilAimMultiplier = 1

SWEP.VMData = {
	["Model"] = "models/weapons/danny/cmb/v_cmb_akm.mdl",

	["Anim"] = {
		["Draw"] = "draw",
		["Fire"] = "hip_shoot",
		["Reload"] = "hip_reload",
		["HipReload"] = "hip_reload",
		["FullReload"] = "hip_reload_full",
		["FullHipReload"] = "hip_reload_full",
		["Hip"] = "origin_to_hip",
		["Origin"] = "hip_to_origin",
		["Sprint"] = "sprint",
		["Nade"] = "grenade",
		["HipNade"] = "hip_grenade"
	},

	["Activity"] = {
		["Fire"] = "CMB_AKM.Fire",
		["Draw"] = "CMB_Uni.Deploy1",
		["Reload"] = {
			{time = 0.29, snd = "CMB_AKM.ClipRelease"},
			{time = 0.3, snd = "CMB_AKM.ClipOut"},
			{time = 0.4, snd = "CMB_AKM.ClipOutRattle"},
			{time = 1.7, snd = "CMB_AKM.ClipIn"},
			{time = 2.45, snd = "CMB_AKM.Rattle"}
		},
		["FullReload"] = {
			{time = 0.29, snd = "CMB_AKM.ClipRelease"},
			{time = 0.3, snd = "CMB_AKM.ClipOut"},
			{time = 0.4, snd = "CMB_AKM.ClipOutRattle"},
			{time = 1.7, snd = "CMB_AKM.ClipIn"},
			{time = 2.65, snd = "CMB_AKM.BoltBack"},
			{time = 2.85, snd = "CMB_AKM.BoltForward"},
			{time = 3.6, snd = "CMB_AKM.Rattle"}
		},
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-2.755,-1,1.17),
			["Ang"] = Vector(-0.25,0,0)
		},
		["Sprint"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Origin"] = {
			["Pos"] = Vector(1,1.5,-0.6),
			["Ang"] = Vector(0,0,0)
		},
		["Recoil"] = {
			["Pos"] = Vector(0,0.6,0.2),
			["Ang"] = Vector(-1,0,0)	
		}
	},

	["Shell"] = {
		["Model"] = "models/shells/shell_556.mdl"
	}
}

SWEP.ViewModel = SWEP.VMData.Model
SWEP.WorldModel = "models/weapons/danny/cmb/w_cmb_akm.mdl"

SWEP.HipRecoil		= 1.6
SWEP.AimRecoil		= 1.3
SWEP.HipSpread		= 0.005
SWEP.AimSpread		= 0
SWEP.HipVelSpread	= 1.5
SWEP.AimVelSpread	= 0.8
SWEP.HipSpreadAdd	= 0.65
SWEP.AimSpreadAdd	= 0.25
SWEP.CrouchAccuracy = 0.7
SWEP.DeployTime 	= 0.6

SWEP.DotSight 		= false
SWEP.WallDistance	= 50

SWEP.AimFOV = 70
SWEP.HipFOV = 85

function SWEP:MagReload()
	self:SetAiming(true)
	self.BaseClass.MagReload(self)
end