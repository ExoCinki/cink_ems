Config = {}

Config.ModelLits = {`shmann_ehos_couch01`,`shmann_ehos_couch02`}
Config.ModelLitsBig = {`shmann_ehos_bed05`}
Config.ModelLitsMorgue = {`v_med_cor_autopsytbl`}
Config.ModelLitsMorgueLittle = {`v_med_cor_emblmtable`}

Config.ModelWheelChair = {`prop_wheelchair_01`}

--- Death Screen Config ---
GlobalState.Timer = 12 -- minutes for bleeding out

GlobalState.RespawnCoords = vector3(-677.1683, 310.5062, 83.0840) -- where the player will spawn after timer is at 0
GlobalState.RespawnHeading = 1.0148 -- heading for respawncoords

Config.ReviveRewardPlayer = 700
Config.ReviveRewardSociety = 700

Config.JobName = 'ambulance'

Config.BlipsHospital = {
    position = vector3(-676.3265, 320.2641, 83.0832),
    title = "Hôpital [EMS]",
    sprite = 61,
    colour = 1,
    scale = 0.7,
    display = 4,
    shortRange = true,
}

Config.BlipsPsy = {
    position = vector3(-1905.6453, -573.2115, 19.0972),
    title = "Psychologue [EMS]",
    sprite = 362,
    colour = 1,
    scale = 0.7,
    display = 4,
    shortRange = true,
}

Config.ShopPharmacieCoords = vector4(-676.6450, 334.7412, 82.1, 175.4911)
Config.PedModelPharma = `s_f_y_scrubs_01`

--- Sonnette
Config.Sonnette = vector3(-674.5535, 326.4814, 82.5)
Config.SonnetteWebHook = ""
Config.PedModel = `s_f_y_scrubs_01`
Config.PedCoords = {
    first = vector4(-680.8112, 328.9040, 82.16, 86.8283),
    second = vector4(-676.1941, 327.7884, 82.16, 226.6247),
}


--------------------------------
Config.WeaponList = {
    balle9mm0 = joaat("weapon_pistol"),
    balle9mm2 = joaat("weapon_combatpistol"),
    balle9mm3 = joaat("weapon_smg"),
    balle9mm4 = joaat("weapon_pistol_mk2"),
    balle9mm5 = joaat("weapon_minismg"),
    balle9mm6 = joaat("weapon_machinepistol"),
    balle9mm7 = joaat("weapon_ceramicpistol"),
    balle50acp = joaat("weapon_pistol50"),
    balle44 = joaat("WEAPON_REVOLVER"),
    balle45acp = joaat("weapon_snspistol"),
    balle45acp0 = joaat("weapon_heavypistol"),
    balle45acp2 = joaat("WEAPON_GUSENBERG"),
    balle45acp3 = joaat("weapon_microsmg"),
    balle556 = joaat("weapon_carbinerifle_mk2"),
    balle5562 = joaat("WEAPON_SPECIALCARBINE"),
    balle12G = joaat("weapon_pumpshotgun_mk2"),
    balle12G2 = joaat("weapon_dbshotgun"),
    balleplomb = joaat("weapon_musket"),
    griffe = joaat("weapon_knuckle"),
    coupure = joaat("weapon_knife"),
    coupure2 = joaat("weapon_switchblade"),
    bleu = joaat("weapon_golfclub"),
    bleu2 = joaat("weapon_bat"),
    bleu3 = joaat("weapon_nightstick"),
    bleu4 = joaat("weapon_flashlight"),
    bleu5 = joaat("WEAPON_DILDO"),
    brulure = joaat("WEAPON_MOLOTOV"),
    balle762 = joaat("WEAPON_ASSAULTRIFLE"),
    balle762NATO = joaat("WEAPON_SNIPERRIFLE"),
    poing = joaat("WEAPON_UNARMED"),
}

Config.ActionPatronEms = vector4(-660.9089, 310.8815, 92.7440, 5.3449)

Config.BleedoutTimer = 30

Config.WeapKo = {
    poing = joaat('WEAPON_UNARMED'),
    tonfa = joaat('WEAPON_NIGHTSTICK'),
    dildo = joaat('WEAPON_DILDO')
}
