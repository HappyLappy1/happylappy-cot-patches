.nds
.include "symbols.asm"

// By Happylappy: To be included in patches for C-Of-Time.
// Optimizes and Tabulates Status Checker AI Use Conditions for each move, allowing easier customization. 
// Note: This uses a LOT of custom symbols. Might be best to put them in a dedicated file?


// custom symbols
    .definelabel CAMOUFLAGE_TYPE_START, TILESET_PROPERTIES + 0x6; // The vanilla function does this lol




// Condition Names:
    .definelabel ABILITIES_DONT_MATCH_USER, 0
    .definelabel ACUPRESSURE_ALLY_SIGHT_CHECK, 1
    .definelabel ANY_STAT_LOWERED, 2
    .definelabel ASSOCIATION_IS_TEAM, 3
    .definelabel ATTACK_LT_DEFENSE, 4
    .definelabel BELLY_ABOVE_MIN, 5
    .definelabel CURSE_CHECK, 6
    .definelabel FLOOR_HAS_NO_DECOY, 7
    .definelabel GENDERS_NOT_EQUAL, 8
    .definelabel HAS_ITEM_ANY, 9
    .definelabel HAS_ITEM_NONE, 10
    .definelabel HAS_ITEM_STICKY, 11
    .definelabel HAS_NEGATIVE_STATUS, 12
    .definelabel HELPING_HAND_ALLY_SIGHT_CHECK, 13
    .definelabel HP_ABOVE_USER, 14
    .definelabel HP_ABOVE_MIN, 15
    .definelabel HP_BELOW_HALF, 16
    .definelabel HP_BELOW_QUARTER_OR_STATUSED, 17
    .definelabel IS_TYPE_GHOST, 18
    .definelabel LAST_MOVE_ANY, 19
    .definelabel LAST_MOVE_HAS_PP, 20
    .definelabel LUCKY_CHANT_ALLY_SIGHT_CHECK, 21
    .definelabel MIRACLE_EYE_CONDITION, 22
    .definelabel TORMENT_CHECK, 23
    .definelabel NOT_BOSS_FIGHT, 24
    .definelabel NOT_HAS_MAX_ATK, 25
    .definelabel NOT_HAS_MAX_ATK_DEF, 26
    .definelabel NOT_HAS_MAX_ATK_SPE, 27
    .definelabel NOT_HAS_MAX_DEF, 28
    .definelabel NOT_HAS_MAX_DEF_SPD, 29
    .definelabel NOT_HAS_MAX_EVA, 30
    .definelabel NOT_HAS_MAX_SPA, 31
    .definelabel NOT_HAS_MAX_SPA_SPDEF, 32
    .definelabel NOT_HAS_MAX_SPDEF, 33
    .definelabel NOT_HAS_MIN_ACC, 34
    .definelabel NOT_HAS_MIN_ATK, 35
    .definelabel NOT_HAS_MIN_ATK_DEF, 36
    .definelabel NOT_HAS_MIN_DEF, 37
    .definelabel NOT_HAS_MIN_EVA, 38
    .definelabel NOT_HAS_MIN_SPA, 39
    .definelabel NOT_HAS_MIN_SPDEF, 40
    .definelabel NOT_MAX_OFF_DEF_ANY, 41
    .definelabel NOT_SLEEPING, 42
    .definelabel NOT_SPED_UP, 43
    .definelabel NOT_STATUS_AQUA_RING, 44
    .definelabel NOT_STATUS_BAD_POISON, 45
    .definelabel NOT_STATUS_BIDE, 46
    .definelabel NOT_STATUS_BURN, 47
    .definelabel NOT_STATUS_CHARGE, 48
    .definelabel NOT_STATUS_CONFUSED, 49
    .definelabel NOT_STATUS_CONVERSION_2, 50
    .definelabel NOT_STATUS_COUNTER, 51
    .definelabel NOT_STATUS_DESTINY_BOND, 52
    .definelabel NOT_STATUS_EMBARGO, 53
    .definelabel NOT_STATUS_ENCORE, 54
    .definelabel NOT_STATUS_ENDURE, 55
    .definelabel NOT_STATUS_ENRAGED, 56
    .definelabel NOT_STATUS_EXPOSED, 57
    .definelabel NOT_STATUS_SET_DAMAGE, 58
    .definelabel NOT_STATUS_FOCUS_ENERGY, 59
    .definelabel NOT_STATUS_GASTRO_ACID, 60
    .definelabel NOT_STATUS_GRUDGE, 61
    .definelabel NOT_STATUS_HEAL_BLOCK, 62
    .definelabel NOT_STATUS_INFATUATED, 63
    .definelabel NOT_STATUS_INGRAIN, 64
    .definelabel NOT_STATUS_INVISIBLE, 65
    .definelabel NOT_STATUS_LEECH_SEED, 66
    .definelabel NOT_STATUS_LIGHT_SCREEN, 67
    .definelabel NOT_STATUS_LUCKY_CHANT, 68
    .definelabel NOT_STATUS_MAGIC_COAT, 69
    .definelabel NOT_STATUS_MAGNET_RISE, 70
    .definelabel NOT_STATUS_METAL_BURST, 71
    .definelabel NOT_STATUS_MIRROR_COAT, 72
    .definelabel NOT_STATUS_MIRROR_MOVE_FUZZY, 73
    .definelabel NOT_STATUS_MIST, 74
    .definelabel NOT_STATUS_NIGHTMARE, 75
    .definelabel NOT_STATUS_PARALYSIS, 76
    .definelabel NOT_STATUS_PAUSED, 77
    .definelabel NOT_STATUS_PERISH_SONG, 78
    .definelabel NOT_STATUS_POISON, 79
    .definelabel NOT_STATUS_PROTECT, 80
    .definelabel NOT_STATUS_REFLECT, 81
    .definelabel NOT_STATUS_SAFEGUARD, 82
    .definelabel NOT_STATUS_SHADOW_HOLD, 83
    .definelabel NOT_STATUS_SLEEPLESS, 84
    .definelabel NOT_STATUS_SNATCH, 85
    .definelabel NOT_STATUS_SURE_SHOT, 86
    .definelabel NOT_STATUS_TAUNTED, 87
    .definelabel NOT_STATUS_TRANSFORMED, 88
    .definelabel NOT_STATUS_WHIFFER, 89
    .definelabel NOT_STATUS_WISH, 90
    .definelabel NOT_STATUS_WRAPPED, 91
    .definelabel NOT_STATUS_WRAPPING, 92
    .definelabel NOT_STATUS_YAWN, 93
    .definelabel SPEED_ABOVE_MIN, 94
    .definelabel SPEED_BELOW_MAX, 95
    .definelabel STANDING_ON_LAND, 96
    .definelabel STANDING_ON_NOT_TRAP, 97
    .definelabel STANDING_ON_TRAP, 98
    .definelabel STANDING_ON_WATER, 99
    .definelabel STAT_MULT_OVER_POINT_25_ATK, 100
    .definelabel STAT_MULT_OVER_POINT_25_DEF, 101
    .definelabel STAT_MULT_OVER_POINT_25_SPD, 102
    .definelabel STATS_EXCEED_USER, 103
    .definelabel STOCKPILE_NOT_MAX, 104
    .definelabel STOCKPILE_NOT_MIN, 105
    .definelabel SUM_STATS_GT_USER_DEF, 106
    .definelabel SUM_STATS_GT_USER_OFF, 107
    .definelabel SUM_STATS_GT_USER_OFF_DEF, 108
    .definelabel TERRAIN_NOT_GRAVITY, 109
    .definelabel TERRAIN_NOT_MUD_SPORT, 110
    .definelabel TYPE_MATCHES_CAMOUFLAGE, 111
    .definelabel USER_HAS_ITEM_ANY, 112
    .definelabel WEATHER_NOT_HAIL, 113
    .definelabel WEATHER_NOT_RAINY, 114
    .definelabel WEATHER_NOT_SANDSTORM, 115
    .definelabel WEATHER_NOT_SUNNY, 116
    .definelabel STAT_MULT_OVER_POINT_25_ATK_SPA, 117
    .definelabel TERRAIN_NOT_WATER_SPORT, 118
    .definelabel NO_CONDITION, 119






.open "overlay29.bin", overlay29_start
    //.org 0x233571c; // Turn HasUsedLastMove into GetLastUsedMoveId (1-indexed, so no last used move would still yield "false")
    //.area 0x4
    //    addne, r0, r3, #0x1
    //.endarea

    .org StatusCheckerCheck; // Replace the entire vanilla function!
    .area StatusCheckerCheckOnTarget - StatusCheckerCheck - 0x24; // The specific EntityIsValid function between these two needs to be preserved!
        push {r2-r12,lr}
        mov r11, r0; // r11: target, same as user for this function.
        mov r7, r0; // r7: user.
        ldrh r10, [r1, #0x4]; // r10: move_id. Discard move struct, we don't need that shit!
        ldr r8, =STATUS_CHECKER_CONDITIONS_TABLE; // r8: move conditions table. Eventually conditions table row of the matching entry.
    StatusCheckerUniversalLoopInit:
        // Here onward is universal to both StatusCheckerCheck AND StatusCheckerTargetCheck!
        mov r9, #0x1; // r9: returned bool for whether the move should be used, true by default.
        ldr r6, [r11, #0xB4]; // r6: target monster
        ldr r5, [r7, #0xB4]; // r5: user monster
    StatusCheckerUniversalLoopStart:
        ldrh r0, [r8]
        cmp r0, #0x0
        beq StatusCheckerUniversalReturnTrue
        cmp r0, r10
        beq StatusCheckerUniversalMatchFound
    StatusCheckerUniversalLoopIncrement:
        add r8, #0x4
        b StatusCheckerUniversalLoopStart

    StatusCheckerUniversalIncrementCondition:
        tst r8, #0x1; // Check if we're two-aligned. If not, this is not our first pass!
        beq StatusCheckerUniversalReturnTrue
        add r8, #0x1;
    StatusCheckerUniversalMatchFound:
        ldrb r0, [r8, #0x2]
        cmp r0, NO_CONDITION
        addls pc, r0, lsl #0x2
        b StatusCheckerUniversalReturnTrue
        b func_abilities_dont_match_user
        b func_acupressure_ally_sight_check
        b func_any_stat_lowered
        b func_association_is_team
        b func_attack_lt_defense
        b func_belly_above_min
        b func_curse_check
        b func_floor_has_no_decoy
        b func_genders_not_equal
        b func_has_item_any
        b func_has_item_none
        b func_has_item_sticky
        b func_has_negative_status
        b func_helping_hand_ally_sight_check
        b func_hp_above_user
        b func_hp_above_min
        b func_hp_below_half
        b func_hp_below_quarter_or_statused
        b func_is_type_ghost
        b func_last_move_any
        b func_last_move_has_pp
        b func_lucky_chant_ally_sight_check
        b func_miracle_eye_condition
        b func_torment_check
        b func_not_boss_fight
        b func_not_has_max_atk
        b func_not_has_max_atk_def
        b func_not_has_max_atk_spe
        b func_not_has_max_def
        b func_not_has_max_def_spd
        b func_not_has_max_eva
        b func_not_has_max_spa
        b func_not_has_max_spa_spdef
        b func_not_has_max_spdef
        b func_not_has_min_acc
        b func_not_has_min_atk
        b func_not_has_min_atk_def
        b func_not_has_min_def
        b func_not_has_min_eva
        b func_not_has_min_spa
        b func_not_has_min_spdef
        b func_not_max_off_def_any
        b func_not_sleeping
        b func_not_sped_up
        b func_not_status_aqua_ring
        b func_not_status_bad_poison
        b func_not_status_bide
        b func_not_status_burn
        b func_not_status_charge
        b func_not_status_confused
        b func_not_status_conversion_2
        b func_not_status_counter
        b func_not_status_destiny_bond
        b func_not_status_embargo
        b func_not_status_encore
        b func_not_status_endure
        b func_not_status_enraged
        b func_not_status_exposed
        b func_not_status_set_damage
        b func_not_status_focus_energy
        b func_not_status_gastro_acid
        b func_not_status_grudge
        b func_not_status_heal_block
        b func_not_status_infatuated
        b func_not_status_ingrain
        b func_not_status_invisible
        b func_not_status_leech_seed
        b func_not_status_light_screen
        b func_not_status_lucky_chant
        b func_not_status_magic_coat
        b func_not_status_magnet_rise
        b func_not_status_metal_burst
        b func_not_status_mirror_coat
        b func_not_status_mirror_move_fuzzy
        b func_not_status_mist
        b func_not_status_nightmare
        b func_not_status_paralysis
        b func_not_status_paused
        b func_not_status_perish_song
        b func_not_status_poison
        b func_not_status_protect
        b func_not_status_reflect
        b func_not_status_safeguard
        b func_not_status_shadow_hold
        b func_not_status_sleepless
        b func_not_status_snatch
        b func_not_status_sure_shot
        b func_not_status_taunted
        b func_not_status_transformed
        b func_not_status_whiffer
        b func_not_status_wish
        b func_not_status_wrapped
        b func_not_status_wrapping
        b func_not_status_yawn
        b func_speed_above_min
        b func_speed_below_max
        b func_standing_on_land
        b func_standing_on_not_trap
        b func_standing_on_trap
        b func_standing_on_water
        b func_stat_mult_over_point_25_atk
        b func_stat_mult_over_point_25_def
        b func_stat_mult_over_point_25_spd
        b func_stats_exceed_user
        b func_stockpile_not_max
        b func_stockpile_not_min
        b func_sum_stats_gt_user_def
        b func_sum_stats_gt_user_off
        b func_sum_stats_gt_user_off_def
        b func_terrain_not_gravity
        b func_terrain_not_mud_sport
        b func_type_matches_camouflage
        b func_user_has_item_any
        b func_weather_not_hail
        b func_weather_not_rainy
        b func_weather_not_sandstorm
        b func_weather_not_sunny
        b func_stat_mult_over_point_25_atk_spa
        b func_terrain_not_water_sport

        func_abilities_dont_match_user:
            ldrh r0, [r5, #0x60]; // Get both abilities User
            ldrh r1, [r6, #0x60]; // Get both abilities Target
            cmp r0, r1
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_acupressure_ally_sight_check:
            push {r5,r7,r8}
            ldr r8, =#0x00140014;
            ldr r4, =DUNGEON_PTR
            ldr r4, [r4]
            add r4, #0x12800
            ldrb r0, [r6, #0x6]; // not_team_member
            cmp r0, #0x1
            add r4, #0x328
            addeq r4, #0x10
            moveq r5, #0x10
            movne r5, #0x4
            acupressure_sight_loop_start:
                ldr r7, [r4]
                mov r0, r7
                bl EntityIsValid
                cmp r0, #0x1
                cmpne r7, r11
                bne acupressure_sight_loop_increment
                mov r0, r11
                mov r1, r7
                bl CanSeeTarget
                cmp r0, #0x1
                bne acupressure_sight_loop_increment
                ldr r1, [r7, #0xB4]
                ldr r0, [r1, #0x24]
                cmp r0, r8
                ldrge r0, [r1, #0x28]
                cmpge r0, r8
                bge StatusCheckerUniversalIncrementCondition
            acupressure_sight_loop_increment:
                add r4, #0x4
                subs r5, #0x1
                bgt acupressure_sight_loop_start
            pop {r5,r7,r8}
            // Of the entities that got checked, none would benefit from the move!
            b StatusCheckerUniversalReturnFalse
        
        func_any_stat_lowered:
            ldrh r0, [r6, #0x24]
            cmp r0, #0xA
            ldrgeh r0, [r6, #0x26]
            cmpge r0, #0xA
            ldrgeh r0, [r6, #0x28]
            cmpge r0, #0xA
            ldrgeh r0, [r6, #0x2A]
            cmpge r0, #0xA
            ldrgeh r0, [r6, #0x2C]
            cmpge r0, #0xA
            ldrgeh r0, [r6, #0x2E]
            cmpge r0, #0xA
        func_bge_return_false:
            bge StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_association_is_team:
            ldrb r0, [r6, #0x6]
            cmp r0, #0x1
        func_beq_return_false:
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_attack_lt_defense:
            ldrh r0, [r6, #0x24]
            ldrh r1, [r6, #0x26]
            cmp r0, r1
            b func_bge_return_false

        func_belly_above_min:
            ldr r0, [r6, #0x148]; // Belly + Belly Thousandths * 65536
            cmp r0, #0x0
            b func_beq_return_false

        func_curse_check:
            mov r0, r7; // user
            mov r1, #14; // ghost
            bl MonsterIsType
            cmp r0, #0x1
            bne func_curse_non_ghost_check
        func_curse_ghost_check:
            // Now checking target
            ldrb r0, [r6, #0xD8]; // curse_id
            cmp r0, #0x1; // cursed
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_curse_non_ghost_check:
            // Can't reuse bulk up, because that would check the stats of the target, not the user!
            ldrh r0, [r5, #0x24]; // attack
            cmp r0, #0x14;
            ldrgeh r0, [r5, #0x28]; // def
            cmpge r0, #0x14;
            bge StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_floor_has_no_decoy:
            ldr r0, =DUNGEON_PTR
            ldr r1, =0x3E38
            ldr r0, [r0]
            add r0, r1
            ldrb r0, [r0]
            cmp r0, #0x1
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_genders_not_equal:
            ldrh r0, [r5, #0x4]
            ldrh r1, [r6, #0x4]
            bl GendersEqualNotGenderless
            cmp r0, #0x1
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_has_item_any:
            ldrb r0, [r6, #0x62]
            tst r0, #0x1; // item_is_valid?
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_has_item_none:
            ldrb r0, [r6, #0x62]
            tst r0, #0x1; // item_is_valid?
            bne StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition    
            
        func_has_item_sticky:
            ldrb r0, [r6, #0x62]
            tst r0, #0x1; // item_is_valid?
            tstne r0, #0x8; // sticky?
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_has_negative_status:
            mov r0, r11
            mov r1, #0x0
            bl MonsterHasNegativeStatus
            cmp r0, #0x1
            bne StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_helping_hand_ally_sight_check:
            push {r5,r7,r8}
            ldr r8, =#0x00140014;
            ldr r4, =DUNGEON_PTR
            ldr r4, [r4]
            add r4, #0x12800
            ldrb r0, [r6, #0x6]; // not_team_member
            cmp r0, #0x1
            add r4, #0x328
            addeq r4, #0x10
            moveq r5, #0x10
            movne r5, #0x4
            helping_hand_sight_loop_start:
                ldr r7, [r4]
                mov r0, r7
                bl EntityIsValid
                cmp r0, #0x1
                cmpne r7, r11
                bne helping_hand_sight_loop_increment
                mov r0, r11
                mov r1, r7
                bl CanSeeTarget
                cmp r0, #0x1
                bne helping_hand_sight_loop_increment
                ldr r1, [r7, #0xB4]
                ldr r0, [r1, #0x24]
                cmp r0, r8
                bge StatusCheckerUniversalIncrementCondition
            helping_hand_sight_loop_increment:
                add r4, #0x4
                subs r5, #0x1
                bgt helping_hand_sight_loop_start
            pop {r5,r7,r8}
            // Of the entities that got checked, none would benefit from the move!
            b StatusCheckerUniversalIncrementCondition

        func_hp_above_user:
            ldrh r0, [r6, #0x10]
            ldrh r1, [r5, #0x10]
            cmp r0, r1
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_hp_above_min:
            ldrh r0, [r6, #0x10]
            cmp r0, #0x1
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_hp_below_half:
            ldrh r0, [r6, #0x10]
            ldrh r1, [r6, #0x12]
            ldrh r2, [r6, #0x16]
            add r1, r2
            cmp r0, r1, lsr #0x1;
            bge StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_hp_below_quarter_or_statused:
            mov r0, r11
            bl MonsterHasQuarterHp
            cmp r0, #0x1
            bne func_has_negative_status
            b StatusCheckerUniversalIncrementCondition

        func_is_type_ghost:
            mov r0, r11
            mov r1, #14; // TYPE_GHOST
            bl MonsterIsType
            cmp r0, #0x1
            bne StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_last_move_any:
            add r0, r11, #0x124;
            bl HasLastUsedMove
            cmp r0, #0x1
            bne StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_last_move_has_pp:
            // Loop through all moves the target has. 
            add r4, r6, #0x124;
            mov r3, #0x0
            last_move_pp_loop_start:
                ldrb r0, [r4,r3, lsl #0x3]
                tst r0, #0x1; // Does the move exist? (If struggle is an "invalid move", I'm going to stab something)
                beq last_move_pp_loop_increment;
                tst r0, #0x10; // is this move the last one used?
                bne last_move_pp_loop_increment
                add r0, r4, #0x6
                ldrb r0, [r0, r3, lsl #0x3]
                cmp r0, #0x0
                bne StatusCheckerUniversalIncrementCondition
                // The last used move is out of PP.
                b StatusCheckerUniversalReturnFalse
            last_move_pp_loop_increment:
                add r3, #0x1
                cmp r3, #0x4;
                blt last_move_pp_loop_start
            // The target has not used a move
            b StatusCheckerUniversalReturnFalse

        func_lucky_chant_ally_sight_check:
            push {r5,r7,r8}
            ldr r4, =DUNGEON_PTR
            ldr r4, [r4]
            add r4, #0x12800
            ldrb r0, [r6, #0x6]; // not_team_member
            cmp r0, #0x1
            add r4, #0x328
            addeq r4, #0x10
            moveq r5, #0x10
            movne r5, #0x4
            lucky_chant_sight_loop_start:
                ldr r7, [r4]
                mov r0, r7
                bl EntityIsValid
                cmp r0, #0x1
                cmpne r7, r11
                bne lucky_chant_sight_loop_increment
                mov r0, r11
                mov r1, r7
                bl CanSeeTarget
                cmp r0, #0x1
                bne lucky_chant_sight_loop_increment
                ldr r1, [r7, #0xB4]
                ldr r0, [r1, #0xD5]
                cmp r0, #0x11; // is this entity lucky-chanted already?
                bge StatusCheckerUniversalIncrementCondition
            lucky_chant_sight_loop_increment:
                add r4, #0x4
                subs r5, #0x1
                bgt lucky_chant_sight_loop_start
            pop {r5,r7,r8}
            // Of the entities that got checked, none would benefit from the move!
            b StatusCheckerUniversalIncrementCondition

        func_miracle_eye_condition:
            mov r0, r11
            mov r1, #16; // TYPE_DARK
            bl MonsterIsType
            cmp r0, #0x1
            ldreqb r0, [r6, #0xF5]; // miracle eye status
            cmpeq r0, #0x1
            bne func_not_has_min_eva; // Miracle eye also has an evasion reduction component!
            b StatusCheckerUniversalIncrementCondition

        func_torment_check:
            // Loop through all moves the target has. 
            add r4, r6, #0x124;
            mov r3, #0x0
            torment_moveset_loop_start:
                ldrb r0, [r4,r3, lsl #0x3]
                tst r0, #0x1; // Does the move exist? (If struggle is an "invalid move", I'm going to stab something)
                beq torment_moveset_loop_increment;
                tst r0, #0x20; // is this move disabled? if so, torment would fail!
                bne StatusCheckerUniversalReturnFalse
            torment_moveset_loop_increment:
                add r3, #0x1
                cmp r3, #0x5; // the 5th move in the loop is struggle!
                blt torment_moveset_loop_start
            // The target is capable of being tormented... if they've used a move!
            b func_last_move_any


        func_not_boss_fight:
            bl IsCurrentFixedRoomBossFight
            cmp r0, #0x1
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_has_max_atk:
            ldrh r0, [r6, #0x24]; // attack
            cmp r0, #0x14;
            bge StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_has_max_atk_def:
            ldrh r0, [r6, #0x24]; // attack
            cmp r0, #0x14;
            bge func_not_has_max_def
            b StatusCheckerUniversalIncrementCondition

        func_not_has_max_atk_spe:
            ldrh r0, [r6, #0x24]; // attack
            cmp r0, #0x14;
            bge func_speed_below_max
            b StatusCheckerUniversalIncrementCondition

        func_not_has_max_def:
            ldrh r0, [r6, #0x28]; // defense
            cmp r0, #0x14;
            bge StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_has_max_def_spd:
            ldrh r0, [r6, #0x2A]; // special defense
            cmp r0, #0x14;
            bge func_not_has_max_def
            b StatusCheckerUniversalIncrementCondition

        func_not_has_max_eva:
            ldrh r0, [r6, #0x2E]; // evasion
            cmp r0, #0x14;
            bge StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_has_max_spa:
            ldrh r0, [r6, #0x26]; // special attack
            cmp r0, #0x14;
            bge StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_has_max_spa_spdef:
            ldrh r0, [r6, #0x26]; // special attack
            cmp r0, #0x14;
            bge func_not_has_max_spdef
            b StatusCheckerUniversalIncrementCondition

        func_not_has_max_spdef:
            ldrh r0, [r6, #0x2A]; // special defense
            cmp r0, #0x14;
            bge StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_has_min_acc:
            ldrh r0, [r6, #0x2C]; // accuracy
            cmp r0, #0x0;
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_has_min_atk:
            ldrh r0, [r6, #0x24]; // attack
            cmp r0, #0x0;
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_has_min_atk_def:
            ldrh r0, [r6, #0x28]; // defense
            cmp r0, #0x0;
            ble func_not_has_min_atk
            b StatusCheckerUniversalIncrementCondition

        func_not_has_min_def:
            ldrh r0, [r6, #0x28]; // defense
            cmp r0, #0x0;
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_has_min_eva:
            ldrh r0, [r6, #0x2E]; // evasion
            cmp r0, #0x0
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_has_min_spa:
            ldrh r0, [r6, #0x26]; // special attack
            cmp r0, #0x0;
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_has_min_spdef:
            ldrh r0, [r6, #0x2A]; // special defense
            cmp r0, #0x0;
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        
        func_not_max_off_def_any:
            ldrh r0, [r6, #0x26]; // special attack
            cmp r0, #0x0
            ldrleh r0, [r6, #0x2A]; // special defense
            cmple r0, #0x0
            ble func_not_has_min_atk_def
            b StatusCheckerUniversalIncrementCondition

        func_not_sleeping:
            mov r0, r11
            bl IsMonsterSleeping
            cmp r0, #0x1
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_sped_up:
            ldr r0, [r6, #0x110]; // speed stage
            cmp r0, #0x1
            bgt StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_aqua_ring:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0x10; // aqua ring
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_bad_poison:
            ldrb r0, [r6, #0xBF]; // burn_id
            cmp r0, #0x3; // bad poison
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_bide:
            ldrb r0, [r6, #0xD2]; // two_turn_id
            cmp r0, #0x1; // bide_two_turn
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_burn:
            ldrb r0, [r6, #0xBF]; // burn_id
            cmp r0, #0x1; // burn
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_charge:
            ldrb r0, [r6, #0xD2]; // two_turn_id
            cmp r0, #0xB; // charging_two_turn
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_not_status_confused:
            ldrb r0, [r6, #0xD0]; // cringe_id
            cmp r0, #0x2; // confused
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition            

        func_not_status_conversion_2:
            mov r0, r11;
            bl Conversion2IsActive
            cmp r0, #0x1;
            bge StatusCheckerUniversalReturnFalse; 
            b StatusCheckerUniversalIncrementCondition

        func_not_status_counter:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0x4; // counter
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_destiny_bond:
            ldrb r0, [r6, #0xE0]; // leech_seed_id
            cmp r0, #0x2; // destiny bond
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_embargo:
            ldrb r0, [r6, #0xD8]; // curse_id
            cmp r0, #0x6; // embargo
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_encore:
            ldrb r0, [r6, #0xD0]; // cringe_id
            cmp r0, #0x6; // encore
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_not_status_endure:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0x9; // endure
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_enraged:
            ldrb r0, [r6, #0xD2]; // two_turn_id
            cmp r0, #0xC; // enraged
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_exposed:
            ldrb r0, [r6, #0xFE]; // exposed
            cmp r0, #0x1; // exposed?
            beq StatusCheckerUniversalReturnFalse
            // Ghost type is a separate check, but you could redirect this to the ghost type check code if you wanted.
            b StatusCheckerUniversalIncrementCondition

        func_not_status_set_damage:
            ldrb r0, [r6, #0xEC]; // sure_shot_id
            cmp r0, #0x3; // set damage
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_focus_energy:
            ldrb r0, [r6, #0xEC]; // sure_shot_id
            cmp r0, #0x4; // focus energy
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_gastro_acid:
            ldrb r0, [r6, #0xD8]; // curse_id
            cmp r0, #0x4; // gastro acid
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_grudge:
            ldrb r0, [r6, #0xFD]; // grudge
            cmp r0, #0x1; // grudge?
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_heal_block:
            ldrb r0, [r6, #0xD8]; // curse_id
            cmp r0, #0x5; // heal block
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_infatuated:
            ldrb r0, [r6, #0xD0]; // cringe_id
            cmp r0, #0x7; // infatuated
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_ingrain:
            ldrb r0, [r6, #0xC4]; // frozen_id
            cmp r0, #0x5; // ingrain
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_invisible:
            ldrb r0, [r6, #0xEF]; // invisible_id
            cmp r0, #0x1; // invisible
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_leech_seed:
            ldrb r0, [r6, #0xE0]; // leech_seed_id
            cmp r0, #0x1; // leech seed
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_light_screen:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0x3; // light screen
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_lucky_chant:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0x11; // lucky chant
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_magic_coat:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0x5; // magic coat
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_magnet_rise:
            ldrb r0, [r6, #0xF7]; // magnet rise
            cmp r0, #0x1; // magnet rise?
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_metal_burst:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0xF; // metal burst
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_mirror_coat:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0x8; // mirror coat
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_not_status_mirror_move_fuzzy:
            // Fuzzy because it includes the vanilla 20% check for Chatot Scarf.
            mov r0, r11
            bl MirrorMoveIsActive
            cmp r0, #0x1;
            // Change to beq to ignore the chatot scarf, which would return 2.
            bge StatusCheckerUniversalReturnFalse; 
            b StatusCheckerUniversalIncrementCondition
        
        func_not_status_mist:
            mov r0, r11    
            bl MistIsActive
            cmp r0, #0x1;
            bge StatusCheckerUniversalReturnFalse; 
            b StatusCheckerUniversalIncrementCondition

        func_not_status_nightmare:
            ldrb r0, [r6, #0xBD]; // sleep_id
            cmp r0, #0x3; // nightmare
            beq StatusCheckerUniversalReturnFalse;
            b StatusCheckerUniversalIncrementCondition

        func_not_status_paralysis:
            ldrb r0, [r6, #0xBF]; // burn_id
            cmp r0, #0x4; // paralysis
            beq StatusCheckerUniversalReturnFalse;
            b StatusCheckerUniversalIncrementCondition
        
        func_not_status_paused:
            ldrb r0, [r6, #0xD0]; // cringe_id
            cmp r0, #0x3; // paused
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_not_status_perish_song:
            add r0, r6, #0x100;
            ldrb r0, [r0, #0x6]; // perish_count
            cmp r0, #0x0
            bne StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_poison:
            ldrb r0, [r6, #0xBF]; // burn_id
            cmp r0, #0x2; // poison
            beq func_not_status_bad_poison; // Poison also checks for bad poison!
            b StatusCheckerUniversalIncrementCondition

        func_not_status_protect:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0x7; // protect
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_not_status_reflect:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0x1; // reflect
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_safeguard:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0x2; // safeguard
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_shadow_hold:
            ldrb r0, [r6, #0xC4]; // frozen_id
            cmp r0, #0x2; // shadow hold
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_sleepless:
            ldrb r0, [r6, #0xBD]; // sleep_id
            cmp r0, #0x2; // sleepless
            beq StatusCheckerUniversalReturnFalse;
            b StatusCheckerUniversalIncrementCondition

        func_not_status_snatch:
            ldrb r0, [r6, #0xD8]; // curse_id
            cmp r0, #0x3; // snatch (why is this a curse class status???)
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_sure_shot:
            ldrb r0, [r6, #0xEC]; // sure_shot_id
            cmp r0, #0x1; // sure shot
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_taunted:
            ldrb r0, [r6, #0xD0]; // cringe_id
            cmp r0, #0x5; // taunted
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_transformed:
            ldrb r0, [r6, #0xEF]; // invisible_id
            cmp r0, #0x2; // transformed
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_whiffer:
            ldrb r0, [r6, #0xEC]; // sure_shot_id
            cmp r0, #0x2; // whiffer
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_wish:
            ldrb r0, [r6, #0xD5]; // reflect_id
            cmp r0, #0x6; // protect
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_wrapped:
            ldrb r0, [r6, #0xC4]; // frozen_id
            cmp r0, #0x3; // wrapped
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_wrapping:
            ldrb r0, [r6, #0xC4]; // frozen_id
            cmp r0, #0x4; // wrapping
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_not_status_yawn:
            ldrb r0, [r6, #0xBD]; // sleep_id
            cmp r0, #0x5; // yawning
            beq StatusCheckerUniversalReturnFalse;
            b StatusCheckerUniversalIncrementCondition

        func_speed_above_min:
            ldr r0, [r6, #0x110]; // speed stage
            cmp r0, #0x1
            blt StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_speed_below_max:
            ldr r0, [r6, #0x110]; // speed stage
            cmp r0, #0x4
            bge StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_standing_on_land:
            mov r0, r11
            bl GetTileAtEntity
            mov r4, r0
            bl IsTileGround
            cmp r0, #0x1
            bne StatusCheckerUniversalReturnFalse
            mov r0, r4
            bl GetTileTerrain
            cmp r0, #0x1
            bne StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        func_standing_on_not_trap:
            mov r0, r11
            bl GetTileAtEntity
            ldr r0, [r0, #0x10]
            cmp r0, #0x0
            beq StatusCheckerUniversalIncrementCondition
            ldr r0, [r0]
            cmp r0, #0x2
            bne StatusCheckerUniversalIncrementCondition
            b StatusCheckerUniversalReturnFalse

        func_standing_on_trap:
            mov r0, r11
            bl GetTileAtEntity
            ldr r0, [r0, #0x10]
            cmp r0, #0x0
            beq StatusCheckerUniversalReturnFalse
            ldr r0, [r0]
            cmp r0, #0x2
            bne StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        func_standing_on_water:
            mov r0, r11
            bl GetTileAtEntity
            bl IsTileGround
            cmp r0, #0x0
            bne StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        
        func_stat_mult_over_point_25_atk:
            ldr r0, [r6, #0x34]; // atk mult
            cmp r0, #0x3F
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_stat_mult_over_point_25_def:
            ldr r0, [r6, #0x3C]; // def mult
            cmp r0, #0x3F
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_stat_mult_over_point_25_spd:
            ldr r0, [r6, #0x40]; // spd mult
            cmp r0, #0x3F
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_stats_exceed_user: 
            // psych up: check off, def, acc/eva, and modifiers! If target has any that exceed user, allow the move to run!
            mov r2, #0x24;
            func_stats_exceed_user_loop_stages:
                ldrh r0, [r6, r2]; // target stat stage
                ldrh r1, [r5, r2]; // user stat stage
                cmp r0, r1
                bgt StatusCheckerUniversalIncrementCondition
                add r2, #0x2
                cmp r2, #0x30
                blt func_stats_exceed_user_loop_stages
            mov r2, #0x34
            func_stats_exceed_user_loop_modifiers:
                ldr r0, [r6, r2]; // target stat mult
                ldr r1, [r5, r2]; // user stat mult
                cmp r0, r1
                bgt StatusCheckerUniversalIncrementCondition
                add r2, #0x4
                cmp r2, #0x44
                blt func_stats_exceed_user_loop_modifiers
            b StatusCheckerUniversalReturnFalse


        func_stockpile_not_max:
            add r0, r6, #0x100
            ldrb r0, [r0,#0x1E]; // stockpile stages
            cmp r0, #0x3
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_stockpile_not_min:
            add r0, r6, #0x100
            ldrb r0, [r0,#0x1E]; // stockpile stages
            cmp r0, #0x0
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_sum_stats_gt_user_def:
            ldrh r0, [r6, #0x28]; // target def
            ldrh r1, [r6, #0x2A]; // target spd
            add r0, r1
            ldrh r1, [r5, #0x28]; // user def
            ldrh r2, [r5, #0x2A]; // user spd
            add r2, r1
            cmp r0, r1
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_sum_stats_gt_user_off:
            ldrh r0, [r6, #0x24]; // target atk
            ldrh r1, [r6, #0x26]; // target spa
            add r0, r1
            ldrh r1, [r5, #0x24]; // user atk
            ldrh r2, [r5, #0x26]; // user spa
            add r2, r1
            cmp r0, r1
            cmp r0, r1
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition


        func_sum_stats_gt_user_off_def:
            ldr r0, [r6, #0x24]; // target atk both
            ldr r1, [r6, #0x28]; // target def both
            add r0, r1
            add r0, r0, ror 0x10; // yields 0x10001 * (atk + spa + def + spdef) 
            ldr r1, [r5, #0x24]; // target atk both
            ldr r2, [r5, #0x28]; // target def both
            add r1, r2
            add r1, r1, ror 0x10; // yields 0x10001 * (atk + spa + def + spdef)
            cmp r0, r1
            ble StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_terrain_not_gravity:
            bl GravityIsActive
            cmp r0, #0x1
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition
        
        func_terrain_not_mud_sport:
            mov r1, #0x97
        func_terrain_sport_check:
            ldr r0, =DUNGEON_PTR
            ldr r0, [r0]
            add r0, r1
            add r0, #0x8C00
            ldrb r0, [r0]
            cmp r0, #0x0
            bgt StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_type_matches_camouflage:
            mov r0, r11
            ldr r1, =DUNGEON_PTR
            mov r2, #0xc
            ldr r1, [r1]
            ldr r3, =CAMOUFLAGE_TYPE_START
            add r1, r1, #0x4000
            ldrsh r1, [r1, #0xd4]
            smulbb r1, r1, r2
            ldrb r1, [r3, r1]
            bl MonsterIsType
            cmp r0, #0x1
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_user_has_item_any:
            // Trick needs to check both entities. greedy little shit.
            ldrb r0, [r5, #0x62]
            tst r0, #0x1; // item_is_valid?
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_weather_not_hail:
            mov r0, r11
            bl GetApparentWeather
            cmp r0, #0x5; // hail
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_weather_not_rainy:
            mov r0, r11
            bl GetApparentWeather
            cmp r0, #0x4; // rain
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_weather_not_sandstorm:
            mov r0, r11
            bl GetApparentWeather
            cmp r0, #0x2; // sandstorm
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_weather_not_sunny:
            mov r0, r11
            bl GetApparentWeather
            cmp r0, #0x1; // sunny
            beq StatusCheckerUniversalReturnFalse
            b StatusCheckerUniversalIncrementCondition

        func_stat_mult_over_point_25_atk_spa:
            ldr r0, [r6, #0x38]; // spa mult
            cmp r0, #0x3F
            ble func_stat_mult_over_point_25_atk
            b StatusCheckerUniversalIncrementCondition

        func_terrain_not_water_sport:
            mov r1, #0x98
            b func_terrain_sport_check

        // If you run out of room in this function, there is extra space in the other one! move any "func" around as you see fit!
    StatusCheckerUniversalReturnFalse:
        mov r9, #0x0;
    StatusCheckerUniversalReturnTrue:
        mov r0, r9
        pop {r2-r12,pc}

        .pool
    STATUS_CHECKER_CONDITIONS_TABLE:
        .hword 14; // MOVE_HAIL
            .byte WEATHER_NOT_HAIL, NO_CONDITION
        .hword 19; // MOVE_RAGE
            .byte NOT_STATUS_ENRAGED, NO_CONDITION
        .hword 51; // MOVE_COUNTER
            .byte NOT_STATUS_COUNTER, NO_CONDITION
        .hword 472; // MOVE_PAYBACK
            .byte NOT_STATUS_COUNTER, NO_CONDITION
        .hword 38; // MOVE_PURSUIT
            .byte NOT_STATUS_COUNTER, NO_CONDITION
        .hword 40; // MOVE_MIRROR_MOVE
            .byte NOT_STATUS_MIRROR_MOVE_FUZZY, NO_CONDITION
        .hword 195; // MOVE_HOWL
            .byte NOT_HAS_MAX_ATK, NO_CONDITION
        .hword 333; // MOVE_MEDITATE
            .byte NOT_HAS_MAX_ATK, NO_CONDITION
        .hword 55; // MOVE_SHARPEN
            .byte NOT_HAS_MAX_ATK, NO_CONDITION
        .hword 257; // MOVE_BELLY_DRUM
            .byte NOT_HAS_MAX_ATK, BELLY_ABOVE_MIN
        .hword 202; // MOVE_ACID_ARMOR
            .byte NOT_HAS_MAX_DEF, NO_CONDITION
        .hword 258; // MOVE_BARRIER
            .byte NOT_HAS_MAX_DEF, NO_CONDITION
        .hword 302; // MOVE_DEFENSE_CURL
            .byte NOT_HAS_MAX_DEF, NO_CONDITION
        .hword 58; // MOVE_HARDEN
            .byte NOT_HAS_MAX_DEF, NO_CONDITION
        .hword 186; // MOVE_IRON_DEFENSE
            .byte NOT_HAS_MAX_DEF, NO_CONDITION
        .hword 70; // MOVE_WITHDRAW
            .byte NOT_HAS_MAX_DEF, NO_CONDITION
        .hword 215; // MOVE_AMNESIA
            .byte NOT_HAS_MAX_SPDEF, NO_CONDITION
        .hword 61; // MOVE_BIDE
            .byte NOT_STATUS_BIDE, NO_CONDITION
        .hword 340; // MOVE_REVENGE
            .byte NOT_STATUS_BIDE, NO_CONDITION
        .hword 535; // MOVE_AVALANCHE
            .byte NOT_STATUS_BIDE, NO_CONDITION
        .hword 95; // MOVE_AGILITY
            .byte SPEED_BELOW_MAX, NO_CONDITION
        .hword 540; // MOVE_ROCK_POLISH
            .byte SPEED_BELOW_MAX, NO_CONDITION
        .hword 444; // MOVE_TAILWIND
            .byte SPEED_BELOW_MAX, NO_CONDITION
        .hword 349; // MOVE_LOCK_ON
            .byte NOT_STATUS_SURE_SHOT, NO_CONDITION
        .hword 98; // MOVE_MIND_READER
            .byte NOT_STATUS_SURE_SHOT, NO_CONDITION
        .hword 99; // MOVE_COSMIC_POWER
            .byte NOT_HAS_MAX_DEF_SPD, NO_CONDITION
        .hword 104; // MOVE_ENDURE
            .byte NOT_STATUS_ENDURE, NO_CONDITION
        .hword 128; // MOVE_CHARGE
            .byte NOT_STATUS_CHARGE, NO_CONDITION
        .hword 130; // MOVE_MIST
            .byte NOT_STATUS_MIST, NO_CONDITION
        .hword 259; // MOVE_LIGHT_SCREEN
            .byte NOT_STATUS_LIGHT_SCREEN, NO_CONDITION
        .hword 169; // MOVE_MINIMIZE
            .byte NOT_HAS_MAX_EVA, NO_CONDITION
        .hword 233; // MOVE_INGRAIN
            .byte NOT_STATUS_INGRAIN, HP_BELOW_HALF
        .hword 236; // MOVE_SWALLOW
            .byte STOCKPILE_NOT_MIN, HP_BELOW_HALF
        .hword 245; // MOVE_SPIT_UP
            .byte STOCKPILE_NOT_MIN, NO_CONDITION
        .hword 256; // MOVE_DOOM_DESIRE
            .byte NOT_STATUS_SET_DAMAGE, NO_CONDITION
        .hword 317; // MOVE_FUTURE_SIGHT
            .byte NOT_STATUS_SET_DAMAGE, NO_CONDITION
        .hword 265; // MOVE_BULK_UP
            .byte NOT_HAS_MAX_ATK_DEF, NO_CONDITION
        .hword 286; // MOVE_CAMOUFLAGE
            .byte TYPE_MATCHES_CAMOUFLAGE, NO_CONDITION
        .hword 288; // MOVE_TAIL_GLOW
            .byte NOT_HAS_MAX_SPA, NO_CONDITION
        .hword 313; // MOVE_DESTINY_BOND
            .byte NOT_STATUS_DESTINY_BOND, NO_CONDITION
        .hword 316; // MOVE_MIRROR_COAT
            .byte NOT_STATUS_MIRROR_COAT, NO_CONDITION
        .hword 338; // MOVE_REFLECT
            .byte NOT_STATUS_REFLECT, NO_CONDITION
        .hword 343; // MOVE_DRAGON_DANCE
            .byte NOT_HAS_MAX_ATK_SPE, NO_CONDITION
        .hword 298; // MOVE_MAGIC_COAT
            .byte NOT_STATUS_MAGIC_COAT, NO_CONDITION
        .hword 305; // MOVE_DETECT
            .byte NOT_STATUS_PROTECT, NO_CONDITION
        .hword 301; // MOVE_PROTECT
            .byte NOT_STATUS_PROTECT, NO_CONDITION
        .hword 12; // MOVE_RAIN_DANCE
            .byte WEATHER_NOT_RAINY, NO_CONDITION
        .hword 141; // MOVE_SANDSTORM
            .byte WEATHER_NOT_SANDSTORM, NO_CONDITION
        .hword 223; // MOVE_SUNNY_DAY
            .byte WEATHER_NOT_SUNNY, NO_CONDITION
        .hword 134; // MOVE_SAFEGUARD
            .byte NOT_STATUS_SAFEGUARD, NO_CONDITION
        .hword 391; // MOVE_INVISIFY
            .byte NOT_STATUS_INVISIBLE, NO_CONDITION
        .hword 74; // MOVE_FOCUS_ENERGY
            .byte NOT_STATUS_FOCUS_ENERGY, NO_CONDITION
        .hword 364; // MOVE_TAKEAWAY
            .byte HAS_ITEM_NONE, NO_CONDITION
        .hword 232; // MOVE_REST
            .byte HP_BELOW_QUARTER_OR_STATUSED, NO_CONDITION
        .hword 156; // MOVE_DIVE
            .byte STANDING_ON_WATER, NO_CONDITION
        .hword 8; // MOVE_DIG
            .byte STANDING_ON_LAND, NO_CONDITION
        .hword 389; // MOVE_TRAP_BUSTER
            .byte STANDING_ON_TRAP, NO_CONDITION
        .hword 212; // MOVE_MUD_SPORT
            .byte TERRAIN_NOT_MUD_SPORT, NO_CONDITION
        .hword 307; // MOVE_WATER_SPORT
            .byte TERRAIN_NOT_WATER_SPORT, NO_CONDITION
        .hword 49; // MOVE_GRUDGE
            .byte NOT_STATUS_GRUDGE, NO_CONDITION
        .hword 380; // MOVE_DECOY_MAKER
            .byte FLOOR_HAS_NO_DECOY, NO_CONDITION
        .hword 102; // MOVE_FOLLOW_ME
            .byte FLOOR_HAS_NO_DECOY, NO_CONDITION
        .hword 304; // MOVE_SUBSTITUTE
            .byte FLOOR_HAS_NO_DECOY, NO_CONDITION
        .hword 160; // MOVE_STOCKPILE
            .byte STOCKPILE_NOT_MAX, NO_CONDITION
        .hword 378; // MOVE_CLEANSE
            .byte HAS_ITEM_STICKY, NO_CONDITION
        .hword 56; // MOVE_DOUBLE_TEAM
            .byte NOT_HAS_MAX_EVA, NO_CONDITION
        .hword 148; // MOVE_GROWTH
            .byte NOT_HAS_MAX_SPA, NO_CONDITION
        .hword 181; // MOVE_SWORDS_DANCE
            .byte NOT_HAS_MAX_ATK, NO_CONDITION
        .hword 225; // MOVE_WISH
            .byte ASSOCIATION_IS_TEAM, NOT_STATUS_WISH
        .hword 282; // MOVE_TRANSFORM
            .byte NOT_STATUS_TRANSFORMED, NOT_BOSS_FIGHT
        .hword 295; // MOVE_SPIKES
            .byte STANDING_ON_NOT_TRAP, NO_CONDITION
        .hword 480; // MOVE_STEALTH_ROCK
            .byte STANDING_ON_NOT_TRAP, NO_CONDITION
        .hword 496; // MOVE_TOXIC_SPIKES
            .byte STANDING_ON_NOT_TRAP, NO_CONDITION
        .hword 319; // MOVE_CALM_MIND
            .byte NOT_HAS_MAX_SPA_SPDEF, NO_CONDITION
        .hword 334; // MOVE_SNATCH
            .byte NOT_STATUS_SNATCH, NO_CONDITION
        .hword 269; // MOVE_BEAT_UP
            .byte NOT_BOSS_FIGHT, NO_CONDITION
        .hword 368; // MOVE_BLOWBACK
            .byte NOT_BOSS_FIGHT, NO_CONDITION
        .hword 406; // MOVE_HURL
            .byte NOT_BOSS_FIGHT, NO_CONDITION
        .hword 43; // MOVE_MEMENTO
            .byte NOT_BOSS_FIGHT, NO_CONDITION
        .hword 284; // MOVE_ROAR
            .byte NOT_BOSS_FIGHT, NO_CONDITION
        .hword 375; // MOVE_STAY_AWAY
            .byte NOT_BOSS_FIGHT, NO_CONDITION
        .hword 367; // MOVE_SWITCHER
            .byte NOT_BOSS_FIGHT, NO_CONDITION
        .hword 187; // MOVE_TELEPORT
            .byte NOT_BOSS_FIGHT, NO_CONDITION
        .hword 7; // MOVE_VITAL_THROW
            .byte NOT_BOSS_FIGHT, NO_CONDITION
        .hword 369; // MOVE_WARP
            .byte NOT_BOSS_FIGHT, NO_CONDITION
        .hword 268; // MOVE_WHIRLWIND
            .byte NOT_BOSS_FIGHT, NO_CONDITION
        .hword 184; // MOVE_CONVERSION_2
            .byte NOT_STATUS_CONVERSION_2, NO_CONDITION
        .hword 185; // MOVE_HELPING_HAND
            .byte HELPING_HAND_ALLY_SIGHT_CHECK, NO_CONDITION
        .hword 434; // MOVE_AQUA_RING
            .byte NOT_STATUS_AQUA_RING, NO_CONDITION
        .hword 447; // MOVE_LUCKY_CHANT
            .byte LUCKY_CHANT_ALLY_SIGHT_CHECK, NO_CONDITION
        .hword 464; // MOVE_PSYCHO_SHIFT
            .byte HAS_NEGATIVE_STATUS, NO_CONDITION
        .hword 492; // MOVE_ACUPRESSURE
            .byte ACUPRESSURE_ALLY_SIGHT_CHECK, NO_CONDITION
        .hword 493; // MOVE_MAGNET_RISE
            .byte NOT_STATUS_MAGNET_RISE, NO_CONDITION
        .hword 499; // MOVE_TRICK_ROOM
            .byte NOT_SPED_UP, NO_CONDITION
        .hword 520; // MOVE_DEFEND_ORDER
            .byte NOT_HAS_MAX_DEF_SPD, NO_CONDITION
        .hword 532; // MOVE_METAL_BURST
            .byte NOT_STATUS_METAL_BURST, NO_CONDITION
        .hword 542; // MOVE_NASTY_PLOT
            .byte NOT_HAS_MAX_SPA, NO_CONDITION
    STATUS_CHECKER_TABLE_END:
        .hword 0, 0; // Used to check for end of table.
    STATUS_CHECKER_FREE_SPACE_START:
        .fill StatusCheckerCheckOnTarget - 0x24 - STATUS_CHECKER_FREE_SPACE_START, 0x99
    .endarea

    .org StatusCheckerCheckOnTarget
    .area HasLastUsedMove - StatusCheckerCheckOnTarget
        push {r2-r12,lr}; // Must push the same way to use the pop in the prior function!!!
        ldr r8, =STATUS_CHECKER_TARGET_CONDITIONS_TABLE; // r8: move conditions table. Eventually conditions table row of the matching entry.
        mov r11, r1; // r11: target
        mov r7, r0; // r7: user, same as user for this function only.
        ldrh r10, [r2, #0x4]; // r10: move_id. Discard move struct, we don't need that shit!
        
        // For any move, if the target is frozen and this move would unthaw it, do NOT use the move! 
        ldr r0, [r11, #0xB4]
        ldrb r0, [r0, #0xC4]; // frozen status_id
        cmp r0, #0x1
        bne StatusCheckerUniversalLoopInit; // Yeah that's actually it. Everything else can be handled in either case.
        mov r0, r2; // r2 is move id, we won't need it!
        bl IsThawingMove
        cmp r0, #0x1
        bne StatusCheckerUniversalReturnFalse
        b StatusCheckerUniversalLoopInit

        .pool
    STATUS_CHECKER_TARGET_CONDITIONS_TABLE:
        .hword 483; // MOVE_DARK_VOID
            .byte NOT_SLEEPING, NO_CONDITION
        .hword 84; // MOVE_GRASSWHISTLE
            .byte NOT_SLEEPING, NO_CONDITION
        .hword 111; // MOVE_HYPNOSIS
            .byte NOT_SLEEPING, NO_CONDITION
        .hword 4; // MOVE_LOVELY_KISS
            .byte NOT_SLEEPING, NO_CONDITION
        .hword 34; // MOVE_SING
            .byte NOT_SLEEPING, NO_CONDITION
        .hword 231; // MOVE_SLEEP_POWDER
            .byte NOT_SLEEPING, NO_CONDITION
        .hword 79; // MOVE_SPORE
            .byte NOT_SLEEPING, NO_CONDITION
        .hword 3; // MOVE_YAWN
            .byte NOT_STATUS_YAWN, NOT_SLEEPING
        .hword 5; // MOVE_NIGHTMARE
            .byte NOT_STATUS_NIGHTMARE, NO_CONDITION
        .hword 456; // MOVE_DEFOG
            .byte NOT_HAS_MIN_EVA, NO_CONDITION
        .hword 10; // MOVE_SWEET_SCENT
            .byte NOT_HAS_MIN_EVA, NO_CONDITION
        .hword 11; // MOVE_CHARM
            .byte STAT_MULT_OVER_POINT_25_ATK, NO_CONDITION
        .hword 17; // MOVE_ENCORE
            .byte NOT_STATUS_ENCORE, LAST_MOVE_ANY
        .hword 20; // MOVE_SUPER_FANG
            .byte HP_ABOVE_MIN, NO_CONDITION
        .hword 21; // MOVE_PAIN_SPLIT
            .byte HP_ABOVE_USER, NO_CONDITION
        .hword 22; // MOVE_TORMENT
            .byte LAST_MOVE_ANY, TORMENT_CHECK
        .hword 351; // MOVE_COTTON_SPORE
            .byte SPEED_ABOVE_MIN, NO_CONDITION
        .hword 106; // MOVE_SCARY_FACE
            .byte SPEED_ABOVE_MIN, NO_CONDITION
        .hword 23; // MOVE_STRING_SHOT
            .byte SPEED_ABOVE_MIN, NO_CONDITION
        .hword 27; // MOVE_SCREECH
            .byte STAT_MULT_OVER_POINT_25_DEF, NO_CONDITION
        .hword 33; // MOVE_FAKE_TEARS
            .byte STAT_MULT_OVER_POINT_25_SPD, NO_CONDITION
        .hword 35; // MOVE_SPITE
            .byte LAST_MOVE_HAS_PP, NO_CONDITION
        .hword 37; // MOVE_SMOKESCREEN
            .byte NOT_STATUS_WHIFFER, NO_CONDITION
        .hword 47; // MOVE_WILL_O_WISP
            .byte NOT_STATUS_BURN, NO_CONDITION
        .hword 315; // MOVE_FORESIGHT
            .byte IS_TYPE_GHOST, NOT_STATUS_EXPOSED
        .hword 54; // MOVE_ODOR_SLEUTH
            .byte IS_TYPE_GHOST, NOT_STATUS_EXPOSED
        .hword 59; // MOVE_DISABLE
            .byte NOT_STATUS_PARALYSIS, NO_CONDITION
        .hword 281; // MOVE_GLARE
            .byte NOT_STATUS_PARALYSIS, NO_CONDITION
        .hword 124; // MOVE_STUN_SPORE
            .byte NOT_STATUS_PARALYSIS, NO_CONDITION
        .hword 192; // MOVE_THUNDER_WAVE
            .byte NOT_STATUS_PARALYSIS, NO_CONDITION
        .hword 66; // MOVE_ENDEAVOR
            .byte HP_ABOVE_USER, NO_CONDITION
        .hword 224; // MOVE_LEER
            .byte NOT_HAS_MIN_DEF, NO_CONDITION
        .hword 122; // MOVE_TAIL_WHIP
            .byte NOT_HAS_MIN_DEF, NO_CONDITION
        .hword 83; // MOVE_METAL_SOUND
            .byte NOT_HAS_MIN_SPDEF, NO_CONDITION
        .hword 85; // MOVE_TICKLE
            .byte NOT_HAS_MIN_ATK_DEF, NO_CONDITION
        .hword 194; // MOVE_BLOCK
            .byte NOT_STATUS_SHADOW_HOLD, NO_CONDITION
        .hword 89; // MOVE_MEAN_LOOK
            .byte NOT_STATUS_SHADOW_HOLD, NO_CONDITION
        .hword 86; // MOVE_SPIDER_WEB
            .byte NOT_STATUS_SHADOW_HOLD, NO_CONDITION
        .hword 88; // MOVE_HAZE
            .byte ANY_STAT_LOWERED, NO_CONDITION
        .hword 112; // MOVE_UPROAR
            .byte NOT_STATUS_SLEEPLESS, NO_CONDITION
        .hword 504; // MOVE_WORRY_SEED
            .byte NOT_STATUS_SLEEPLESS, NO_CONDITION
        .hword 115; // MOVE_PSYCH_UP
            .byte STATS_EXCEED_USER, NO_CONDITION
        .hword 273; // MOVE_FLASH
            .byte NOT_HAS_MIN_ACC, NO_CONDITION
        .hword 146; // MOVE_KINESIS
            .byte NOT_HAS_MIN_ACC, NO_CONDITION
        .hword 142; // MOVE_SAND_ATTACK
            .byte NOT_HAS_MIN_ACC, NO_CONDITION
        .hword 172; // MOVE_TAUNT
            .byte NOT_STATUS_TAUNTED, NO_CONDITION
        .hword 482; // MOVE_SWITCHEROO
            .byte HAS_ITEM_ANY, USER_HAS_ITEM_ANY
        .hword 209; // MOVE_TRICK
            .byte HAS_ITEM_ANY, USER_HAS_ITEM_ANY
        .hword 249; // MOVE_KNOCK_OFF
            .byte HAS_ITEM_ANY, NO_CONDITION
        .hword 267; // MOVE_FEATHERDANCE
            .byte NOT_HAS_MIN_ATK, NO_CONDITION
        .hword 217; // MOVE_GROWL
            .byte NOT_HAS_MIN_ATK, NO_CONDITION
        .hword 220; // MOVE_ROLE_PLAY
            .byte ABILITIES_DONT_MATCH_USER, NO_CONDITION
        .hword 237; // MOVE_CURSE
            .byte CURSE_CHECK, NO_CONDITION
        .hword 266; // MOVE_IMPRISON
            .byte NOT_STATUS_PAUSED, NO_CONDITION
        .hword 379; // MOVE_OBSERVER
            .byte NOT_STATUS_PAUSED, NO_CONDITION
        .hword 314; // MOVE_FALSE_SWIPE
            .byte HP_ABOVE_MIN, NO_CONDITION
        .hword 329; // MOVE_LEECH_SEED
            .byte NOT_STATUS_LEECH_SEED, NO_CONDITION
        .hword 293; // MOVE_PERISH_SONG
            .byte NOT_STATUS_PERISH_SONG, NO_CONDITION
        .hword 525; // MOVE_COPYCAT
            .byte LAST_MOVE_ANY, NO_CONDITION
        .hword 327; // MOVE_MIMIC
            .byte LAST_MOVE_ANY, NO_CONDITION
        .hword 138; // MOVE_SKETCH
            .byte LAST_MOVE_ANY, NO_CONDITION
        .hword 326; // MOVE_ATTRACT
            .byte NOT_STATUS_INFATUATED, NO_CONDITION
        .hword 294; // MOVE_WRAP
            .byte NOT_STATUS_WRAPPING, NOT_STATUS_WRAPPED
        .hword 197; // MOVE_TOXIC
            .byte NOT_STATUS_BAD_POISON, NO_CONDITION
        .hword 196; // MOVE_POISON_GAS
            .byte NOT_STATUS_POISON, NOT_STATUS_BAD_POISON
        .hword 199; // MOVE_POISONPOWDER
            .byte NOT_STATUS_POISON, NOT_STATUS_BAD_POISON
        .hword 13; // MOVE_CONFUSE_RAY
            .byte NOT_STATUS_CONFUSED, NO_CONDITION
        .hword 45; // MOVE_FLATTER
            .byte NOT_STATUS_CONFUSED, NO_CONDITION
        .hword 171; // MOVE_SUPERSONIC
            .byte NOT_STATUS_CONFUSED, NO_CONDITION
        .hword 24; // MOVE_SWAGGER
            .byte NOT_STATUS_CONFUSED, NO_CONDITION
        .hword 191; // MOVE_SWEET_KISS
            .byte NOT_STATUS_CONFUSED, NO_CONDITION
        .hword 274; // MOVE_TEETER_DANCE
            .byte NOT_STATUS_CONFUSED, NO_CONDITION
        .hword 382; // MOVE_TOTTER
            .byte NOT_STATUS_CONFUSED, NO_CONDITION
        .hword 438; // MOVE_GASTRO_ACID
            .byte NOT_STATUS_GASTRO_ACID, NO_CONDITION
        .hword 439; // MOVE_HEALING_WISH (Yes, this is a vanilla bug!)
            .byte NOT_STATUS_GASTRO_ACID, NO_CONDITION
        .hword 447; // MOVE_LUCKY_CHANT
            .byte NOT_STATUS_LUCKY_CHANT, NO_CONDITION
        .hword 448; // MOVE_GUARD_SWAP
            .byte SUM_STATS_GT_USER_DEF, NO_CONDITION
        .hword 450; // MOVE_HEAL_BLOCK
            .byte NOT_STATUS_HEAL_BLOCK, NO_CONDITION
        .hword 466; // MOVE_EMBARGO
            .byte NOT_STATUS_EMBARGO, NO_CONDITION
        .hword 478; // MOVE_GRAVITY
            .byte TERRAIN_NOT_GRAVITY, NO_CONDITION
        .hword 492; // MOVE_ACUPRESSURE
            .byte NOT_MAX_OFF_DEF_ANY, NO_CONDITION
        .hword 493; // MOVE_MAGNET_RISE
            .byte NOT_STATUS_MAGNET_RISE, NO_CONDITION
        .hword 506; // MOVE_HEART_SWAP
            .byte SUM_STATS_GT_USER_OFF_DEF, NO_CONDITION
        .hword 513; // MOVE_POWER_SWAP
            .byte SUM_STATS_GT_USER_OFF, NO_CONDITION
        .hword 514; // MOVE_POWER_TRICK
            .byte ATTACK_LT_DEFENSE, NO_CONDITION
        .hword 528; // MOVE_MIRACLE_EYE
            .byte MIRACLE_EYE_CONDITION, NO_CONDITION
        .hword 532; // MOVE_METAL_BURST
            .byte NOT_STATUS_METAL_BURST, NO_CONDITION
        .hword 534; // MOVE_CAPTIVATE
            .byte GENDERS_NOT_EQUAL, NOT_HAS_MIN_SPA
        .hword 43; // MOVE_MEMENTO
            .byte STAT_MULT_OVER_POINT_25_ATK_SPA, NO_CONDITION
    STATUS_CHECKER_TARGET_TABLE_END:
        .hword 0, 0; // Used to check for end of table.
    STATUS_CHECKER_TARGET_FREE_SPACE_START:
        .fill HasLastUsedMove - STATUS_CHECKER_TARGET_FREE_SPACE_START, 0x99
    .endarea
.close