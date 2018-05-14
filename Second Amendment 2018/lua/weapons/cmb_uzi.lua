SWEP.PrintName			= "IMI UZI"	
SWEP.Slot				= 2
SWEP.SlotPos			= 1

SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment"

SWEP.Spawnable			= true

SWEP.Primary.Damage		= 32
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone		= 0
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 666
SWEP.Primary.Force 		= 1

SWEP.Primary.MagSize		= 32
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "cmb_45acp"

SWEP.ReloadLength 		= 2
SWEP.FullReloadLength	= 3

SWEP.CustomRecoilAimMultiplier = 0.2

SWEP.VMData = {
	["Model"] = "models/weapons/danny/cmb/v_cmb_uzi.mdl",

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
		["Fire"] = "CMB_UZI.Fire",
		["Draw"] = "CMB_Uni.Deploy1",
		["Reload"] = {
			{time = 0.3, snd = "CMB_UZI.ClipOut"},
			{time = 1, snd = "CMB_UZI.ClipIn"},
			{time = 1.3, snd = "CMB_UZI.Tap"}
		},
		["FullReload"] = {
			{time = 0.3, snd = "CMB_UZI.ClipOut"},
			{time = 1, snd = "CMB_UZI.ClipIn"},
			{time = 1.3, snd = "CMB_UZI.Tap"},
			{time = 2, snd = "CMB_UZI.BoltBack"},
			{time = 2.15, snd = "CMB_UZI.BoltForward"}
		},
		["Aim"] = {
			{time = 0.13, snd = "CMB_Uni.Tap"}
		}
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-3.815,-5,1.75),
			["Ang"] = Vector(-0.3,-0.8,0)
		},
		["Sprint"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Origin"] = {
			["Pos"] = Vector(0,-1,-2),
			["Ang"] = Vector(0,0,0)
		},
		["Recoil"] = {
			["Pos"] = Vector(0, 1, -0.1),
			["Ang"] = Vector(-0.5, 0, 0)	
		}
	},

	["Shell"] = {
		["Model"] = "models/shells/shell_9mm.mdl"
	}
}

SWEP.ViewModel = SWEP.VMData.Model
SWEP.WorldModel = "models/weapons/danny/cmb/w_cmb_uzi.mdl"
SWEP.HipRecoil		= 0.8
SWEP.AimRecoil		= 0.5
SWEP.HipSpread		= 0.005
SWEP.AimSpread		= 0
SWEP.HipVelSpread	= 1
SWEP.AimVelSpread	= 0.5
SWEP.HipSpreadAdd	= 0.5
SWEP.AimSpreadAdd	= 0.2
SWEP.CrouchAccuracy = 0.8
SWEP.DeployTime 	= 0.2

SWEP.HipSpeed 		= 0.8
SWEP.AimSpeed 		= 0.6
SWEP.DotSight 		= false
SWEP.WallDistance	= 35