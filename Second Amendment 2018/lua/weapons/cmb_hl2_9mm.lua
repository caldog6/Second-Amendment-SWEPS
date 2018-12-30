SWEP.PrintName			= "9mm Pistol"
SWEP.Slot				= 1
SWEP.SlotPos			= 1
SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment HL2"
SWEP.ViewModelFOV = 60
SWEP.Spawnable			= true
SWEP.Primary.Damage		= 25
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone		= 0
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 900
SWEP.Primary.Force 		= 6

SWEP.Primary.MagSize		= 18
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.ReloadLength 		= 1.75
SWEP.FullReloadLength	= 1.75

SWEP.SprintSeed = 1


SWEP.CustomRecoilAimMultiplier = 1

SWEP.VMData = {
	["Model"] = "models/viper/viper_9mm.mdl",

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
		["Fire"] = "CMB_9mm.Fire",
		["Draw"] = "CMB_9mm.Draw",
		["Reload"] = {
		  {time = 0.3, snd = "CMB_9MM.MagOut"},
		  {time = 1, snd = "CMB_9MM.MagIn"},
		  {time = 1.55, snd = "CMB_9MM.Sliderelease"}
		},
		["Sprint"] = {
		  {time = 0.3, snd = "CMB_HL2.Sprint"},
		},
		["FullHipReload"] = {
		  {time = 0.3, snd = "CMB_9MM.MagOut"},
		  {time = 1, snd = "CMB_9MM.MagIn"},
		  {time = 1.55, snd = "CMB_9MM.Sliderelease"}
		},
		["FullReload"] = {
		  {time = 0.3, snd = "CMB_9MM.MagOut"},
		  {time = 1, snd = "CMB_9MM.MagIn"},
		  {time = 1.55, snd = "CMB_9MM.Sliderelease"}
		},
		["HipReload"] = {
		  {time = 0.3, snd = "CMB_9MM.MagOut"},
		  {time = 1, snd = "CMB_9MM.MagIn"},
		  {time = 1.55, snd = "CMB_9MM.Sliderelease"}
		},
		},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-5,-2,2.5),
			["Ang"] = Vector(0,0,0)
		},
		["Sprint"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Origin"] = {
			["Pos"] = Vector(-1,-2,1),
			["Ang"] = Vector(0,0,0)
		},
		["Recoil"] = {
			["Pos"] = Vector(0.015,1.5,0),
			["Ang"] = Vector(-0.25,0,0)
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
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

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
