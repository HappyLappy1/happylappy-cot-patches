# TweakTips
Wouldn't it be cool if we could make better use of the dungeon tips? Really wish you could get them back, after you applied DisableTips a little too early into your hack design? Well, this might help with that! tweak_tips.asm allows for full configuration of what triggers cause tips to spawn, by changing DisplayItemTip and DisplayFloorTip to read a table of parameters, instead of being a mess of if statements. 
This patch should be able to replace (and be replaced) by DisableTips, without breaking anything. However, there are a few caveats:
- I only have EU offsets: You'll need to find NA addresses for what I call MESSAGE_TIP_TABLE_1 and MESSAGE_TIP_TABLE_2.
- This does SLIGHTLY change vanilla behavior! There is one dungeon tip that only runs if you pick up a sunny orb or rainy orb in Bidoof's copy of Star Cave. This patch replicates all of that, except for the dungeon ID check! That's the only (known) difference.
This is intended for CoT use, but it shouldn't be too difficult to convert it to a proper SkyPatch.

If you are especially interested in porting this to NA, please let me know, and I would be happy to help!
