SWEP.PrintName			= "Mossberg M500"	
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
	["Model"] = "models/weapons/danny/cmb/v_cmb_mossberg.mdl",

	["Anim"] = {
		["Draw"] = "draw",
		["Fire"] = "hip_shoot",
		["MiddleReload"] = "reload_middle",
		["StartHipReload"] = "hip_reload_start",
		["StartReload"] = "reload_start",
		["EndHipReload"] = "hip_reload_end",
		["EndReload"] = "reload_end",
		["Hip"] = "origin_to_hip",
		["Origin"] = "hip_to_origin",
		["Sprint"] = "sprint",
		["Pump"] = "cock",
	},

	["Activity"] = {
		["Fire"] = "CMB_Mossberg.Fire",
		["Draw"] = "CMB_Uni.Deploy1",
		["StartReload"] = {
			{time = 0.3, snd = "CMB_Mossberg.PumpBack"}
		},
		["StartHipReload"] = {
			{time = 0, snd = "CMB_Mossberg.PumpBack"}
		},
		["MiddleReload"] = {
			{time = 0, snd = "CMB_Mossberg.ShellInsert"}
		},
		["EndReload"] = {
			{time = 0.3, snd = "CMB_Mossberg.PumpForward"}
		},
		["Pump"] = {
			{time = 0, snd = "CMB_Mossberg.PumpBack"},
			{time = 0.15, snd = "CMB_Mossberg.PumpForward"}
		}
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-2.85,-5,1.6),
			["Ang"] = Vector(0.8,0,0)
		},
		["Sprint"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Origin"] = {
			["Pos"] = Vector(-1,0,-1),
			["Ang"] = Vector(0,0,0)
		},
		["World"] = {
			["Pos"] = Vector(-2,4,-8),
			["Ang"] = Vector(15,0,0)		
		},
		["Recoil"] = {
			["Pos"] = Vector(0,0.5,0.1),
			["Ang"] = Vector(-2,0,0)	
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

SWEP.UseMagazine = false
SWEP.PumpAction = true
SWEP.PumpTime = 0.4

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