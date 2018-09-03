SWEP.PrintName			= "Saiga-12k"	
SWEP.Slot				= 3
SWEP.SlotPos			= 1

SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment"

SWEP.Spawnable			= true

SWEP.Primary.Damage		= 20
SWEP.Primary.NumShots	= 12
SWEP.Primary.Cone		= 0
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 600
SWEP.Primary.Force 		= 2

SWEP.Primary.MagSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "cmb_12gauge"

SWEP.ReloadLength 		= 2
SWEP.FullReloadLength	= 3

SWEP.SprintSeed = 5

SWEP.VMData = {
	["Model"] = "models/viper/saiga.mdl",

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
			["Pos"] = Vector(-2.75,-3,0.65),
			["Ang"] = Vector(-0.1,0.02,0)
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
		["Model"] = "models/shells/shell_12gauge.mdl"
	}
}

SWEP.HoldTypes = {
	["Aiming"] = "ar2",
	["Hip"] = "passive",
}

SWEP.ViewModel = SWEP.VMData.Model
SWEP.WorldModel = "models/weapons/danny/cmb/w_cmb_mossberg.mdl"

SWEP.UseMagazine = true
SWEP.PumpAction = false

SWEP.HipRecoil		= 2.5
SWEP.AimRecoil		= 2
SWEP.HipSpread		= 0.057
SWEP.AimSpread		= 0.057
SWEP.HipVelSpread	= 0
SWEP.AimVelSpread	= 0
SWEP.HipSpreadAdd	= 0
SWEP.AimSpreadAdd	= 0
SWEP.CrouchAccuracy = 0.8
SWEP.DeployTime 	= 0.4

SWEP.HipSpeed 		= 0.8
SWEP.AimSpeed 		= 0.6
SWEP.DotSight 		= false
SWEP.WallDistance	= 35