SWEP.PrintName			= "Crossbow"
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

SWEP.Primary.MagSize		= 1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "xbowbolt"

SWEP.ReloadLength 		= 3.5
SWEP.FullReloadLength	= 3.5

SWEP.SprintSeed = 1


SWEP.CustomRecoilAimMultiplier = 1

SWEP.VMData = {
	["Model"] = "models/viper/viper_crossbow.mdl",

	["Anim"] = {
		["Draw"] = "draw",
		["Fire"] = "fire",
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
		["Fire"] = "CMB_Xbow.Fire",
		["Draw"] = "CMB_Xbow.Draw",
		["Reload"] = {
			{time = 0.75, snd = "CMB_Xbow.String"},
			{time = 2.4, snd = "CMB_Xbow.Load"}
		},
		["Sprint"] = {
		  {time = 0.3, snd = "CMB_HL2.Sprint"},
		},
		["FullHipReload"] = {
			{time = 0.75, snd = "CMB_Xbow.String"},
			{time = 2.4, snd = "CMB_Xbow.Load"}
		},
		["FullReload"] = {
{time = 0.75, snd = "CMB_Xbow.String"},
{time = 2.4, snd = "CMB_Xbow.Load"}
		},
		["HipReload"] = {
			{time = 0.75, snd = "CMB_Xbow.String"},
			{time = 2.4, snd = "CMB_Xbow.Load"}
		},
		},

	["Matrix"] = {
		["Aim"] = {
			["Pos"] = Vector(-5, -1, 1),
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

SWEP.UseParticleMuzzle = true // set this to true if you want to disable the default muzzle effect and use particles as muzzle instead
SWEP.ParticleMuzzle = {""} // table of particles, or can be a single string
SWEP.ParticleMuzzleToStop = ""

function SWEP:MagReload()
	self:SetAiming(true)
	self.BaseClass.MagReload(self)
end

function SWEP:ShootBullet()
	if CLIENT then return end
	local ply = self.Owner
	local dir = ply:EyeAngles():Forward()
	local ent = ents.Create( "crossbow_bolt" )
	if ( IsValid( ent ) ) then
		ent:SetPos( ply:GetShootPos() + dir )
		ent:SetAngles( ply:EyeAngles() )
		ent:Spawn()
		ent:Activate()
		ent:SetVelocity( dir * 3500 )
		ent:SetOwner( ply )
		ent.Owner = self:GetOwner()
		ent:SetMoveCollide(MOVECOLLIDE_FLY_CUSTOM)
		ent.CustomXBOWBolt = true
		ent:SetSaveValue("m_flDamage", 150)
		ent:SetSaveValue("m_hOwner", self)
	end

	local tr = util.TraceLine({
		start = ply:GetPos(),
		endpos = ply:GetPos()+Vector(0,0,-32),
	})

	if ply:EyeAngles().p >= 80 and tr.Hit then // jumpity jump
		ply:SetVelocity(Vector(0,0,500))
	end
end

	if SERVER then
		hook.Add("EntityTakeDamage", "SA_XBOWBOLT_TAKEDAMGE", function( target, dmginfo )
			local ent = dmginfo:GetInflictor()
			if IsValid(ent) and ent:GetClass() == "crossbow_bolt" and ent.CustomXBOWBolt then
				dmginfo:SetMaxDamage(100)
				dmginfo:SetDamage(100)
				dmginfo:SetDamageForce( ent:GetVelocity() * 6)
				dmginfo:SetDamageType( bit.bor(DMG_GENERIC, DMG_NEVERGIB) )

				if target:IsNPC() and target:GetBloodColor() != -1 then
					local ed = EffectData()
					ed:SetOrigin(dmginfo:GetDamagePosition())
					ed:SetStart(ent:GetPos())
					ed:SetEntity(target)
					ed:SetEntIndex(target:EntIndex())
					ed:SetColor(target:GetBloodColor())
					util.Effect("BloodImpact", ed)
				end
			end
		end)
	end

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
