SWEP.PrintName			= "SMG-1"
SWEP.Slot				= 2
SWEP.SlotPos			= 1
SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment HL2"
SWEP.ViewModelFOV = 55
SWEP.Spawnable			= true
SWEP.Primary.Damage		= 25
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone		= 0
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 900
SWEP.Primary.Force 		= 6

SWEP.Primary.MagSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.ReloadLength 		= 2
SWEP.FullReloadLength	= 2

SWEP.SprintSeed = 1


SWEP.CustomRecoilAimMultiplier = 1

SWEP.VMData = {
	["Model"] = "models/viper/viper_smg1.mdl",

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
		["Fire"] = "CMB_SMG1.Fire",
		["Draw"] = "CMB_SMG1.Draw",
		["Reload"] = {
			{time = 0.3, snd = "CMB_SMG1.ClipOut"},
			{time = 1.15, snd = "CMB_SMG1.ClipIn"}
		},
		["Sprint"] = {
			{time = 0, snd = "CMB_HL2.Sprint"}
		},
		["FullReload"] = {
			{time = 0.3, snd = "CMB_SMG1.ClipOut"},
			{time = 1.15, snd = "CMB_SMG1.ClipIn"}
		},
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-4.67,-5,1.5),
			["Ang"] = Vector(1.45,0.2,0)
		},
		["Sprint"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Origin"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Recoil"] = {
			["Pos"] = Vector(0.015,0.5,0),
			["Ang"] = Vector(0,0,0)
		}
	},

	["Shell"] = {
		["Model"] = "models/shells/shell_9mm.mdl"
	}
}

SWEP.ViewModel = SWEP.VMData.Model
SWEP.WorldModel = "models/weapons/w_smg1.mdl"

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
SWEP.HipFOV = 100

function SWEP:MagReload()
	self:SetAiming(true)
	self.BaseClass.MagReload(self)
end
