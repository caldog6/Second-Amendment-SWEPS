if SERVER then return end

local int = SecondAmendment.Lerp
local math = math
local surface = surface

SecondAmendment.Crosshair = Material("cmb/circle")

local alpha = 0
local col = 1
function SWEP:DrawHUD()
	if not SecondAmendment.CVar["xhair_enabled"]:GetBool() then return end
	
	local FT, CT = FrameTime(), CurTime()

	local trace = self.Owner:GetEyeTraceNoCursor()
	local pos = trace.HitPos:ToScreen()
	local punch = self.Owner:GetViewPunchAngles()
	local W = math.Round(pos.x - punch.y * 12)
	local H = math.Round(pos.y + punch.p * 12)
	local ent = trace.Entity:IsNPC() or trace.Entity:IsPlayer()

	alpha = int(FT * 25, alpha, ((self:GetAiming() and !self:GetHip() or self.PermanentCrosshair)) and 1 or 0)

	col = int(FT * 15, col, ent and 0 or 1)

	surface.SetMaterial(SecondAmendment.Crosshair)

	surface.SetDrawColor(0, 0, 0, 200 * alpha)
	surface.DrawTexturedRect(W - 3, H - 3, 6, 6)

	surface.SetDrawColor(255, 255 * col, 255 * col, 255 * alpha)
	surface.DrawTexturedRect(W - 2, H - 2, 4, 4)
end

function SWEP.RenderScene()
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
		
	if IsValid(wep) and wep.DrawRT and wep.SecondAmendment then
		wep:DrawRT()
	end
end
hook.Add("RenderScene", "CMB_RenderScene", SWEP.RenderScene)
