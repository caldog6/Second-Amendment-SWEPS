SecondAmendment = {}
SecondAmendment.CVar = {}
local math = math

function SecondAmendment.AddSound(wpn, name, snd, vol)
	sound.Add(
	{
		name = "CMB_"..wpn.."."..name,
		channel = CHAN_STATIC,
		volume = vol or 1,
		soundlevel = 100,
		pitchstart = 96,
		pitchend = 104,
		sound = "<"..snd
	})
end

local normalize = math.NormalizeAngle
function util_NormalizeAngles( a )
	a.p = normalize( a.p )
	a.y = normalize( a.y )
	a.r = normalize( a.r )
	return a
end

function SecondAmendment.Lerp(delta, from, to)
	local delta = math.Clamp(delta, 0, 1)

	if type(from) == "Angle" then
		from = util_NormalizeAngles(from)
		to = util_NormalizeAngles(to)
	end

	local out = from + (to-from)*delta

	return out
end

function SecondAmendment.Cerp(delta, from, to)
	local delta = math.Clamp(delta, 0, 1)
	
	local f = (1-math.cos(delta*math.pi))*.5
	
	if type(from) == "Angle" then
		from = util_NormalizeAngles(from)
		to = util_NormalizeAngles(to)
	end
	
	local out = from*(1-f)+to*f
	
	return out
end

function SecondAmendment.AddClientCVar(name, value)
	SecondAmendment.CVar[name] = CreateClientConVar("cmb_"..name, value)
end

function SecondAmendment.AddCVar(name, value)
	SecondAmendment.CVar[name] = CreateConVar("cmb_"..name, value, {FCVAR_ADMIN, FCVAR_REPLICATED})
end

SecondAmendment.AddClientCVar("vm_origin", 0)
SecondAmendment.AddClientCVar("vm_blur", 1)
SecondAmendment.AddClientCVar("view_blur", 1)
SecondAmendment.AddClientCVar("xhair_size", 1)

SecondAmendment.AddCVar("xhair_enabled", 1)

AddCSLuaFile("SecondAmendment/cmb_sound.lua")
include("SecondAmendment/cmb_sound.lua")
AddCSLuaFile("SecondAmendment/cmb_settings.lua")
include("SecondAmendment/cmb_settings.lua")

local function AddAmmo(name, ammotype)
	local ammoType = {}
    ammoType.name = ammotype
    ammoType.dmgtype = DMG_BULLET
    
    game.AddAmmoType(ammoType)

    if CLIENT then
        language.Add(ammotype.."_ammo", name)
    end
end

AddAmmo("7.62x39mm", "cmb_762")
AddAmmo("5.56x45mm", "cmb_556")
AddAmmo("9x19mm", "cmb_9mm")
AddAmmo("12 Gauge", "cmb_12gauge")
AddAmmo(".45 ACP", "cmb_45acp")
AddAmmo(".44 Magnum", "cmb_44")
AddAmmo("M67 Grenade", "cmb_m67")
AddAmmo(".308 Winchester", "cmb_308")