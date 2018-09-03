SWEP.PrintName			= "L96"	
SWEP.Slot				= 3
SWEP.SlotPos			= 1

SWEP.Base				= "cmb_base"
SWEP.Category			= "Second Amendment"

SWEP.Spawnable			= true

SWEP.Primary.Damage		= 175
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone		= 0
SWEP.Primary.Spread 	= 0
SWEP.Primary.RPM 		= 600
SWEP.Primary.Force 		= 7

SWEP.Primary.MagSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "cmb_308"

SWEP.ReloadLength 		= 4.2
SWEP.FullReloadLength	= 4.2

SWEP.SprintSeed = 6

SWEP.VMData = {
	["Model"] = "models/viper/l96.mdl",

	["Anim"] = {
		["Draw"] = "draw",
		["Fire"] = "hip_shoot",
		["Reload"] = "reload",
		["HipReload"] = "hip_reload",
		["FullReload"] = "reload",
		["FullHipReload"] = "hip_reload",
		["Hip"] = "origin_to_hip",
		["Origin"] = "hip_to_origin",
		["Sprint"] = "sprint",
		["Pump"] = "boltpull",
	},

	["Activity"] = {
		["Fire"] = "CMB_Remington.Fire",
		["Draw"] = "CMB_Uni.Deploy1",
		["Reload"] = {
			{time = 0.25, snd = "CMB_Remington.BoltRelease"},
			{time = 0.4, snd = "CMB_Remington.BoltBack"},
			{time = 1.2, snd = "CMB_Remington.MagOut"},
			{time = 2.25, snd = "CMB_Remington.MagIn"},
			{time = 3, snd = "CMB_Remington.BoltForward"},
			{time = 3.2, snd = "CMB_Remington.BoltLatch"}
		},
		["FullReload"] = {
			{time = 0.25, snd = "CMB_Remington.BoltRelease"},
			{time = 0.4, snd = "CMB_Remington.BoltBack"},
			{time = 1.2, snd = "CMB_Remington.MagOut"},
			{time = 2.25, snd = "CMB_Remington.MagIn"},
			{time = 3, snd = "CMB_Remington.BoltForward"},
			{time = 3.2, snd = "CMB_Remington.BoltLatch"}
		},
		["Pump"] = {
			{time = 0.25, snd = "CMB_Remington.BoltRelease"},
			{time = 0.4, snd = "CMB_Remington.BoltBack"},
			{time = 0.6, snd = "CMB_Remington.BoltForward"},
			{time = 0.8, snd = "CMB_Remington.BoltLatch"}
		}
	},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-2.61,-6,0.543),
			["Ang"] = Vector(0,0,0)
		},
		["Sprint"] = {
			["Pos"] = Vector(0,0,0),
			["Ang"] = Vector(0,0,0)
		},
		["Origin"] = {
			["Pos"] = Vector(0,-0.5,-1.2),
			["Ang"] = Vector(0,0,0)
		},
		["Recoil"] = {
			["Pos"] = Vector(-0.2,0.4,-0.05),
			["Ang"] = Vector(-0.5,0,-1)	
		}
	},

	["Shell"] = {
		["Model"] = "models/shells/shell_556.mdl"
	}
}

SWEP.CustomRecoilAimMultiplier = 0.3

SWEP.ViewModel = SWEP.VMData.Model

SWEP.UseMagazine = true
SWEP.PumpAction = true
SWEP.PumpTime = 1

SWEP.HipRecoil		= 4
SWEP.AimRecoil		= 3
SWEP.HipSpread		= 0.02
SWEP.AimSpread		= 0
SWEP.HipVelSpread	= 5
SWEP.AimVelSpread	= 0.5
SWEP.HipSpreadAdd	= 0.008
SWEP.AimSpreadAdd	= 0
SWEP.CrouchAccuracy = 0.8
SWEP.DeployTime 	= 0.4

SWEP.DotSight 		= false
SWEP.WallDistance	= 35

SWEP.HolsterReloadTimeOffset = 0.35

if CLIENT then
	local surface = surface
	SWEP.Lens = surface.GetTextureID("cmb/lens")
	SWEP.LensMask = Material("cmb/lensring")
	SWEP.LensVignette = Material("cmb/lensvignette")
	SWEP._ScopeRT = GetRenderTarget("cmb_scope", 1024, 1024, false)

	local angle = Angle()
	local r_ = {
		x = 0,
		y = 0,
		w = 1024,
		h = 1024,
		fov = 6.5,
		drawviewmodel = false,
		drawhud = false,
		dopostprocess = false
	}
	SWEP.ScopeAlpha = 0
	SWEP.ScopePos = 0
	
	local aim_difference = Vector()
	function SWEP:DrawRT()
		local x, y = ScrW(), ScrH()
		local old = render.GetRenderTarget()

		self.ScopeAlpha = math.Approach(self.ScopeAlpha, (!self:GetHip() or self:GetReloading() or !self:GetAiming()) and 255 or 0, 15)
		
		local att = self.vm:GetAttachment(1)
		local vm_pos, vm_ang = att.Pos, att.Ang

		vm_ang:RotateAroundAxis(vm_ang:Up(), 90)

		local angDif = util_NormalizeAngles( (vm_ang - EyeAngles()) - (self.AngDelta or angle)*3 )*100

		r_.origin = self.Owner:GetShootPos()
		r_.angles = vm_ang

		render.SetRenderTarget(self._ScopeRT)
		render.SetViewPort(0, 0, 1024, 1024)

		if self.ScopeAlpha <= 200 then
			render.RenderView(r_)
		end

		local lens_color = render.ComputeLighting(vm_pos, -vm_ang:Forward())*2

		cam.Start2D()
			surface.SetDrawColor(0, 0, 0, 255 - self.ScopeAlpha)
			surface.DrawRect(0, 512, 1024, 5)
			surface.DrawRect(512, 0, 5, 1024)

			surface.SetDrawColor(255, 255, 255, 255 - self.ScopeAlpha)
			surface.SetMaterial(self.LensMask)
			surface.DrawTexturedRect(angDif.y, angDif.p, 1024, 1024)

			surface.SetMaterial(self.LensVignette)
			surface.DrawTexturedRect(0, 0, 1024, 1024)

			surface.SetDrawColor(0, 0, 0, 255 - self.ScopeAlpha)
			surface.DrawRect(angDif.y - 2048, angDif.p, 2048, 1024) --left
			surface.DrawRect(angDif.y - 2048, angDif.p - 4096, 4096, 4096) --up
			surface.DrawRect(angDif.y - 2048, angDif.p + 1024, 4096, 4096) --down
			surface.DrawRect(angDif.y + 1024, angDif.p, 4096, 4096) --right

			surface.SetDrawColor(255*lens_color[1], 255*lens_color[2], 255*lens_color[3], 255)			
			surface.SetTexture(self.Lens)
			surface.DrawTexturedRect(0, 0, 1024, 1024)
		cam.End2D()

		if !self._Scope then
			self._Scope = Material("weapons/danny/cmb/black")
			self._Scope:SetTexture("$basetexture", self._ScopeRT)
		end
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
	end
end