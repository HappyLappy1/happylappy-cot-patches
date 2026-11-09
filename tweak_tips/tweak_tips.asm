.nds
.include "symbols.asm"

// By Happylappy: To be included in patches for C-Of-Time.
// Optimizes and extracts Dungeon Floor Tips, allowing individual tips to be toggled or reparameterized!
// NOTE: The Sunny/Rainy Orb Item Tip has been simplified. In vanilla, it also requires being inside Bidoof's Wish Cave!

// Region Addresses
.definelabel MESSAGE_TIP_TABLE_1, 0x2353e50; // EU. Dunno about NA, but in EU it's directly above "GUMMI_LIKE_STRING_IDS".
.definelabel MESSAGE_TIP_TABLE_2, 0x2353ee8; // EU. Dunno about NA, but in EU it's directly below "GUMMI_LIKE_STRING_IDS".



// Constants
.definelabel FLOOR_TIPS_START_STRING_ID, 0x3FD0; // Start from string ID 16336 for Floor Tip 0.
.definelabel FLOOR_TIPS_COUNT, 0xA; // 10 dungeon floor pair dungeon tips! (Should not exceed 32)
.definelabel ITEM_TIPS_START_STRING_ID, 0x3FDA; // Start from string ID 16346 for Item Tip 0.
.definelabel ITEM_TIPS_COUNT, 0x11; // 17 item related dungeon tips! (Should not exceed 32)
.definelabel EU_0x204D944, 0x204D944;
.definelabel EU_0x204D74C, 0x204D74C;

.open "overlay29.bin", overlay29_start
	.org MESSAGE_TIP_TABLE_1
	.area 0x90
		// Item IDs
		.hword 0x0000; // None (Item Category, Food/Gummi)
		.hword 0x0046; // Oran Berry
		.hword 0x0052; // Cheri Berry
		.hword 0x0057; // Blast Seed
		.hword 0x0008; // Geo Pebble
		.hword 0x0051; // Pecha Berry
		.hword 0x0054; // Sleep Seed
		.hword 0x00B7; // Poke
		.hword 0x0063; // Max Elixir
		.hword 0x0045; // Heal Seed
		.hword 0x005B; // Stun Seed
		.hword 0x0056; // Warp Seed
		.hword 0x005E; // Vile Seed
		.hword 0x004C; // X-Eye Seed
		.hword 0x0060; // Violent Seed
		.hword 0x0075; // Oren Berry
		// This hint will only normally play in Bidoof's Wish Star Cave. That behavior has not been implemented...
		.hword 0x012E; // Sunny Orb (ITEM_DELTA = 1, so Sunny Orb (302) OR Rainy Orb (303) will work!)
		// Expand as needed
	MESSAGE_TIP_TABLE_1_METADATA:
		// Metadata for the above Item IDs. If between 0x0 (0) and 0xF (15), treat as item_category.
		// Otherwise, treat (value - 0x10) as delta for item range: [ITEM_ID, ITEM_ID + ITEM_DELTA]
		.byte 0x03; // ITEM_CATEGORY: 3
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x10; // ITEM_DELTA: 0
		.byte 0x11; // ITEM_DELTA: 1
	END_OF_MESSAGE_TIP_TABLE_1:
		.fill 0x60 - END_OF_MESSAGE_TIP_TABLE_1 + MESSAGE_TIP_TABLE_1, 0x00
	// Provided all 32 tips are used on items, only 0x60 of these 0x90 bytes will get used!
	// Short of expanding the tooltips save data info, this space should always be unused!
		.fill 0x30, 0xCC
	.endarea

	.org MESSAGE_TIP_TABLE_2
	.area 0x48
		// Dungeon/Floor-based Dungeon Tips!
		//	   Dungeon   Floor	  (Note: 0xFF = Any)
		.byte	0xFF,	 0xFF; // Typically Beach Cave 1F Tip
		.byte	0xFF,	 0xFF; // Typically Beach Cave 2F Tip
		.byte	0xFF,	 0xFF; // Typically Beach Cave 3F Tip
		.byte	0xFF,	 0xFF; // Typically Beach Cave 4F Tip
		.byte   0x03,    0xFF; // Typically 1F, Must be Drenched Bluff!
		.byte   0x03,    0xFF; // Typically 2F, Must be Drenched Bluff!
		.byte   0x03,    0xFF; // Typically 3F, Must be Drenched Bluff!
		.byte   0x03,    0xFF; // Typically 4F, Must be Drenched Bluff!
		.byte   0x03,    0xFF; // Typically 5F, Must be Drenched Bluff!
		.byte   0x03,    0xFF; // Typically 6F, Must be Drenched Bluff!
	END_OF_MESSAGE_TIP_TABLE_2:
		.fill 0x40 - END_OF_MESSAGE_TIP_TABLE_2 + MESSAGE_TIP_TABLE_2, 0x00
	// Provided all 32 tips are used on floors, only 0x40 of these 0x48 bytes will get used!
	// Short of expanding the tooltips save data info, this space should always be unused!
		.fill 0x8, 0xCC
	.endarea

	// Actually changing the functions to use the new and improved table data!

	.org DisplayItemTip
	.area DisplayDungeonTip - DisplayItemTip
		push {r1-r12,lr}
		sub sp, #0x8
		mov r11, r0; // r11: item_id
		bl GetItemCategoryVeneer
		mov r10, r0; // r10: item_category
		ldr r8, =MESSAGE_TIP_TABLE_1
		ldr r7, =MESSAGE_TIP_TABLE_1_METADATA
		mov r6, #0x0
		DisplayItemTipLoopStart:
			ldrb r0, [r7, r6]
			cmp r0, #0x10
			bge DisplayItemTipCaseDelta
			cmp r0, r10
			beq DisplayItemTipMatch
			b DisplayItemTipLoopIncrement
		DisplayItemTipCaseDelta:
			sub r0, #0x10
			ldrh r1, [r8];
			add r2, r1, r0
			cmp r11, r1;   // r11 >= item_id_min
			cmpge r2, r11; // item_id_max >= r11
			bge DisplayItemTipMatch
		DisplayItemTipLoopIncrement:
			add r6, #0x1
			add r8, #0x2
			cmp r6, #ITEM_TIPS_COUNT;
			blt DisplayItemTipLoopStart
			mov r0, #0x0
			b DisplayItemTipReturn
			
	DisplayItemTipMatch:
		add r0, r6, #FLOOR_TIPS_COUNT
		str r0, [sp, #0x0];
		ldr r0, =ITEM_TIPS_START_STRING_ID;
		add r0, r6;
		str r0, [sp, #0x4];
		mov r0, sp
		mov r1, #0x1; // Actually log the message after pop-up?
		bl DisplayDungeonTip
	DisplayItemTipReturn:
		add sp, #0x8
		pop {r1-r12,pc}
		.pool
	END_OF_ITEM_TIP_PATCH:
		.fill DisplayDungeonTip - END_OF_ITEM_TIP_PATCH, 0xCC
	.endarea

	.org DisplayFloorTip
	.area DisplayItemTip - DisplayFloorTip
		push {r1-r12,lr}
		sub sp, #0x8
		ldr r0, =DUNGEON_PTR
		ldr r0, [r0]
		add r0, #0x700
		ldrh r10, [r0, #0x48]; // Dungeon Floor Pair
		mov r9, #0x0
		ldr r8, =MESSAGE_TIP_TABLE_2
		DisplayFloorTipLoopStart:
			ldrb r0, [r8, #0x0]
			and r1, r10, #0xFF
			ldrb r2, [r8, #0x1]
			lsr r3, r10, #0x8
			cmp r0, r1
			cmpne r0, #0xFF; // Check for wildcard dungeon
			bne DisplayFloorTipLoopIncrement
			cmp r2, r3
			cmpne r2, #0xFF; // Check for wildcard floor
			beq DisplayFloorTipMatch
		DisplayFloorTipLoopIncrement:
			add r8, #0x2
			add r9, #0x1
			cmp r9, #FLOOR_TIPS_COUNT;
			blt DisplayFloorTipLoopStart
			mov r0, #0x0
			b DisplayFloorTipReturn
	DisplayFloorTipMatch:
		str r9, [sp, #0x0];
		ldr r0, =FLOOR_TIPS_START_STRING_ID;
		add r0, r9;
		str r0, [sp, #0x4];
		mov r0, sp
		mov r1, #0x0; // Actually log the message after pop-up?
		bl DisplayDungeonTip
		// If the floor tip failed to spawn, try the next one!
		cmp r0, #0x1
		bne DisplayFloorTipLoopIncrement
	DisplayFloorTipReturn:
		add sp, #0x8
		pop {r1-r12,pc}
		.pool
	END_OF_FLOOR_TIP_PATCH:
		.fill DisplayItemTip - END_OF_FLOOR_TIP_PATCH, 0xCC
	.endarea
	// A half-hearted attempt at adding compatibility with DisableTips.
	// I'm pretty sure DisableTips also prevents the tip flags from saving, which isn't easy to undo.
	.org DisplayDungeonTip
	.area 0x4
		push {r3-r5, lr}; // Original instruction, replaced by DisableTips
	.endarea
	
	// Addresses courtesy of Frostbyte's DisableTips
	// https://github.com/Frostbyte0x70/EoS-asm-patches/blob/1e5ebe4a216a5d3e4c7c8dd480b33c850d3d083f/src/DisableTips.asm
.close

.open "arm9.bin", arm9_start
	.org EU_0x204D74C; // NA 0x204D414 
	.area 0x4
		bl GetDungeonTipShown
	.endarea

	.org EU_0x204D944; // NA 0x204D60C
	.area 0x4
		bl SetDungeonTipShown
	.endarea
.close