function SWEP:HandleHoldTypes()
	if self:GetAiming() then
		self:SetCustomHoldType("Aiming")
	else
		self:SetCustomHoldType("Hip")
	end
end

function SWEP:SetCustomHoldType(cht)
	
	self.CurHoldType = self.HoldTypes[cht]
	self:SetHoldType(self.CurHoldType)
end

function SWEP:DrawWorldModel()
	local hand, offset, rotate

	if !IsValid(self.Owner) then
		self:DrawModel()
		return
	end

	if !self.Hand then
		self.Hand = self.Owner:LookupAttachment("anim_attachment_rh")
	end

	hand = self.Owner:GetAttachment(self.Hand)

	if !hand then
		self:DrawModel()
		return
	end

	local right, up, forward = hand.Ang:Right(), hand.Ang:Up(), hand.Ang:Forward()

	hand.Pos = hand.Pos + (self.VMData.Matrix.World.Pos.x) * right
	hand.Pos = hand.Pos + (self.VMData.Matrix.World.Pos.y) * up
	hand.Pos = hand.Pos + (self.VMData.Matrix.World.Pos.z) * forward

	hand.Ang:RotateAroundAxis(right, self.VMData.Matrix.World.Ang.x)
	hand.Ang:RotateAroundAxis(up, self.VMData.Matrix.World.Ang.y)
	hand.Ang:RotateAroundAxis(forward, self.VMData.Matrix.World.Ang.z)

	self:SetRenderOrigin(hand.Pos)
	self:SetRenderAngles(hand.Ang)

	self:DrawModel()
end