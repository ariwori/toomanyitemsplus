return {
--对部分无规律的项目代码重新赋值命名，以匹配官方现有的贴图
	prefablist = {
	["shadowdigger"] = "shadowdigger_builder",
	["shadowduelist"] = "shadowduelist_builder",
	["shadowlumber"] = "shadowlumber_builder",
	["shadowminer"] = "shadowminer_builder",
	["critter_dragonling"] = "critter_dragonling_builder",
	["critter_glomling"] = "critter_glomling_builder",
	["critter_kitten"] = "critter_kitten_builder",
	["critter_lamb"] = "critter_lamb_builder",
	["critter_perdling"] = "critter_perdling_builder",
	["critter_puppy"] = "critter_puppy_builder",
	["critter_lunarmothling"] = "critter_lunarmothling_builder",
	["twiggy_short"] = "twiggytree_short",
	["twiggy_normal"] = "twiggytree_normal",
	["twiggy_tall"] = "twiggytree_tall",
	["twiggy_old"] = "twiggytree_old",
	["rock_avocado_fruit"] = "rock_avocado_fruit_rockhard",	
	["sculpture_bishopbody"] = "sculpture_bishopbody_full",
	["sculpture_knightbody"] = "sculpture_knightbody_full",
	["sculpture_rookbody"] = "sculpture_rookbody_full",
	["sculpture_bishop"] = "sculpture_bishopbody_full",
	["sculpture_knight"] = "sculpture_knightbody_full",
	["sculpture_rook"] = "sculpture_rookbody_full",
	["hermit_bundle_shells"] = "hermit_bundle",
	["beebox_hermit"] = "beebox_hermitcrab",
	["singingshell_octave3"] = "singingshell_octave3_3",
	["singingshell_octave4"] = "singingshell_octave4_3",
	["singingshell_octave5"] = "singingshell_octave5_3",
	["minisign"] = "minisign_drawn",
	["eyeturret"] = "eyeball_turret",
	["mermthrone"] = "merm_king_carpet",
	["deer_antler"] = "deer_antler1",
	["statuemaxwell"] = "statue",
	["statueharp"] = "statue_small",
	["oasislake"] = "oasis",
	["resurrectionstone"] = "resurrection_stone",
	["moon_altar_rock_idol"] = "moon_altar_idol_rock",
	["moon_altar_rock_glass"] = "moon_altar_glass_rock",
	["moon_altar_rock_seed"] = "moon_altar_seed_rock",
	["wormhole_limited_1"] = "wormhole_sick",
	["gravestone"] = "gravestones",
	["redpouch_yotc"] = "redpouch_yotc_large",
	["redpouch_yotp"] = "redpouch_yotp_large",
	["bundle"] = "bundle_large",
	["gift"] = "gift_large1",
	["gravestone"] = "gravestones",
	--洋葱大蒜直接使用暴食的名称 改都不改 klei真懒
	["onion"] = "quagmire_onion",
	["onion_cooked"] = "quagmire_onion_cooked",
	["potato"] = "quagmire_potato",
	["potato_cooked"] = "quagmire_potato_cooked",
	["tomato"] = "quagmire_tomato",
	["tomato_cooked"] = "quagmire_tomato_cooked",
	["garlic"] = "quagmire_garlic",
	["garlic_cooked"] = "quagmire_garlic_cooked",
	["slingshotammo_marble"] = "slingshotammo_marble_proj"
 	},
--对部分无规律的项目代码重新赋值，以指向*.po语言文件中合适的文本字符串
	desclist = {
	["moose"] = STRINGS.NAMES.MOOSE2,
	["mooseegg"] = STRINGS.NAMES.MOOSENEST1,
	["sapling_moon"] = STRINGS.NAMES.MOOSENEST1,
	["flower_rose"] = STRINGS.NAMES.FLOWER,
	["planted_flower"] = STRINGS.NAMES.FLOWER,
	["deer_red"] = STRINGS.NAMES.DEER,
	["deer_blue"] = STRINGS.NAMES.DEER,
	["stalker_minion1"] = STRINGS.NAMES.STALKER_MINION,
	["stalker_minion2"] = STRINGS.NAMES.STALKER_MINION,
	["atrium_idol"] = STRINGS.NAMES.ATRIUM_OVERGROWTH,
	["atrium_statue_facing"] = STRINGS.NAMES.ATRIUM_STATUE,
	["chessjunk"]= STRINGS.NAMES.CHESSJUNK1,
	["deer_antler1"] = STRINGS.NAMES.DEER_ANTLER,
	["deer_antler2"] = STRINGS.NAMES.DEER_ANTLER,
	["deer_antler3"] = STRINGS.NAMES.DEER_ANTLER,
	["lava_pond_rock2"] = STRINGS.NAMES.LAVA_POND_ROCK,
	["lava_pond_rock3"] = STRINGS.NAMES.LAVA_POND_ROCK,
	["lava_pond_rock4"] = STRINGS.NAMES.LAVA_POND_ROCK,
	["lava_pond_rock5"] = STRINGS.NAMES.LAVA_POND_ROCK,
	["lava_pond_rock6"] = STRINGS.NAMES.LAVA_POND_ROCK,
	["lava_pond_rock7"] = STRINGS.NAMES.LAVA_POND_ROCK,
	["moon_altar"] = STRINGS.NAMES.MOON_ALTAR.MOON_ALTAR,
	["gargoyle_houndatk"] = STRINGS.NAMES.GARGOYLE_HOUND,
	["gargoyle_hounddeath"] = STRINGS.NAMES.GARGOYLE_HOUND,
	["gargoyle_werepigatk"] = STRINGS.NAMES.GARGOYLE_WEREPIG,
	["gargoyle_werepigdeath"] = STRINGS.NAMES.GARGOYLE_WEREPIG,
	["gargoyle_werepighowl"] = STRINGS.NAMES.GARGOYLE_WEREPIG,
	["oasis_cactus"] = STRINGS.NAMES.CACTUS,
	["portableblender"] = STRINGS.NAMES.PORTABLEBLENDER_ITEM,
	["portablecookpot"] = STRINGS.NAMES.PORTABLECOOKPOT_ITEM,
	["portablespicer"] = STRINGS.NAMES.PORTABLESPICER_ITEM,
	["multiplayer_portal_moonrock_constr"] = STRINGS.NAMES.MULTIPLAYER_PORTAL_MOONROCK,
	["rock_avocado_fruit_sprout_sapling"] = STRINGS.NAMES.ROCK_AVOCADO_FRUIT_SPROUT,
	["spiderhole_rock"] = STRINGS.NAMES.SPIDERHOLE,
	["moon_altar_glass_rock"] = STRINGS.NAMES.MOON_ALTAR_ROCK_GLASS,
	["moon_altar_idol_rock"] = STRINGS.NAMES.MOON_ALTAR_ROCK_IDOL,
	["moon_altar_seed_rock"] = STRINGS.NAMES.MOON_ALTAR_ROCK_SEED,
	["driftwood_small1"] = STRINGS.NAMES.DRIFTWOOD_TREE,
	["driftwood_small2"] = STRINGS.NAMES.DRIFTWOOD_TREE,
	["driftwood_tall"] = STRINGS.NAMES.DRIFTWOOD_TREE,
	["shadowdigger"] = STRINGS.NAMES.SHADOWDIGGER_BUILDER,
	["shadowduelist"] = STRINGS.NAMES.SHADOWDUELIST_BUILDER,
	["shadowlumber"] = STRINGS.NAMES.SHADOWLUMBER_BUILDER,
	["shadowminer"] = STRINGS.NAMES.SHADOWMINER_BUILDER,
	["stalker_forest"] = STRINGS.NAMES.STALKER,
	["sculpture_bishop"] = STRINGS.NAMES.SCULPTURE_BISHOPBODY,
	["sculpture_knight"] = STRINGS.NAMES.SCULPTURE_KNIGHTBODY,
	["sculpture_rook"] = STRINGS.NAMES.SCULPTURE_ROOKBODY,
	["statue_marble_muse"] = STRINGS.NAMES.STATUE_MARBLE,
	["statue_marble_pawn"] = STRINGS.NAMES.STATUE_MARBLE,
	},
}