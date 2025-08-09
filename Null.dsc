nullexist:
    type: world
    debug: true
    events:
        on delta time secondly:
        # ------------- Null watch (unused) -------------
        - if <server.has_flag[null]>:
            - if !<server.has_flag[nullwatch]>:
                - execute as_server "teleport <server.flag[null].uuid> ~ ~400 ~"
        # ------------- IKNOWWHATYOUFEAR (unused) -------------
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
        # ------------- Circuit -------------
        - if <server.has_flag[circuitnull]>:
            - if !<server.has_flag[circuittimedeath]>:
                - flag server circuittimedeath:0
            - flag server circuittimedeath:++
            - if <server.flag[circuittimedeath]> == 25:
                - execute as_server "nullnocircuit"

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
            - flag server spawnnull:++
            - if <server.flag[spawnnull].mod[10]> == 0:
                - if <server.has_flag[inaminute]>:
                    - stop
                - else:
                    - execute as_server nulljoin
        # ------------- Make r2 despawn after 1 minute -------------
        - foreach <server.online_players_flagged[theangryone]> as:angry:
            - flag <[angry]> r2despawn:++
            - if <[angry].flag[r2despawn]> == 2:
                - teleport <player.flag[theangryone]> <player.flag[theangryone].location.below[100]>
                - kill <player.flag[theangryone]>
                - teleport <player.flag[theangryone].flag[thearmor]> <player.flag[theangryone].flag[thearmor].location.down[400]>
                - kill <player.flag[theangryone].flag[thearmor]>
                - flag <player.flag[theangryone]> thearmor:!
                - flag server r2:<-:<player.flag[theangryone]>
                - flag server triggeredr2:!
                - flag <player> theangryone:!
        # ------------- Make Sub Anomaly 1 despawn after 10 minutes -------------
        - foreach <server.flag[blackthing]> as:thing:
            - flag <[thing]> timerofthings:++
            - if <[thing].flag[timerofthings]> == 10:
                - flag <[thing]> itsame:!
                - flag server blackthing:<-:<[thing]>
                - wait 1t
                - kill <[thing]>

        on delta time secondly every:30:
        # ------------- Handle events and reputation. -------------
        - if <server.has_flag[null]>:
            - if !<server.has_flag[reputation]>:
                - flag server reputation:NORMAL
            - if !<server.has_flag[eventnull]>:
                - flag server eventnull:0
            - flag server eventnull:++
            - if <server.has_flag[notimedevents]>:
                - stop
            - define time <world[world].time>
            - if <[time]> >= 0 && <[time]> < 12300 || <[time]> >= 23850:
                - define eventsperminute 6
                - if <server.has_flag[nulldebug]>:
                    - narrate "It is day time, changing events per minute to: <[eventsperminute].div[2]>" targets:<server.online_ops>
                - if <server.flag[reputation]> == BAD:
                    - define eventsperminute 3
                    - if <server.has_flag[nulldebug]>:
                        - narrate "It is day time, but reputation is <red>bad<white>, changing events per minute to: <[eventsperminute].div[2]>" targets:<server.online_ops>
            - else:
                - define eventsperminute 4
                - if <server.has_flag[nulldebug]>:
                    - narrate "It is night time, changing events per minute to: <[eventsperminute].div[2]>" targets:<server.online_ops>
                - if <server.flag[reputation]> == BAD:
                    - define eventsperminute 2
                    - if <server.has_flag[nulldebug]>:
                        - narrate "It is night time, and reputation is <red>bad<white>, changing events per minute to: <[eventsperminute].div[2]>" targets:<server.online_ops>
            - if <server.flag[eventnull].mod[<[eventsperminute]>]> == 0:
                - define randomevent <list[nullwatch|nullsong|nullsteps|nulltitle|nullpotion|nulladvancement2|nullgoaway|nullhappyface|nullopengl|nullfall|nullhost|nulljumpscare|nullbreak|nullcantyousee|nullrandomlook|nullinventory|nullgoodluck|nullplaysound|nullbook|nullslowsong|nullfire|nulldisc11|nullfaraway|nullfreezetime|nulllightning|nullfalsevillager|nullbsod|nullflying|nullcircuitdisguised|nullnamemob|nullcircuit|nullstructure|nullrandomtext|nullwater].random>
                - if <server.has_flag[nulldebug]>:
                    - narrate "Event happening! Events per minute is on: <[eventsperminute]>, current event <[randomevent]>" targets:<server.online_ops>
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
                    - narrate "Oh no! an entity, current entity: <[randomentity]>" targets:<server.online_ops>
            - if <server.flag[eventnull].mod[10]> == 0:
                - flag server reputation:<list[GOOD|NORMAL|BAD].random>

        on entity damaged:
        # ------------- Handle nullnocircuit command -------------
        - if !<context.damager.exists>:
            - if <context.entity> == <server.flag[circuit]>:
                - if !<server.has_flag[circuitdeath]>:
                    - determine cancelled

        on entity dies:
        # ------------- Handle circuit death -------------
        - if <server.has_flag[circuit]>:
            - if <server.flag[circuit]> == <context.entity>:
                - if !<server.has_flag[circuitdeath]>:
                    - execute as_server 'summon item <context.entity.location.x> <context.entity.location.y> <context.entity.location.z> {Item:{id:"minecraft:paper",Count:1b,tag:{CustomModelData:131313,display:{Name:'{"text":"Music Disc","color":"aqua","italic":false}',Lore:['{"text":"14","color":"gray","italic":false}']}}}}'
                    - flag server circuit:!

        on entity damages player:
        # ------------- Handle circuit disguised as villager. -------------
        - if <context.damager> == <server.flag[circuitattacker]>:
            - execute as_server 'nullcrash <player.name>'
            - teleport <server.flag[circuitattacker]> <server.flag[circuitattacker].location.below[100]>
            - kill <server.flag[circuitattacker]>
            - wait 1t
            - kick <context.entity> reason:Disconnected.
        # ------------- Circuit. -------------
        - if <context.damager> == <server.flag[circuit]>:
            - execute as_server "execute as <player.name> at <[player].name> run playsound minecraft:custom.circuit_jumpscare ambient <[player].name> ~ ~ ~"
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
                - execute as_server "execute as <context.entity.name> at <context.entity.name> run playsound minecraft:custom.circuitchase ambient <context.entity.name> ~ ~ ~"
                - execute as_server "execute as <context.entity.name> at <context.entity.name> run playsound minecraft:custom.circuit_jumpscare ambient <context.entity.name> ~ ~ ~"
                - repeat 100:
                    - define yaw <context.entity.location.yaw>
                    - define pitch <context.entity.location.pitch>
                    - execute as_server "execute as <context.entity.name> at @s run tp @s ~ ~ ~ <[yaw].add[<list[<util.random.int[1].to[5]>|<util.random.int[-1].to[-5]>].random>]> <[pitch].add[<list[<util.random.int[1].to[5]>|<util.random.int[-1].to[-5]>].random>]>"
                    - wait 1t
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
        # ------------- Xxram2diexX -------------
        - if <context.damager> == <server.flag[ramyoudie]>:
            - kick <player> reason:null
            - wait 1t
            - teleport <server.flag[ramyoudie]> <server.flag[ramyoudie].location.below[100]>
            - kill <server.flag[ramyoudie]>
            - wait 1t
            - flag server ramyoudie:!
            - flag server ramisdead:!

        on player damages entity:
        # ------------- Circuit -------------
        - if <context.entity> == <server.flag[circuit]>:
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.youwillregretthat ambient <player.name> ~ ~ ~"
            - wait 2s
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.circuitchase ambient <player.name> ~ ~ ~ 0.5"
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.nullchase ambient <player.name> ~ ~ ~ 0.7"
            - execute as_server "effect give <server.flag[circuit].uuid> minecraft:speed infinite 2 true"

        on player joins:
        # ------------- Warning and VHS effects -------------
        - if !<player.has_flag[removevhs]>:
            - fakeequip <player> head:carved_pumpkin
        - wait 1s
        - if !<player.has_flag[versionwarning]>:
            - narrate "<&lt>Integrity<&gt> This server works best on 1.21.3 and below."
            - flag <player> versionwarning
        - if <player.name.contains[.]> && !<player.has_flag[bedrockwarning]>:
            - narrate "<&lt>Integrity<&gt> Bedrock edition is not supported."
            - flag <player> bedrockwarning
        - if <server.has_flag[moonglitch]>:
            - execute as_server "pvdc setonline 2"

        on player respawns:
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
        - define itemname <player.item_in_hand.display>
        - if <[item]> == structure_void or <player.inventory.slot[offhand].material.name> == structure_void:
            - if <[itemname]> == <white>name.null or <player.inventory.slot[offhand].display> == <white>name.null:
                - determine passively cancelled
                - execute as_server "clear <player.name> minecraft:structure_void 1"
            - if <[itemname]> == <white>name.revuxor or <player.inventory.slot[offhand].display> == <white>name.revuxor:
                - determine passively cancelled

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
        # ------------- Xxram2diexX -------------
        - if <player> == <server.flag[ramisdead]>:
            - kick <player> reason:null
            - wait 1t
            - teleport <server.flag[ramyoudie]> <server.flag[ramyoudie].location.below[100]>
            - kill <server.flag[ramyoudie]>
            - wait 1t
            - flag server ramyoudie:!
            - flag server ramisdead:!

        on entity enters portal:
        # ------------- Prevent null from going through portals (Unused) -------------
        - if <server.has_flag[null]>:
            - if <server.flag[null]> == <context.entity>:
                - determine cancelled

        on player right clicks *_bed:
        # ------------- Needs overhaul, bed mechanics -------------
        - if <util.random_chance[50]>:
            - if <player.has_flag[doneonce]>:
                - stop
            - wait 1.5s
            - flag <player> doneonce expire:10s
            - hurt 1 <player>

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
                        - execute as_server 'summon item <[juke].x> <[juke].y.add[1]> <[juke].z> {Item:{id:"minecraft:paper",Count:1b,tag:{CustomModelData:131313,display:{Name:'{"text":"Music Disc","color":"aqua","italic":false}',Lore:['{"text":"14","color":"gray","italic":false}']}}}}'
                        - flag server jukebox:<-:<[juke]>
                        - determine cancelled
        - define item <player.item_in_hand.material.name>
        - define itemname <player.item_in_hand.display>
        - define itemlore <player.item_in_hand.lore.formatted>
        - if <[item]> == paper:
            - if <[itemname]> == "<aqua>Music Disc" && <[itemlore]> == 14:
                - flag server jukebox:->:<context.location>
                - foreach <context.location.find_entities[player].within[16]> as:player:
                    - execute as_server "playsound minecraft:custom.record14 record <[player].name> <context.location.x> <context.location.y> <context.location.z>"
                - execute as_server "item replace entity <player.name> weapon.mainhand with air"
                - determine cancelled

        on player breaks jukebox:
        - if <server.has_flag[jukebox]>:
            - foreach <server.flag[jukebox]> as:juke:
                - if <context.location> == <[juke]>:
                    - foreach <context.location.find_entities[player].within[16]> as:player:
                        - execute as_server "stopsound <[player].name> record minecraft:custom.record14"
                        - execute as_server 'summon item <[juke].x> <[juke].y.add[1]> <[juke].z> {Item:{id:"minecraft:paper",Count:1b,tag:{CustomModelData:131313,display:{Name:'{"text":"Record 14","italic":false}',Lore:['{"text":"Record 14","color":"gray","italic":false}']}}}}'
                        - flag server jukebox:<-:<[juke]>

        on player damages bedrock with:stone_pickaxe|iron_pickaxe|diamond_pickaxe:
        # ------------- Breakeable bedrock. -------------
        - if !<player.has_flag[breakthebedrock]>:
            - flag <player> breakthebedrock:0
        - repeat 101:
            - flag <player> breakthebedrock:++ expire:2t
            - if <player.cursor_on> != <context.location>:
                - stop
            - wait 1t
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

        on player chats priority:-4:
        # ------------- Chat handler -------------
        - if <server.has_flag[triggeredr2]>:
            - determine passively cancelled
            - actionbar "IMPORT minecraft.chatengine"
            - wait 1s
            - actionbar Unexpected_error.returnedvalue=-1
            - stop
        - if <server.has_flag[null]>:
            - if <context.message> == hello:
                - wait 30s
                - announce "<&lt>Null<&gt> err.type=null.hello"
                - playsound <player> sound:ambient_cave pitch:0.5
            - else if <context.message> == "Who are you?":
                - wait 5s
                - announce "<&lt>Null<&gt> err.type=null."
                - playsound <player> sound:ambient_cave pitch:0.5
            - else if <context.message> == "What do you want?":
                - wait 5s
                - announce "<&lt>Null<&gt> err.type=null.freedom"
                - playsound <player> sound:ambient_cave pitch:0.5
            - else if <context.message> == null:
                - ratelimit <player> 6s
                - wait 5s
                - announce "<&lt>Null<&gt> The end is nigh."
                - wait 1s
                - announce "<&lt>Null<&gt> The end is null."
                - wait 0.5s
                - playsound <player> sound:entity_enderman_death pitch:0.5
                - wait 1t
                - teleport <server.flag[null]> <player.location>
                - adjust <server.flag[null]> visible:true
                - execute as_server 'tellraw @a {"translate":"death.attack.player","with":["<player.name>","Null"],"color":"white"}'
                - execute as_server "execute at <player.name> run gamerule showDeathMessages false"
                - kill <player>
                - wait 1t
                - execute as_server "execute at <player.name> run gamerule showDeathMessages true"
                - kick <player> reason:null
                - wait 0.5s
                - execute as_server "teleport <server.flag[null].uuid> ~ ~400 ~"
                - adjust <server.flag[null]> visible:false
            - else if <context.message> == "Can you see me?":
                - ratelimit <player> 10s
                - wait 5s
                - announce "<&lt>Null<&gt> Yes."
                - wait 3s
                - announce "<&lt>Null<&gt> Hello."
                - wait 3s
                - spawn lightning <player.location.block>
                - execute as_server "effect give <player.name> minecraft:blindness 2 250 true"
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
                - execute as_server "execute at <[thething].uuid> run particle minecraft:block minecraft:black_concrete ~ ~1 ~ 1 1 1 0.1 20 force"
                - hurt 2 <[thething].location.find_entities.within[3]>
                - define water <[thething].location.find_blocks[water].within[3]>
                - modifyblock <[water]> cobblestone
                - wait 1t
        # ------------- R2 -------------
        - if <server.has_flag[r2]>:
            - foreach <server.flag[r2]> as:r2:
                - execute as_server "execute as <[r2].flag[thearmor].uuid> at @s run tp @s <list[^ ^ ^0.3|^ ^0.3 ^|^0.3 ^ ^|^ ^ ^-0.3|^ ^-0.3 ^|^-0.3 ^ ^].random>"
                - wait 1t
                - teleport <[r2].flag[thearmor]> <[r2].location>
                - define time <world[world].time>
                - if <[time]> >= 0 && <[time]> < 12300 || <[time]> >= 23850:
                    - teleport <[r2]> <[r2].location.down[400]>
                    - teleport <[r2].flag[thearmor]> <[r2].flag[thearmor].location.down[400]>
                    - kill <[r2].flag[thearmor]>
                    - flag <[r2]> thearmor:!
                    - kill <[r2]>
                    - flag server r2:<-:<[r2]>
                    - foreach <server.online_players_flagged[theangryone]> as:angry:
                        - flag <[angry]> theangryone:!
                    - flag server triggeredr2:!
        # ------------- Null is here mode -------------
        - if <server.has_flag[oneofus]>:
            - execute as_server "execute as <server.flag[nullishere].uuid> at @s run tp @s ^ ^ ^1 facing entity <server.flag[oneofus].name> feet"
            - if <server.flag[oneofus].location.distance[<server.flag[nullishere].location>]> <= 2:
                - execute as_server "execute at <server.flag[oneofus].name> run gamerule showDeathMessages false"
                - kill <server.flag[oneofus]>
                - execute as_server 'tellraw @a {"translate":"death.attack.player","with":["<server.flag[oneofus].name>","Null"],"color":"white"}'
                - flag <server.flag[oneofus]> oneofusdied
                - execute as_server "execute as <server.flag[oneofus].name> at <server.flag[oneofus].name> run playsound minecraft:custom.randomjumpscare ambient <server.flag[oneofus].name> ~ ~ ~"
                - execute as_server "nullcrash <server.flag[oneofus].name>"
                - wait 1t
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
            - execute as_server "execute as <server.flag[oneofus].name> at <server.flag[oneofus].name> run playsound minecraft:custom.nullishereloop ambient <server.flag[oneofus].name> ~ ~ ~ 100 0.5"
            - ratelimit <server.flag[oneofus]> 0.3s
            - title title:<list[You know nothing|Worship me|Follow me|Join us|Corrupted|Go away|Null|We can hear you|Can you see me?|0|Behind you|Help me|Nothing can be changed|Close your eyes|One of us].random> targets:<server.flag[oneofus]>
        # ------------- Null watching -------------
        - if <server.has_flag[nullwatcher]>:
            - define time <world[world].time>
            - if <[time]> >= 0 && <[time]> < 12300 || <[time]> >= 23850:
                - teleport <server.flag[nullwatcher]> <server.flag[nullwatcher].location.below[400]>
                - wait 1t
                - kill <server.flag[nullwatcher]>
                - flag server nullwatcher:!
        # ------------- Null flying -------------
        - if <server.has_flag[nullflying]>:
            - define time <world[world].time>
            - if <[time]> >= 0 && <[time]> < 12300 || <[time]> >= 23850:
                - foreach <server.flag[nullflying]> as:null:
                    - teleport <[null]> <[null].location.below[400]>
                    - wait 1t
                    - kick <[null]>
                    - flag server nullflying:<-:<[null]>
        - if <server.has_flag[ramyoudie]>:
            - execute as_server "execute at <server.flag[ramyoudie].uuid> run particle minecraft:block minecraft:black_concrete ~ ~1 ~ 1 1 1 0.1 20 force"
            - define water <[thething].location.find_blocks[water].within[3]>
            - modifyblock <[water]> cobblestone

        on player walks:
        # ------------- Prevent looking at someone else while on nullishere phase (Unused) -------------
        - if <server.has_flag[nullwatch]>:
            - if <server.has_flag[oneofus]>:
                - stop
            - execute as_server "execute as <server.flag[null].uuid> at @s run tp @s ~ ~ ~ facing entity @a[limit=1,sort=nearest] feet"
        # ------------- Null watching -------------
        - if <server.has_flag[nullwatcher]>:
            - execute as_server "execute as <server.flag[nullwatcher].uuid> at @s run tp @s ~ ~ ~ facing entity @a[limit=1,sort=nearest] feet"
            - if <player.location.distance[<server.flag[nullwatcher].location>]> <= 4:
                - execute as_server "effect give <player.name> minecraft:blindness 20 1"
                - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.nullflee ambient <player.name> ~ ~ ~ 100"
                - teleport <server.flag[nullwatcher]> <player.location.below[400]>
                - wait 1t
                - kill <server.flag[nullwatcher]>
                - flag server nullwatcher:!
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
                    - execute as_server "setblock <[far].location.block.x> <[far].location.block.y> <[far].location.block.z> air"
                    - execute as_server "setblock <[far].location.block.x> <[far].location.block.y.add[1]> <[far].location.block.z> air"
                    - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.randomjumpscare ambient <player.name> ~ ~ ~ 100 0.5"
                    - wait 1t
                    - execute as_server "execute at <[far].uuid> run particle minecraft:block minecraft:black_concrete ~ ~1 ~ 1 1 1 0.1 300 force"
                    - wait 1t
                    - teleport <[far]> <[far].location.above[100]>
                    - kill <[far]>
                    - wait 1t
                    - flag server faraway:<-:<[far]>
                    - wait 1s
                    - execute as_server "effect clear <player.name> minecraft:blindness"
        # ------------- Handle R2 -------------
        - if <server.has_flag[r2]>:
            - foreach <server.flag[r2]> as:r2:
                - execute as_server "effect give <[r2].uuid> minecraft:speed infinite 5 true"
                - if <player.location.distance[<[r2].location>]> <= 5:
                    - if <server.has_flag[spawningr2]>:
                        - stop
                    - if !<player.has_flag[theangryone]>:
                        - ratelimit <player> 1s
                        - if <util.random_chance[50]>:
                            - execute as_server "effect give <player.name> minecraft:blindness 100 100 true"
                            - title "title:CANT'T YOU SEE?" "subtitle:CANT'T YOU SEE?" fade_in:0s stay:0.5s fade_out:0s targets:<player>
                            - actionbar "CANT'T YOU SEE?" targets:<player>
                            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.textmadness1 ambient <player.name> ~ ~ ~"
                            - execute as_server "execute as <player.name> at @s run teleport <player.name> ~ ~ ~ facing entity <[r2].uuid> feet"
                            - wait 0.5
                            - actionbar '' targets:<player>
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
                            - spawn lightning <player.location>
                            - adjust <[r2]> has_ai:true
                            - execute as_server "data modify entity <[r2].uuid> AngryAt set from entity <player.uuid> UUID"
                            - flag server triggeredr2
                            - flag <player> theangryone:<[r2]>
                            - flag <[r2]> chaser:!
                            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.nullchase ambient <player.name> ~ ~ ~ 0.7"
        # ------------- Handle false villager. -------------
        - if <server.has_flag[unsusvillager]>:
            - if <player.location.distance[<server.flag[unsusvillager].location>]> <= 4:
                - ratelimit <player> 3s
                - teleport <server.flag[circuitattacker]> <server.flag[unsusvillager].location>
                - wait 1t
                - teleport <server.flag[unsusvillager]> <server.flag[unsusvillager].location.above[100]>
                - kill <server.flag[unsusvillager]>
                - wait 1t
                - flag server unsusvillager:!
                - adjust <server.flag[circuitattacker]> has_ai:true
                - execute as_server "data modify entity <server.flag[circuitattacker].uuid> AngryAt set from entity <player.uuid> UUID"
                - execute as_server "effect give <server.flag[circuitattacker].uuid> minecraft:speed infinite 2 true"
                - spawn lightning <player.location>
        # ------------- Handle Circuit -------------
        - if <server.has_flag[circuit]>:
            - if <player.location.distance[<server.flag[circuit].location>]> <= 4:
                - ratelimit <player> 1m
                - if <player.name> == <server.flag[circuit].name>:
                    - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.circuitchase ambient <player.name> ~ ~ ~ 0.5"
                    - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.nullchase ambient <player.name> ~ ~ ~ 0.7"
                    - execute as_server "data modify entity <server.flag[circuit].uuid> AngryAt set from entity <player.uuid> UUID"
                    - execute as_server "effect give <server.flag[circuit].uuid> minecraft:speed infinite 2 true"
                    - stop
                - narrate "<&lt><server.flag[circuit].name><&gt> <list[hey|do you have some food?|i'm lost|where's the base].random>" targets:<player>
        # ------------- Handle Xxram2diexX -------------
        - if <server.has_flag[ram2die]>:
            - if <player.location.distance[<server.flag[ram2die].location>]> <= 20:
                - ratelimit <player> 3s
                - adjust <player> gamemode:survival
                - adjust <server.flag[ramyoudie]> has_ai:true
                - teleport <server.flag[ramyoudie]> <server.flag[ram2die].location>
                - flag server ramisdead:<player>
                - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.circuitchase ambient <player.name> ~ ~ ~ 0.5"
                - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.nullchase ambient <player.name> ~ ~ ~ 0.7"
                - execute as_server "data modify entity <server.flag[ramyoudie].uuid> AngryAt set from entity <player.uuid> UUID"
                - execute as_server "effect give <server.flag[ramyoudie].uuid> minecraft:speed infinite 2 true"
                - wait 1t
                - teleport <server.flag[ram2die]> <server.flag[ram2die].location.below[100]>
                - kill <server.flag[ram2die]>
                - wait 1t
                - flag server ram2die:!
        - if <server.has_flag[ramisdead]>:
            - if <server.flag[ramisdead]> == <player>:
                - ratelimit <player> 1t
                - execute as_server "execute as <player.name> at @s run tp @s ~ ~ ~ facing entity <server.flag[ramyoudie].uuid>"
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
        - if <player.has_flag[broisrealangry]>:
            - if !<player.has_flag[inventoryisclosing]>:
                - flag <player> inventoryisclosing expire:25s
                - while <server.has_flag[circuitnull]>:
                    - inventory close
                    - wait 1t
            - else:
                - stop

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
    - playsound <server.online_players> sound:ambient_cave pitch:0.5
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
    - if <server.has_flag[nullwatcher]>:
        - stop
    - define time <world[world].time>
    - if <[time]> >= 0 && <[time]> < 12300 || <[time]> >= 23850:
        - stop
    - define randomplayer <server.online_players.random>
    - spawn <player.location.above[50]> villager save:nullwatcher
    - define null <entry[nullwatcher].spawned_entity>
    - flag server nullwatcher:<[null]>
    - adjust <[null]> has_ai:false
    - adjust <[null]> invulnerable:true
    - execute as_server "disgplayer <[null].uuid> Player yyy88 setName Null setDisplayedInTab false"
    - wait 0.5s
    - if <[randomplayer].location.world.name> == world_nether:
        - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 1 30 under <[randomplayer].location.y> false <[null].uuid>"
    - else:
        - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 1 30 false <[null].uuid>"

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
    - execute as_server "execute as @a at @a run playsound minecraft:custom.randomsong ambient @s ~ ~ ~"
    - wait 15s
    - if <player.location.block.highest.y> < <player.location.block.y> && <util.random_chance[50]>:
        - spawn <player.location.block> lightning

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
        - execute as_server "execute at <[randomplayer].name> run particle minecraft:entity_effect ~ ~1 ~ 0.3 0.4 0.3 0 1 force"
        - wait 0.25s

nullHereIam:
    type: command
    name: nullhereiam
    description: Can you see me?
    usage: /nullhereiam
    permission: null.heriam
    script:
    - define randomplayer <server.online_players.random>
    - if !<[randomplayer].has_flag[hereiam]>:
        - announce "<element[<[randomplayer].name>].on_hover[<[randomplayer].name><n>Type: Player<n><[randomplayer].uuid>]> has made the advancement <green>[<element[Here I am.].on_hover[<green>Here I am.<n>Can you see me?]>]"
        - flag <[randomplayer]> hereiam
        - playsound <[randomplayer]> sound:ui_toast_in
        - wait 6s
        - playsound <[randomplayer]> sound:ui_toast_out

nulladvancement2:
    type: command
    name: nulladvancement2
    description: nullnullnull
    usage: /nulladvancement2
    permission: null.advancement2
    script:
    - define randomplayer <server.online_players.random>
    - if !<[randomplayer].has_flag[advancement2]>:
        - announce "<element[<[randomplayer].name>].on_hover[<[randomplayer].name><n>Type: Player<n><[randomplayer].uuid>]> has made the advancement <green>[<element[nullnullnull].on_hover[<green>nullnullnull<n>nullnullnull]>]"
        - flag <[randomplayer]> advancement2
        - playsound <[randomplayer]> sound:ui_toast_in
        - wait 6s
        - playsound <[randomplayer]> sound:ui_toast_out

nullgoaway:
    type: command
    name: nullgoaway
    description: This place is not for you.
    usage: /nullgoaway
    permission: null.goaway
    script:
    - define randomplayer <server.online_players.random>
    - if !<[randomplayer].has_flag[goaway]>:
        - announce "<element[<[randomplayer].name>].on_hover[<[randomplayer].name><n>Type: Player<n><[randomplayer].uuid>]> has made the advancement <green>[<element[Go Away].on_hover[<green>Go Away<n>This place is not for you.]>]"
        - flag <[randomplayer]> goaway
        - playsound <[randomplayer]> sound:ui_toast_in
        - wait 6s
        - playsound <[randomplayer]> sound:ui_toast_out

nullinvadebase:
    type: command
    name: nullinvadebase
    description: THIS DOES NOT WORK AND IS JUST A PLACEHOLDER (W.I.P)
    usage: /nullinvadebase
    permission: null.invadebase
    script:
    - define randomplayer <server.online_players.random>
    - narrate "This does not work yet, it's just a placeholder lol."

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
    - spawn lightning <server.flag[nullisangry].up[1]>
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
        - execute as_server "execute as <[player].name> at @s run teleport <[player].name> ~ ~ ~ <util.random.int[0].to[360]> <util.random.int[0].to[90]>"
        - execute as_server "execute as <[player].name> at @s run playsound minecraft:custom.textmadness1 ambient <[player].name> ~ ~ ~ 100 0.5"
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
    - playsound <server.online_players> sound:ambient_cave pitch:0.5

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
    - flag server ramwashere expire:20m
    - announce "<white>Local game hosted on port [<green><&k>00000<white>]"
    - wait 25s
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.joined","with":["xXram2dieXx"],"color":"yellow"}'
    - execute as_server "nulltimeset midnight"
    - define randomplayer <server.online_players.random>
    - spawn <[randomplayer].location.above[100]> villager save:ram2die
    - flag server ram2die:<entry[ram2die].spawned_entity>
    - execute as_server "disgplayer <server.flag[ram2die].uuid> Player xXram2dieX_ setName Xxram2diexX setDisplayedInTab false setNameVisible false"
    - spawn <[randomplayer].location.above[50]> zombified_piglin save:nullchase
    - flag server ramyoudie:<entry[nullchase].spawned_entity>
    - execute as_server "disgplayer <server.flag[ramyoudie].uuid> Player yyy88 setName Null setDisplayedInTab false"
    - adjust <server.flag[ramyoudie]> has_ai:false
    - adjust <server.flag[ramyoudie]> invulnerable:true
    - adjust <server.flag[ramyoudie]> persistent:true
    - adjust <server.flag[ramyoudie]> item_in_hand:air
    - playsound <server.online_players> sound:ambient_cave
    - wait 1t
    - execute as_server "spreadplayers <world[world].spawn_location.x> <world[world].spawn_location.z> 1 2 false <server.flag[ram2die].uuid>"
    - wait 25s
    - announce "<&lt>xXram2dieXx<&gt> 48656c6c6f3f"
    - execute as_server "nulltimeset midnight"
    - playsound <server.online_players> sound:ambient_cave
    - wait 25s
    - announce "<&lt>xXram2dieXx<&gt> 486f772064696420796f7520666f756e642074686973207365727665723f"
    - execute as_server "nulltimeset midnight"
    - playsound <server.online_players> sound:ambient_cave
    - wait 25s
    - announce "<&lt>xXram2dieXx<&gt> 446f20796f752077616e7420746f20626520667269656e64733f"
    - execute as_server "nulltimeset midnight"
    - playsound <server.online_players> sound:ambient_cave
    - wait 25s
    - announce "<&lt>xXram2dieXx<&gt> 4c656176652e"
    - execute as_server "nulltimeset midnight"
    - playsound <server.online_players> sound:ambient_cave
    - wait 25s
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.left","with":["xXram2dieXx"],"color":"yellow"}'
    - teleport <server.flag[ram2die]> <server.flag[ram2die].location.below[100]>
    - kill <server.flag[ram2die]>
    - flag server ram2die:!
    - wait 1t
    - teleport <server.flag[ramyoudie]> <server.flag[ramyoudie].location.below[400]>
    - kill <server.flag[ramyoudie]>
    - flag server ramyoudie:!
    - wait 1t
    - flag server ramisdead:!

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
    - flag <[randomplayer]> nomove
    - spawn armor_stand <[randomplayer].location>
    - execute as_server "execute at <[randomplayer].name> run teleport <[randomplayer].name> ~ ~ ~ 0 0"
    - wait 1t
    - define target <[randomplayer].target>
    - wait 1t
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ <[yaw]> <[pitch]>"
    - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 1 30 false <[target].uuid>"
    - flag <[randomplayer]> nomove:!
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
    - define randomscare <util.random_chance[70]>
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
        - define null <entry[nulljumpscare].spawned_entity>
        - execute as_server "disgplayer <[null].uuid> Player yyy88 setName Null setDisplayedInTab false"
        - teleport <[null]> <[newbehind]>
        - execute as_server "execute as <[null].uuid> at @s run tp @s ~ ~ ~ facing entity <[randomplayer].name>"
        - wait 0.5s
        - execute as_server "execute as <[randomplayer].name> at @s run teleport <[randomplayer].name> ~ ~ ~ facing <[newbehind].x> <[newbehind].y> <[newbehind].z>"
        - hurt 5 <[randomplayer]>
        - execute as_server "execute as <[randomplayer].name> at <[randomplayer].name> run playsound minecraft:custom.randomjumpscare ambient <[randomplayer].name> ~ ~ ~"
        - wait 1s
        - execute as_server "teleport <[null].uuid> ~ ~400 ~"
        - wait 1t
        - kill <[null]>
    - else:
        - narrate "nullendgame <[randomplayer].name>"

nullbreak:
    type: command
    name: nullbreak
    description: <red>Warning!! This command WILL greif.
    usage: /nullbreak
    permission: null.break
    script:
    - define randomplayer <server.online_players.random>
    - define blockbehind 1
    - execute as_server "execute as <[randomplayer].name> at @s run fill ~5 ~5 ~5 ~ ~ ~ structure_void destroy"

nullcantyousee:
    type: command
    name: nullcantyousee
    description: CANT'T YOU SEE? CANT'T YOU SEE? CANT'T YOU SEE?
    usage: /nullcantyousee
    permission: null.cantyousee
    script:
    - execute as_server "effect give @a minecraft:blindness 100 100 true"
    - title "title:CANT'T YOU SEE?" "subtitle:CANT'T YOU SEE?" fade_in:0s stay:0.5s fade_out:0s targets:<server.online_players>
    - actionbar "CANT'T YOU SEE?" targets:<server.online_players>
    - wait 0.5
    - actionbar '' targets:<server.online_players>
    - execute as_server "effect clear @a minecraft:blindness"

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
        - wait 0.2s

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
    - title "title:Good luck." "subtitle:=)" fade_in:0s stay:4s fade_out:0s targets:<server.online_players>
    - execute as_server "nulltimeset midnight"
    - wait 4s
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
    description: null.err.ob,ject.err.null.object.alone3.not.behind.entitytype:player.receiveddata.invalid.reboot.failed.reset.playerdata:00F9219492D94210F812
    usage: /nullbook
    permission: null.book
    script:
    - define randomplayer <server.online_players.random>
    - execute as_server 'give <[randomplayer].name> written_book{pages:['["null.err.object.err.null.object.alone3.not.behind.entitytype:player.receiveddata.invalid.reboot.failed.reset.playerdata:00F9219492D94210F812"]'],title:"null",author:"null"} 1'

nullgift:
    type: command
    name: nullgift
    description: 10 diamonds.
    usage: /nullgift
    permission: null.gift
    script:
    - define randomplayer <server.online_players.random>
    - define block <[randomplayer].location.backward[50].highest.block.above[1]>
    - define whichchest <util.random.int[1].to[2]>
    - if <[whichchest]> == 1:
        - execute as_server 'setblock <[block].x> <[block].y> <[block].z> minecraft:chest[facing=east,type=single,waterlogged=false]{Items:[{Count:10b,Slot:13b,id:"minecraft:diamond"}]}'
    - if <[whichchest]> == 2:
        - execute as_server 'setblock <[block].x> <[block].y> <[block].z> minecraft:chest[facing=east,type=single,waterlogged=false]{Items:[{Count:1b,Slot:4b,id:"minecraft:redstone_torch"},{Count:1b,Slot:12b,id:"minecraft:redstone_torch"},{Count:5b,Slot:13b,id:"minecraft:diamond"},{Count:1b,Slot:14b,id:"minecraft:redstone_torch"},{Count:1b,Slot:22b,id:"minecraft:redstone_torch"}]}'
        - execute as_server 'setblock <[block].x.add[1]> <[block].y> <[block].z> minecraft:oak_wall_sign[facing=east,waterlogged=false]{back_text:{color:"black",has_glowing_text:0b,messages:['""','""','""','""']},front_text:{color:"black",has_glowing_text:0b,messages:['"Gift"','""','""','""']},is_waxed:0b}'

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
        - execute as_server "execute as @a at @a run playsound minecraft:custom.falsecalm2 ambient @a ~ ~ ~ 0.5"
    - else:
        - execute as_server "execute as @a at @a run playsound minecraft:custom.falsesubwooferlullaby ambient @a ~ ~ ~ 0.35"

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
    - define block <[randomplayer].location.backward[100].highest.block.above[1]>
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

nullr2:
    type: command
    name: nullr2
    description: R2. (Needs to be more accurate.)
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
    - flag server r2:->:<[r2]>
    - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 20 20 false <[r2].uuid>"
    - define yaw <[randomplayer].location.yaw>
    - define yaw <[randomplayer].location.pitch>
    - wait 1t
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ 0 0"
    - flag <[randomplayer]> nomove
    - wait 1t
    - execute as_server 'execute at <[randomplayer].name> run summon armor_stand ~ ~ ~ { Invisible:1b, NoGravity:1b, Marker:0b, HandItems:[{id:"minecraft:stick",Count:1b,tag:{CustomModelData:2222222}},{}], Pose:{RightArm:[-90f,0f,0f]}}'
    - wait 1t
    - define armor_stand <[randomplayer].target>
    - flag <[randomplayer]> nomove:!
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ <[yaw]> <[pitch]>"
    - execute as_server "disgplayer <[r2].uuid> Player PolloProMC setNameVisible false setInvisible true"
    - execute as_server "item replace entity <[r2].uuid> weapon.mainhand with air"
    - adjust <[r2]> invulnerable:true
    - adjust <[r2]> custom_name:r2
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
    - spawn lightning <[randomplayer].location.add[<[randomx]>,0,<[randomz]>].highest.block>

nullfalsevillager:
    type: command
    name: nullfalsevillager
    description: Crashed.
    usage: /nullfalsevillager
    permission: null.falsevillager
    script:
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
    - spawn villager <[randomplayer].location.above[4000]> save:unsusvillager
    - flag server unsusvillager:<entry[unsusvillager].spawned_entity>
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
    - spawn <[randomplayer].location.above[200]> zombified_piglin save:circuitattacker
    - flag server circuitattacker:<entry[circuitattacker].spawned_entity>
    - execute as_server "disgplayer <server.flag[circuitattacker].uuid> Player yyy88 setName Circuit setNameVisible false"
    - adjust <server.flag[circuitattacker]> custom_name:Circuit
    - teleport <server.flag[circuitattacker]> <server.flag[unsusvillager].location.above[200]>
    - adjust <server.flag[circuitattacker]> persistent:true
    - adjust <server.flag[unsusvillager]> invulnerable:true
    - adjust <server.flag[circuitattacker]> invulnerable:true
    - adjust <server.flag[circuitattacker]> has_ai:false

nullbsod:
    type: command
    name: nullbsod
    description: :(
    usage: /nullbsod
    permission: null.bsod
    script:
    - execute as_server "execute as @a at @a run playsound minecraft:custom.bsod ambient @s ~ ~ ~ 100"
    - execute as_server "effect give @a blindness 10 100 true"
    - title title::( fade_in:0s fade_out:0s stay:9s targets:<server.online_players>
    - wait 9s
    - execute as_server "effect clear @a blindness"

nullflying:
    type: command
    name: nullflying
    description: Null flying.
    usage: /nullflying
    permission: null.flying
    script:
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
    - execute as_server "execute as @a at @a run playsound minecraft:custom.nullsad ambient @a ~ ~ ~"

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
    - define randommob <[randomplayer].location.find_entities[zombie].within[30].get[1]>
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
    - while <server.has_flag[nullwatch]>:
        - wait 1s
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
    - teleport <server.flag[null]> <[randomplayer].location.add[<[randomx]>,0,<[randomz]>]>
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
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.joined","with":["<[randomplayer].name>"],"color":"yellow"}'
    - define yaw <[randomplayer].location.yaw>
    - define pitch <[randomplayer].location.pitch>
    - flag <[randomplayer]> nomove
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ 0 0"
    - execute as_server "execute at <[randomplayer].name> run summon zombified_piglin ~ ~ ~ {IsBaby:0}"
    - wait 1t
    - flag server circuitnull:<[randomplayer].target>
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
    - while <server.has_flag[nullwatch]>:
        - wait 1s
    - define dude <server.match_player[<context.args.get[1]>]>
    - if <[dude].location.forward[<[1]>].block.material.name> != air:
        - stop
    - spawn <player.location.above[50]> villager save:nullendgame
    - adjust <entry[nullendgame].spawned_entity> has_ai:false
    - adjust <entry[nullendgame].spawned_entity> persistent:true
    - define null <entry[nullendgame].spawned_entity>
    - execute as_server "disgplayer <[null].uuid> Player yyy88 setName Null setDisplayedInTab false"
    - wait 0.5s
    - teleport <[null]> <[dude].location.forward[1]>
    - execute as_server "execute as <[null].uuid> at @s run teleport @s ~ ~ ~ facing entity <[dude].name>"
    - execute as_server "execute as <[dude].name> at <[dude].name> run playsound minecraft:custom.theendisnear ambient <[dude].name> ~ ~ ~"
    - repeat 60:
        - narrate "<dark_red>HERE I AM" targets:<[dude]>
        - narrate <dark_red><&k>VOIDNULLSILUETTANOMALY
        - wait 1t
    - kill <[dude]>
    - execute as_server "nullcrash <[dude].name>"
    - wait 2t
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
        - if <util.random_chance[50]>:
            - execute as_server "nullhole"
            - stop
    - define randomplayer <server.online_players.random>
    - define howfar <util.random.int[30].to[100]>
    - define block <[randomplayer].location.backward[<[howfar]>].block>
    - define structure <list[house2|cavebase|trap1|house3|crossfly|generationbug1|heavenportal|clanbuildoverhaul|gorestructure|totem|burnfractal|carcas|trap2|crosses|magmacross|randomwoodstructure|fractal3|glassfractal].random>
    - if <context.args.get[1].exists>:
        - define structure <context.args.get[1]>
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
    - if <[structure]> == cavebase:
        - define block <[randomplayer].location.backward[<[howfar]>].block.below[30]>
        - define newblock <[block]>
    - if <[structure]> == crosses:
        - define block <[randomplayer].location.backward[<[howfar]>].block.above[50]>
        - define newblock <[block]>
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
    - define block <[randomplayer].location.backward[50].above[<[howmuch]>]>
    - if <[block].material.name> != air:
        - define I 0
        - while <[block].above[<[I]>].material.name> != air:
            - define i:++
        - define block <[block].above[<[I].add[<[howmuch]>]>]>
    - modifyblock <[block]> water

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
    - execute as_server "execute as @a at @a run playsound minecraft:custom.moonglitch ambient @s ~ ~ ~"
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
        - define target:0
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
    description: Kills the entities that follow you and spawn black particles. (Admins only)
    usage: /nullnoblackthing
    permission: null.noblackthing
    script:
    - define theblack <player.location.find_entities[armor_stand].within[10].get[1]>
    - if <[theblack].has_flag[itsame]>:
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
    - kill <[circuit]>
    - flag server circuit:!
    - flag server circuitdeath:!

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
    - if !<server.has_flag[ram2die]> or !<server.has_flag[ramyoudie]>:
        - stop
    - teleport <server.flag[ram2die]> <server.flag[ram2die].location.below[100]>
    - kill <server.flag[ram2die]>
    - flag server ram2die:!
    - wait 1t
    - teleport <server.flag[ramyoudie]> <server.flag[ramyoudie].location.below[400]>
    - kill <server.flag[ramyoudie]>
    - flag server ramyoudie:!
    - wait 1t
    - flag server ramisdead:!

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