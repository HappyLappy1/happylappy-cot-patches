.align 4




PERFORMANCE_FLAG_ID = 62; // Change this to a non-conflicting performance progress list flag id!




ShouldUseFlippedPortraits:
	push {lr}
	push {r1-r9}
	// r10: portrait_params
	
	mov r0, #0x0
	mov r1, #0x4E; // Performance Progress List Variable Id 
	mov r2, #PERFORMANCE_FLAG_ID;
	bl LoadScriptVariableValueAtIndex
	// if r0 = 1, use the flipped portrait, even if we are not trying to flip it!
	// If r0 = 0, do not use the flipped portrait, even though we have one!
	ldrb r1, [r10, #0xC]; // try_flip (whether the portrait asked to be flipped)
	ldr r2, =SHOULD_FLIP_PORTRAIT_REAL_ACTUAL
	str r1, [r2]
	orr r1, r0; // if using the flipped portrait, always attempt a flip!
	strb r1, [r10, #0xC];
	cmp r0, #0x1
ShouldUseFlippedPortraitsReturn:
	pop {r1-r9}
	popeq {pc}
	ldr r0, [sp, #0x8]; 
	rsb r0, #0x0
	str r0, [sp, #0x8];
	moveq r0, #0x1
	movne r0, #0x0
	pop {pc}

ShouldActuallyDoHardwareCheck:
	push {r0-r3, lr}
	mov r0, #0x0
	mov r1, #0x4E; // Performance Progress List Variable Id 
	mov r2, #PERFORMANCE_FLAG_ID;
	bl LoadScriptVariableValueAtIndex
	cmp r0, #0x1
	popne {r0-r3, pc}
	ldr r2, =SHOULD_FLIP_PORTRAIT_REAL_ACTUAL
	ldrb r4, [r2]
	strb r4, [r10, #0xE]
	pop {r0-r3, pc}

ShouldActuallyDoHardwareCheck2:
	push {r0-r3, lr}
	mov r0, #0x0
	mov r1, #0x4E; // Performance Progress List Variable Id 
	mov r2, #PERFORMANCE_FLAG_ID;
	bl LoadScriptVariableValueAtIndex
	eor r5, r0
	strb r5, [r10, #0xE]
	pop {r0-r3, pc}

.pool

SHOULD_FLIP_PORTRAIT_REAL_ACTUAL:
	.word 0x0