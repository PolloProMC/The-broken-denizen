nullexist:
    type: world
    debug: false
    events:
        # ------------- Initial setup. -------------
        on server start:
        - execute as_server "op Integrity"
        - yaml create id:serverproperties
        - yaml id:serverproperties set "K̸̜̦̀͋̋̑́̌Ĩ̷̘͎̑̽̅̕L̷̛͉̉̊́̌̒ͅL̴̫̩̓̈̍̕͝ ̶̡̣͕̠̮̑̊͑̍̈́H̸̢̻͉̗͈̃̾̆̂̈́Ì̵̯̕M̵͙̞͌̐̊͆:true"
        - yaml savefile:serverproperties.txt id:serverproperties

        on delta time secondly:
        # ------------- Null watch (unused) -------------
        - if <server.has_flag[null]>:
            - if !<server.has_flag[nullwatch]>:
                - execute as_server "teleport <server.flag[null].uuid> ~ ~400 ~"
        # ------------- Clan_Void (unused) -------------
        - foreach <server.online_players_flagged[whereiwas]> as:wherei:
            - if !<[wherei].has_flag[iamhere]>:
                - teleport <[wherei]> <[wherei].flag[whereiwas]>
                - wait 1t
                - flag <[wherei]> whereiwas:!
                - execute as_server "gamemode survival <[wherei].name>"
        # ------------- Sub Anomaly 1 -------------
        - if <server.has_flag[blackthing]>:
            - foreach <server.flag[blackthing]> as:thething:
                - execute as_server "execute as <[thething].uuid> at @s run tp @s ^ ^ ^0.5 facing entity @a[limit=1,sort=nearest] feet"
                - while <[thething].location.block.below.material.name> == air:
                    - teleport <[thething]> <[thething].location.below[1]>
        # ------------- Failsafe -------------
        - if <server.has_flag[null]>:
            - if !<server.flag[null].location.exists>:
                - execute as_server "nullleave silent"
                - wait 3s
                - execute as_server "nulljoin silent"
        # ------------- R2 -------------
        - if <server.has_flag[r2]>:
            - foreach <server.flag[r2]> as:r2:
                - if <[r2].has_flag[chaser]>:
                    - execute as_server "data modify entity <[r2].uuid> AngryAt set from entity <[r2].location.find_entities[player].within[100].get[1].uuid> UUID"
                    - execute as_server "effect give <[r2].uuid> minecraft:speed infinite 2 true"
                    - adjust <[r2]> has_ai:true
                    - wait 0.5s
                    - adjust <[r2]> has_ai:false
                - if <[r2].has_flag[r2angy]>:
                    - adjust <[r2]> has_ai:true
        - if <server.has_flag[triggeredr2]>:
            - if <util.random_chance[18.21]>:
                - execute as_server <list[nulltimeset day|nulltimeset midnight].random>
        - foreach <server.online_players_flagged[theangryone]> as:angry:
            - flag <[angry]> r2despawn:++
            - if <[angry].flag[r2despawn]> >= 40:
                - teleport <[angry].flag[theangryone]> <[angry].flag[theangryone].location.below[100]>
                - kill <[angry].flag[theangryone]>
                - teleport <[angry].flag[theangryone].flag[thearmor]> <[angry].flag[theangryone].flag[thearmor].location.down[400]>
                - kill <[angry].flag[theangryone].flag[thearmor]>
                - flag <[angry].flag[theangryone]> thearmor:!
                - flag server r2:<-:<[angry].flag[theangryone]>
                - flag server triggeredr2:!
                - flag <[angry]> theangryone:!
                - flag <[angry]> r2despawn:!
        # ------------- Circuit -------------
        - if <server.has_flag[circuitnull]>:
            - if !<server.has_flag[circuittimedeath]>:
                - flag server circuittimedeath:0
            - flag server circuittimedeath:++
            - if <server.flag[circuittimedeath]> == 25:
                - execute as_server "nullnocircuit"
        # ------------- False villager -------------
        - if <server.has_flag[unsusvillager]>:
            - heal 20 <server.flag[unsusvillager]>
            - flag server falsegoneforever:++
            - if <server.flag[falsegoneforever]> >= 900:
                - execute as_server "nullnofalsevillager"
        - if !<server.has_flag[unsusvillager]> && <server.has_flag[circuitattacker]>:
            - flag server circuitdespawn:++
            - if <server.flag[circuitdespawn]> >= 70:
                - execute as_server "nullnofalsevillager"
        # ------------- No peaceful difficulty & No circuit disguised. -------------
        - foreach <server.online_players> as:player:
            - if <[player].location.world.difficulty> == Peaceful:
                - adjust <[player].location.world> difficulty:Easy
            - if <[player].location.y> < -50:
                - execute as_server "effect give <[player].name> minecraft:blindness 3 255 true"
        - if <server.has_flag[circuitdisguised]>:
            - flag server despawnthedisg:++
            - if <server.flag[despawnthedisg]> >= 150:
                - execute as_server "nullnodisguisedcircuit"
        # ------------- Null chase. -------------
        - if <server.has_flag[nullchaser]>:
            - foreach <server.flag[nullchaser]> as:chaser:
                - flag <[chaser]> despawnmelol:++
                - if <[chaser].flag[despawnmelol]> >= 22:
                    - teleport <[chaser]> <[chaser].location.below[400]>
                    - kill <[chaser]>
                    - wait 1t
                    - flag server nullchaser:<-:<[chaser]>
        # ------------- Nothingiswatching chase. -------------
        - if <server.has_flag[nothingchaser]>:
            - foreach <server.flag[nothingchaser]> as:chaser:
                - flag <[chaser]> despawnmelol:++
                - if <[chaser].flag[despawnmelol]> >= 40:
                    - teleport <[chaser]> <[chaser].location.below[400]>
                    - teleport <[chaser].flag[litnothing]> <[chaser].location.below[400]>
                    - kill <[chaser].flag[litnothing]>
                    - flag <[chaser]> litnothing:!
                    - kill <[chaser]>
                    - wait 1t
                    - flag server nothingchaser:<-:<[chaser]>
        # ------------- Null Invade base -------------
        - if <server.has_flag[nullinvaders]>:
            - foreach <server.flag[nullinvaders]> as:invader:
                - flag <[invader]> itsdespawntime:++
                - if <[invader].flag[itsdespawntime]> >= 250:
                    - teleport <[invader]> <[invader].location.below[400]>
                    - kill <[invader]>
                    - wait 1t
                    - flag server nullinvaders:<-:<[invader]>
        # ------------- Handle events and reputation. -------------
        - if <server.has_flag[null]>:
            - if !<server.has_flag[reputation]>:
                - flag server reputation:NORMAL
            - if !<server.has_flag[eventnull]>:
                - flag server eventnull:0
            - flag server eventnull:++
            - if <server.has_flag[notimedevents]>:
                - stop
            - if <server.online_players.size> == 0:
                - stop
            - if <world[world].is_day>:
                - define eventsperminute 0.583
                - if <server.flag[reputation]> == BAD:
                    - define eventsperminute 0.833
            - else:
                - define eventsperminute 0.917
                - if <server.flag[reputation]> == BAD:
                    - define eventsperminute 1
            - if <util.random_chance[<[eventsperminute]>]>:
                - define randomevent <list[nullwatch|nullsong|nullsteps|nulltitle|nullpotion|nulladvancement2|nullgoaway|nullhappyface|nullopengl|nullfall|nullhost|nulljumpscare|nullbreak|nullrandomlook|nullinventory|nullgoodluck|nullplaysound|nullbook|nullslowsong|nullfire|nulldisc11|nullfaraway|nullfreezetime|nulllightning|nullfalsevillager|nullbsod|nullflying|nullcircuitdisguised|nullnamemob|nullcircuit|nullstructure|nullrandomtext|nullwater|nullhungry|nulldenizenwarning|nullheartbeat|nulldoors|nullplacehello|nulljframe5|nullplacebase|nullinvadebase].random>
                - if <server.has_flag[nulldebug]>:
                    - narrate "Event happening! average events per day is on: <[eventsperminute].mul[12].round>, current event <[randomevent]> and reputation is <server.flag[reputation]>" targets:<server.online_ops>
                - execute as_server <[randomevent]>
                - if <server.flag[reputation]> == GOOD:
                    - define maybechest <util.random_chance[10]>
                    - if <[maybechest]>:
                        - execute as_server nullgift
                - define chance <util.random_chance[20]>
                - if <server.flag[reputation]> == BAD:
                    - define chance <util.random_chance[50]>
                - if <[chance]>:
                    - define randomentity <list[nullr2|nullblackthing|nullfaraway].random>
                    - execute as_server <[randomentity]>
                    - if <server.has_flag[nulldebug]>:
                        - narrate "Oh no! an entity, current entity: <[randomentity]>" targets:<server.online_ops>
            - if <server.flag[eventnull].mod[600]> == 0:
                - flag server reputation:<list[GOOD|NORMAL|BAD].random>

        on entity transforms:
        # ------------- Prevent null from transforming if he's struck by lightning -------------
        - if <server.flag[null]> == <context.entity>:
            - determine cancelled

        on delta time minutely:
        # ------------- Transform null into null every minute -------------
        - if <server.has_flag[null]>:
            - if !<server.has_flag[nullwatch]>:
                - execute as_server "disgplayer <server.flag[null].uuid> Player yyy88 setName Null setDisplayedInTab true"
        # ------------- Null joins the game -------------
        - if !<server.has_flag[null]>:
            - if <server.has_flag[idontwantnull]>:
                - stop
            - flag server spawnnull:++
            - if <server.flag[spawnnull].mod[10]> == 0:
                - if <server.has_flag[inaminute]>:
                    - stop
                - else:
                    - execute as_server nulljoin
        # ------------- Make Sub Anomaly 1 despawn after 10 minutes -------------
        - foreach <server.flag[blackthing]> as:thing:
            - flag <[thing]> timerofthings:++
            - if <[thing].flag[timerofthings]> == 10:
                - flag <[thing]> itsame:!
                - flag server blackthing:<-:<[thing]>
                - wait 1t
                - kill <[thing]>

        on entity damaged:
        # ------------- Handle nullnocircuit command -------------
        - if !<context.damager.exists>:
            - if <context.entity> == <server.flag[circuit]>:
                - if !<server.has_flag[circuitdeath]>:
                    - determine cancelled
        - if <context.entity> == <server.flag[unsusvillager]>:
            - wait 1t
            - execute as_server "stopsound @a * minecraft:entity.villager.hurt"
            - playsound <context.entity.location> sound:entity_generic_hurt

        on entity spawns:
        - if <context.entity.entity_type> == VILLAGER:
            - if <util.random_chance[50]>:
                - adjust <context.entity> custom_name:TESTIFICATE

        on entity dies:
        # ------------- Handle circuit death -------------
        - if <server.has_flag[circuit]>:
            - if <server.flag[circuit]> == <context.entity>:
                - if !<server.has_flag[circuitdeath]>:
                    - execute as_server 'summon item <context.entity.location.x> <context.entity.location.y> <context.entity.location.z> {Item:{id:"minecraft:paper",Count:1b,components:{"minecraft:item_model":"thebrokenscript:record14","minecraft:custom_name":{"text":"Music Disc","color":"yellow","italic":false},"minecraft:lore":[{"text":"14","color":"gray","italic":false}]}}}'
                    - flag server circuit:!
        # ------------- Handle circuit disguised as villager.-------------
        on entity damages entity:
        - if <context.entity> == <server.flag[unsusvillager]>:
            - if !<context.damager.is_player>:
                - determine cancelled
        on entity damages player:
        - if <context.damager> == <server.flag[circuitattacker]>:
            - determine passively cancelled
            - execute as_server "execute at <context.entity.name> run gamerule showDeathMessages false"
            - wait 1t
            - execute as_server 'tellraw @a {"translate":"death.attack.player","with":["PolloProMC","Circuit"],"color":"white"}'
            - wait 1t
            - execute as_server "execute at <context.entity.name> run gamerule showDeathMessages false"
            - kill <context.entity>
            - teleport <server.flag[circuitattacker]> <server.flag[circuitattacker].location.below[100]>
            - kill <server.flag[circuitattacker]>
            - wait 2s
            - kick <context.entity> reason:<list[No more hiding.|No more running.].random>
        # ------------- Circuit. -------------
        - if <context.damager> == <server.flag[circuit]>:
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.circuit_jumpscare master <player.name> ~ ~ ~ 0.07"
            - execute as_server "effect give <player.name> blindness 10 250 true"
            - wait 1t
            - execute as_server 'nullcrash <player.name>'
            - teleport <server.flag[circuit]> <server.flag[circuit].location.below[100]>
            - kill <server.flag[circuit]>
            - wait 1t
            - kick <context.entity> reason:Disconnected.
        # ------------- Circuit disguised as null -------------
        - if <context.damager> == <server.flag[circuitnull]>:
            - ratelimit <context.entity> 2s
            - if !<context.entity.has_flag[circuitwarning]>:
                - flag <context.entity> circuitwarning
                - execute as_server "execute as <context.entity.name> at <context.entity.name> run playsound minecraft:custom.circuitchase master <context.entity.name> ~ ~ ~ 0.07"
                - execute as_server "execute as <context.entity.name> at <context.entity.name> run playsound minecraft:custom.circuit_jumpscare master <context.entity.name> ~ ~ ~ 0.07"
                - repeat 500:
                    - define yaw <context.entity.location.yaw>
                    - define pitch <context.entity.location.pitch>
                    - execute as_server "execute as <context.entity.name> at @s run tp @s ~ ~ ~ <[yaw].add[<list[<util.random.int[1].to[5]>|<util.random.int[-1].to[-5]>].random>]> <[pitch].add[<list[<util.random.int[1].to[5]>|<util.random.int[-1].to[-5]>].random>]>"
                    - wait 1t
                    - if !<server.has_flag[circuitnull]>:
                        - stop
                - teleport <server.flag[circuitnull]> <server.flag[circuitnull].location.below[400]>
                - kill <server.flag[circuitnull]>
                - flag server circuitnull:!
                - flag <context.entity> broisrealangry:!
                - flag <context.entity> circuitwarning:!
            - else:
                - execute as_server "execute at <context.entity.name> run gamerule showDeathMessages false"
                - kill <context.entity>
                - execute as_server 'tellraw @a {"translate":"death.attack.player","with":["<context.entity.name>","Circuit"],"color":"white"}'
                - wait 2t
                - execute as_server "execute at <context.entity.name> run gamerule showDeathMessages true"
                - wait 1s
                - teleport <server.flag[circuitnull]> <server.flag[circuitnull].location.below[400]>
                - kill <server.flag[circuitnull]>
                - flag server circuitnull:!
                - flag <context.entity> broisrealangry:!
                - flag <context.entity> circuitwarning:!
        # ------------- Null chase -------------
        - foreach <server.flag[nullchaser]> as:chaser:
            - if <context.damager> == <[chaser]>:
                - kick <player> reason:null
                - teleport <[chaser]> <[chaser].location.below[400]>
                - wait 1t
                - kill <[chaser]>
                - flag server nullchaser:<-:<[chaser]>

        on player damages entity:
        # ------------- Circuit -------------
        - if <context.entity> == <server.flag[circuit]>:
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.youwillregretthat master <player.name> ~ ~ ~ 0.7"
            - wait 2s
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.circuitchase master <player.name> ~ ~ ~ 0.09"
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.nullchase master <player.name> ~ ~ ~ 0.4"
            - execute as_server "effect give <server.flag[circuit].uuid> minecraft:speed infinite 2 true"
        # ------------- False villager -------------
        - if <context.entity> == <server.flag[unsusvillager]>:
            - execute as_server "gamemode survival <player.name>"
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.circuit_jumpscare master <player.name> ~ ~ ~ 0.07"
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.circuitchase master <player.name> ~ ~ ~ 0.09"
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.nullchase master <player.name> ~ ~ ~ 0.4"
            - teleport <server.flag[circuitattacker]> <server.flag[unsusvillager].location>
            - wait 1t
            - teleport <server.flag[unsusvillager]> <server.flag[unsusvillager].location.above[100]>
            - kill <server.flag[unsusvillager]>
            - wait 1t
            - flag server unsusvillager:!
            - adjust <server.flag[circuitattacker]> has_ai:true
            - execute as_server "data modify entity <server.flag[circuitattacker].uuid> AngryAt set from entity <player.uuid> UUID"
            - execute as_server "effect give <server.flag[circuitattacker].uuid> minecraft:speed infinite 2 true"
            - spawn lightning_bolt <player.location>

        on player joins:
        # ------------- Warning and VHS effects -------------
        - if <player.name.contains[.]> && !<player.has_flag[bedrockwarning]>:
            - narrate "<&lt>Integrity<&gt> Bedrock edition is not supported. Some stuff will not work."
            - flag <player> bedrockwarning
        - if <server.has_flag[moonglitch]>:
            - execute as_server "pvdc setonline 2"
        - else:
            - execute as_server "pvdc setonline 32"
        - if <player.has_flag[boots]>:
            - inventory set o:<player.flag[boots]> d:<player.inventory> slot:BOOTS
        - if !<player.has_flag[removevhs]>:
            - fakeequip <player> head:carved_pumpkin
        - execute as_server "attribute <player.name> minecraft:attack_speed base set 1000"
        - if <player.name> == null:
            - kick <player> "reason:Player is already playing on this server."
            - determine none
        - else if <player.name> == xXram2dieXx:
            - kick <player> "reason:Player is already playing on this server."
            - determine none
        - else if <player.name> == DyeXD412:
            - kick <player> "reason:Player is already playing on this server."
            - determine none
        - else if <player.name> == Integrity:
            - kick <player> "reason:I am watching you."
            - determine none
        - else if <player.name> == Modrome:
            - kick <player> "reason:I am right behind you <&lt>o<&gt>"
            - determine none

        after player respawns:
        # ------------- VHS -------------
        - if !<player.has_flag[removevhs]>:
            - fakeequip <player> head:carved_pumpkin

        on player changes sign:
        # ------------- IKNOWWHATYOUFEAR (unused) -------------
        - if <player.has_flag[iamhere]>:
            - determine cancelled

        on player right clicks oak_door:
        - if <player.has_flag[iamhere]>:
            - determine cancelled

        on player right clicks block:
        # ------------- name.null and name.revuxor -------------
        - define item <player.item_in_hand.material.name>
        - if <[item]> == structure_void or <player.inventory.slot[offhand].material.name> == structure_void:
            - define itemname <player.item_in_hand.display>
            - if <[itemname]> == <white>name.null or <player.inventory.slot[offhand].display> == <white>name.null:
                - determine passively cancelled
                - execute as_server "clear <player.name> minecraft:structure_void 1"
            - if <[itemname]> == <white>name.revuxor or <player.inventory.slot[offhand].display> == <white>name.revuxor:
                - determine passively cancelled
                - execute as_server "clear <player.name> minecraft:structure_void 1"

        on player places block:
        - define item <player.item_in_hand.material.name>
        - define itemname <player.item_in_hand.display>
        - if <[item]> == structure_void or <player.inventory.slot[offhand].material.name> == structure_void:
            - if <[itemname]> == <white>name.null or <player.inventory.slot[offhand].display> == <white>name.null:
                - determine passively cancelled
            - if <[itemname]> == <white>name.revuxor or <player.inventory.slot[offhand].display> == <white>name.revuxor:
                - determine passively cancelled

        on player dies:
        # ------------- R2 -------------
        - if <server.has_flag[r2]>:
            - if <player.has_flag[theangryone]>:
                - teleport <player.flag[theangryone]> <player.flag[theangryone].location.above[100]>
                - kill <player.flag[theangryone]>
                - teleport <player.flag[theangryone].flag[thearmor]> <player.flag[theangryone].flag[thearmor].location.down[400]>
                - kill <player.flag[theangryone].flag[thearmor]>
                - flag <player.flag[theangryone]> thearmor:!
                - flag server r2:<-:<player.flag[theangryone]>
                - flag server triggeredr2:!
                - flag <player> theangryone:!
                - flag <player> r2despawn:!
        # ------------- Circuit -------------
        - if <player.has_flag[broisrealangry]>:
            - flag <player> broisrealangry:!

        on player quits:
        # ------------- R2 -------------
        - if <player.has_flag[theangryone]>:
            - teleport <player.flag[theangryone]> <player.flag[theangryone].location.above[100]>
            - kill <player.flag[theangryone]>
            - teleport <player.flag[theangryone].flag[thearmor]> <player.flag[theangryone].flag[thearmor].location.down[400]>
            - kill <player.flag[theangryone].flag[thearmor]>
            - flag <player.flag[theangryone]> angery:!
            - flag <player.flag[theangryone]> thearmor:!
            - flag server r2:<-:<player.flag[theangryone]>
            - flag server triggeredr2:!
            - flag <player> theangryone:!
        # ------------- Null is here mode -------------
        - if <player> == <server.flag[oneofus]>:
            - if <player.has_flag[oneofusdied]>:
                - flag <player> oneofusdied:!
                - stop
            - execute as_server 'tellraw @a {"translate":"death.attack.player","with":["<player.name>","Null"],"color":"white"}'
            - execute as_server "execute at <server.flag[oneofus].name> run gamerule showDeathMessages false"
            - kill <server.flag[oneofus]>
            - execute as_server "execute at <server.flag[oneofus].name> run gamerule showDeathMessages true"
            - ban <server.flag[oneofus]> reason:null
            - flag server oneofus:!
            - flag server nullwatch:!
            - wait 1s
            - adjust <server.flag[null]> visible:false
        # ------------- Circuit -------------
        - if <player.has_flag[broisrealangry]>:
            - execute as_server "execute at <player.name> run gamerule showDeathMessages false"
            - kill <player>
            - execute as_server 'tellraw @a {"translate":"death.attack.player","with":["<player.name>","Circuit"],"color":"white"}'
            - execute as_server "execute at <player.name> run gamerule showDeathMessages true"
            - flag <player> broisrealangry:!
            - wait 1s
            - teleport <server.flag[circuitnull]> <server.flag[circuitnull].location.below[400]>
            - kill <server.flag[circuitnull]>
            - flag server circuitnull:!
        # ------------- Handle names. -------------
        - if <player.name> == null:
            - determine none
        - else if <player.name> == xXram2dieXx:
            - determine none
        - else if <player.name> == DyeXD412:
            - determine none
        - else if <player.name> == Integrity:
            - determine none
        - else if <player.name> == Modrome:
            - determine none
        # ------------- Quit mechanic (Coming soon!) -------------

        on entity enters portal:
        # ------------- Prevent null from going through portals (Unused) -------------
        - if <server.has_flag[null]>:
            - if <server.flag[null]> == <context.entity>:
                - determine cancelled

        on player right clicks jukebox:
        # ------------- Disc 14 -------------
        - ratelimit <player> 0.5s
        - if <context.location.jukebox_is_playing>:
            - stop
        - if <server.has_flag[jukebox]>:
            - foreach <server.flag[jukebox]> as:juke:
                - if <context.location> == <[juke]>:
                    - foreach <context.location.find_entities[player].within[16]> as:player:
                        - execute as_server "stopsound <[player].name> record minecraft:custom.record14"
                    - execute as_server 'summon item <[juke].x> <[juke].y.add[1]> <[juke].z> {Item:{id:"minecraft:paper",Count:1b,components:{"minecraft:item_model":"thebrokenscript:record14","minecraft:custom_name":{"text":"Music Disc","color":"yellow","italic":false},"minecraft:lore":[{"text":"14","color":"gray","italic":false}]}}}'
                    - flag server jukebox:<-:<[juke]>
                    - determine cancelled
        - define item <player.item_in_hand.material.name>
        - define itemname <player.item_in_hand.display>
        - define itemlore <player.item_in_hand.lore.formatted>
        - if <[item]> == paper:
            - if <[itemname]> == "<yellow>Music Disc" && <[itemlore]> == 14:
                - flag server jukebox:->:<context.location>
                - foreach <context.location.find_entities[player].within[16]> as:player:
                    - execute as_server "playsound minecraft:custom.record14 record <[player].name> <context.location.x> <context.location.y> <context.location.z>"
                - execute as_server "item replace entity <player.name> weapon.mainhand with air"
                - determine cancelled
        - else if <[item]> == music_disc_13:
            - execute as_server "particle block_marker{block_state:{Name:black_concrete}} <context.location.x> <context.location.y> <context.location.z> 1.5 1.5 1.5 0 30"

        on player breaks jukebox:
        - if <server.has_flag[jukebox]>:
            - foreach <server.flag[jukebox]> as:juke:
                - if <context.location> == <[juke]>:
                    - foreach <context.location.find_entities[player].within[16]> as:player:
                        - execute as_server "stopsound <[player].name> record minecraft:custom.record14"
                        - execute as_server 'summon item <[juke].x> <[juke].y.add[1]> <[juke].z> {Item:{id:"minecraft:paper",Count:1b,components:{"minecraft:item_model":"thebrokenscript:record14","minecraft:custom_name":{"text":"Music Disc","color":"aqua","italic":false},"minecraft:lore":[{"text":"14","color":"gray","italic":false}]}}}'
                        - flag server jukebox:<-:<[juke]>

        # ------------- Hello block -------------
        on player breaks brown_stained_glass:
        - define newblock <context.location>
        - wait 1t
        - execute as_server 'setblock <[newblock].x> <[newblock].y> <[newblock].z> minecraft:structure_block[mode=load]{author:"?",ignoreEntities:1b,integrity:1.0f,metadata:"",mirror:"NONE",mode:"LOAD",name:"minecraft:magmacross",posX:0,posY:0,posZ:0,powered:0b,rotation:"NONE",seed:0L,showair:0b,showboundingbox:1b,sizeX:6,sizeY:6,sizeZ:6}'
        - define whatblock <[newblock].add[0,-1,0].material.name>
        - define whatblocklocation <[newblock].add[0,-1,0]>
        - wait 1t
        - modifyblock <[whatblocklocation]> redstone_torch
        - wait 1t
        - modifyblock <[whatblocklocation]> <[whatblock]>
        - execute as_server "execute as <player.name> at @s run playsound minecraft:custom.heartbeat master @s ~ ~ ~ 100"
        - waituntil rate:1s !<world[world].is_day>
        - execute as_server "nullhost"

        on player damages bedrock with:stone_pickaxe|iron_pickaxe|diamond_pickaxe:
        # ------------- Breakeable bedrock. -------------
        - if !<player.has_flag[breakthebedrock]>:
            - flag <player> breakthebedrock:0
        - blockcrack <context.location> progress:1
        - repeat 120:
            - flag <player> breakthebedrock:++ expire:2t
            - if <player.cursor_on> != <context.location>:
                - blockcrack <context.location> progress:0
                - stop
            - wait 1t
            - if <[value]> == 10:
                - blockcrack <context.location> progress:2
            - if <[value]> == 20:
                - blockcrack <context.location> progress:3
            - if <[value]> == 30:
                - blockcrack <context.location> progress:4
            - if <[value]> == 40:
                - blockcrack <context.location> progress:5
            - if <[value]> == 50:
                - blockcrack <context.location> progress:6
            - if <[value]> == 60:
                - blockcrack <context.location> progress:7
            - if <[value]> == 70:
                - blockcrack <context.location> progress:8
            - if <[value]> == 80:
                - blockcrack <context.location> progress:9
            - if <[value]> == 90:
                - blockcrack <context.location> progress:10
            - if <player.flag[breakthebedrock]> == 100:
                - execute as_server "setblock <context.location.x> <context.location.y> <context.location.z> air destroy"

        on player drops item:
        # ------------- "help" inventory. -------------
        - if <player.has_flag[inventoryfreeze]>:
            - determine cancelled

        on player clicks in inventory:
        - if <player.has_flag[inventoryfreeze]>:
            - determine cancelled

        on player swaps items:
        - if <player.has_flag[inventoryfreeze]>:
            - determine cancelled

        on player closes inventory:
        - if <player.has_flag[inventoryfreeze]>:
            - flag <player> inventoryfreeze:!

        on villager changes profession:
        - if <server.flag[falsevillager].exists>:
            - if <context.entity> == <server.flag[falsevillager]>:
                - determine cancelled

        on player chats priority:-22:
        # ------------- Chat handler -------------
        - if <server.has_flag[triggeredr2]>:
            - determine passively cancelled
            - actionbar "IMPORT minecraft.chatengine"
            - wait 1s
            - actionbar Unexpected_error.returnedvalue=-1
            - stop
        - if <util.random_chance[1]>:
            - repeat 60:
                - actionbar <list[Here I am|H3r3 I 4m|<red>Here I am|<reset>Her<&k>e I a<reset>m|<underline>Here I am<reset>|Here<&k>I am<reset>|Here <italic>I am|<&k>Here <reset>I am].random>
                - wait 1t
            - actionbar ""
        - if <server.has_flag[null]>:
            - if <context.message> matches hello|hi?:
                - wait 40s
                - announce "<&lt>Null<&gt> err.type=null.hello"
                - playsound <player> sound:ambient.cave pitch:0.5
            - else if <context.message> == "Who are you?":
                - wait 5s
                - announce "<&lt>Null<&gt> err.type=null."
                - playsound <player> sound:ambient.cave pitch:0.5
            - else if <context.message> == "What do you want?":
                - wait 5s
                - announce "<&lt>Null<&gt> err.type=null.freedom"
                - playsound <player> sound:ambient.cave pitch:0.5
            - else if <context.message> == null:
                - ratelimit <player> 6s
                - wait 5s
                - announce "<&lt>Null<&gt> The end is nigh."
                - wait 1s
                - announce "<&lt>Null<&gt> The end is null."
                - wait 0.5s
                - playsound <player> sound:entity_enderman_death pitch:0.5
                - wait 1t
                - execute as_server 'tellraw @a {"translate":"death.attack.player","with":["<player.name>","Null"],"color":"white"}'
                - execute as_server "execute at <player.name> run gamerule showDeathMessages false"
                - kill <player>
                - wait 1t
                - execute as_server "execute at <player.name> run gamerule showDeathMessages true"
                - kick <player> reason:null
            - else if <context.message> == "Can you see me?":
                - ratelimit <player> 10s
                - wait 5s
                - announce "<&lt>Null<&gt> Yes."
                - wait 3s
                - announce "<&lt>Null<&gt> Hello."
                - wait 3s
                - spawn lightning_bolt <player.location.block>
                - flag <player> boots:<player.inventory.slot[boots]>
                - flag <player> inventoryfreeze expire:1s
                - execute as_server 'item replace entity <player.name> armor.feet with stick[minecraft:equippable={slot:feet,camera_overlay:"thebrokenscript:screen/snimok_ekrana"}]'
                - execute as_server "effect give <player.name> minecraft:blindness 1 250 true"
                - wait 1s
                - inventory set o:<player.flag[boots]> d:<player.inventory> slot:BOOTS
                - flag <player> boots:!
            - else if <context.message> == Friend?:
                - ratelimit <player> 10s
                - wait 5s
                - execute as_server "nulljumpscare <player.name>"
            - else if <context.message> == "How can i help you?":
                - wait 5s
                - announce [?][?][?]
            - else if <context.message> == herobrine:
                - wait 5s
                - announce <&lt>Null<&gt>
            - else if <context.message> == "Entity 303":
                - wait 5s
                - announce "<&lt>Null<&gt> Ended his own life."
            - else if <context.message> == Integrity:
                - wait 5s
                - announce "<&lt>Null<&gt> Deep down under the bedrock."
            - else if <context.message> == clan_build:
                - wait 5s
                - announce "<&lt>Null<&gt> Home."
            - else if <context.message> == xXram2dieXx:
                - ratelimit <player> 6s
                - wait 5s
                - announce "<&lt>Null<&gt> Rot in hell."
                - playsound <player> sound:entity_enderman_death pitch:0.5
                - teleport <server.flag[null]> <player.location>
                - adjust <server.flag[null]> visible:true
                - execute as_server 'tellraw @a {"translate":"death.attack.player","with":["<player.name>","Null"],"color":"white"}'
                - execute as_server "execute at <player.name> run gamerule showDeathMessages false"
                - kill <player>
                - wait 1t
                - execute as_server "execute at <player.name> run gamerule showDeathMessages true"
                - ban <player> "reason:Disconnected"
                - wait 0.5s
                - execute as_server "teleport <server.flag[null].uuid> ~ ~400 ~"
                - adjust <server.flag[null]> visible:false
            - else if <context.message> == Revuxor:
                - wait 5s
                - announce "<&lt>Null<&gt> Poor soul."
            - else if <context.message> == Follow:
                - wait 5s
                - announce "<&lt>Null<&gt> Is behind you."
            - else if <context.message> matches "nothing is watching|nothingiswatching":
                - wait 5s
                - announce "<&lt>Null<&gt> A broken promise."
            - else if <context.message> == circuit:
                - wait 5s
                - announce "<&lt>Null<&gt> It was all his fault."
            - else if <context.message> == "The broken end":
                - wait 5s
                - announce "<&lt>Circuit<&gt> Administration."
            - else if <context.message> == Steve:
                - wait 5s
                - announce "<&lt>Null<&gt> [0.1]"
            - else if <context.message> == Void:
                - wait 5s
                - announce "It's me."



nullticktasks:
    type: world
    debug: false
    events:
        on tick every:2:
        # ------------- Sub Anomaly 1 -------------
        - if <server.has_flag[blackthing]>:
            - foreach <server.flag[blackthing]> as:thething:
                - execute as_server "execute at <[thething].uuid> run particle block_marker{block_state:{Name:black_concrete}} ~ ~1 ~ 1.5 1.5 1.5 0 1"
                - hurt 2 <[thething].location.find_entities.within[3]>
                - if <[thething].location.find_blocks[water].within[3].exists>:
                    - define water <[thething].location.find_blocks[water].within[3]>
                    - modifyblock <[water]> cobblestone
                    - wait 1t
        # ------------- R2 -------------
        - if <server.has_flag[r2]>:
            - foreach <server.flag[r2]> as:r2:
                - execute as_server "execute as <[r2].flag[thearmor].uuid> at @s run tp @s <list[^ ^ ^0.3|^ ^0.3 ^|^0.3 ^ ^|^ ^ ^-0.3|^ ^-0.3 ^|^-0.3 ^ ^].random> facing entity @a[sort=nearest,limit=1]"
                - wait 1t
                - execute as_server "execute as <[r2].flag[thearmor].uuid> at @s run tp @s <[r2].location.x> <[r2].location.y> <[r2].location.z> facing entity @a[sort=nearest,limit=1]"
                - if <world[world].is_day> && !<[r2].has_flag[r2angy]>:
                    - execute as_server "execute at <[r2].uuid> run particle block_marker{block_state:{Name:black_concrete}} ~ ~1 ~ 0.7 1.5 0.7 0 30"
                    - teleport <[r2]> <[r2].location.down[400]>
                    - teleport <[r2].flag[thearmor]> <[r2].flag[thearmor].location.down[400]>
                    - kill <[r2].flag[thearmor]>
                    - flag <[r2]> thearmor:!
                    - flag <[r2]> r2angy:!
                    - kill <[r2]>
                    - flag server r2:<-:<[r2]>
                    - flag server triggeredr2:!
        # ------------- Nothingiswatching -------------
        - if <server.has_flag[thewatchers]>:
            - foreach <server.flag[thewatchers]> as:nothing:
                - execute as_server "execute as <[nothing].flag[litnothing].uuid> at @s run tp @s <[nothing].location.x> <[nothing].location.above[3].y> <[nothing].location.z> facing entity @a[sort=nearest,limit=1]"
                - execute as_server "data modify entity <[nothing].uuid> AngryAt set from entity <[nothing].location.find_entities[player].within[100].get[1].uuid> UUID"
                - define litnothing <[nothing].flag[litnothing]>
                - foreach <server.online_players> as:player:
                    - if <[player].location.distance[<[nothing].location>]> <= 10 or <[player].target.exists> && <[player].target> == <[nothing]>:
                        - define nothingloc <[nothing].location>
                        - teleport <[nothing]> <[nothing].location.below[400]>
                        - teleport <[litnothing]> <[nothing].location.below[400]>
                        - flag <[nothing]> litnothing:!
                        - kill <[nothing]>
                        - kill <[litnothing]>
                        - flag server thewatchers:<-:<[nothing]>
                        - if <util.random_chance[70]>:
                            - execute as_server "nullnothingchase <[nothingloc]> <[player].name>"
                        - else:
                            - spawn lightning_bolt <[nothingloc]>
        # ------------- Null is here mode -------------
        - if <server.has_flag[oneofus]>:
            - execute as_server "execute as <server.flag[nullishere].uuid> at @s run tp @s ^ ^ ^1 facing entity <server.flag[oneofus].name> feet"
            - if <server.flag[oneofus].location.distance[<server.flag[nullishere].location>]> <= 2:
                - ratelimit <server.flag[oneofus]> 3s
                - execute as_server "execute at <server.flag[oneofus].name> run gamerule showDeathMessages false"
                - kill <server.flag[oneofus]>
                - execute as_server 'tellraw @a {"translate":"death.attack.player","with":["<server.flag[oneofus].name>","Null"],"color":"white"}'
                - flag <server.flag[oneofus]> oneofusdied
                - execute as_server "execute as <server.flag[oneofus].name> at <server.flag[oneofus].name> run playsound minecraft:custom.randomjumpscare master <server.flag[oneofus].name> ~ ~ ~"
                - execute as_server "nullcrash <server.flag[oneofus].name>"
                - wait 0.3s
                - execute as_server "execute at <server.flag[oneofus].name> run gamerule showDeathMessages true"
                - ban <server.flag[oneofus]> reason:null
                - flag server oneofus:!
                - flag server nullwatch:!
                - wait 1s
                - adjust <server.flag[nullishere]> visible:false
                - teleport <server.flag[nullishere]> <server.flag[nullishere].location.below[200]>
                - wait 1t
                - kill <server.flag[nullishere]>
                - flag server nullishere:!
            - execute as_server "execute as <server.flag[oneofus].name> at <server.flag[oneofus].name> run playsound minecraft:custom.nullishereloop master <server.flag[oneofus].name> ~ ~ ~ 100 0.5"
            - ratelimit <server.flag[oneofus]> 0.3s
            - title title:<list[You know nothing|Worship me|Follow me|Join us|Corrupted|Go away|Null|We can hear you|Can you see me?|0|Behind you|Help me|Nothing can be changed|Close your eyes|One of us].random> targets:<server.flag[oneofus]>
        # ------------- Null watching -------------
        - if <server.has_flag[nullwatcher]>:
            - foreach <server.flag[nullwatcher]> as:null:
                - if <world[world].is_day>:
                    - teleport <[null]> <[null].location.below[400]>
                    - wait 1t
                    - kill <[null]>
                    - flag server nullwatcher:<-:<[null]>
        # ------------- Null flying -------------
        - if <server.has_flag[nullflying]>:
            - define time <world[world].time>
            - if <[time]> >= 0 && <[time]> < 12300 || <[time]> >= 23850:
                - foreach <server.flag[nullflying]> as:null:
                    - teleport <[null]> <[null].location.below[400]>
                    - wait 1t
                    - kick <[null]>
                    - flag server nullflying:<-:<[null]>
        # ------------- Null chase -------------
        - if <server.has_flag[nullchaser]>:
            - foreach <server.flag[nullchaser]> as:chaser:
                - execute as_server "execute at <[chaser].uuid> run particle block_marker{block_state:{Name:black_concrete}} ~ ~1 ~ 2 2 2 0 1"
                - if <[chaser].location.find_blocks[water].within[3].exists>:
                    - define water <[chaser].location.find_blocks[water].within[3]>
                    - modifyblock <[water]> mossy_cobblestone
        # ------------- Nothingiswatching chase -------------
        - if <server.has_flag[nothingchaser]>:
            - foreach <server.flag[nothingchaser]> as:nothing:
                - execute as_server "execute at <[nothing].uuid> run fill ~2 ~2 ~2 ~-2 ~1 ~-2 air destroy"
                - execute as_server "execute as <[nothing].flag[litnothing].uuid> at @s run tp @s <list[^ ^ ^0.3|^ ^0.3 ^|^0.3 ^ ^|^ ^ ^-0.3|^ ^-0.3 ^|^-0.3 ^ ^].random> facing entity @a[sort=nearest,limit=1]"
                - if <[nothing].location.find_blocks[water].within[3].exists>:
                    - define water <[nothing].location.find_blocks[water].within[3]>
                    - modifyblock <[water]> cobblestone
                - wait 1t
                - execute as_server "execute as <[nothing].flag[litnothing].uuid> at @s run tp @s <[nothing].location.x> <[nothing].location.above[3].y> <[nothing].location.z> facing entity @a[sort=nearest,limit=1]"

        on player walks:
        # ------------- Prevent looking at someone else while on nullishere phase (Unused) -------------
        - if <server.has_flag[nullwatch]>:
            - if <server.has_flag[oneofus]>:
                - stop
            - execute as_server "execute as <server.flag[null].uuid> at @s run tp @s ~ ~ ~ facing entity @a[limit=1,sort=nearest] feet"
        # ------------- Null watching -------------
        - if <server.has_flag[nullwatcher]>:
            - foreach <server.flag[nullwatcher]> as:null:
                - execute as_server "execute as <[null].uuid> at @s run tp @s ~ ~ ~ facing entity @a[limit=1,sort=nearest] feet"
                - if <player.location.distance[<[null].location>]> <= 4:
                    - define random <util.random.int[1].to[4]>
                    - if <[random]> == 1:
                        - execute as_server "effect give <player.name> minecraft:blindness 20 1"
                        - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.nullflee master <player.name> ~ ~ ~ 100"
                    - else if <[random]> == 2:
                        - spawn <[null].location> lightning_bolt
                    - else if <[random]> == 3:
                        - execute as_server "execute at <[null].uuid> run particle block_marker{block_state:{Name:black_concrete}} ~ ~1 ~ 1 1 1 0 30"
                    - else if <[random]> == 4:
                        - execute as_server "execute at <[null].uuid> run particle block_marker{block_state:{Name:black_concrete}} ~ ~1 ~ 1 1 1 0 30"
                        - teleport <player> <player.calculated_bed_spawn||<player.spawn_location>>
                    - teleport <[null]> <player.location.below[400]>
                    - wait 1t
                    - kill <[null]>
                    - flag server nullwatcher:<-:<[null]>
        # ------------- "help" Inventory -------------
        - if <player.has_flag[plsopeninventory]>:
            - inventory open d:generic[size=36;title=help;contents=<player.inventory.list_contents>]
            - flag <player> plsopeninventory:!
        # ------------- Prevent player from moving -------------
        - if <player.has_flag[nomove]>:
            - determine cancelled
        # ------------- Handle faraway -------------
        - if <server.has_flag[faraway]>:
            - foreach <server.flag[faraway]> as:far:
                - execute as_server "execute as <[far].uuid> at @s run tp @s ~ ~ ~ facing entity @a[limit=1,sort=nearest] feet"
                - if <player.location.distance[<[far].location>]> <= 25:
                    - ratelimit <player> 2s
                    - execute as_server "execute as <player.name> at @s run teleport <player.name> ~ ~ ~ <util.random.int[0].to[360]> <util.random.int[0].to[90]>"
                    - execute as_server "effect give <player.name> minecraft:blindness 100 100 true"
                    - define boots <player.inventory.slot[boots]>
                    - flag player boots:<[boots]>
                    - execute as_server 'item replace entity <player.name> armor.feet with stick[minecraft:equippable={slot:feet,camera_overlay:"thebrokenscript:screen/snimok_ekrana"}]'
                    - execute as_server "setblock <[far].location.block.x> <[far].location.block.y> <[far].location.block.z> air"
                    - execute as_server "setblock <[far].location.block.x> <[far].location.block.y.add[1]> <[far].location.block.z> air"
                    - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.randomjumpscare master <player.name> ~ ~ ~ 0.35 0.5"
                    - wait 1t
                    - execute as_server "execute at <[far].uuid> run particle block_marker{block_state:{Name:black_concrete}} ~ ~1 ~ 1 1 1 0 30"
                    - wait 1t
                    - teleport <[far]> <[far].location.above[100]>
                    - kill <[far]>
                    - wait 1t
                    - flag server faraway:<-:<[far]>
                    - wait 1s
                    - inventory set o:<[boots]> d:<player.inventory> slot:BOOTS
                    - flag <player> boots:!
                    - execute as_server "effect clear <player.name> minecraft:blindness"
        # ------------- Handle R2 -------------
        - if <server.has_flag[r2]>:
            - foreach <server.flag[r2]> as:r2:
                - execute as_server "effect give <[r2].uuid> minecraft:speed infinite 5 true"
                - if <player.location.distance[<[r2].location>]> <= 5:
                    - if <server.has_flag[spawningr2]>:
                        - stop
                    - if !<player.has_flag[theangryone]>:
                        - if <[r2].has_flag[r2angy]>:
                            - foreach next
                        - ratelimit <player> 1s
                        - if <util.random_chance[50]>:
                            - execute as_server "effect give <player.name> minecraft:blindness 100 100 true"
                            - define boots <player.inventory.slot[boots]>
                            - flag <player> boots:<[boots]>
                            - execute as_server 'item replace entity <player.name> armor.feet with stick[minecraft:equippable={slot:feet,camera_overlay:"thebrokenscript:screen/cantyousee"}]'
                            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.textmadness1 master <player.name> ~ ~ ~"
                            - execute as_server "execute as <player.name> at @s run teleport <player.name> ~ ~ ~ facing entity <[r2].uuid> feet"
                            - wait 0.5s
                            - inventory set o:<[boots]> d:<player.inventory> slot:BOOTS
                            - flag <player> boots:!
                            - execute as_server "effect clear <player.name> minecraft:blindness"
                            - teleport <[r2].flag[thearmor]> <[r2].flag[thearmor].location.down[400]>
                            - kill <[r2].flag[thearmor]>
                            - flag <[r2]> thearmor:!
                            - teleport <[r2]> <[r2].location.down[400]>
                            - kill <[r2]>
                            - flag server r2:<-:<[r2]>
                        - else:
                            - execute as_server "gamemode survival <player.name>"
                            - execute as_server "effect give <[r2].uuid> minecraft:speed infinite 5 true"
                            - spawn lightning_bolt <player.location>
                            - adjust <[r2]> has_ai:true
                            - execute as_server "data modify entity <[r2].uuid> AngryAt set from entity <player.uuid> UUID"
                            - flag server triggeredr2
                            - flag <player> theangryone:<[r2]>
                            - flag <[r2]> chaser:!
                            - flag <[r2]> r2angy
                            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.nullchase master <player.name> ~ ~ ~ 0.4"
        # ------------- Handle false villager. -------------
        - if <server.has_flag[unsusvillager]>:
            - define closeplayer <server.flag[unsusvillager].location.find_entities[player].within[100].get[1]>
            - if <[closeplayer].location.distance[<server.flag[unsusvillager].location>]> > 20:
                - ratelimit server 1s
                - define block <[closeplayer].location.backward_flat[20].block.highest.above[1]>
                - if <[block].material.name> == air:
                    - define I 0
                    - while <[block].down[<[I]>].material.name> == air:
                        - define I:++
                    - define newblock <[block].down[<[I].sub[1]>]>
                - else if <[block].material.name> != air:
                    - define I 0
                    - while <[block].up[<[I]>].material.name> != air:
                        - define I:++
                    - define newblock <[block].up[<[I]>]>
                - walk <server.flag[unsusvillager]> <[newblock]> speed:0.35
            - if <[closeplayer].location.distance[<server.flag[unsusvillager].location>]> < 20:
                - ratelimit server 3s
                - walk <server.flag[unsusvillager]> stop
        # ------------- Handle Disguised Circuit -------------
        - if <server.has_flag[circuit]>:
            - if <player.location.world.name> != <server.flag[circuit].location.world.name>:
                - stop
            - if <player.location.distance[<server.flag[circuit].location>]> <= 4:
                - ratelimit <player> 1m
                - if <player.name> == <server.flag[circuit].name>:
                    - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.circuitchase master <player.name> ~ ~ ~ 0.1"
                    - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.nullchase master <player.name> ~ ~ ~ 0.4"
                    - execute as_server "data modify entity <server.flag[circuit].uuid> AngryAt set from entity <player.uuid> UUID"
                    - execute as_server "effect give <server.flag[circuit].uuid> minecraft:speed infinite 2 true"
                    - stop
                - narrate "<&lt><server.flag[circuit].name><&gt> <list[hey|do you have some food?|i'm lost|where's the base].random>" targets:<player>
        # ------------- Handle Xxram2diexX -------------
        - if <server.has_flag[ram2die]>:
            - if <player.location.distance[<server.flag[ram2die].location>]> <= 20:
                - ratelimit <player> 3s
                - execute as_server "nullchase <server.flag[ram2die].location> <player.name>"
                - wait 1t
                - teleport <server.flag[ram2die]> <server.flag[ram2die].location.below[100]>
                - kill <server.flag[ram2die]>
                - wait 1t
                - flag server ram2die:!
        # ------------- Handle Null flying. -------------
        - foreach <server.flag[nullflying]> as:null:
            - execute as_server "execute as <[null].uuid> at @s run tp @s ~ ~ ~ facing entity @a[limit=1,sort=nearest] feet"
            - if <player.location.distance[<[null].location>]> < 20:
                - teleport <[null]> <[null].location.below[400]>
                - hurt <util.random.int[1].to[10]> <player>
                - wait 1t
                - kill <[null]>
                - flag server nullflying:<-:<[null]>
        # ------------- Handle circuit -------------
        - if <player.has_flag[circuitwarning]>:
            - if !<player.has_flag[inventoryisclosing]>:
                - flag <player> inventoryisclosing expire:25s
                - while <player.has_flag[broisrealangry]>:
                    - inventory close
                    - wait 1t
            - else:
                - stop
        # ------------- Handle Null Invading base -------------
        - if <server.has_flag[nullinvaders]>:
            - foreach <server.flag[nullinvaders]> as:invade:
                - execute as_server "execute as <[invade].uuid> at @s run tp @s ~ ~ ~ facing entity @a[limit=1,sort=nearest] feet"
                - if <player.location.distance[<[invade].location>]> < 7.5:
                    - ratelimit <player> 1s
                    - if <util.random_chance[70]>:
                        - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.textmadness1 master <player.name> ~ ~ ~ 1"
                        - spawn <[invade].location> lightning_bolt
                        - if !<player.has_flag[boots]>:
                            - define boots <player.inventory.slot[boots]>
                            - flag player boots:<[boots]>
                            - execute as_server 'item replace entity <player.name> armor.feet with stick[minecraft:equippable={slot:feet,camera_overlay:"thebrokenscript:screen/wecanhearyou"}]'
                            - teleport <[invade]> <[invade].location.below[400]>
                            - kill <[invade]>
                            - flag server nullinvaders:<-:<[invade]>
                            - wait 1s
                            - inventory set o:<[boots]> d:<player.inventory> slot:BOOTS
                            - flag <player> boots:!
                    - else:
                        - execute as_server "nullchase <[invade].location> <player.name>"
                        - wait 1t
                        - teleport <[invade]> <[invade].location.below[400]>
                        - kill <[invade]>
                        - flag server nullinvaders:<-:<[invade]>
        - if <player.location.find_blocks[deepslate].within[9].exists>:
            - modifyblock <player.location.find_blocks[deepslate].within[9]> stone

        on player right clicks *_bed:
        # ------------- Bed mechanics -------------
        - if <server.flag[r2].size> > 0:
            - determine passively cancelled
            - ratelimit <player> 60t
            - repeat 60:
                - actionbar "You may not rest now; <list[err.soul|err.s0ul|<red>err.soul|<reset>err.<&k>s<reset>oul|<underline>err.soul<reset>|err.<&k>soul<reset>|err.<italic>soul].random>"
                - wait 1t
            - actionbar ""
        - if <server.flag[nullwatcher].size> > 0:
            - determine passively cancelled
            - ratelimit <player> 60t
            - repeat 60:
                - actionbar "You may not rest now; <list[err.null|err.<black>null<reset>|<red>err.null|<reset>err.<&k>n<reset>ull|<underline>err.null<reset>|err.<&k>null<reset>|err.<italic>null].random>"
                - wait 1t
            - actionbar ""

        # Only turn on if you have luck perms installed!
        # An illusion to make "Null Plugins: Null" as a plugin.
        # after *plugins|*pl command:
        # - execute as_server "lp group default permission set null.plugin true"
        # - narrate "<black>Null Plugins:"
        # - narrate <green><element[Null].on_click[/nullplugin]>

nulljoin_command:
    type: command
    name: nulljoin
    description: Null joined the game.
    usage: /nulljoin
    permission: null.join
    script:
    - define randomplayer <server.online_players.random>
    - spawn <[randomplayer].location.above[50]> villager save:Null
    - adjust <entry[Null].spawned_entity> has_ai:false
    - flag server null:<entry[Null].spawned_entity>
    - adjust <server.flag[null]> persistent:true
    - execute as_server "forceload add ~ ~ ~ ~"
    - wait 1t
    - execute as_server "teleport <server.flag[null].uuid> ~ ~400 ~"
    - wait 1t
    - execute as_server "disgplayer <server.flag[null].uuid> Player yyy88 setName Null setDisplayedInTab true"
    - adjust <server.flag[null]> visible:false
    - adjust <server.flag[null]> invulnerable:true
    - if <context.args.get[1]> == silent:
        - stop
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.joined","with":["Null"],"color":"yellow"}'
    - playsound <server.online_players> sound:ambient.cave pitch:0.5
    - adjust <server.flag[null]> invulnerable:true

nullleave_command:
    type: command
    name: nullleave
    description: Null left the game
    usage: /nullleave
    permission: null.leave
    script:
    - execute as_server "disgplayer <server.flag[null].uuid> Player yyy88 setName Null setDisplayedInTab false"
    - wait 1t
    - kill <server.flag[null]>
    - flag server null:!
    - flag server spawnnull:0
    - if <context.args.get[1]> == silent:
        - stop
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.left","with":["Null"],"color":"yellow"}'

nullwatch:
    type: command
    name: nullwatch
    description: Null is watching.
    usage: /nullwatch
    permission: null.watch
    script:
    - if <server.flag[nullwatcher].size> >= 2:
        - stop
    - if <world[world].is_day>:
        - stop
    - define randomplayer <server.online_players.random>
    - spawn <[randomplayer].location.above[50]> villager save:nullwatcher
    - define null <entry[nullwatcher].spawned_entity>
    - flag server nullwatcher:->:<[null]>
    - adjust <[null]> has_ai:false
    - adjust <[null]> invulnerable:true
    - execute as_server "disgplayer <[null].uuid> Player yyy88 setName Null setDisplayedInTab false"
    - wait 0.5s
    - if <[randomplayer].location.world.name> == world_nether:
        - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 10 30 under <[randomplayer].location.y> false <[null].uuid>"
    - else:
        - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 10 30 false <[null].uuid>"
    - playsound <server.online_players> sound:ambient.cave

nullsong:
    type: command
    name: nullsong
    description: Song of him.
    usage: /nullsong
    permission: null.song
    script:
    - execute as_server "effect give @a minecraft:blindness 16 100"
    - execute as_server "effect give @a minecraft:slowness 16 1"
    - execute as_server "effect give @a minecraft:slow_falling 16 1"
    - wait 1s
    - execute as_server "nulltimeset midnight"
    - execute as_server "execute as @a at @s run playsound minecraft:custom.randomsong master @s ~ ~ ~ 100"
    - wait 15s
    - foreach <server.online_players> as:player:
        - if <[player].location.block.highest.y> < <[player].location.block.y> && <util.random_chance[50]>:
            - spawn <[player].location.block> lightning_bolt

nullsteps:
    type: command
    name: nullsteps
    description: Grass break
    usage: /nullsteps
    permission: null.steps
    script:
    - define randomuser <server.online_players.random>
    - repeat 4:
        - playsound <[randomuser]> sound:block_grass_break volume:100
        - wait 1s

nulltitle:
    type: command
    name: nulltitle
    description: null null null null null null null.
    usage: /nulltitle
    permission: null.steps
    script:
    - title "title:null null null null null null null" targets:<server.online_players>

nullpotion:
    type: command
    name: nullpotion
    description: Why can't you just leave?
    usage: /nullpotion
    permission: null.potion
    script:
    - define randomplayer <server.online_players.random>
    - execute as_server "effect give <[randomplayer].name> minecraft:unluck 50 1 true"
    - repeat 200:
        - execute as_server "execute at <[randomplayer].name> run particle entity_effect{color:[0.0,0.0,0.0,1.0]} ~ ~1 ~ 0.3 0.4 0.3 0.6 1"
        - wait 0.25s

nullHereIam:
    type: command
    name: nullhereiam
    description: Can you see me?
    usage: /nullhereiam
    permission: null.heriam
    script:
    - foreach <server.online_players> as:randomplayer:
        - if !<[randomplayer].has_flag[hereiam]>:
            - announce "<element[<[randomplayer].name>].on_hover[<[randomplayer].name><n>Type: Player<n><[randomplayer].uuid>]> has made the advancement <green>[<element[Here I am.].on_hover[<green>Here I am.<n>Can you see me?]>]"
            - flag <[randomplayer]> hereiam
            - toast "Here I am." icon:black_concrete targets:<[randomplayer]>
            - stop

nulladvancement2:
    type: command
    name: nulladvancement2
    description: nullnullnull
    usage: /nulladvancement2
    permission: null.advancement2
    script:
    - foreach <server.online_players> as:randomplayer:
        - if !<[randomplayer].has_flag[advancement2]>:
            - announce "<element[<[randomplayer].name>].on_hover[<[randomplayer].name><n>Type: Player<n><[randomplayer].uuid>]> has made the advancement <green>[<element[nullnullnull].on_hover[<green>nullnullnull<n>nullnullnull]>]"
            - flag <[randomplayer]> advancement2
            - toast "nullnullnull" icon:i@structure_void[display=name.null;components_patch=map@[minecraft:item_model=string:thebrokenscript:n;denizen:__data_version=4440]] targets:<[randomplayer]>
            - stop

nullgoaway:
    type: command
    name: nullgoaway
    description: This place is not for you.
    usage: /nullgoaway
    permission: null.goaway
    script:
    - foreach <server.online_players> as:randomplayer:
        - if !<[randomplayer].has_flag[goaway]>:
            - announce "<element[<[randomplayer].name>].on_hover[<[randomplayer].name><n>Type: Player<n><[randomplayer].uuid>]> has made the advancement <green>[<element[Go Away].on_hover[<green>Go Away<n>This place is not for you.]>]"
            - flag <[randomplayer]> goaway
            - toast "Go away." icon:i@white_wool[components_patch=map@[minecraft:item_model=string:thebrokenscript:redobsidian;denizen:__data_version=4440]] targets:<[randomplayer]>
            - stop

nullinvadebase:
    type: command
    name: nullinvadebase
    description: Null invades the base.
    usage: /nullinvadebase
    permission: null.invadebase
    script:
    - foreach <server.online_players> as:player:
        - if <[player].bed_spawn.exists>:
            - if <[player].location.distance[<[player].bed_spawn>]> < 20:
                - if <util.random_chance[50]>:
                    - narrate <list[[{}]}|{[<&gt> null]}].random>
                - if <util.random_chance[50]>:
                    - stop
            - spawn <[player].location.above[50]> villager save:nullinvade
            - define nullinvade <entry[nullinvade].spawned_entity>
            - adjust <[nullinvade]> has_ai:false
            - adjust <[nullinvade]> invulnerable:true
            - execute as_server "disgplayer <[nullinvade].uuid> Player yyy88 setName Null setDisplayedInTab false"
            - flag server nullinvaders:->:<[nullinvade]>
            - wait 1t
            - teleport <[nullinvade]> <[player].bed_spawn>
            - stop

nullsummoned:
    type: command
    name: nullsummoned
    description: 0 0 0 - - - - - -
    usage: /nullsummoned
    permission: null.nullsummoned
    script:
    - if <server.has_flag[nullwatch]>:
        - stop
    - adjust <server.flag[null]> visible:false
    - teleport <server.flag[null]> <server.flag[nullisangry].up[100]>
    - spawn lightning_bolt <server.flag[nullisangry].up[1]>
    - wait 1t
    - flag server nullisangry:!
    - flag server nullwatch:! expire:1m

nullhappyface:
    type: command
    name: nullhappyface
    description: =)
    usage: /nullhappyface
    permission: null.happyface
    script:
    - foreach <server.online_players> as:player:
        - execute as_server "execute as <[player].name> at @s run teleport <[player].name> ~ ~ ~ <[player].location.yaw.add[180]> <[player].location.pitch.mul[-1]>
        - execute as_server "execute as <[player].name> at @s run playsound minecraft:custom.textmadness1 master <[player].name> ~ ~ ~ 100 0.5"
    - actionbar =) targets:<server.online_players>

## WARNING: This command does NOT work if you don't have a build in there!!!
nullmaze:
    type: command
    name: nullmaze
    description: IKNOWHATYOUFEAR
    usage: /nullmaze
    permission: null.maze
    script:
    - define randomplayer <server.online_players.random>
    - flag <[randomplayer]> whereiwas:<[randomplayer].location>
    - flag <[randomplayer]> iamhere expire:2m
    - execute as_server "execute as <[randomplayer].name> in minecraft:the_end run tp @s -29999885.00 184.00 -29999882.01 -1079.60 2.10"
    - execute as_server "gamemode adventure <[randomplayer].name>"

nullOpenGL:
    type: command
    name: nullOpenGL
    description: OpenGL Error: 0 (Here I am.)
    usage: /nullOpenGL
    permission: null.maze
    script:
    - announce "<yellow>OpenGL Error<white>: 1282 (Invalid operation)"
    - wait 1s
    - announce "<yellow>OpenGL Error<white>: 1282 (Invalid operation)"
    - wait 1s
    - announce "<yellow>OpenGL Error<white>: 1282 (Invalid operation)"
    - wait 1s
    - announce "<yellow>OpenGL Error<white>: 1282 (Invalid operation)"
    - wait 6s
    - announce "<yellow>OpenGL Error<white>: 0 (Here I am.)"
    - playsound <server.online_players> sound:ambient.cave pitch:0.5

nullFall:
    type: command
    name: nullFall
    description: Null Fall
    usage: /nullFall
    permission: null.fall
    script:
    - define randomplayer <server.online_players.random>
    - define I 0
    - repeat 50:
        - if <[randomplayer].location.block.above[<[I]>].material.name> == air:
            - define I:++
        - else:
            - stop
    - execute as_server "effect give <[randomplayer].name> minecraft:blindness 100 250 true"
    - teleport <[randomplayer]> <[randomplayer].location.above[<[I]>]>
    - execute as_server "effect give <[randomplayer].name> minecraft:slow_falling 25 2 true"
    - wait 0.5s
    - execute as_server "effect clear <[randomplayer].name> minecraft:blindness"

nullHost:
    type: command
    name: nullHost
    description: xXram2dieXx
    usage: /nullHost
    permission: null.host
    script:
    - if <server.has_flag[ramwashere]>:
        - stop
    - if <world[world].is_day>:
        - stop
    - flag server ramwashere expire:20m
    - announce "<white>Local game hosted on port [<green><&k>00000<white>]"
    - wait 25s
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.joined","with":["xXram2dieXx"],"color":"yellow"}'
    - execute as_server "nulltimeset midnight"
    - define randomplayer <server.online_players.random>
    - spawn <[randomplayer].location.above[100]> villager save:ram2die
    - flag server ram2die:<entry[ram2die].spawned_entity>
    - execute as_server "disgplayer <server.flag[ram2die].uuid> Player  xXram2d1eXx setName xXram2dieXx setDisplayedInTab false setNameVisible True"
    - execute as_server "spreadplayers <world[world].spawn_location.x> <world[world].spawn_location.z> 1 2 false <server.flag[ram2die].uuid>"
    - wait 25s
    - announce "<&lt>xXram2dieXx<&gt> 48656c6c6f3f"
    - execute as_server "nulltimeset midnight"
    - playsound <server.online_players> sound:ambient.cave
    - wait 25s
    - announce "<&lt>xXram2dieXx<&gt> 486f772064696420796f7520666f756e642074686973207365727665723f"
    - execute as_server "nulltimeset midnight"
    - playsound <server.online_players> sound:ambient.cave
    - wait 25s
    - announce "<&lt>xXram2dieXx<&gt> 446f20796f752077616e7420746f20626520667269656e64733f"
    - execute as_server "nulltimeset midnight"
    - playsound <server.online_players> sound:ambient.cave
    - wait 25s
    - announce "<&lt>xXram2dieXx<&gt> 4c656176652e"
    - execute as_server "nulltimeset midnight"
    - playsound <server.online_players> sound:ambient.cave
    - wait 25s
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.left","with":["xXram2dieXx"],"color":"yellow"}'
    - teleport <server.flag[ram2die]> <server.flag[ram2die].location.below[100]>
    - kill <server.flag[ram2die]>
    - flag server ram2die:!

nullblackthing:
    type: command
    name: nullblackthing
    description: . . .
    usage: /nullblackthing
    permission: null.blackthing
    script:
    - define randomplayer <server.online_players.random>
    - define yaw <[randomplayer].location.yaw>
    - define pitch <[randomplayer].location.pitch>
    - spawn armor_stand <[randomplayer].location.above[20]> save:blackthing
    - define target <entry[blackthing].spawned_entity>
    - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 10 30 false <[target].uuid>"
    - flag server blackthing:->:<[target]>
    - adjust <[target]> invulnerable:true
    - adjust <[target]> visible:false
    - adjust <[target]> gravity:false
    - flag <[target]> itsame

nullhole:
    type: command
    name: nullhole
    description: Redstone Torch
    usage: /nullhole
    permission: null.hole
    script:
    - define randomplayer <server.online_players.random>
    - define howfar <util.random.int[10].to[100]>
    - define block <[randomplayer].location.forward[<[howfar]>].block>
    - if <[block].material.name> == air:
        - define I 0
        - while <[block].down[<[I]>].material.name> == air:
            - define I:++
        - define newblock <[block].down[<[I].sub[1]>]>
        - modifyblock <[newblock].add[1,0,0]> redstone_torch
        - modifyblock <[newblock].add[-1,0,0]> redstone_torch
        - modifyblock <[newblock].add[0,0,-1]> redstone_torch
        - modifyblock <[newblock].add[0,0,1]> redstone_torch
        - execute as_server "fill <[newblock].x> <[newblock].y> <[newblock].z> <[newblock].x> -64 <[newblock].z> air"
    - if <[block].material.name> != air:
        - define I 0
        - while <[block].up[<[I]>].material.name> != air:
            - define I:++
        - define newblock <[block].up[<[I]>]>
        - modifyblock <[newblock].add[1,0,0]> redstone_torch
        - modifyblock <[newblock].add[-1,0,0]> redstone_torch
        - modifyblock <[newblock].add[0,0,-1]> redstone_torch
        - modifyblock <[newblock].add[0,0,1]> redstone_torch
        - execute as_server "fill <[newblock].x> <[newblock].y> <[newblock].z> <[newblock].x> -64 <[newblock].z> air"

nulljumpscare:
    type: command
    name: nulljumpscare
    description: AGH- WHAT THE-
    usage: /nulljumpscare
    permission: null.jumpscare
    script:
    - define randomplayer <server.online_players.random>
    - if <context.args.get[1].exists>:
        - define randomplayer <server.match_player[<context.args.get[1]>]>
    - define randomscare <util.random_chance[90]>
    - define randomloc <[randomplayer].location>
    - if <[randomscare]>:
        - define blockbehind 1
        - repeat 5:
            - if <[randomplayer].location.backward[<[blockbehind]>].block.material.name> != air:
                - stop
            - define blockbehind:++
        - define newbehind <[randomplayer].location.backward[<[blockbehind]>]>
        - spawn <[randomplayer].location.above[50]> villager save:nulljumpscare
        - adjust <entry[nulljumpscare].spawned_entity> has_ai:false
        - adjust <entry[nulljumpscare].spawned_entity> persistent:true
        - adjust <entry[nulljumpscare].spawned_entity> visible:false
        - define null <entry[nulljumpscare].spawned_entity>
        - wait 1t
        - execute as_server "disgplayer <[null].uuid> Player yyy88 setName Null setDisplayedInTab false"
        - wait 0.5s
        - teleport <[null]> <[newbehind]>
        - execute as_server "execute as <[null].uuid> at @s run tp @s ~ ~ ~ facing entity <[randomplayer].name>"
        - wait 0.5s
        - execute as_server "execute as <[randomplayer].name> at @s run teleport <[randomplayer].name> ~ ~ ~ facing <[newbehind].x> <[newbehind].y> <[newbehind].z>"
        - adjust <[null]> visible:true
        - hurt 5 <[randomplayer]>
        - execute as_server "execute as <[randomplayer].name> at <[randomplayer].name> run playsound minecraft:custom.randomjumpscare master <[randomplayer].name> ~ ~ ~ 0.35"
        - wait 1s
        - execute as_server "teleport <[null].uuid> ~ ~400 ~"
        - wait 1t
        - kill <[null]>
    - else:
        - execute as_server "nullendgame <[randomplayer].name>"

nullbreak:
    type: command
    name: nullbreak
    description: <red>Warning!! This command WILL greif.
    usage: /nullbreak
    permission: null.break
    script:
    - define randomplayer <server.online_players.random>
    - execute as_server "execute as <[randomplayer].name> at @s run fill ~5 ~5 ~5 ~ ~ ~ structure_void destroy"

nullrandomlook:
    type: command
    name: nullrandomlook
    description: Wha-
    usage: /nullrandomlook
    permission: null.randomlook
    script:
    - define randomplayer <server.online_players.random>
    - repeat 4:
        - execute as_server "execute as <[randomplayer].name> at @s run teleport <[randomplayer].name> ~ ~ ~ <util.random.int[0].to[360]> <util.random.int[0].to[90]>"
        - hurt 1 <[randomplayer]>
        - wait 0.25s

nullinventory:
    type: command
    name: nullinventory
    description: help
    usage: /nullinventory
    permission: null.inventory
    script:
    - define randomplayer <server.online_players.random>
    - flag <[randomplayer]> inventoryfreeze
    - flag <[randomplayer]> plsopeninventory

nullgoodluck:
    type: command
    name: nullgoodluck
    description: Good luck. =)
    usage: /nullgoodluck
    permission: null.goodluck
    script:
    - execute as_server "effect give @a minecraft:blindness 100 100 true"
    - execute as_server "nulltimeset midnight"
    - foreach <server.online_players> as:player:
        - if <[player].health> <= 0:
            - foreach next
        - flag <[player]> boots:<[player].inventory.slot[boots]>
        - execute as_server 'item replace entity <[player].name> armor.feet with stick[minecraft:equippable={slot:feet,camera_overlay:"thebrokenscript:screen/goodluck"}]'
    - flag <server.online_players> inventoryfreeze expire:4s
    - wait 4s
    - foreach <server.online_players_flagged[boots]> as:player:
        - inventory set o:<[player].flag[boots]> d:<[player].inventory> slot:BOOTS
        - flag <[player]> boots:!
    - execute as_server "effect clear @a minecraft:blindness

nullplaysound:
    type: command
    name: nullplaysound
    description: Don't hear it too much.
    usage: /nullplaysound
    permission: null.playsound
    script:
    - playsound <server.online_players> sound:<list[music_disc_13|ambient_cave|music_disc_11].random> pitch:<util.random.decimal[0.2].to[1]>

nullbook:
    type: command
    name: nullbook
    description: null.err.object.err.null.object.alone.3.not.behind.entitytype:player.receiveddata.invalid.reboot.failed.reset.playerdata:00F9219492D94210F812
    usage: /nullbook
    permission: null.book
    script:
    - define randomplayer <server.online_players.random>
    - execute as_server 'give <[randomplayer].name> written_book[written_book_content={pages:[[["null.err.object.err.null.object.alone.3.not.behind.entitytype:player.receiveddata.invalid.reboot.failed.reset.playerdata:00F9219492D94210F812"]]],title:null,author:null}] 1'

nullgift:
    type: command
    name: nullgift
    description: 10 diamonds.
    usage: /nullgift
    permission: null.gift
    script:
    - define randomplayer <server.online_players.random>
    - define block <[randomplayer].location.backward_flat[50].highest.block.above[1]>
    - define whichchest <util.random.int[1].to[2]>
    - if <[whichchest]> == 1:
        - execute as_server 'setblock <[block].x> <[block].y> <[block].z> minecraft:chest[facing=east,type=single,waterlogged=false]{Items:[{Slot:13b,count:10,id:"minecraft:diamond"}],components:{}}'
    - if <[whichchest]> == 2:
        - execute as_server 'setblock <[block].x> <[block].y> <[block].z> minecraft:chest[facing=east,type=single,waterlogged=false]{Items:[{Slot:4b,count:1,id:"minecraft:redstone_torch"},{Slot:12b,count:1,id:"minecraft:redstone_torch"},{Slot:13b,count:5,id:"minecraft:diamond"},{Slot:14b,count:1,id:"minecraft:redstone_torch"},{Slot:22b,count:1,id:"minecraft:redstone_torch"}],components:{}}'
        - execute as_server 'setblock <[block].x.add[1]> <[block].y> <[block].z> minecraft:oak_wall_sign[facing=east,waterlogged=false]{back_text:{color:"black",has_glowing_text:0b,messages:['""','""','""','""']},components:{},front_text:{color:"black",has_glowing_text:0b,messages:["Gift","","",""]},is_waxed:0b}'

nullslowsong:
    type: command
    name: nullslowsong
    description: Slow song plays.
    usage: /nullslowsong
    permission: null.slowsong
    script:
    - execute as_server "stopsound @a music"
    - define random <util.random.int[1].to[2]>
    - if <[random]> == 1:
        - execute as_server "execute as @a at @s run playsound minecraft:custom.falsecalm2 master @a ~ ~ ~ 0.45"
    - else:
        - execute as_server "execute as @a at @s run playsound minecraft:custom.falsesubwooferlullaby master @a ~ ~ ~ 0.3"

nullfire:
    type: command
    name: nullfire
    description: Fire.
    usage: /nullfire
    permission: null.fire
    script:
    - define randomplayer <server.online_players.random>
    - adjust <[randomplayer]> visual_fire:true
    - repeat 3:
        - hurt 1 <[randomplayer]> cause:FIRE
        - wait 1s
    - adjust <[randomplayer]> visual_fire:false

nulldisc11:
    type: command
    name: nulldisc11
    description: Disc 11.
    usage: /nulldisc11
    permission: null.disc11
    script:
    - define randomplayer <server.online_players.random>
    - give <[randomplayer]> music_disc_11

nullfaraway:
    type: command
    name: nullfaraway
    description: Faraway.
    usage: /nullfaraway
    permission: null.faraway
    script:
    - define randomplayer <server.online_players.random>
    - define block <[randomplayer].location.backward_flat[100].highest.block.above[1]>
    - define chance <util.random_chance[70]>
    - if <[chance]>:
        - stop
    - spawn <[randomplayer].location.above[50]> villager save:faraway
    - define target <entry[faraway].spawned_entity>
    - flag server faraway:->:<[target]>
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ <[yaw]> <[pitch]>"
    - execute as_server "disgplayer <[target].uuid> Player Timbothany setNameVisible false"
    - execute as_server "teleport <[target].uuid> <[block].x> <[block].y> <[block].z>"
    - execute as_server "setblock <[block].x> <[block].y> <[block].z> light[level=15]"
    - execute as_server "setblock <[block].x> <[block].y.add[1]> <[block].z> light[level=15]"
    - adjust <[target]> invulnerable:true
    - adjust <[target]> has_ai:false

nullr2:
    type: command
    name: nullr2
    description: R2.
    usage: /nullr2
    permission: null.r2
    script:
    - define time <world[world].time>
    - if <[time]> >= 0 && <[time]> < 12300 || <[time]> >= 23850:
        - stop
    - if <util.random_chance[70]>:
        - stop
    - flag server spawningr2
    - define randomplayer <server.online_players.random>
    - spawn <[randomplayer].location.above[50]> zombified_piglin save:r2
    - define r2 <entry[r2].spawned_entity>
    - adjust <[r2]> persistent:true
    - adjust <[r2]> has_ai:false
    - adjust <[r2]> visible:false
    - execute as_server "attribute <[r2].uuid> minecraft:step_height base set 1.5"
    - execute as_server "attribute <[r2].uuid> minecraft:jump_strength base set 0"
    - flag server r2:->:<[r2]>
    - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 20 20 false <[r2].uuid>"
    - define yaw <[randomplayer].location.yaw>
    - define pitch <[randomplayer].location.pitch>
    - wait 1t
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ 0 0"
    - flag <[randomplayer]> nomove
    - wait 1t
    - execute as_server 'execute at <[randomplayer].name> run summon armor_stand ~ ~ ~ {Invisible:1b,NoGravity:1b,Marker:0b,Pose:{RightArm:[-90f,0f,0f]},ShowArms:0b,equipment:{mainhand:{id:stick,components:{item_model:"thebrokenscript:error5"},count:1}},drop_chances:{mainhand:0f}}'
    - wait 1t
    - define armor_stand <[randomplayer].target>
    - flag <[randomplayer]> nomove:!
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ <[yaw]> <[pitch]>"
    - execute as_server "disgplayer <[r2].uuid> Player PolloProMC setNameVisible false setInvisible true"
    - execute as_server "item replace entity <[r2].uuid> weapon.mainhand with air"
    - adjust <[r2]> invulnerable:true
    - adjust <[r2]> custom_name:r2
    - playsound <server.online_players> sound:ambient.cave
    - define advancement? <util.random_chance[30]>
    - if <[advancement?]>:
        - execute as_server "nullhereiam"
    - flag server spawningr2:!
    - flag <[r2]> thearmor:<[armor_stand]>
    - define chaser <util.random_chance[50]>
    - if <[chaser]>:
        - flag <[r2]> chaser

nullfreezetime:
    type: command
    name: nullfreezetime
    description: Why isn't the sun moving?
    usage: /nullfreezetime
    permission: null.freezetime
    script:
    - define randomtime <util.random.int[60].to[180]>
    - execute as_server "gamerule doDaylightCycle false"
    - wait <[randomtime]>s
    - execute as_server "gamerule doDaylightCycle true"

nulllightning:
    type: command
    name: nulllightning
    description: lightning
    usage: /nulllightning
    permission: null.lightning
    script:
    - define randomplayer <server.online_players.random>
    - define randomx <util.random.int[-10].to[10]>
    - define randomz <util.random.int[-10].to[10]>
    - spawn lightning_bolt <[randomplayer].location.add[<[randomx]>,0,<[randomz]>].highest.block>

nullfalsevillager:
    type: command
    name: nullfalsevillager
    description: Circuit is real.
    usage: /nullfalsevillager
    permission: null.falsevillager
    script:
    - define randomplayer <server.online_players.random>
    - if !<[randomplayer].location.find_entities[villager].within[30].get[1].exists>:
        - stop
    - define randomwhere <util.random.int[1].to[2]>
    - if <[randomwhere]> == 1:
        - define randomx <util.random.int[5].to[10]>
    - else:
        - define randomx <util.random.int[-5].to[-10]>
    - define randomwhere <util.random.int[1].to[2]>
    - if <[randomwhere]> == 1:
        - define randomz <util.random.int[5].to[10]>
    - else:
        - define randomz <util.random.int[-5].to[-10]>
    - spawn villager <[randomplayer].location.above[50]> save:unsusvillager
    - flag server unsusvillager:<entry[unsusvillager].spawned_entity>
    - adjust <server.flag[unsusvillager]> custom_name:TESTIFICATE
    - define block <[randomplayer].location.add[<[randomx]>,0,<[randomz]>].block>
    - if <[block].material.name> == air:
        - define I 0
        - while <[block].down[<[I]>].material.name> == air:
            - define I:++
        - define block <[block].down[<[I].sub[1]>]>
    - else if <[block].material.name> != air:
        - define I 0
        - while <[block].up[<[I]>].material.name> != air:
            - define I:++
        - define block <[block].up[<[I]>]>
    - teleport <server.flag[unsusvillager]> <[block]>
    - spawn <[randomplayer].location.above[50]> zombified_piglin save:circuitattacker
    - flag server circuitattacker:<entry[circuitattacker].spawned_entity>
    - execute as_server "disgplayer <server.flag[circuitattacker].uuid> Player yyy88 setName Circuit setNameVisible false"
    - adjust <server.flag[circuitattacker]> custom_name:Circuit
    - teleport <server.flag[circuitattacker]> <server.flag[unsusvillager].location.above[200]>
    - adjust <server.flag[circuitattacker]> persistent:true
    - adjust <server.flag[unsusvillager]> invulnerable:false
    - adjust <server.flag[circuitattacker]> invulnerable:true
    - adjust <server.flag[circuitattacker]> has_ai:false

nullbsod:
    type: command
    name: nullbsod
    description: :(
    usage: /nullbsod
    permission: null.bsod
    script:
    - foreach <server.online_players> as:player:
        - if <[player].health> <= 0:
            - foreach next
        - if <[player].has_flag[boots]>:
            - foreach next
        - execute as_server "execute as <[player].name> at @s run playsound minecraft:custom.bsod master @s ~ ~ ~ 100"
        - execute as_server "effect give <[player].name> blindness 9 100 true"
        - flag <[player]> boots:<[player].inventory.slot[boots]>
        - execute as_server 'item replace entity <[player].name> armor.feet with stick[minecraft:equippable={slot:feet,camera_overlay:"thebrokenscript:screen/bsodd"}]'
    - flag <server.online_players> inventoryfreeze expire:9s
    - wait 9s
    - foreach <server.online_players_flagged[boots]> as:player:
        - inventory set o:<[player].flag[boots]> d:<[player].inventory> slot:BOOTS
        - flag <[player]> boots:!

nullflying:
    type: command
    name: nullflying
    description: Null flying.
    usage: /nullflying
    permission: null.flying
    script:
    - if <world[world].is_day>:
        - stop
    - define randomplayer <server.online_players.random>
    - define block <[randomplayer].location.above[100]>
    - if <[block].material.name> != air:
        - define I 0
        - while <[block].above[<[I]>].material.name> != air:
            - define i:++
        - define block <[block].above[<[I].add[100]>]>
    - spawn <[block]> villager save:nullflying
    - flag server nullflying:->:<entry[nullflying].spawned_entity>
    - define nullflying <entry[nullflying].spawned_entity>
    - adjust <[nullflying]> has_ai:false
    - adjust <[nullflying]> invulnerable:true
    - adjust <[nullflying]> persistent:true
    - execute as_server "disgplayer <[nullflying].uuid> Player yyy88 setName MobIsmissingID setDisplayedInTab false"
    - execute as_server "execute as @a at @s run playsound minecraft:custom.nullsad master @s ~ ~ ~"

nullcircuitdisguised:
    type: command
    name: nullcircuitdisguised
    description: Circuit as the player.
    usage: /nullcircuitdisguised
    permission: null.circuitdisguised
    script:
    - if <server.has_flag[circuit]>:
        - stop
    - define randomplayer <server.online_players.random>
    - define randomwhere <util.random.int[1].to[2]>
    - if <[randomwhere]> == 1:
        - define randomx <util.random.int[5].to[10]>
    - else:
        - define randomx <util.random.int[-5].to[-10]>
    - define randomwhere <util.random.int[1].to[2]>
    - if <[randomwhere]> == 1:
        - define randomz <util.random.int[5].to[10]>
    - else:
        - define randomz <util.random.int[-5].to[-10]>
    - spawn <[randomplayer].location.above[400]> zombified_piglin save:circuitdisguised
    - define block <[randomplayer].location.add[<[randomx]>,0,<[randomz]>].block>
    - if <[block].material.name> == air:
        - define I 0
        - while <[block].down[<[I]>].material.name> == air:
            - define I:++
        - define block <[block].down[<[I].sub[1]>]>
    - else if <[block].material.name> != air:
        - define I 0
        - while <[block].up[<[I]>].material.name> != air:
            - define I:++
        - define block <[block].up[<[I]>]>
    - flag server circuit:<entry[circuitdisguised].spawned_entity>
    - teleport <server.flag[circuit]> <[block]>
    - define randomplayer2 <server.online_players.random.name>
    - execute as_server "disgplayer <server.flag[circuit].uuid> Player <[randomplayer2]> setHelmet <[randomplayer].inventory.slot[HEAD].material.name> setChestplate <[randomplayer].inventory.slot[CHESTPLATE].material.name> setLeggings <[randomplayer].inventory.slot[LEGGINGS].material.name> setBoots <[randomplayer].inventory.slot[BOOTS].material.name>"
    - adjust <server.flag[circuit]> custom_name:<[randomplayer2]>
    - adjust <server.flag[circuit]> persistent:true

nullnamemob:
    type: command
    name: nullnamemob
    description: 01001000 01100101 00100000 01110111 01101001 01101100 01101100 00100000 01100110 01101001 01101110 01100100 00100000 01111001 01101111 01110101
    usage: /nullnamemob
    permission: null.namemob
    script:
    - define randomplayer <server.online_players.random>
    - define randommob <[randomplayer].location.find_entities[zombie|skeleton|creeper|spider|husk|enderman|witch].within[30].get[1]>
    - define randomchance <util.random_chance[70]>
    - if <[randomchance]> == 70:
        - adjust <[randommob]> "custom_name:01001000 01100101 00100000 01110111 01101001 01101100 01101100 00100000 01100110 01101001 01101110 01100100 00100000 01111001 01101111 01110101"
    - else:
        - adjust <[randommob]> "custom_name:01001000 01100101 01101100 01101100 01101111"

nullishere:
    type: command
    name: nullishere
    description: Null Is Here.
    usage: /nullishere
    permission: null.ishere
    script:
    - waituntil !<server.has_flag[nullishere]> rate:1s
    - define randomplayer <server.online_players.random>
    - if <context.args.get[1].exists>:
        - define randomplayer <server.match_player[<context.args.get[1]>]>
    - define randomwhere <util.random.int[1].to[2]>
    - if <[randomwhere]> == 1:
        - define randomx 30
    - else:
        - define randomx -30
    - define randomwhere <util.random.int[1].to[2]>
    - if <[randomwhere]> == 1:
        - define randomz 30
    - else:
        - define randomz -30
    - spawn <[randomplayer].location.above[50]> villager save:nullishere
    - adjust <entry[nullishere].spawned_entity> has_ai:false
    - adjust <entry[nullishere].spawned_entity> persistent:true
    - define null <entry[nullishere].spawned_entity>
    - execute as_server "disgplayer <[null].uuid> Player yyy88 setName Null setDisplayedInTab false"
    - wait 1t
    - teleport <[null]> <[randomplayer].location.add[<[randomx]>,0,<[randomz]>]>
    - flag server oneofus:<[randomplayer]>
    - flag server nullwatch
    - flag server nullishere:<[null]>

nullcircuit:
    type: command
    name: nullcircuit
    description: Circuit.
    usage: /nullcircuit
    permission: null.circuit
    script:
    - define randomplayer <server.online_players.random>
    - if <[randomplayer].location.world.is_day>:
        - stop
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.joined","with":["<[randomplayer].name>"],"color":"yellow"}'
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ 0 0"
    - spawn <[randomplayer].location.above[50]> zombified_piglin save:circuitnull
    - flag server circuitnull:<entry[circuitnull].spawned_entity>
    - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 30 30 false <server.flag[circuitnull].uuid>"
    - if <[randomplayer].world.name> == world_nether:
        - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 30 30 under <[randomplayer].y> false <server.flag[circuitnull].uuid>"
    - flag <[randomplayer]> nomove:!
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ <[yaw]> <[pitch]>"
    - adjust <server.flag[circuitnull]> persistent:true
    - execute as_server "data modify entity <server.flag[circuitnull].uuid> AngryAt set from entity <[randomplayer].uuid> UUID"
    - execute as_server "effect give <server.flag[circuitnull].uuid> speed infinite 3 true"
    - define ironoraxe <util.random_chance[70]>
    - if <[ironoraxe]>:
        - execute as_server "item replace entity <server.flag[circuitnull].uuid> weapon.mainhand with minecraft:iron_pickaxe"
    - else:
        - execute as_server "item replace entity <server.flag[circuitnull].uuid> weapon.mainhand with minecraft:iron_axe"
    - execute as_server "disgplayer <server.flag[circuitnull].uuid> Player yyy88 setNameVisible false setHelmet <[randomplayer].inventory.slot[HEAD].material.name> setChestplate <[randomplayer].inventory.slot[CHESTPLATE].material.name> setLeggings <[randomplayer].inventory.slot[LEGGINGS].material.name> setBoots <[randomplayer].inventory.slot[BOOTS].material.name>"
    - adjust <server.flag[circuitnull]> invulnerable:true
    - adjust <server.flag[circuitnull]> persistent:true
    - adjust <server.flag[circuitnull]> custom_name:Circuit
    - flag <[randomplayer]> broisrealangry

nullendgame:
    type: command
    name: nullendgame
    description: HERE I AM
    usage: /nullendgame
    permission: null.endgame
    script:
    - define dude <server.match_player[<context.args.get[1]>]>
    - if <[dude].location.forward_flat[<[1]>].block.material.name> != air:
        - stop
    - spawn <player.location.above[50]> villager save:nullendgame
    - adjust <entry[nullendgame].spawned_entity> has_ai:false
    - adjust <entry[nullendgame].spawned_entity> persistent:true
    - define null <entry[nullendgame].spawned_entity>
    - execute as_server "disgplayer <[null].uuid> Player yyy88 setName Null setDisplayedInTab false"
    - wait 0.5s
    - teleport <[null]> <[dude].location.forward_flat[1]>
    - wait 2t
    - execute as_server "execute as <[null].uuid> at @s run teleport @s ~ ~ ~ facing entity <[dude].name>"
    - execute as_server "execute as <[dude].name> at <[dude].name> run playsound minecraft:custom.theendisnear master <[dude].name> ~ ~ ~ 0.1"
    - repeat 25:
        - execute as_server "execute as <[null].uuid> at @s run teleport @s ~ ~ ~ facing entity <[dude].name>"
        - narrate "<dark_red>HERE I AM" targets:<[dude]>
        - narrate <dark_red><&k>VOIDNULLSILUETTANOMALY targets:<[dude]>
        - execute as_server "execute as <[dude].name> at @s run teleport @s ~ ~ ~ facing entity <[null].uuid>"
        - wait 1t
    - kill <[dude]>
    - execute as_server "nullcrash <[dude].name>"
    - wait 0.3s
    - kick <[dude]> "reason:Here I am."
    - wait 1s
    - teleport <[null]> <[null].location.below[400]>
    - wait 1t
    - kill <[null]>

nullstructure:
    type: command
    name: nullstructure
    description: Random structure.
    usage: /nullstructure
    permission: null.structure
    script:
    - if !<context.args.get[1].exists>:
        - if <util.random_chance[20]>:
            - execute as_server "nullhole"
            - narrate "hole"
            - stop
    - define randomplayer <server.online_players.random>
    - define howfar <util.random.int[30].to[100]>
    - define block <[randomplayer].location.backward_flat[<[howfar]>].block>
    - define structure <list[house2|cavebase|trap1|house3|crossfly|generationbug1|heavenportal|clanbuildoverhaul|gorestructure|totem|burnfractal|carcas|trap2|crosses|magmacross|randomwoodstructure|fractal3|glassfractal].random>
    - if <context.args.get[1].exists>:
        - define structure <context.args.get[1]>
    - narrate <[structure]>
    - if <[block].material.name> == air:
        - define I 0
        - while <[block].down[<[I]>].material.name> == air:
            - define I:++
        - define newblock <[block].down[<[I].sub[1]>]>
    - else if <[block].material.name> != air:
        - define I 0
        - while <[block].up[<[I]>].material.name> != air:
            - define I:++
        - define newblock <[block].up[<[I]>]>
    - wait 1t
    - if <[structure]> == crosses:
        - define block <[randomplayer].location.backward_flat[<[howfar]>].block.above[50]>
        - define newblock <[block]>
    - if <[structure]> == cavebase:
        - define block <[randomplayer].location.backward_flat[<[howfar]>].block.below[<util.random.int[20].to[40]>]>
        - define newblock <[block]>
    - narrate "<[block]>"
    - execute as_server 'setblock <[newblock].x> <[newblock].y> <[newblock].z> minecraft:structure_block[mode=load]{author:"?",ignoreEntities:1b,integrity:1.0f,metadata:"",mirror:"NONE",mode:"LOAD",name:"minecraft:<[structure]>",posX:0,posY:0,posZ:0,powered:0b,rotation:"NONE",seed:0L,showair:0b,showboundingbox:1b,sizeX:6,sizeY:6,sizeZ:6}'
    - define whatblock <[newblock].add[0,-1,0].material.name>
    - define whatblocklocation <[newblock].add[0,-1,0]>
    - wait 1t
    - modifyblock <[whatblocklocation]> redstone_torch
    - wait 1t
    - modifyblock <[whatblocklocation]> <[whatblock]>

nullrandomtext:
    type: command
    name: nullrandomtext
    description: A random text appears.
    usage: /nullrandomtext
    permission: null.randomtext
    script:
    - define randomtext <list[I can see you.|Can you see me?|It was all your fault.|Help us.|I am right behind you.|<red>I am right behind you.|<white>null|null.err|000|<&k>AAAAAAAAA|<reset><yellow>Null joined the game|<yellow>Null left the game|<yellow>joined the game].random>
    - announce <[randomtext]>

nullwater:
    type: command
    name: nullwater
    description: Water.
    usage: /nullwater
    permission: null.water
    script:
    - define randomplayer <server.online_players.random>
    - define howmuch <util.random.int[50].to[60]>
    - define block <[randomplayer].location.backward_flat[50].above[<[howmuch]>]>
    - if <[block].material.name> != air:
        - define I 0
        - while <[block].above[<[I]>].material.name> != air:
            - define i:++
        - define block <[block].above[<[I].add[<[howmuch]>]>]>
    - modifyblock <[block]> water

nullbedrock:
    type: command
    name: nullbedrock
    description: Bedrock
    usage: /nullbedrock
    permission: null.bedrock
    script:
    - define randomplayer <server.online_players.random>
    - define howmuch <util.random.int[50].to[60]>
    - define block <[randomplayer].location.backward_flat[50].above[<[howmuch]>]>
    - if <[block].material.name> != air:
        - define I 0
        - while <[block].above[<[I]>].material.name> != air:
            - define i:++
        - define block <[block].above[<[I].add[<[howmuch]>]>]>
    - modifyblock <[block]> bedrock

nullhungry:
    type: command
    name: nullhungry
    description: hungry
    usage: /nullhungry
    permission: null.hungry
    script:
    - define randomplayer <server.online_players.random>
    - adjust <[randomplayer]> food_level:<util.random.int[1].to[10]>

nulldenizenwarning:
    type: command
    name: nulldenizenwarning
    description: Here I am.
    usage: /nulldenizenwarning
    permission: null.denizenwarning
    script:
    - announce "<yellow>[Denizen]<red> Recent strong system warnings, scripters need to address ASAP (check earlier console logs for details):"
    - announce "<red>- Here I am."
    - wait 1s
    - playsound <server.online_players> sound:ambient.cave

nullheartbeat:
    type: command
    name: nullheartbeat
    description: Heartbeat
    usage: /nullheartbeat
    permission: null.heartbeat
    script:
    - execute as_server "nulltimeset night"
    - execute as_server "execute as @a at @s run playsound minecraft:custom.heartbeat master @s ~ ~ ~ 100"
    - if <util.random_chance[50]>:
        - playsound <server.online_players> sound:ambient.cave

nulldoors:
    type: command
    name: nulldoors
    description: Doors.
    usage: /nulldoors
    permission: null.doors
    script:
    - define randomplayer <server.online_players.random>
    - define doors <[randomplayer].location.find_blocks[oak_door].within[6]>
    - foreach <[doors]> as:door:
        - if <[door].material.contains[half=TOP]>:
            - foreach next
        - define material <[door].material>
        - define splitdoor1 <[material].replace[;].with[ ].replace[=].with[ ].split>
        - define facing <[splitdoor1].get[2].to_lowercase>
        - modifyblock <[door]> oak_door[switched=true;direction=<[facing]>]

nullplacehello:
    type: command
    name: nullplacehello
    description: Hello.
    usage: /nullplacehello
    permission: null.placehello
    script:
    - define randomplayer <server.online_players.random>
    - define door <[randomplayer].location.find_blocks[*_door].within[12].get[1]>
    - modifyblock <[door]> brown_stained_glass

nulljframe5:
    type: command
    name: nulljframe5
    description: black box
    usage: /nulljframe5
    permission: null.jframe5
    script:
    - foreach <server.online_players> as:player:
        - if <[player].health> <= 0:
            - foreach next
        - flag <[player]> boots:<[player].inventory.slot[boots]>
        - execute as_server 'item replace entity <[player].name> armor.feet with stick[minecraft:equippable={slot:feet,camera_overlay:"thebrokenscript:screen/frame5"}]'
    - flag <server.online_players> inventoryfreeze expire:1s
    - wait 1s
    - foreach <server.online_players_flagged[boots]> as:player:
        - inventory set o:<[player].flag[boots]> d:<[player].inventory> slot:BOOTS
        - flag <[player]> boots:!

nullplacebase:
    type: command
    name: nullplacebase
    description: black box
    usage: /nullplacebase
    permission: null.placebase
    script:
    - foreach <server.online_players> as:player:
        - if <[player].calculated_bed_spawn.exists>:
            - define randomlist <list[NETHERRACK|REDSTONE_TORCH].random>
            - define bedspawn <[player].calculated_bed_spawn>
            - if <server.flag[reputation]> == GOOD:
                - define randomlist <list[NETHERRACK|REDSTONE_TORCH|OAK_SIGN].random>
            - else if <server.flag[reputation]> == BAD:
                - define randomlist <list[NETHERRACK|REDSTONE_TORCH|LAVA|TNT].random>
            - if <[randomlist]> == TNT:
                - execute as_server "summon minecraft:tnt <[bedspawn].x> <[bedspawn].y> <[bedspawn].z> {fuse:0}"
                - stop
            - modifyblock <[bedspawn].block> <[randomlist]>
            - if <[randomlist]> == OAK_SIGN:
                - adjust <[bedspawn].block> "sign_contents:Nice house"
            - stop

nullchase:
    type: command
    name: nullchase
    description: Null.
    usage: /nullchase
    permission: null.chase
    script:
    - spawn zombified_piglin <context.args.get[1]> save:nullchase
    - define nullchase <entry[nullchase].spawned_entity>
    - adjust <[nullchase]> invulnerable:true
    - define chased <server.match_player[<context.args.get[2]>]>
    - execute as_server "disgplayer <[nullchase].uuid> Player yyy88 setName Null setDisplayedInTab false"
    - execute as_server "effect give <[nullchase].uuid> minecraft:speed infinite 3 true"
    - wait 1t
    - execute as_server "item replace entity <[nullchase].uuid> weapon.mainhand with air"
    - execute as_server "data modify entity <[nullchase].uuid> AngryAt set from entity <[chased].uuid> UUID"
    - execute as_server "execute as <[chased].name> at <[chased].name> run playsound minecraft:custom.circuitchase master <[chased].name> ~ ~ ~ 0.08"
    - execute as_server "execute as <[chased].name> at <[chased].name> run playsound minecraft:custom.nullchase master <[chased].name> ~ ~ ~ 0.4"
    - flag server nullchaser:->:<[nullchase]>
    - while <[nullchase].location.exists>:
        - look <[chased]> <[nullchase].location.above[1]> duration:2t
        - wait 1t

nullnothingiswatching:
    type: command
    name: nullnothingiswatching
    description: A broken promise.
    usage: /nullnothingiswatching
    permission: null.nothingiswatching
    script:
    - define randomplayer <server.online_players.random>
    - spawn zombified_piglin <[randomplayer].location.above[50]> save:nothingiswatching
    - define nothingiswatching <entry[nothingiswatching].spawned_entity>
    - adjust <[nothingiswatching]> invulnerable:true
    - adjust <[nothingiswatching]> persistent:true
    - adjust <[nothingiswatching]> has_ai:true
    - adjust <[nothingiswatching]> visible:false
    - flag server thewatchers:->:<[nothingiswatching]>
    - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 30 40 false <[nothingiswatching].uuid>"
    - execute as_server "disgplayer <[nothingiswatching].uuid> Player PolloProMC setNameVisible false setInvisible true"
    - execute as_server "effect give <[nothingiswatching].uuid> slowness infinite 2 true"
    - execute as_server "item replace entity <[nothingiswatching].uuid> weapon.mainhand with air"
    - spawn item_display <[randomplayer].location.above[50]> save:litnothing
    - define litnothing <entry[litnothing].spawned_entity>
    - execute as_server 'execute as <[litnothing].uuid> run data merge entity @s {item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"thebrokenscript:nothing"}},"transformation":"scale:[ 0.5f, 1.0f, 1.0f]"}'
    - execute as_server "execute as <[litnothing].uuid> run data merge entity @s {transformation:{scale:[ 3.0f, 6.0f, 1.0f]},interpolation_duration:0,interpolation_start:-6000}"
    - flag <[nothingiswatching]> litnothing:<[litnothing]>
    - execute as_server "execute as @a at @s run playsound minecraft:custom.white_noise master @s ~ ~ ~ 0.5"
    - playsound <server.online_players> sound:ambient.cave

nullnothingchase:
    type: command
    name: nullnothingchase
    description: A really broken promise.
    usage: /nullnothingchase
    permission: null.nothingchase
    script:
    - spawn zombified_piglin <context.args.get[1]> save:nothingchaser
    - define nothingchaser <entry[nothingchaser].spawned_entity>
    - adjust <[nothingchaser]> invulnerable:true
    - define chased <server.match_player[<context.args.get[2]>]>
    - execute as_server "disgplayer <[nothingchaser].uuid> Player PolloProMC setNameVisible false setInvisible true"
    - execute as_server "effect give <[nothingchaser].uuid> minecraft:speed infinite 3 true"
    - execute as_server "attribute <[nothingchaser].uuid> minecraft:step_height base set 1.5"
    - execute as_server "attribute <[nothingchaser].uuid> minecraft:jump_strength base set 0"
    - adjust <[nothingchaser]> invulnerable:true
    - adjust <[nothingchaser]> persistent:true
    - adjust <[nothingchaser]> has_ai:true
    - adjust <[nothingchaser]> visible:false
    - execute as_server "data modify entity <[nothingchaser].uuid> AngryAt set from entity <[chased].uuid> UUID"
    - spawn item_display <[chased].location.above[50]> save:litnothing
    - define litnothing <entry[litnothing].spawned_entity>
    - execute as_server 'execute as <[litnothing].uuid> run data merge entity @s {item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"thebrokenscript:nothing"}},"transformation":"scale:[ 0.5f, 1.0f, 1.0f]"}'
    - execute as_server "execute as <[litnothing].uuid> run data merge entity @s {transformation:{scale:[ 3.0f, 6.0f, 1.0f]},interpolation_duration:0,interpolation_start:-6000}"
    - flag <[nothingchaser]> litnothing:<[litnothing]>
    - execute as_server "execute as <[chased].name> at <[chased].name> run playsound minecraft:custom.nullchase master <[chased].name> ~ ~ ~ 0.4"
    - flag server nothingchaser:->:<[nothingchaser]>
    - while <[nothingchaser].location.exists>:
        - execute as_server "item replace entity <[nothingchaser].uuid> weapon.mainhand with air"
        - look <[chased]> <[nothingchaser].location.above[3]> duration:2t
        - if <util.random_chance[1]>:
            - execute as_server "effect give <[chased].name> blindness 2 0 true"
            - wait 1s
            - execute as_server "effect clear <[chased].name> blindness"
        - if <[chased].location.distance[<[nothingchaser].location>]> <= 5:
            - kill <[chased]>
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.nullchase master <player.name> ~ ~ ~ 0.4"
            - teleport <[nothingchaser]> <[nothingchaser].location.below[400]>
            - teleport <[nothingchaser].flag[litnothing]> <[nothingchaser].location.below[400]>
            - kill <[nothingchaser].flag[litnothing]>
            - flag <[nothingchaser]> litnothing:!
            - kill <[nothingchaser]>
            - wait 1t
            - flag server nothingchaser:<-:<[nothingchaser]>
            - wait 0.5s
            - execute as_server "nullcrash <[chased].name>"
        - wait 1t

nullmoonglitch:
    type: command
    name: nullmoonglitch
    description: Integrity.curious
    usage: /nullmoonglitch
    permission: null.moonglitch
    script:
    # Requires player view distance controler
    # and requires setting the config in lang "all-online-change: none"
    # This is the reason why it's off by deafult.
    - if <server.has_flag[moonglitch]>:
        - stop
    - execute as_server "execute as @a at @s run playsound minecraft:custom.moonglitch master @s ~ ~ ~ 0.5"
    - execute as_server "pvdc setonline 2"
    - flag server moonglitch expire:5m
    - wait 5m
    - execute as_server "pvdc setonline 12"

nulltimeset:
    type: command
    name: nulltimeset
    description: Set time without reseting day counter.
    usage: /nulltimeset
    permission: null.timeset
    script:
    - define arg:<context.args.get[1].to_lowercase>
    - if <[arg]> == midnight:
        - define target:18000
    - else if <[arg]> == day:
        - define target:1000
    - else if <[arg]> == noon:
        - define target:6000
    - else if <[arg]> == night:
        - define target:13000
    - else:
        - narrate "<red>Invalid time."
        - stop
    - define now <world[world].time>
    - define fullDay:24000
    - define halfDay:12000
    - define raw:<[target].sub[<[now]>].add[<[halfDay]>]>
    - define wrapped:<[raw].mod[<[fullDay]>]>
    - define diff:<[wrapped].sub[<[halfDay]>]>
    - if <[diff]> >= 0:
        - execute as_server "time add <[diff]>"
    - else:
        - define delta:<[diff].abs>
        - define toAdd:<[fullDay].sub[<[delta]>]>
        - execute as_server "time add <[toAdd]>"

# OPTIONS

removevhs:
    type: command
    name: removevhs
    description: removevhs
    usage: /removevhs
    permission: null.removevhs
    script:
    - if !<player.has_flag[removevhs]>:
        - flag <player> removevhs
        - narrate "Disabled VHS."
        - fakeequip <player> reset
    - else:
        - flag <player> removevhs:!
        - narrate "Enabled VHS."
        - fakeequip <player> head:carved_pumpkin

# ADMINS ONLY SECTION.

nulltimedevents:
    type: command
    name: nulltimedevents
    description: Toggle events that happen over time, on by deafult. (Admins only)
    usage: /nulltimedevents
    permission: null.timedevents
    script:
    - if <server.has_flag[notimedevents]>:
        - narrate "<&lt>Integrity<&gt> Timed events resumed."
        - flag server notimedevents:!
    - else:
        - narrate "<&lt>Integrity<&gt> Timed events paused."
        - flag server notimedevents

nullnoblackthing:
    type: command
    name: nullnoblackthing
    description: Kills Sub-Anomaly 1 (Admins only)
    usage: /nullnoblackthing
    permission: null.noblackthing
    script:
    - foreach <server.flag[blackthing]> as:theblack:
        - flag <[theblack]> itsame:!
        - flag server blackthing:<-:<[theblack]>
        - wait 1t
        - kill <[theblack]>

nullnor2:
    type: command
    name: nullnor2
    description: Kills all r2 (Admins only)
    usage: /nullnor2
    permission: null.nor2
    script:
    - if !<server.has_flag[r2]>:
        - stop
    - foreach <server.flag[r2]> as:r2:
        - teleport <[r2].flag[thearmor]> <[r2].flag[thearmor].location.down[400]>
        - kill <[r2].flag[thearmor]>
        - flag <[r2]> thearmor:!
        - flag <[r2]> r2angy:!
        - flag server r2:<-:<[r2]>
        - wait 1t
        - kill <[r2]>
        - flag server triggeredr2:!
        - foreach <server.online_players_flagged[theangryone]> as:player:
            - flag <[player]> theangryone:!
            - flag <[player]> r2despawn:!

nullnofaraway:
    type: command
    name: nullnofaraway
    description: Kills all faraway (Admins only)
    usage: /nullnofaraway
    permission: null.nofaraway
    script:
    - if !<server.has_flag[faraway]>:
        - stop
    - foreach <server.flag[faraway]> as:faraway:
        - execute as_server "setblock <[faraway].location.block.x> <[faraway].location.block.y> <[faraway].location.block.z> air"
        - execute as_server "setblock <[faraway].location.block.x> <[faraway].location.block.y.add[1]> <[faraway].location.block.z> air"
        - wait 1t
        - flag server faraway:<-:<[faraway]>
        - wait 1t
        - kill <[faraway]>

nullnofalsevillager:
    type: command
    name: nullnofalsevillager
    description: Kills false villager. (Admins only)
    usage: /nullnofalsevillager
    permission: null.nofalsevillager
    script:
    - if !<server.has_flag[unsusvillager]>:
        - if !<server.has_flag[circuitattacker]>:
            - stop
    - define villager <server.flag[unsusvillager]>
    - define circuit <server.flag[circuitattacker]>
    - wait 1t
    - kill <[circuit]>
    - kill <[villager]>
    - flag server circuitattacker:!
    - flag server unsusvillager:!
    - flag server circuitdespawn:!
    - flag server falsegoneforever:!

nullnodisguisedcircuit:
    type: command
    name: nullnodisguisedcircuit
    description: Kills fake player aka circuit (Admins only)
    usage: /nullnodisguisedcircuit
    permission: null.nodisguisedcircuit
    script:
    - if !<server.has_flag[circuit]>:
        - stop
    - flag server circuitdeath
    - define circuit <server.flag[circuit]>
    - wait 1t
    - teleport <[circuit]> <[circuit].location.below[400]>
    - wait 1t
    - kill <[circuit]>
    - flag server circuit:!
    - flag server circuitdeath:!
    - flag server despawnthedisg:!

nullnocircuit:
    type: command
    name: nullnocircuit
    description: Kills circuit disguised as null. (Admins only)
    usage: /nullnocircuit
    permission: null.nocircuit
    script:
    - if !<server.has_flag[circuitnull]>:
        - stop
    - define circuit <server.flag[circuitnull]>
    - wait 1t
    - teleport <[circuit]> <[circuit].location.below[400]>
    - kill <[circuit]>
    - flag server circuitnull:!
    - flag server circuittimedeath:!
    - foreach <server.online_players_flagged[broisrealangry]> as:player:
        - flag <[player]> broisrealangry:!
        - flag <[player]> circuitwarning:!

nullnoxxram2diexx:
    type: command
    name: nullnoxxram2diexx
    description: Kills Xxram2diexX (Admins only)
    usage: /nullnoxxram2diexx
    permission: null.noxxram2diexx
    script:
    - if !<server.has_flag[ram2die]>:
        - stop
    - teleport <server.flag[ram2die]> <server.flag[ram2die].location.below[100]>
    - kill <server.flag[ram2die]>
    - flag server ram2die:!

nullnonothingiswatching:
    type: command
    name: nullnonothingiswatching
    description: Kills Nothingiswatching (Admins only)
    usage: /nullnonothingiswatching
    permission: null.nonothingiswatching
    script:
    - foreach <server.flag[thewatchers]> as:nothing:
        - define litnothing <[nothing].flag[litnothing]>
        - teleport <[nothing]> <[nothing].location.below[400]>
        - teleport <[litnothing]> <[nothing].location.below[400]>
        - flag <[nothing]> litnothing:!
        - kill <[nothing]>
        - kill <[litnothing]>
        - flag server thewatchers:<-:<[nothing]>

nulldebug:
    type: command
    name: nulldebug
    description: nulldebug
    usage: /nulldebug
    permission: null.debug
    script:
    - if !<server.has_flag[nulldebug]>:
        - flag server nulldebug
        - narrate "<&lt>Integrity<&gt> Enabled debug mode."
    - else:
        - flag server nulldebug:!
        - narrate "<&lt>Integrity<&gt> Disabled debug mode."

nullcrash:
    type: command
    name: nullcrash
    description: nullcrash
    usage: /nullcrash
    permission: null.crash
    script:
    - define dude <server.match_player[<context.args.get[1]>]>
    # Insert a crash of your choice below.
    - execute as_server ''

# - IGNORE -

nullplugin:
    type: command
    name: nullplugin
    description: Plugin illusion
    usage: /nullplugin
    permission: null.plugin
    script:
    - narrate "<green>Null <white>version <green><green><element[0.0.0].on_hover[Click to copy to clipboard].on_click[0.0.0].type[COPY_TO_CLIPBOARD]>"
    - narrate "Here I am."
    - narrate "Author: <green>null"