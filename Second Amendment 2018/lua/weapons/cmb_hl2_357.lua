SWEP.PrintName			= ".357 Magnum"
SWEP.Slot				= 1
SWEP.SlotPos			= 1

SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment HL2"

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
SWEP.Primary.Ammo			= "357"

SWEP.ReloadLength 		= 4.25
SWEP.FullReloadLength	= 4.25

SWEP.VMData = {
	["Model"] = "models/viper/viper_357.mdl",

	["Anim"] = {
		["Draw"] = "draw",
		["Fire"] = "fire_is",
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
		["Fire"] = "CMB_357.Fire",
		["Draw"] = "CMB_357.Draw",
		["Reload"] = {
			{time = 0.25, snd = "CMB_357.Reload1"},
			{time = 1.25, snd = "CMB_357.Reload2"},
			{time = 2.8, snd = "CMB_357.Reload3"},
			{time = 3.45, snd = "CMB_357.Reload4"}
		},
		["HipReload"] = {
			{time = 0.25, snd = "CMB_357.Reload1"},
			{time = 1.25, snd = "CMB_357.Reload2"},
			{time = 2.8, snd = "CMB_357.Reload3"},
			{time = 3.45, snd = "CMB_357.Reload4"}
		},
		["Sprint"] = {
			{time = 0, snd = "CMB_HL2.Sprint"}
		},
		["FullReload"] = {
			{time = 0.25, snd = "CMB_357.Reload1"},
			{time = 1.25, snd = "CMB_357.Reload2"},
			{time = 2.8, snd = "CMB_357.Reload3"},
			{time = 3.45, snd = "CMB_357.Reload4"}
		},
		["FullHipReload"] = {
			{time = 0.25, snd = "CMB_357.Reload1"},
			{time = 1.25, snd = "CMB_357.Reload2"},
			{time = 2.8, snd = "CMB_357.Reload3"},
			{time = 3.45, snd = "CMB_357.Reload4"}
		}
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-3.18,-3,1.1),
			["Ang"] = Vector(0,0,0)
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
SWEP.WorldModel = "models/weapons/w_357.mdl"

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
