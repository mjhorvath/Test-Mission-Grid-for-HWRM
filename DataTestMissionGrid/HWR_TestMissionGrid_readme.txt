Title: Test Mission Grid
Version: 0.15.3
Authors: Mikali
Created: 2010/12/22
Updated: 2020/07/29
Homepage:
	http://isometricland.net/homeworld/homeworld.php
Discussion:
	https://forums.gearboxsoftware.com/t/mod-test-mission-grid-v0-10-0/1577162
	http://forums.relicnews.com/showthread.php?256699 (old thread, dead link)
Steam:
	https://steamcommunity.com/sharedfiles/filedetails/?id=1009418970


======== ======== ======== ======== ======== ======== ======== ======== ========

UPDATE
Source code is now on GitHub if you want to poke around:

https://github.com/mjhorvath/Test-Mission-Grid-for-HWRM


DESCRIPTION
This demo mod modifies the game so that missions are organized in a grid- or 
table-like fashion. Instead of proceeding through the singleplayer campaign in 
a linear, sequential fashion, you now can exit each mission and travel to 
neighboring adjacent sectors in one of the four cardinal directions. Included 
is a modified and extended version of the Postmortem campaign created by 
following WyvernNZ's singleplayer campaign tutorial. WyvernNZ's tutorial can be 
found at this address:

http://forums.relicnews.com/showthread.php?t=21997 (dead link)


INSTALLATION
If you have the Steam version of the game and want to play the mod, you need to 
subscribe to it on Steam Workshop, and select Mods from the game launcher. For 
the GOG.com version of the game and/or the GitHub version of the mod, extract 
the ZIP archive and copy the "DataTestMissionGrid" folder to your "Homeworld 
Remastered" or "HomeworldRM" directories. Then create a new desktop shortcut, 
and add the "-moddatapath DataTestMissionGrid", "-overrideBigFile", and 
"-luatrace" flags to the shortcut's "Target" field. Use this shortcut from now 
on.

When upgrading to newer versions of this mod, make sure to first start a new 
campaign by deleting the contents of the "HomeworldRM\Bin\Profiles\
(YourProfile)\TestMissionGrid" folder. This folder contains the custom save 
game, as well as a number of temporary files, and the format of these files may 
have changed since the last mod version. Leaving these files intact could cause 
the game to crash, or other bad stuff to happen. Alternatively, you can delete 
your current player profile and create a new one, but this will affect all your 
other mods, as well as the vanilla HWRM campaigns. Sadly, the "Reset" button in 
the Mission Select screen does not work properly with this mod, and has been 
disabled.


INSTRUCTIONS
Simply start the game as you would normally. If you are using a custom desktop 
shortcut to launch the game, you will be taken directly to the HWRM main menu. 
If you are using Gearbox's mod launcher, make sure to select this mod, but do 
*not* enable either the HW1 or HW2 campaigns! Leave both checkboxes unchecked.

In the main menu you will see many of the same menu options as in the unmodded 
game. However, the first menu option will now be "TEST MISSION GRID CAMPAIGN". 
Click on this, and you'll be taken to the new mission selection screen. You'll 
notice that now the missions are arranged in a grid of sectors instead of a 
vertical list. The positions of the sectors in the grid are intended to reflect 
their physical coordinates in space. I.e. Sector D4 is "Galactic South" and 
"Galactic East" of Sector A1, and Sector B2 is "Galactic West" and "Galactic 
North" of Sector C3. The coordinate 000 on the in-game compass always points 
toward Galactic North, and your starting fleets will always start the campaign 
pointing toward Galactic East.

You start out the game with three "fleets" of ships, each lead by a capital or 
super capital ship. You can change the makeup of each fleet using the "Fleet 
Manager" screen (a.k.a. the "Squad Menu" screen), which is accessed by pressing 
CTRL+Backslash. You can move your ships around the galaxy using the "Sector 
Map" screen, which is accessed by pressing the Backslash key.

Battles take place in the "minor" gametype scope, and fleet movements take 
place in the "major" gametype scope. The choice you make determines the 
functions that are available to you. To switch between gametype scopes, press 
the "Enter Sector" and "Leave Map" buttons. You can also leave a sector by 
moving your squads onto one of four pink semi-circular exit grids. When you are 
properly positioned, a button will appear on the lower half of your screen, 
indicating the readiness of your fleet to travel to the adjacent sector. 
Pressing the button will cause your squad to leave the map and enter hyperspace.

You can travel back to a sector that you have visited previously. However, the 
sector will be considered "cleared", and will likely no longer contain the 
enemies or objectives you encountered the first time you visited the sector. 
I.e. you cannot "replay" a previously-completed mission like you can in the 
vanilla HW1 and HW2 campaigns. Your progress through the galaxy is tracked in 
the map screen by coloring "visited" sectors lighter than the default dark 
color. In future versions of this mod, you will not be able to leave a sector 
using the Sector Map screen until all mission objectives and enemies have been 
cleared from the sector.

Note, when leaving a sector using an exit grid, you must dock all your ships 
manually. As of version 0.12.0, the mod is more selective about who gets to 
leave a sector and under what conditions. For instance, probes and platforms 
will not follow the mothership into hyperspace, and fighters and corvettes need 
to be docked with a capship first before the game will let you leave with them. 
Capital ships need to be selected using the mouse, and must all be located on 
top of the same exit grid. Lastly, capital ships require a hyperspace module in 
order to leave, or need to be within a certain distance of another capital ship 
with a hyperspace module. In a future version of this mod, any ships that are 
left behind may be permanently lost

On the Sector Map screen, you can see how many ships are located in each sector 
by looking at the small colored pips in the bottom-right of each cell. Red pips 
represent the enemy, yellow pips an ally, and green pips your own ships. Large 
hollow pips represent capital ships with shipholds; x-shaped pips represent 
frigates and destroyers without shipholds; slash-shaped pips represent strike-
craft that can be docked; and tiny solid pips represent probes and platforms. 
Fleets that are in transit between sectors will not be indicated using the 
pips. Instead, large yellow arrows will indicate the number and direction of 
fleets that are traveling in hyperspace.

On the Fleet Manager screen, ships are color-coded based on whether they have 
shipholds, hyperspace capability, can dock, or none of the above. For instance, 
probes and platforms are color-coded red since they cannot dock with other 
ships, or travel between sectors on their own.

Lastly, nothing in the game world happens without passing time. In the "minor" 
gametype scope where tactical battles occur, time proceeds as per normal. In 
the "major" strategic gametype scope, however, you must advance, slow down or 
stop time using the game timer in the bottom-right of the Sector Map screen. 
You can pause the timer, or speed it all the way up to 60 minutes-per-second. 
Further, as of version 0.15.0, enemy squad movements also proceed according to 
this schedule. Enemy squads are spawned every 24 hours, and move to neighboring 
sectors every few hours. If a player squad occupies the same sector as an enemy 
squad, combat will start automatically.


MODIFICATION
Persistent data is recorded in the "Bin\Profiles\(YourProfile)\TestMissionGrid" 
folder. Other configuration files can be found in the "Data\Scripts" folder.


======== ======== ======== ======== ======== ======== ======== ======== ========


CREDITS

• Siber who prodded me to continue working on this mod.
• WyvernNZ for his helpful SP Campaign Creation tutorial.
• Norsehound for the galaxy map background image.
• sastrei for tips about HODs.
• shadowwinterknig, Dom2, EatThePath, Dwarfinator and everyone else for tons of 
  scripting help on the Gearbox forums!


======== ======== ======== ======== ======== ======== ======== ======== ========


CHANGE LOG

0.15.3 - 2020/07/29
• Moved the game files to a sub-directory of the GitHub repo. Nothing else was 
  changed.

0.15.2 - 2018/03/12
• Fixed a bug with squadron lists that occurred after building the 
  "hgn_shipyard_spg".

0.15.1 - 2017/10/07
• Somehow I reverted to an older verstion of "data\defprofile\playercfg.lua". 
  It should be fixed now.

0.15.0 - 2017/09/25
• Merged the "testmissiongrid" sub-table into the "campaignTable" parent table, 
  since there's likely only going to be one campaign per mod.
• Renamed "TestMissionGrid_sectormapproto.lua" to 
  "TestMissionGrid_sectormap_proto.lua".
• Enemy and ally pips are now shown on the sector map, even if the ships are in 
  hyperspace.
• Created the "CheckForInterceptions" function so that interceptions can be 
  checked from within both the deploy and travel tasks.
• Removed the shipyard from the starting fleet.
• Enemy squadrons are now spawned at the bottom of the map every 24 hours, and 
  will wander randomly around the map until they come into contact with the 
  player's fleet and start a battle.
• Probes now cost 0 RUs to build.
• Fixed a bug in "TestMissionGrid_squadmenu.lua" that was preventing ships from 
  being properly removed from their old squad when being added to a new squad.
• Fixed the bug where the "Ready to Jump" button in the minor gametype scope 
  was still being displayed despite there being no valid or alive squads in the 
  sector.
• Fixed the bug where the game would not always exit the minor gametype scope 
  and enter the major gametype scope when all squads in the sector died or were 
  already gone from the sector.
• Moved the "Refresh" button in the minor scope squad menu from the loose ships 
  section to the main button section, and broadened its scope to include squad 
  ships as well. Ultimately, this button should be replaced with a script that 
  checks for alive and dead ships every second or so.
• Renamed all script files beginning with "TestMissionGrid_" so they start with 
  "TMG_" instead. I can have more tabs open in Notepad++ now.

0.14.2 - 2017/09/20
• Recreated the large arrow and circle graphics on the sector map in SVG. Made 
  the circle graphics a bit larger.
• The mod no longer checks for incomplete missions or local ships when deciding 
  whether to allow you to travel through a sector in hyperspace without being 
  stopped. This can be easily reverted in the code.
• Fixed the bug where the large arrows were pointing down when they should have 
  been pointing up, and vise versa. Need to make sure from now on in XnView 
  that TGA images are saved without compression, and with the "bottom up" flag 
  enabled.
• Fixed the bug in the major sector map, where the "Enter Sector" button would 
  become enabled after selecting a movement destination, regardless of whether 
  it made sense to do so or not.
• Replaced the "lastPathNode" global variable with the "lastpathnode" squad 
  table parameter. Before, things could get screwed up if you selected multiple 
  squads and then pressed the "Stop" button to return to the last-visited 
  sector.
• Split the "AreEnemiesClear" function into "AreSquadEnemiesClear" and 
  "AreLocalEnemiesClear".
• Fixed the bug where pressing the "Stop" button in the major sector map would 
  cause the game to crash if the squad was moving and more than one sector away 
  from its departure point.
• Created the "Queue_DeleteTask" function.
• Fixed the bug where the "List" buttons in the major squad menu were not 
  functioning.

0.14.1 - 2017/09/13
• Made it so that the player has to complete objectives and kill all enemies in 
  a sector before he or she can leave the sector using the sector map. The 
  player can of course still exit using the exit grids.
• Small tweaks to screens' appearances and how some screens detect whether they 
  are active or not.
• Fixed a bug where setting the destination of a path the same as the origin 
  led to weird paths.
• The mod now shows a warning and automatically enters a sector when there is a 
  mission objective or enemy in that sector.
• Fixed the bug where you could hopscotch around the galaxy map without 
  consuming any time simply by pressing the "Move To" button multiple times.
• Fully implemented the "Stop" button on the major sector map. Now you can 
  order squads in transit to reverse direction and go back to the last-visited 
  sector.
• All sector map buttons are now disabled during the time between you land in a 
  hostile sector, and the time that you are automatically sent into the hostile 
  sector to fight (or to complete a mission). This currently takes 4 seconds.
• Added the "departuretime" and "arrivaltime" parameters to squads.

0.14.0 - 2017/09/10
• Moved squad menu screen generation code from "TestMissionGrid_sectormap.lua" 
  to "TestMissionGrid_sectormapproto.lua". Moved sector map manipulation code 
  from "TestMissionGrid_gametypemajor.lua" to "TestMissionGrid_sectormap.lua".
• Fixed several bugs in the "SetUpCamera" function that were causing the mod to 
  fail.
• Fixed part of the timer text not updating consistently.
• Created the file "TestMissionGrid_globaltimequeue.lua" and moved all time-
  related code to there.
• Renamed the file "TestMissionGrid_dialoguescripts.lua" to 
  "TestMissionGrid_dialoguedata.lua" since the contents are more or less static.
• Recreated the file "TestMissionGrid_dialoguescripts.lua" and moved the 
  dialogue-related gametype code to there.
• Fixed a few mission scripts that were still trying to look for the old 
  "FlagsShips" sobgroup, which no longer exists.
• The "sectorsExplored" table is now written to 
  "TestMissionGrid_tempsectormap.lua" as well as to the regular save game file.
• You can now move across the galaxy by using the "Move To" buttons on the 
  major scope sector map! Not all sector missions have been re-tested yet, and 
  not all features have been implemented, so you can expect lots of bugs! Yay! 
  Regardless, this still represents a major milestone in the mod's history.

0.13.0 alpha 11 - 2017/09/09
• Tweaked "missionselect.lua" to make the mouse selections not visible.
• Changed the background image of the sector map.
• Made a few other cosmetic tweaks to the sector map.
• Added "data\defprofile\playercfg.lua" since you apparently can't start the 
  campaign using a new player profile without it! Sorry!!
• Reloading the game by pressing CTRL+F8 now spawns a confirmation dialog and 
  clears the temp files. This addresses a potential issue where old data (such 
  as the selected map square) could affect the game even after a reload. Tried 
  to do the same for ALT+F4 with no success.
• Added an x-shaped pip for frigates and destroyers, and a forward slash-shaped 
  pip for fighters and corvettes, to the sector map.
• Fixed (hopefully) some issues where ships were not being added to or removed 
  from a squad, or were appearing in the wrong squad, in the squad menus.
• Deleted the "exitLocations" table, and started calculating entry and exit 
  points on-the-fly based on the "exitRotations" table instead.
• Added some random perturbations to the entry points.
• Modified the camera placement script to better handle different starting 
  conditions.
• Added a "Refresh" button to the minor scope squad menu since the script does 
  not scan for newly-created or recently-destroyed ships automatically, anyway.
• Temp files are now deleted when leaving a sector in addition to when entering 
  a sector. (Just to be safe.)

0.13.0 alpha 10 - 2017/09/06
• Merged the "Rule_ProcessTimeQueue" rule into the "Rule_IncrementTimer" rule 
  since they were operating at the same time intervals anyway.
• Added the "Rule_SectorEmptied" rule to force the game to leave a sector if 
  there are no player squads in it any more.
• Updated the "Rule_SectorCleared" rule so that it can be toggled on/off 
  depending on whether new ships (e.g. reinforcements) arrive in a sector 
  before the player has a chance to leave it manually.
• Fixed backslash key not working in major scope screens.
• Fixed the bug where duplicate members of a squad were being created when 
  escaping between sectors using the exit grids.
• Removed the "selectedSectorRow" and "selectedSectorCol" parameters since they 
  were just confusing things.
• Fixed the bug where a sector map square could become stuck in the "selected" 
  or "pressed" state.
• The camera once again focuses on your ships when starting a mission.
• The game now kicks you back out to the galaxy map when you leave a sector and 
  the sector is empty of player-owned ships.
• Added code to the start of each mission that improves support for the default 
  save game system in HWRM.
• Added the screen "saveprogress.lua" as well as "Save Game" and "Reload Game" 
  buttons to the minor and major sector map screens.

0.13.0 alpha 9 - 2017/09/05
• Grouped similar squad properties together into sub-tables of the "squadShips" 
  table. For example "travel" and "tasks".
• Removed the quoted functions from the "globalTimeQueue" table. Now the table 
  just tells you which squad has a task that needs to be completed, the time 
  the task needs to be completed by, and the string name representing the task.
• The sector map no longer reloads entirely each time you click on a sector 
  square. Instead, the screen is updated dynamically and in real time.
• Tweaked the screen toggle functions and moved them from 
  "TestMissionGrid_gametypeminor.lua" and "TestMissionGrid_gametypemajor.lua" 
  to "TestMissionGrid_gametypeshared.lua".
• The squad manager and sector map screens are now reloaded automatically when 
  you switch between them.
• Switching between the squad manager and sector map using the buttons on those 
  screens now toggles the repsective buttons at the top of "newtaskbar.lua" as 
  well.
• The global time queue seems to be functioning properly. It is now possible to 
  add and remove tasks from it, and then perform those tasks. You can also once 
  again travel between sectors by moving onto exit grids. Selecting travel 
  destinations using the sector map should be possible in the next version.

0.13.0 alpha 8 - 2017/09/02
• Edited "testmissiongrid.campaign" to make it easier to switch back and forth 
  between my test level and the normal levels.
• Converted and merged most code from "TestMissionGrid_levelscripts.lua" into 
  "TestMissionGrid_gametypeminor.lua". This means I can spawn a squad at any 
  time during a mission, not just when the level is first loaded.
• Deleted "TestMissionGrid_levelscripts.lua".
• Disabled global time queue temporarily.

0.13.0 alpha 7 - 2017/08/31
• Game timer now runs in 5, 30 and 60 minute intervals in the major sector map,
  instead of 1 second, 1 minute and 60 minute intervals. 
• Game timer no longer shows the number of seconds.
• Renamed "TestMissionGrid_squadmanagement.lua" to 
  "TestMissionGrid_squadmanager.lua".
• Changed the way ships are spawned at the beginning of a mission, depending on 
  whether they are hyperspacing in, are recent arrivals, or are loose squadrons.
• Renamed several functions in "TestMissionGrid_gametypeminor.lua" to reflect 
  the above changes.
• Added the "Rule_ProcessTimeQueue" rule and "globalTimeQueue" table to track 
  when actions should occur. These are just the very first steps, though.

0.13.0 alpha 6 - 2017/08/28
• More cosmetic/useability changes to the sector map.
• You can once again click outside the sector map screen in the minor gametype 
  scope.
• Replaced the "direction", "location_row", "location_col", "destination_row", 
  "destination_col", "origin_row" and "origin_col" variables with a single 
  array of map coordinates.
• Fixed bug in level scripts that was preventing local ships from being created 
  due to a missing deprecated "inhyperspace" parameter.
• The yellow double arrows on the sector map now point inward and reflect where 
  a squad is coming *from* instead of where it is going *to*.
• Adjusted the path array so that the third variable in each node reflects what 
  direction the squad is coming *from* instead of where it is going *to*.
• Tested the mod and fixed some bugs so things should work properly once again 
  using a completely new player profile and starting from the very beginning.
• Setting the camera position now takes non-squad ships into account, too; 
  though in practice this should never happen since you can't load sectors with 
  no squads in them.
• You now start the game in the major scope sector screen instead of a battle.
• Removed the "named" player characters, as they are not needed any more. Any 
  hyperspace capable ship can now serve as a squad captain.

0.13.0 alpha 5 - 2017/08/27
• More tweaks to the sector map appearance. The movement arrows and lines texts 
  now hover above many of the other GUI elements.
• Fixed a bug in the sector map where ship pips were not being counted properly 
  when squads were spread unevenly across the table.
• Added a few extra graphics for the movement lines in the major sector map.
• The movement lines in the major sector map now only appear when you press the 
  "Move" button next to a squad. Also, all other buttons are disabled when you 
  press the "Move" button.
• Fixed the issue where the timer in the major sector map reverted to an older 
  value briefly after clicking on a sector.
• Added "Main Menu" and "Save Game" buttons on the major sector map.
• On the sector map, yellow and blue are no longer used to indicate whether you 
  have visited a sector previously any more. Instead, these colors are now used 
  to indicate a sector populated with player-owned squads.
• Map pips for capital ships and frigates are now hollow in the middle.
• Escaping out of a sector using an exit grid should be working properly again.
• Added a "writtenGameTime" parameter so I can read the game time in save games.
• Created the "IsSquadValid" function to make sure only squads in the current 
  sector are modified by the minor gametype code.

0.13.0 alpha 4 - 2017/08/24
• Cosmetic tweaks to "missionselect.lua".
• Implemented a path-finding algorithm for the sector map. You can now point to 
  a destination and a path marker will appear. In the future, this behavior 
  will only happen when a button is pressed.
• Disabled the Pause key in the major sector map. You now can pause and unpause 
  time solely using the custom game timer.
• Added buttons to switch between the squad manager and sector map in the minor 
  scope.
• Fixed a bug in the "UpdateSquadShips" function that caused the function to 
  fail when squads were spread unevenly across all twelve slots.
• Added the ship race to the ship names in "TestMissionGrid_objectdata.lua".
• Split "TestMissionGrid_gametypescripts.lua" into three files: 
  "TestMissionGrid_gametypemajor.lua", "TestMissionGrid_gametypeminor.lua" and 
  "TestMissionGrid_squadmanagement.lua". Moved a lot of code from 
  "TestMissionGrid_interfacescripts.lua" into these new files as well.

0.13.0 alpha 3 - 2017/08/22
• Game timer is now working. You can now speed up, slow down or pause game time.
• Added the "minhyperspeed" parameter to each squad, and the "hyperspeed" 
  parameter to all ships in "TestMissionGrid_objectdata.lua". These are used to 
  determine how long it takes to travel between sectors.
• Fixed a bug in "SubtractFromSquad" that prevented the function from properly 
  clearing empty squads.
• Added the "departure_time" and "arrival_time" parameters to each squad.
• Added the "CalcMinHyperSpeed" and "CalcArrivalTime" functions, as well as the 
  "baseSectorTravelTime" and "baseSectorTravelSpeed" global variables, to help 
  determine how long it takes to travel between sectors. A squad can only move 
  as fast as its slowest member. A ship with a "hyper speed" of 100 will take 
  exactly 24 hours to travel from one sector to the next. The "hyper speed" is 
  currently set to equal "thrusterMaxSpeed" in the .ship files.
• Added "Stop" buttons to "sectormapscreenmajor.lua". This will tell a squad to 
  stop moving forward and instead return to the most previous sector.

0.13.0 alpha 2 - 2017/08/20
• Updated the "GetReadyAndLeaveSector" function.
• Created the "UpdateLocalShips" and "UpdateSquadShips" functions.
• Fixed the bug in "InstaDockSquadShipsAndGiveSubs_Sub" where resting squads 
  were being despawned even though they were not supposed to be in hyperspace.
• Save games are working once again.
• You can now exit and enter the first sector. You still cannot yet move 
  between sectors, however.
• The sector map and dialogue screens no longer pause the game automatically. I 
  may reverse this change again in the future.
• Local ship pips and squad ship pips are now stored in separate tables. Only 
  squad ships determine whether you can enter or leave a sector.
• Moved several interface-related functions from 
  "TestMissionGrid_gametypescripts.lua" to 
  "TestMissionGrid_interfacescripts.lua".
• Moved custom icons from "data\ui\newui\shared" to "data\ui\newui\ingameicons".
• Renamed "sectormapscreen.lua" and "squadmenuscreen.lua" to 
  "sectormapscreenminor.lua" and "squadmenuscreenminor.lua".
• Created "sectormapscreenmajor.lua" and "squadmenuscreenmajor.lua".
• Many cosmetic changes to the sector map and squad management screens.
• Created "galaxy_map_level" dummy campaign mission.
• Fixed the bug where map exit detection was not working due to not looping 
  through all 12 squads properly.
• The game now provides hints when jumping from an exit point is not possible.
• The game now checks to make sure fleets have flagships in them before trying 
  to leave a sector.
• Added the "hyperMods" table to "TestMissionGrid_objectdata.lua" to help track 
  whether a squad is capable of leaving a sector using hyperspace.

0.13.0 alpha 1 - 2017/08/14
• Major overhaul of most of the gametype scripts. Support for multiple player-
  controlled fleets has been added. Note that traveling between sectors is 
  disabled at the moment, and will be re-implemented later.
• Created "squadmenuscreen.lua" to manage fleets.
• On the sector map screen, the "Jump" button was replaced with a (currently 
  disabled) "Leave Map" button.
• The floating "Jump" button that appears when you are on an exit grid now 
  skips the sector map screen and sends the fleet into hyperspace directly.
• Renamed "TestMissionGrid_record.lua" to "TestMissionGrid_savegame.lua"
• Renamed "TestMissionGrid_playerfleets.lua" to 
  "TestMissionGrid_initialfleets.lua".
• Renamed "TestMissionGrid_tempplayerfleet.lua" to 
  "TestMissionGrid_tempfleet.lua".
• Renamed "TestMissionGrid_missionscripts.lua" to 
  "TestMissionGrid_gametypescripts.lua".
• Renamed "sector_00" to "sector_hub_level".
• There are now two kinds of ship pips in the sector map: small and large. The 
  small ones are for strikecraft. The large ones are for frigates and capital 
  ships. I may add a third size just for frigates in the future.
• The sector map now reflects that you have visited a sector when you have 
  arrived in the sector. Before it only reflected this after you *left* the 
  sector.
• The game no longer complains about overwriting functions in "utilfunc.lua". 
  It is no longer being loaded multiple times in the same scope.
• Arrows in sector map screen are centered a bit lower than they were before.
• On the sector map, numbers now indicate how many fleets are in a sector or 
  traveling between sectors.
• Fixed the bug where jumping was possible from sections of the level with no 
  exit grid on them.

0.12.4 - 2017/08/08
• Removed some stuff I had intended for the next major release since I will be 
  developing the next version separately from this one.

0.12.3 - 2017/08/07
• The "Speech Logic", "Objectives List" and "Sector Map" screens now toggle 
  each other on and off. The Escape key still does not work with the "Sector 
  Map" screen, sadly.
• The save game file now contains a variable called "currentModVersion" that 
  should (if I am diligent about updating it) make it clear which version of 
  the mod a save game was created by.
• Fixed some capitalization issues in "missionselect.lua".
• Renamed "ingamesectorMap.lua" to "sectormapscreen.lua". Renamed a lot of 
  functions and variables to match.
• Fixed the bug where player ship pips were overlapping sector ship pips in the 
  sector map.
• Fixed the bug where pips were not being created for docked ships in the 
  sector map.
• Added support for multiple rows of pips in the sector map.
• Fixed a bug with the "squadronsize" parameter in the level scripts that was 
  preventing sector based ships from spawning.
• Some (but not all) comments are printed to the save game file now, explaining 
  what a few of the parameters mean.
• Pressing the "Jump" button in the sector map screen more than once no longer 
  causes an error.
• Added sob descriptions for the "character" ships.
• Added icons for the "character" ships.
• The dialogue screen now pauses the game and prevents mouse clicks outside of 
  the window while it is open.
• Fixed the issue where sometimes in the dialogue screen it would take several 
  clicks for the button event to fire, even though you could see the button 
  change color and hear the sound effect.
• Dialogue text can now contain quotation marks. I used this to distinguish 
  between words that are meant to be spoken aloud and words that are meant to 
  be descriptive.
• Added descriptive flavor text to the dialogues.
• The game now stores past dialogues in a variable. I haven't figured out how I 
  want to display this "history" to the player.
• Added partial support for displaying a history of past dialogues. There 
  remain a number of unresolved issues, however, such as how to scroll a GUI 
  frame, or make the contents of the frame hug the bottom. As a result, this 
  feature is currently mostly disabled.
• Renamed several dialogue-related global variables and functions.

0.12.2 - 2017/08/05
• Enabled "StyleSheetTestScreen" via the main menu.
• Renamed the mod folder from "DataTestMissionGridHWRM" to just 
  "DataTestMissionGrid". You will need to update your desktop shortcuts!
• The starting ships are now "characters" named "Commander Athshe", "Commander 
  Gethen" and "Karan S'jet".
• Removed the "squadronsize" and "canhyperspace" parameters from the 
  "playerShips" and "sectorShips" tables. A better place for these parameters 
  is in the "objectdata" table in "TestMissionGrid_objectdata.lua".
• The "Jump" buttons are now disabled (but are still visible) if your selection 
  contains ships that cannot hyperspace or are not within range.
• Bound the sector map screen and button to the backslash key.
• Fixed a bug in the "SobGroup_IsSobGroupOnExitTile" function that was causing 
  the game to detect exiting ships improperly.
• The in-game sector map now pauses the game and fills the entire screen in 
  order to block clicks and prevent the player from inadvertently changing his 
  or her selection. This works with ship groups as well.
• Changed the enemy ship in Sector A4 from "vgr_battlecruiser" to "kpr_sajuuk".

0.12.1 - 2017/08/03
• Reverted the sector map arrows back to 1/3 the size of a cell instead of 1/4.
• Added sound effects when opening and closing the sector map and dialogue 
  screens.
• Moved some shared GUI behaviors to a new file called 
  "TestMissionGrid_interfacescripts.lua".
• The game now tracks/records what larger ships other smaller ships are docked 
  to. I made some of the code more modular in the process.
• The game now tracks/records the rotational values of ships when leaving a 
  sector. If you come back to a sector later, the ships in that sector will be 
  positioned and rotated by the same amounts as when you last visited the 
  sector.
• The game now tracks/records subsystems on non-player ships as well.

0.12.0 - 2017/08/01
• Fixed the bug where players' shipholds were permanently set to "Auto Launch".
• Hyperspacing between sectors is now disabled completely if the mothership is 
  unable to hyperspace by itself. In the future, every capship should be able 
  to lead a small fleet of strikecraft and frigates into a neighboring sector.
• The mod is now more selective about who gets to hyperspace away from a sector 
  and who does not. For instance, probes and platforms will not follow the 
  mothership into hyperspace, and fighters and corvettes need to be docked with 
  a capship first. Further, capships need to be selected using the mouse, and 
  must be located on top of an exit grid before they are allowed to leave the 
  sector. Lastly, capships require a hyperspace module, or need to be within 
  reach of another capship with a hyperspace module in order to travel. (I need 
  to double-check "data\scripts\scar\singleplayerhyperspace.lua" to see how 
  Gearbox juggled all the conditions for hyperspacing, though. I think there 
  are more complications than I am aware of right now.)
• The mission and level scripts now at least try to track whether a ship is in 
  hyperspace or docked before writing to the save game. Prior to this I was 
  using the "Player_Ships<n>" sobgroups and the "SobGroup_SplitGroupFromGroup" 
  function to keep track of my fleet. Now I am using the "SobGroup_Seperate" 
  function by shadowwinterknig, which is a lot easier.
• Added little pips to the sector map representing ships stationed in each 
  sector. Red represents the enemy, yellow represents an ally, green represents 
  your own ships. In the future these will belimited to adjacent sectors, only.

0.11.2 - 2017/07/31
• Fixed a bug in Sector C1 that caused the resource collector to be given to 
  the wrong player.
• In Sector D1, the captured ship is now automatically transferred to an allied 
  player, since the captured ship is of the wrong race to be of real use to the 
  player anyway.
• The exit grids are now semi-circular instead of square. I also had to locate 
  the exit grid collision mesh farther away from the map center, because it was 
  causing the mothership to jump out of hyperspace at odd locations.
• Fixed issue with the camera acting weird when it comes into contact with the 
  coordinate axes model I created. I added a very small collision mesh to re-
  place the bounding box that was apparently being used instead by default.
• Changed map center ID to #5 instead of #0 to make some loops through tables 
  less complicated.
• Objectives now appear as completed in the Objectives screen when entering a 
  cleared sector.
• Created "extra_test_level" for testing, but it is disabled by default. Edit 
  "testmissiongrid.campaign" to enable it again.
• Removed the coordinate axes model from Sector A1 and instead put them in 
  "extra_test_level".
• Fixed an issue with the function that tracks whether you are sitting on an 
  exit grid or not. The script was unable to handle situations where you moved 
  from one exit directly to another, with no blank space between.

0.11.1 - 2017/07/28
• Mission scripts now retrieve some mission-related text strings automatically 
  from "TestMissionGrid_campaigndata.lua".
• Added row and column headers to the map in "missionselect.lua". Fixed a small 
  issue with the placement of the blue sector headers.
• The game now shows time in days, hours, minutes and seconds. It is shown in 
  the frontend menu as well, though time does not yet progress there.
• Stretched the galaxy background image to make it more circular instead of 
  elliptical.
• Split the sector map generation code into "TestMissionGrid_sectormap.lua" and 
  made the map visible in-game as well. I may make it so that hyperspacing is 
  triggered from this screen in a later update.
• Pressing the "Jump" button takes you to the sector map screen where a second 
  "Jump" button triggers the actual jumping.
• On the sector map screen, you can now see a pair of arrows pointing to your 
  hyperspace destination. For the time being, these arrows are only displayed 
  when you are sitting on an exit grid, and the map itself remains non-
  interactive.
• Removed the "canhyperspace" ship parameter and started replacing the code 
  that checks this parameter with calls to the "SobGroup_FilterInclude()" and 
  "SobGroup_FilterExclude()" functions. This makes sorting ships that can and 
  cannot hyperspace a lot simpler. More work needs to be done when ships are 
  leaving a sector too.
• Added a "Choose A or B" dialogue option to the Sector D3 dialogue scripts.
• You can now initiate dialogue only if you are within 10k meters of the target 
  ship. The dialogue window now will also disappear if you exceed that distance.
• Added a "Cancel" dialogue option so that players can close the window without 
  making a choice.
• Added some fake text to the dialogue screen in a different color that is 
  meant to represent lines spoken in the past. I'm not sure I want to keep this 
  feature, however. Right now it's just a mockup.
• The main button in "missionselect.lua" now says "START" if a new campaign is 
  started, and "CONTINUE" if there is a save game and the player is continuing 
  a campaign.

0.11.0 - 2017/07/27
• Enemy and allied ships are persistent now, meaning that if you leave a sector 
  and return later, the alive ships will still be there. I still need to do the 
  same for player-owned ships that are not accompanying the mothership as it 
  travels between sectors.
• Created "TestMissionGrid_playerfleets.lua" to store the initial state of the 
  sector fleets. It contains three tables: "playerShips", "sectorShips" and 
  "sectorSobgroups". I'm still not quite sure the method I chose for tracking 
  sobgroups is a good one, but I haven't been able to think of anything better.
• Added a hyperspace animation for when leaving a sector to proceed to the next.
• Deleted some old backup GUI files that are no longer needed.
• Removed some screen elements from the dialogue screen that are no longer 
  needed.
• Fixed a bug I introduced in Sector D3 when I swapped it with another sector. 
  Dialogues in Sector D3 should progress properly once again.
• The dialogue button text now wraps properly thanks to shadowwinterknig. I 
  also made some tweaks to the demo test buttons.
• The save game is now written line-by-line instead of as one giant string. I 
  changed this because I believe there is a limit on string sizes in Lua, and 
  the amount of data being saved keeps growing.
• Renamed the script file "TestMissionGrid_printtables.lua" to 
  "TestMissionGrid_writetables.lua" since nothing is being printed to the log 
  file.
• Renamed the "currentMissionRow" and "currentMissionCol" global variables to 
  "currentSectorRow" and "currentSectorCol" since they track the sector you're 
  in and not the mission you've completed.
• The table "objectdata" no longer sorts ships by race since it is possible to 
  acquire ships from multiple races. I may need to revert this change and 
  implement something different in the future.
• Added several new parameters to mission scripts to make organizing mission 
  description strings easier.
• Added a new mission to Sector A4 that demonstrates the new persistent fleets 
  by telling the player to avoid the battlecruiser in the center of the map and 
  proceed to an exit grid. The battlecruiser should remain in that spot if the 
  player travels to the sector again in the future.

0.10.6 - 2017/07/25
• Bug in missions looking for "MS_StartGroup" which was renamed to "sobg_strt".
• Instead of hyperspacing automatically when the player reaches an exit grid, a 
  button now appears on the screen prompting the player to do so his or herself.
• Renamed "sectorText" variable to "sectorCode" since it consists of a two-
  digit code.
• Other minor tweaks to the save game format.
• The dialogue screen now uses "MainUI_ScarEvent()" to signal that a dialogue 
  response button has been clicked. This is instead of the old rule that polled 
  the button's status continuously.
• Switched sectors D3 and A4.
• Checked each level to make sure mission-related player ships are spawned in 
  the level file instead of built via the gametype script.
• Changed ownership of some mission-related ships from the player to the 
  player's ally.
• Other small tweaks to ship placement in level files.

0.10.5 - 2017/07/23
• Exit grids now are only visible from within sensors manager.
• Moved the functions "SpawnEntryPoints()" and "SpawnExitPoints()" from within 
  each level file to "TestMissionGrid_levelscripts.lua".
• Ship spawning when entering a map now uses hyperspace effects, but it's still 
  not perfect.
• Player fleet spawning is done in the level files once again instead of in the 
  gametype script. I may reverse this again in the future.
• I am using a generic table printing function to write the save game tables to 
  the save game instead of parsing each table individually.
• The camera position is now set explicitely at the beginning of each mission.
• Added the "canhyperspace" and "squadronsize" parameters to the "playerShips" 
  and "objectdata" tables. These are needed for the new ship spawning routines.

0.10.4 - 2017/07/22
• Map grid is now the same size and aspect ratio on all display resolutions. 
  Previously, the map was squished unless the aspect ratio was 16:9. This may 
  mean the map is too small on 4K or larger monitors, however. If there's a way 
  too scroll the menu frames in HWRM it might help.
• Incorporated the quest and dialogue systems from my "Dialogue Menu Demo" mod 
  for HW2C. Added a new mission to demonstrate them. Switched over to this 
  system for tracking completed missions.
• Switched over to using the questsStatus system for most mission-related stuff.
• Added some extra empty mission to fill out the grid so that it is a square.
• The dialogue button's text is now updated dynamically based on the actor.
• The actor's name now appears in the dialogue window.
• Fixed typos in several level file names.
• Switched places of sectors D3 and D4 on the map.
• Added a third player for allied ships that need to be defended, for instance.
• Sector C1 no longer steals all your RUs before beginning the mission.
• Centered the positions of several ships since the player no longer spawns in 
  the middle of the map.
• Sector D4 (the "Veil of Fire" mission) should work properly once again.
• Switched to using "sectorName" instead of "sectorCode" where appropriate.
• Several sectors such as Sectors D1 and A2 needed some pings since the player 
  no longer spawns in the middle of each map.
• All of the mission scripts now briefly describe the mission in comments begin-
  ning on line #1.
• Some small adjustments to make the sector map look a little prettier.

0.10.3 - 2017/07/20
• Centered the map grid in "missionselect.lua", and put the buttons on the 
  right side of the screen instead of the bottom.
• Was sending players to the wrong sectors after landing on the exit grids!
• The player now spawns toward the part of the map in the direction the player 
  traveled from. In the first sector the player still starts out in the middle 
  of the map, however. Proper ship rotation is disabled until I find a nicer 
  way of spawning ships from hyperspace.
• Sector name and other string capitalization fixes.
• The check for whether the player fleet has landed on an exit grid now occurs 
  more frequently.

0.10.2 - 2017/07/19
• Removed the "PLAYER VS CPU" button from the main menu.
• Added pink semi-circular "exit grid" model. It is supposed to be 50% trans-
  parent, but isn't currently. Need to figure this out.
• The game now checks whether you have landed upon a large exit grid when deter-
  mining whether to send you on to the next sector. Previously, the game 
  checked whether you were inside a small sphere.
• Replaced "Mission_01", "Mission_02", etc. with "Sector_A1", "Sector_B1", etc.
• Replaced "Ascension" with "TestMissionGrid" in file and folder names.
• Switched to two-dimensional tables instead of one-dimensional tables to track 
  sectors visited, etc.
• Mission briefings no longer refer to mission numbers but to sector addresses 
  instead.

0.10.1 - 2017/07/18
• Fixed bug preventing players from starting a new game!
• Added experimental coordinate axes model.

0.10.0 - 2017/07/14
• Ported the mod from HW2C to HWRM.
• Since I no longer can make use of the "persist" Lua files in the player 
  profile (due to the HWRM 2.0 patch limiting where you can and cannot write 
  files to), I had to roll my own. This required a lot of work! Luckily, 
  Gearbox added a function to check which subsystems are installed on a ship. 
  Otherwise, this transition would not have been possible.
• The mod now also re-uses the same campaign mission file over and over again, 
  but still reads the other missions dynamically using `dofilepath`.
• Tweaked the main menu, hiding some buttons, renaming others.
• Converted the galaxy map from ROT to TGA format since HWRM no longer supports 
  ROT images.
• Moved most configuration files to the same folder and renamed them to be 
  consistent.

0.9.5 - 2016/05/31
• Replaced the "GetHW2Path" function with a simple relative file path. Thanks 
  to Dwarfinator for the idea. So simple!
• I made the table in "ascension.campaign" very large using a loop, and 
  populated each one with a copy of the dummy level.
• As a result of the above two changes, the game no longer switches to desktop 
  temporarily when searching for the HW2 path, and no longer kicks the player 
  to the main menu between missions. Yay!

0.9.4 - 2016/05/31
• Each map displays a different background HOD now.
• The "Reset" button in "missionselect.lua" is now disabled since it will lock 
  up the game if clicked on if left enabled.
• Added "keeper.txt" because, depending on how the mod is loaded, it may be 
  needed to get the mod to load.
• This is the first version to appear on Steam Workshop.

0.9.3 - 2011/01/21
• Added the galaxy background by DatonKallandor. You can now configure whether 
  to use thumbnails for each mission, the campaign as a whole, or both. The 
  default example uses a background for the campaign only.
• The campaign menu background frame was being placed on top of the thumbnails, 
  causing the thumbnails to appear washed out.

0.9.2 - ????/??/??
• I've switched to using the existing setMissionComplete() function and 
  persistN.lua files in order to make use of the existing persistent fleet 
  system. This makes things a whole lot simpler, and means that things like 
  subsystems are now saved properly. However, unfortunately it also means that 
  players are now kicked back to the main game menu at the end of each mission, 
  which is something I haven't found a way to prevent yet.
• Buttons in MissionSelect for sectors other than the current one are now 
  disabled and do nothing when pressed.
• Removed StyleSheetTestScreen from the main menu, as it serves no purpose 
  being there.
• Disabled the TUTORIAL button in the main menu.
• Moved "MissionGrid_record.lua" to "Homeworld2\Bin\Profiles\<your profile>\
  Campaign\ASCENSION".

0.9.1 - ????/??/??
• Fixed the bug in mission 2 where the exit portals would not appear when 
  revisiting the sector.
• Fixed the bug in mission 6 where the player wasn't being given sufficient 
  ships to kill the enemy subsystem.
• Fixed the bug that was causing all missions with enemy AI to crash the game.

0.9.0 - ????/??/??
• Changed things so the mod overrides the Ascension (i.e. singleplayer) 
  campaign. As a result, the Start Mission button can now be re-used.
• Adapted the zoning and level loading systems from my Non-Linear mod. Now it 
  is possible to load arbitrary or non-sequential missions using gamerule and 
  level scripts. However, the existing reference and reactive fleet systems can 
  no longer be used, nor the existing save functions.
• Updated the MissionSelect screen and the Postmortem campaign to make use of 
  all the new features. Overall, things are working pretty smoothly now.

0.5.0 - ????/??/??
• Initial release for HW2C.


======== ======== ======== ======== ======== ======== ======== ======== ========


TO DO

• Curved exit grids should be smoothened a bit by adding more polygons.
• The hyperspace animation can take a long time to trigger if your ships are in 
  motion and need to come to a complete stop first before firing the animation. 
  Often it can take as long as or longer than 10 seconds, and could mean some 
  of the your ships will get destroyed in the meantime, but not recorded as 
  such by the game.
• Using an instant dock or parade maneuver may make the hyperspace effects look 
  better, but it does not make sense if you believe that all actions should 
  take a realistic amount of game time to complete.
• The styles used in the dialogue and sector map screens are outdated an look 
  too much like Relic's HW2C instead of Gearbox's HWRM. The styles need to be 
  updated to HWRM standards.
• Neither the default "SpeechRecall" screen nor this mod's "SectorMap" screen 
  can be closed by pressing the Escape key. Need to fix this with custom code.
• All ship and subsystem construction, as well as resource gathering, should 
  occur on the strategic map only, and should happen over much longer time 
  spans. The exceptions could include the collection of end-of-battle debris, 
  the construction of probes, and maybe the construction of platforms or other 
  ships that don't dock.
• Adapt "data\scripts\scar\singleplayerhyperspace.lua" to this mod if possible 
  and use it to handle arriving at and leaving sectors. Need to check the 
  remastered HW1C campaign to see how the game handles insta-docking and 
  hyperspacing at the end of each mission. This is a very, very complicated 
  script, however.
• On the sector map, limit the colored pips to sectors adjacent to the player.
• In "TestMissionGrid_gametypescripts.lua" there is some code right before the 
  game is ended that should be done via the event system instead of directly.
• Need a rule in every sector that ends the game and displays a message if the 
  player manages to somehow die. Currently, only the Sector D4 skirmish mission 
  checks if the player is alive or dead. Putting this code into the major scope 
  would be okay too.
• Outputted "squadShips" and other tables should contain comments that label 
  each sub-table to make it easier to see which sub-table belongs to which map 
  sector. Currently, this cannot be done using the table manipulation functions 
  I am using.
• I could create a wrapper for printing debug text that could be turned on or 
  off at will. It could utilize indentation as well.
• The floating dialogue and hyperspace buttons should be mapped to keyboard 
  keys. But which keys?
• You should be able to select a dialogue response using a number key on your 
  keyboard.
• Need a better way to indicate visually who is and who is not an actor for the 
  purposes of initiating dialogue. It was suggested on the Gearbox forums that  
  one could use FX scripts to accomplish this. Only "named" ships would require 
  these FX scripts, so it wouldn't add a whole lot of extra work to accomplish. 
  Unfortunately, FX are not visible in Sensors Manager.
• The dialogue response container element should have a scrollbar in case there 
  are a lot of responses, or a few very lengthy responses. Not sure if this is 
  possible, unless I switch to using ListBox GUI elements instead of Frames.
• Need to fix the "aitrace('CPU: LOADING SECTOR 05')" command for all sectors. 
  Right now the message is the same for all sectors when it should be different.
• Will constantly reloading a single mission with different objects and data 
  cause the game to run out of memory eventually? I recall something like this 
  happening in my Play Balancing mod, and it was a critical issue that event-
  ually caused my PC to become unresponsive and the game to crash! HWRM is a 
  32-bit application and unfortunately cannot access as much RAM as many other 
  recent games. Actually, I think I remember that the memory issues only 
  occurred when *not* reloading the game, and spawning many ships in the same 
  battle.
• For level files, maybe put the "DetermChunk" and "NonDetermChunk" functions 
  into "sector_hub_level.level", and only store the supplementary scripts in 
  the other sectors' folders. Or, put all map data into one giant table, and 
  then get rid of the other sector folders. Ditto for the "OnInit" function 
  inside the mission scripts.
• Exit grids are visible at all times during a battle. Is there a way to make 
  them disappear until they are needed? Or, appear only once a mission is 
  completed? Can I make them blink on and off?
• Text descriptions of sectors on the sector map should reside in tooltips or 
  some other auxiliary display. Otherwise, if a the map has many sectors, it's 
  going to be really hard to display all the text in each cell.
• The "RESET" frontend menu button should ideally delete the custom save game 
  so that players can start the campaign over from the beginning. Sadly, the 
  necessary I/O functions don't seem to exist within the GUI scripting scope.
• Exit grids are supposed to be semi-transparent but aren't. Need a new shader 
  for this. Someone on the Gearbox forums volunteered to make one for the mod.
• Loading of regular saved games seems to work correctly, except for the non-
  determchunk portions of level files. For instance, the wrong level background 
  and music (NonDetermChunk) can get loaded, but asteroids and ships 
  (DetermChunk) get spawned in their correct positions. [Ed. This may no longer 
  be true. Also, additional work may need to be done to create a custom save 
  game management system.]
• There is no way to track asteroid depletion on a per-asteroid basis. So, 
  either I need to set each asteroid to infinite (or very large) RU amounts, or 
  I need to remove resource collection from the game entirely and rely on other 
  methods of providing the player with funds and equipment.
• Add a "And this is how the story ends, children..." vignette at the end 
  featuring the Bentus as "narrator" of a story. (Sort of like in Mad Max 
  Beyond Thunderdome.)
• Remember to always check and make sure the skirmish mission in Sector D4 ends 
  properly for both the winners and the losers.
• The new circular exit grids have a tendency to disappear if you move the 
  camera far from the map center. I'm not sure how to fix this without just 
  translating the same problem to a different set of coordinates.
• Small ships like probes, platforms and fighter craft should maybe not survive 
  after being left behind in a sector unless a capship with a shiphold remains 
  in the sector along with them.
• Dialogue does not advance properly when the game is paused. Need some way to 
  detect the selected ship while the game is paused. As a stop-gap measure, I 
  have disabled clicking outside the dialogue screen boundaries while the 
  dialogue screen is active.
• The dialogue window should show a record of past dialogues, as well. However, 
  I don't know how to display the speech "log" to the player. I haven't been 
  able to get a GUI frame to sort backwards or align to the bottom, which I 
  believe is important.
• The "onUpdate" GUI event fires even while the game is paused. This could 
  eliminate the need to force the game to pause or block mouse clicks during 
  dialogue.
• Maybe rename Direction #0 to Direction #6 for ships that just sit in a sector 
  instead of hyperspacing in. This will cause problems, however, if I decide at 
  some time to implement hexagonal map sectors, or an irregular network of 
  sectors, instead of square ones.
• When there are multiple squads exiting at Direction #5 (the map center), some 
  of them get spun around 180 degrees for some reason. However, only capships 
  with strikecraft in their holds seem to be affected. This also seems not to 
  affect the other directions. Is this the result of the game automatically 
  trying to avoid ship collisions when spawning ships?
• Ship health should persist between sectors, too. OTOH, sufficient game time 
  may be spent in hyperspace that the ships may be able to heal themselves in 
  the interim. Do ships heal in hyperspace in the vanilla game?
• Update the keyboard diagram with SHIFT + 1 to 10, which adds ships to a 
  selection.
• Reloading the Mission Select screen somehow changes the campaign that is 
  loaded, and sometimes causes the game to crash. Need to remove the Reload 
  Screen button from this screen!
• Maybe strike craft, probes and so forth should not be considered part of a 
  squad, at all. Maybe it should not matter who they are docked to. E.g. treat 
  them sort of like equipment and weapons in JA2.
• Flagships that leave a sector and enter hyperspace still show up in the build 
  and research menus when they shouldn't. Killing them could fix this, but may 
  cause other problems. For instance, killing a ship while it is in hyperspace 
  normally can be seen and heard, and leaves behind debris.
• Double-check to make sure Sector D3 dialogues still work after every major 
  change to the mod.
• Squads should be given jobs to perform on the sector map, such as resource 
  collection, ship construction, patrols, etc. The galaxy map should be the 
  only place these tasks can be performed, versus doing them during combat. 
  RTT gameplay may be preferable to RTS gameplay in general.
• In the future, I may upgrade the path-finding routine to A*. I may also add 
  different types of terrain (e.g. faster, slower, radioactive, etc.) instead 
  of just "Empty" and "Obstacle".
• Maybe add support for diagonal movement on the sector map.
• Add support for setting waypoints on the sector map.
• The game by default seems to remember the order in which windows were opened, 
  and closes them in the reverse order. I will have to emulate this behavior 
  somehow too, as opposed to just closing them all at the same time with just 
  one key press.
• Squads should maybe never arrive at the center of a sector. Instead, they 
  should maybe always arrive at a sector's edge, no matter what.
• Go back and double-check that the function parameters in 
  "TestMissionGrid_writetables.lua" are doing what I intended them to do.
• May need to roll my own save game management system, since the game's default 
  save game system does not mesh perfectly with the mod. I think I will need to 
  use a fixed number of save slots, since I cannot simply scan a directory for 
  files.
• Set "baseSectorTravelMulti" back to 100, then add another higher game time 
  rate to the game time scripts. 120 or 240 minutes per second might be good 
  additions.
• Should create sprite sheets out of the many images I created for the sector 
  map.
• The "Loose Ships" list in the squad menu is not populated automatically each 
  time a ship is built or destroyed. My current solution was to add a "Refresh" 
  button to indicate this to players.
• Not being able to edit squads in the major scope is a PITA if you happen to 
  clear all squads in a sector, and are no longer able to enter the minor scope 
  there until you transfer additional squads.
• It would also be great if you could add and remove ships from squads in the 
  listboxes using the mouse. But there's no reliable way to uniquely identify a 
  ship once it's been built, AFAIK.
• I am not very sure that the "ReloadVisibleScreens" function in 
  "TestMissionGrid_gametypeshared.lua" is working properly. Sometimes it seems 
  to fail.
• I have not fully tested what happens to the mod when one or more ships in a 
  squad are destroyed or captured.
• Maybe add a checkmark or other indicator to show when the main mission in a 
  sector has been completed. On the other hand, you can't leave a sector until 
  you've completed the mission. Maybe this is enough indication?
• Still need to make room for departure and arrival times on the sector map and 
  squad menu screens.
• The squad lists/menus should show the speed of each squad as well. Not all 
  squads are capable of the same max speeds.
• I thought I noticed an issue with some squads moving too quickly across the 
  galaxy following combat or some other scripted event, but I have not been 
  able to reproduce it.
• RUs should be calculated for each squad separately. But how do I do this when 
  there is more than one squad in a sector, and all squads are collecting RUs? 
  The solution is probably to disallow RU collection in the tactical scope, and 
  only allow it in the strategic scope.
• The AI should definitely not be able to build ships while in tactical scope 
  considering it does not know how to add or remove them from a squad.
• Small and decimated enemy squads should join together to form fewer but much 
  larger squads.
• Need some sort of arrow to indicate enemy squadron movements, since right now 
  they are shown as occupying a sector even when they have not fully arrived at 
  the sector yet.
• The "the sector is cleared..." message needs to be changed to indicate it is 
  only cleared of missions, not of potential enemies such as roaming squads.
• The script to trigger the "warning" icon when combat is about to start is 
  firing too early sometimes, i.e. before both squads are "fully" in the sector.
• I wanted to create a unified interface for both the minor (i.e. tactical) 
  scope and the major (i.e. strategic) scope, but came up with some good 
  reasons why I can't manipulate squads in the major scope. I just can't recall 
  right now what those reasons were. :( One reason might have been that making 
  the ship list in the squad menu interactive (e.g. click on a list item to 
  select a ship) would be extra work. Further, you can't link actual ships with 
  the items in the ship list in the minor scope. Or, at least, I have found no 
  reliable to method to do so. But I don't recall if that was the main reason.
• Save games don't seem to load properly after copying a player profile from 
  one person's computer to another. Need to investigate this.
