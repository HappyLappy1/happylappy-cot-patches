# ExtractStatusChecker
This patch tabulates all of the hard-coded move-based conditions for the "Status Checker" IQ Skill, which provided restrictive conditions on when the AI is allowed to use certain moves to a binary table. In vanilla, there are two distinct status checker functions: StatusCheckerCheck which only targets the user, and StatusCheckerCheckOnTarget, which has access to both the user and the target. Generally, self-targeting moves use the former, and moves that target enemies use the latter.

My implementation merges the two functions into one larger function that handles both, with distinct binary tables for the type of check being done. For example, Nasty Plot would go in the STATUS_CHECKER_CONDITIONS_TABLE, since it needs to check the user's special attack. However, Growl would go in the STATUS_CHECKER_TARGET_CONDITIONS_TABLE, since the target's attack needs to be checked, not the user's. Checks that involve both the user and target, like Pain Split, also belong in the STATUS_CHECKER_TARGET_CONDITIONS_TABLE, as a target needs to be chosen before selection.

Adding Moves: Adding moves to either table is simple enough. I've annotated all of the vanilla entries, but each slot requires a move id as a .hword, and up to two byte-sized conditions, like so:
```
        .hword 27; // MOVE_SCREECH
            .byte STAT_MULT_OVER_POINT_25_DEF, NO_CONDITION
```

Vanilla Bugs: I've preserved two vanilla bugs in EoS regarding status checker, that were initially found by AnonymousRandomPerson (Some Body).
The first of these bugs is with healing wish. In vanilla, the AI will never use Gastro Acid (id 438) nor Healing Wish (id 439) if the target of the move has the gastro acid status.
```
        .hword 438; // MOVE_GASTRO_ACID
            .byte NOT_STATUS_GASTRO_ACID, NO_CONDITION
        .hword 439; // MOVE_HEALING_WISH (Yes, this is a vanilla bug!)
            .byte NOT_STATUS_GASTRO_ACID, NO_CONDITION
```
While the intended behavior (if any) is currently unknown, HP_BELOW_QUARTER_OR_STATUSED would be a more appropriate condition for using Healing Wish...

The other bug in vanilla status checker has to do with Mirror Move, and the Chatot Scarf exclusive item. The vanilla code to check whether or not to use mirror move looks something like this:
```
    if (MirrorMoveIsActive(entity) != 0) {
        return false; // do not use move!
    }
```
That may seem like a sensible check at first, but "MirrorMoveIsActive" doesn't actually return true or false! If the Chatot Scarf is active, the function will return 2 20% of the time, provided Mirror Move is not actually active. 

So for a Chatot under the effects of the Chatot Scarf, the AI will believe it has the Mirror Move status 20% of the time, and decide not to use the move. I've recreated this condition, and named it "MIRROR_MOVE_FUZZY" as shown below:
```
        .hword 40; // MOVE_MIRROR_MOVE
            .byte NOT_STATUS_MIRROR_MOVE_FUZZY, NO_CONDITION
```
In order to fix this bug, simply change the "bge" to a "beq" in this block of code, to make the check "exact" rather than "fuzzy":
```
        func_not_status_mirror_move_fuzzy:
            // Fuzzy because it includes the vanilla 20% check for Chatot Scarf.
            mov r0, r11
            bl MirrorMoveIsActive
            cmp r0, #0x1;
            // Change to beq to ignore the chatot scarf, which would return 2.
            bge StatusCheckerUniversalReturnFalse; 
            b StatusCheckerUniversalIncrementCondition
```

Note: This patch does not currently use overlay_36, but if both patch areas are overflowing, storing the tables there might be more effective.

Disclaimer: Status Checker spans two massive functions, and I have not tested every interaction with and without my patch by hand. Broad strokes though, this is functioning as intended, and should be identical to vanilla.
