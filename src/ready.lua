---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- here is where your mod sets up all the things it will do.
-- this file will not be reloaded if it changes during gameplay
-- 	so you will most likely want to have it reference
--	values and functions later defined in `reload.lua`.

local file = rom.path.combine(rom.paths.Content, 'Game/Text/en/HelpText.en.sjson')
sjson.hook(file, function(data)
	elysiumTextTable = sjson.to_object({
		Id = "PackageBountyElysianGauntlet_Text",
		DisplayName = "Elysian Gauntlet"
	}, { "Id", "DisplayName" })
	table.insert(data.Texts, elysiumTextTable)
end)

PackageBountyElysiumTest =
{
	InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },
	Text = "PackageBountyElysianGauntlet_Text",

	DifficultyRating = 1,

	WeaponKitName = "WeaponLob",
	WeaponUpgradeName = "LobAmmoBoostAspect",
	KeepsakeName = "DeathVengeanceKeepsake",
	FamiliarName = "FrogFamiliar",

	ForcedRewards =
	{
		{
			Name = "Boon",
			LootName = "HeraUpgrade",
			ForcedUpgradeOptions =
			{
				{
					Type = "Trait",
					ItemName = "HeraWeaponBoon",
					Rarity = "Epic",
				},
				{
					Type = "Trait",
					ItemName = "HeraSpecialBoon",
					Rarity = "Epic",
				},
				{
					Type = "Trait",
					ItemName = "HeraSprintBoon",
					Rarity = "Epic",
				},
			},
		},
	},

	RunOverrides =
	{
		LootTypeHistory =
		{
			ApolloUpgrade = 1,
			ZeusUpgrade = 1,
			AphroditeUpgrade = 2,
		},
	},

	StartingTraits =
	{
		{ Name = "ApolloRetaliateBoon",      Rarity = "Heroic", },
		{ Name = "BoltRetaliateBoon",        Rarity = "Heroic", },
		{ Name = "HighHealthOffenseBoon",    Rarity = "Heroic", },
		{ Name = "DoorHealToFullBoon",       Rarity = "Heroic", },
		{ Name = "RoomRewardMaxHealthTrait", },
		{ Name = "RoomRewardMaxHealthTrait", },
		{ Name = "RoomRewardMaxHealthTrait", },
		{ Name = "RoomRewardMaxHealthTrait", },
		{ Name = "RoomRewardMaxHealthTrait", },
		{ Name = "RoomRewardMaxHealthTrait", },
		{ Name = "RoomRewardMaxHealthTrait", },
		{ Name = "RoomRewardMaxHealthTrait", },
	},

	MetaUpgradeStateEquipped =
	{
		"HealthRegen",
		"CastBuff",
		"BonusHealth",
		"BonusDodge",
		"LastStand",
	},

	ShrineUpgradesActive =
	{
		EnemySpeedShrineUpgrade = 2,
	},

	UnlockGameStateRequirements =
	{
		NamedRequirements = { "PackageBountyBiomeF", },
		{
			Path = { "GameState", "WeaponsUnlocked", },
			HasAll = { "WeaponStaffSwing", },
		},
	},
}

game.OnControlPressed({ 'Gift', function()
	return trigger_Gift()
end })

ModUtil.LoadOnce(function()
	rom.log.warning("Adding chaos trial table")
	game.BountyData.PackageBountyElysiumTest = PackageBountyElysiumTest
	game.ProcessDataStore(game.BountyData)
	table.insert(game.ScreenData.BountyBoard.ItemCategories[1], "PackageBountyElysiumTest")
end)
