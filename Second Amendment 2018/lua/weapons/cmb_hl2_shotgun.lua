SWEP.PrintName			= "Shotgun"
SWEP.Slot				= 3
SWEP.SlotPos			= 1

SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment HL2"

SWEP.Spawnable			= true
SWEP.ViewModelFOV 		= 60
SWEP.Primary.Damage		= 20
SWEP.Primary.NumShots	= 12
SWEP.Primary.Cone		= 0
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 600
SWEP.Primary.Force 		= 2

SWEP.Primary.MagSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"

SWEP.ReloadLength 		= 1
SWEP.FullReloadLength	= 1

SWEP.SprintSeed = 5

SWEP.VMData = {
	["Model"] = "models/viper/viper_shotgun.mdl",

	["Anim"] = {
		["Draw"] = "draw",
		["Fire"] = "fire_ironsights",
		["MiddleReload"] = "reload2",
		["StartHipReload"] = "reload1",
		["StartReload"] = "reload1",
		["EndHipReload"] = "reload3",
		["EndReload"] = "reload3",
		["Hip"] = "lowtoidle",
		["Origin"] = "idletolow",
		["Sprint"] = "sprint",
		["Pump"] = "pump",
	},

	["Activity"] = {
		["Fire"] = "CMB_Shotgun.Fire",
		["Draw"] = "CMB_Shotgun.Draw",
		["StartReload"] = {
			{time = 0.3, snd = "CMB_HL2.Foley2"}
		},
		["Sprint"] = {
			{time = 0.3, snd = "CMB_HL2.Sprint"},
		},
		["StartHipReload"] = {
			{time = 0, snd = "CMB_HL2.Foley1"}
		},
		["MiddleReload"] = {
			{time = 0.01, snd = "CMB_Shotgun.ShellInsert"}
		},
		["EndReload"] = {
			{time = 0.3, snd = "CMB_HL2.Fole3"}
		},
		["Pump"] = {
			{time = 0, snd = "CMB_Shotgun.PumpBack"},
			{time = 0.15, snd = "CMB_Shotgun.PumpForward"}
		}
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-4.85,-3,2),
			["Ang"] = Vector(0,0,0)
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
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

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

SWEP.AimFOV = 70
SWEP.HipFOV = 95

SWEP.HipSpeed 		= 0.8
SWEP.AimSpeed 		= 0.6
SWEP.DotSight 		= false
SWEP.WallDistance	= 35

function SWEP:MagReload()
	self:SetAiming(true)
	self.BaseClass.MagReload(self)
end
