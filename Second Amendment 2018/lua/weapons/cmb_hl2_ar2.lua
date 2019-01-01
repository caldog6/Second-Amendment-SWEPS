SWEP.PrintName			= "AR2"
SWEP.Slot				= 2
SWEP.SlotPos			= 1

SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment HL2"

SWEP.Spawnable			= true
SWEP.ViewModelFOV = 65
SWEP.Primary.Damage		= 45
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone		= 0
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 600
SWEP.Primary.Force 		= 6

SWEP.Primary.MagSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"

SWEP.ReloadLength 		= 2
SWEP.FullReloadLength	= 2

SWEP.SprintSeed = 0

SWEP.CustomRecoilAimMultiplier = 1

SWEP.VMData = {
	["Model"] = "models/viper/viper_ar2.mdl",

	["Anim"] = {
		["Draw"] = "draw",
		["Fire"] = "fire1_is",
		["Reload"] = "reload",
		["HipReload"] = "reload",
		["FullReload"] = "reload",
		["FullHipReload"] = "reload",
		["Hip"] = "lowtoidle",
		["Origin"] = "idletolow",
		["Sprint"] = "sprint",
		["Nade"] = "grenade",
		["HipNade"] = "hip_grenade"
	},

	["Activity"] = {
		["Fire"] = "CMB_AR2.Fire",
		["Draw"] = "CMB_AR2.Draw",
		["Reload"] = {
			{time = 0.3, snd = "CMB_AR2.Magout"},
			{time = 1.45, snd = "CMB_AR2.Magin"}
		},
		["Sprint"] = {
			{time = 0, snd = "CMB_HL2.Sprint"}
		},
		["FullReload"] = {
			{time = 0.3, snd = "CMB_AR2.Magout"},
			{time = 1.45, snd = "CMB_AR2.Magin"}
		},
		["FullHipReload"] = {
			{time = 0.3, snd = "CMB_AR2.Magout"},
			{time = 1.45, snd = "CMB_AR2.Magin"}
		},
		["HipReload"] = {
			{time = 0.3, snd = "CMB_AR2.Magout"},
			{time = 1.45, snd = "CMB_AR2.Magin"}
		},
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-2.755,-1,1.2),
			["Ang"] = Vector(-0.1,0.02,0)
		},
		["Sprint"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Origin"] = {
			["Pos"] = Vector(-2,-1.5,-0.6),
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
SWEP.WorldModel = "models/weapons/w_irifle.mdl"

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
SWEP.HipFOV = 95

function SWEP:MagReload()
	self:SetAiming(true)
	self.BaseClass.MagReload(self)
end
