--[[-----------------------------------------------------------------------------
 * Infected Wars, an open source Garry's Mod game-mode.
 *
 * Infected Wars is the work of multiple authors,
 * a full list can be found in CONTRIBUTORS.md.
 * For more information, visit https://github.com/JarnoVgr/InfectedWars
 *
 * Infected Wars is free software: you can redistribute it and/or modify
 * it under the terms of the MIT License.
 *
 * A full copy of the MIT License can be found in LICENSE.txt.
 -----------------------------------------------------------------------------]]

include("shared.lua")

SWEP.PrintName = "Crowbar of Death"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.CSMuzzleFlashes = false

SWEP.Slot = 0
SWEP.SlotPos = 1

SWEP.IconLetter = "6"
killicon.AddFont("iw_und_crowbar", "HL2MPTypeDeath", SWEP.IconLetter, Color(255, 80, 0, 255 ))


function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	if CurTime() < self.Weapon:GetNetworkedFloat("LastShootTime", -100) + self.Primary.Delay then return end

	local trace = self.Owner:TraceLine(70)

	if trace.Hit then
		local mat = trace.MatType

		local decal = nil
		local soundname = nil
		if mat == MAT_FLESH then
			decal = "Impact.Flesh"
			local effectdata = EffectData()
				effectdata:SetOrigin(trace.HitPos)
				effectdata:SetStart(trace.HitPos + trace.HitNormal * 8)
			util.Effect("BloodImpact", effectdata)
		elseif mat == MAT_ANTLION then
			decal = "Impact.Antlion"
		elseif mat == MAT_BLOODYFLESH then
			decal = "Impact.BloodyFlesh"
			local effectdata = EffectData()
				effectdata:SetOrigin(trace.HitPos)
				effectdata:SetStart(trace.HitPos + trace.HitNormal * 8)
			util.Effect("BloodImpact", effectdata)
		elseif mat == MAT_SLOSH then
			decal = "Impact.BloodyFlesh"
		elseif mat == MAT_ALIENFLESH then
			decal = "Impact.AlienFlesh"
		elseif mat == MAT_WOOD then
			decal = "Impact.Concrete"
		elseif mat == MAT_CONCRETE then
			decal = "Impact.Concrete"
		elseif mat == MAT_METAL then
			decal = "Impact.Concrete"
		elseif mat == MAT_SAND or mat == MAT_DIRT or mat == MAT_FOLIAGE then
			decal = "Impact.Concrete"
		elseif mat == MAT_GLASS then
			decal = "Impact.Glass"
		elseif mat == MAT_VENT or mat == MAT_GRATE then
			decal = "Impact.Metal"
		elseif mat == MAT_PLASTIC then
			decal = "Impact.Metal"
		elseif mat == MAT_COMPUTER then
			decal = "Impact.Metal"
		elseif mat == MAT_TILE then
			decal = "Impact.Concrete"
		end

		if decal then
			util.Decal(decal, trace.HitPos + trace.HitNormal * 8, trace.HitPos - trace.HitNormal * 8)
		end
	end

	self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
end

function SWEP:CanPrimaryAttack()
	return false
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:Reload()
	return false
end

function SWEP:Think()
end

if CLIENT then
	function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
		draw.SimpleText( "6", "HL2MPTypeDeath", x + wide/2, y + tall*0.3, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )
		// Draw weapon info box
		self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
	end
end
