local function CreateLabel(panel, text)
	panel:AddControl("Label", {Text = text})
end

local function CreateBox(panel, text, cvar)
	panel:AddControl("CheckBox", {
		Label = text,
		Command = cvar,
	})
end

local function CreateSlider(panel, text, cvar, type, min, max)
	panel:AddControl("Slider", {
		Label   = text,
		Command = cvar,
		Type= type,
		Min = min,
		Max = max,
	})
end

function SecondAmendment.ClientMenu(panel)
	CreateLabel(panel, "Blur Control")
	CreateBox(panel, "Weapon Blur", "cmb_vm_blur")
	CreateBox(panel, "View Blur", "cmb_view_blur")

	CreateLabel(panel, "Miscellaneous")
	CreateBox(panel, "Custom Weapon Origins", "cmb_vm_origin")
end

function SecondAmendment.ServerMenu(panel)
	if !LocalPlayer():IsAdmin() then CreateLabel(panel, "ACCESS DENIED") return end

	CreateLabel(panel, "Crosshair Control")
	CreateBox(panel, "Enabled", "cmb_xhair_enabled")
end

function SecondAmendment.Populate()
	spawnmenu.AddToolMenuOption("Utilities", "Second Amendment", "cmb_client", "Client", "", "", SecondAmendment.ClientMenu)
	spawnmenu.AddToolMenuOption("Utilities", "Second Amendment", "cmb_server", "Server", "", "", SecondAmendment.ServerMenu)
end
hook.Add("PopulateToolMenu", "SecondAmendment.Populate", SecondAmendment.Populate)