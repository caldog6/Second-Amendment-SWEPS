SWEP.PrintName			= "Glock"	
SWEP.Slot				= 1
SWEP.SlotPos			= 1

SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment"

SWEP.Spawnable			= true

SWEP.Primary.Damage		= 25
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone		= 0
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 500
SWEP.Primary.Force 		= 1

SWEP.Primary.MagSize		= 13
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "cmb_9mm"

SWEP.ReloadLength 		= 1.5
SWEP.FullReloadLength	= 2

function SWEP:SlideCall()
	if CLIENT then
		self._slide = false
	end
end

SWEP.CustomRecoilAimMultiplier = 0.1

SWEP.VMData = {
	["Model"] = "models/viper/v_cmb_glock.mdl",

	["Anim"] = {
		["Draw"] = "draw",
		["Fire"] = "hip_shoot",
		["Reload"] = "reload",
		["HipReload"] = "hip_reload",
		["FullReload"] = "reload_full",
		["FullHipReload"] = "reload_full",
		["Hip"] = "origin_to_hip",
		["Origin"] = "hip_to_origin",
		["Sprint"] = "sprint",
		["Nade"] = "grenade",
		["HipNade"] = "hip_grenade"
	},

	["Activity"] = {
		["Fire"] = "CMB_Browning.Fire",
		["Draw"] = "CMB_Uni.Deploy1",
		["Reload"] = {
			{time = 0.3, snd = "CMB_Browning.MagOut"},
			{time = 1.1, snd = "CMB_Browning.MagIn"}
		},
		["FullHipReload"] = {
			{time = 0.3, snd = "CMB_Browning.MagOut"},
			{time = 1, snd = "CMB_Browning.MagIn"},
			{time = 1.3, snd = "CMB_Browning.SlideRelease"}
		},
		["FullReload"] = {
			{time = 0.3, snd = "CMB_Browning.MagOut"},
			{time = 1, snd = "CMB_Browning.MagIn"},
			{time = 1.8, snd = "CMB_Browning.SlideBack"},
			{time = 2, snd = "CMB_Browning.SlideRelease"},
		},
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-2.38,-2,0.5),
			["Ang"] = Vector(1,1.25,0)
		},
		["Sprint"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Origin"] = {
			["Pos"] = Vector(-1.5,0,-1),
			["Ang"] = Vector(0,0,0)
		},
		["World"] = {
			["Pos"] = Vector(-4,12,-7),
			["Ang"] = Vector(-40,2,0)		
		},
		["Recoil"] = {
			["Pos"] = Vector(0,2,0.2),
			["Ang"] = Vector(-2,0,0)	
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

SWEP.HipRecoil		= 0.8
SWEP.AimRecoil		= 0.7
SWEP.HipSpread		= 0.01
SWEP.AimSpread		= 0.005
SWEP.HipVelSpread	= 1
SWEP.AimVelSpread	= 1
SWEP.HipSpreadAdd	= 0.5
SWEP.AimSpreadAdd	= 0.2
SWEP.CrouchAccuracy = 0.8
SWEP.DeployTime 	= 0.2

SWEP.DotSight 		= false
SWEP.WallDistance	= 25

SWEP.AimFOV = 80
SWEP.HipFOV = 85

local int = SecondAmendment.Lerp
local SlidePos = Vector()
function SWEP:HandleBoneMods(vm)
	local slide = vm:LookupBone("slide_bone")
	local FT = FrameTime()
	local empty = self._slide and self:Clip1() == 0

	if self:Clip1() > 0 then
		self._slide = true
	end
	if slide then
		local matrix = vm:GetBoneMatrix(slide)

		if matrix then
			SlidePos.x = int(FT*35, SlidePos.x, empty and 1 or 0)

			vm:ManipulateBonePosition(slide, SlidePos)
		end
	end
end

function SWEP:Holster()
	self:SetReloading(false)
	self:SetAiming(false)
	self:SetSprinting(false)
	
	self:StopSoundSequence()

	self._slide = true
	return true
end