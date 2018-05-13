AddCSLuaFile()
ENT.Base = "cmb_box_base"

ENT.Type 			= "anim"
ENT.PrintName		= "Ammo Crate"
ENT.Category		= "Second Amendment"

ENT.Spawnable = true

ENT.Model 			= "models/Items/ammocrate_ar2.mdl"

ENT.AmmoTypes = {
	["cmb_556"] = 30, 
	["cmb_9mm"] = 30, 
	["cmb_12gauge"] = 30, 
	["cmb_45acp"] = 30, 
	["cmb_m67"] = 3, 
	["cmb_308"] = 30,
	["cmb_762"] = 30
}

ENT.TextSize = 0.1
ENT.TextPos = Vector(-9,-11,15.9)
ENT.Uses = 3