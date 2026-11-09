
.nds
.include "symbols.asm"

.definelabel InterceptHasFlipCheck, 0x204dc64;
.definelabel InterceptHardwareFlipCheck, 0x204dcb4;
.definelabel InterceptHardwareFlipCheck2, 0x204dc9c;

.open "arm9.bin", arm9_start
	.org InterceptHasFlipCheck
	.area 0x8
		movlt r0, #0x0; // Original instruction
		// movge r0, #0x1
		blge ShouldUseFlippedPortraits
	.endarea

	.org InterceptHardwareFlipCheck
	.area 0x4
		// strb r4, [r10, #0xE]; 
		bl ShouldActuallyDoHardwareCheck
	.endarea

	.org InterceptHardwareFlipCheck2
	.area 0x4
		// strb r5, [r10, #0xE]; 
		bl ShouldActuallyDoHardwareCheck2
	.endarea
.close