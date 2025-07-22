nullexist:
    type: world
    debug: true
    events:
        on delta time secondly:
        - if <server.has_flag[null]>:
            - if !<server.has_flag[nullwatch]>:
                - execute as_server "teleport <server.flag[null].uuid> ~ ~400 ~"
        - foreach <server.online_players_flagged[whereiwas]> as:wherei:
            - if !<[wherei].has_flag[iamhere]>:
                - teleport <[wherei]> <[wherei].flag[whereiwas]>
                - wait 1t
                - flag <[wherei]> whereiwas:!
                - execute as_server "gamemode survival <[wherei].name>"
        - if <server.has_flag[blackthing]>:
            - foreach <server.flag[blackthing]> as:thething:
                - execute as_server "execute as <[thething].uuid> at @s run tp @s ^ ^ ^0.25 facing entity @a[limit=1,sort=nearest] feet"
        - if <server.has_flag[null]>:
            - if !<server.flag[null].location.exists>:
                - execute as_server "nullleave silent"
                - wait 3s
                - execute as_server "nulljoin silent"

        on entity transforms:
        - if <server.flag[null]> == <context.entity>:
            - determine cancelled

        on delta time minutely:
        - if <server.has_flag[null]>:
            - if !<server.has_flag[nullwatch]>:
                - execute as_server "disgplayer <server.flag[null].uuid> Player yyy88 setName Null setDisplayedInTab true"
        - if !<server.has_flag[null]>:
            - flag server spawnnull:++
            - if <server.flag[spawnnull].mod[4]> == 0:
                - if <server.has_flag[inaminute]>:
                    - stop
                - else:
                    - execute as_server nulljoin
        - foreach <server.online_players_flagged[theangryone]> as:angry:
            - teleport <server.flag[r2]> <[angry].location>

        on delta time secondly every:30:
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
                - define randomevent <list[nullwatch|nullsong|nullsteps|nulltitle|nullsubtitle|nulladvancement2|nullgoaway|nullagressivecross|nullhappyface|nullopengl|nullfall|nullhost|nullblackthing|nullhole|nulljumpscare|nullbreak|nullcross|nullcantyousee|nullrandomlook|nullinventory|nullgoodluck|nulldisc13|nullbook|nullslowsong|nullfire|nulldisc11|nullfaraway|nullr2|nullfreezetime|nulllightning|nullcobblestonecross|nullfalsevillager|nullbsod|nullsad|nullcircuitdisguised|nullnamemob].random>
                - if <server.has_flag[nulldebug]>:
                    - narrate "Event happening! Events per minute is on: <[eventsperminute]>, current event <[randomevent]>" targets:<server.online_ops>
                - execute as_server <[randomevent]>
                - if <server.flag[reputation]> == GOOD:
                    - define maybechest <util.random_chance[10]>
                    - if <[maybechest]>:
                        - execute as_server nullgift
            - if <server.flag[eventnull].mod[10]> == 0:
                - flag server reputation:<list[GOOD|NORMAL|BAD].random>

        on player walks:
        - if <server.has_flag[nullwatch]>:
            - execute as_server "execute as <server.flag[null].uuid> at @s run tp @s ~ ~ ~ facing entity @a[limit=1,sort=nearest] feet"
        - if <server.has_flag[nullisangry]>:
            - foreach <server.online_players> as:player:
                - if <[player].location.distance[<server.flag[nullisangry]>]> <= 7:
                    - execute as_server nullsummoned
                    - wait 1t
                    - flag server nullisangry:!
        - if <player.has_flag[nomove]>:
            - determine cancelled
        - if <server.has_flag[faraway]>:
            - execute as_server "execute as <server.flag[faraway].uuid> at @s run tp @s ~ ~ ~ facing entity @a[limit=1,sort=nearest] feet"
            - foreach <server.online_players> as:player:
                - if <[player].location.distance[<server.flag[faraway].location>]> <= 20:
                    - ratelimit <[player]> 5s
                    - execute as_server "execute as <[player].name> at @s run teleport <[player].name> ~ ~ ~ <util.random.int[0].to[360]> <util.random.int[0].to[90]>"
                    - execute as_server "effect give <[player].name> minecraft:blindness 100 100 true"
                    - execute as_server "setblock <server.flag[faraway].location.block.x> <server.flag[faraway].location.block.y> <server.flag[faraway].location.block.z> air"
                    - execute as_server "setblock <server.flag[faraway].location.block.x> <server.flag[faraway].location.block.y.add[1]> <server.flag[faraway].location.block.z> air"
                    - execute as_server "execute as <[player].name> at <[player].name> run playsound minecraft:custom.farawayjumpscarenew ambient <[player].name> ~ ~ ~"
                    - define fw <server.flag[faraway]>
                    - wait 1t
                    - execute as_server "execute at <server.flag[faraway].uuid> run particle minecraft:block minecraft:black_concrete ~ ~1 ~ 1 1 1 0.1 300 force"
                    - wait 1t
                    - teleport <server.flag[faraway]> <server.flag[faraway].location.above[100]>
                    - kill <[fw]>
                    - wait 1t
                    - flag server faraway:!
                    - wait 1s
                    - execute as_server "effect clear <[player].name> minecraft:blindness"
        - if <server.has_flag[r2]>:
            - foreach <server.online_players> as:player:
                - if <[player].location.distance[<server.flag[r2].location>]> <= 5:
                    - if <server.has_flag[spawningr2]>:
                        - stop
                    - if !<server.has_flag[triggeredr2]>:
                        - execute as_server "effect give <server.flag[r2].uuid> minecraft:speed infinite 5 true"
                        - spawn lightning <[player].location>
                        - adjust <server.flag[r2]> has_ai:true
                        - execute as_server "data modify entity <server.flag[r2].uuid> AngryAt set from entity <[player].uuid> UUID"
                        - flag server triggeredr2
                        - flag <[player]> theangryone
                        - repeat 660:
                            - playsound <[player]> sound:entity_lightning_bolt_thunder volume:0.2
                            - wait 1t
        - if <server.has_flag[unsusvillager]>:
            - foreach <server.online_players> as:player:
                - if <[player].location.distance[<server.flag[unsusvillager].location>]> <= 4:
                    - ratelimit <[player]> 3s
                    - teleport <server.flag[circuitattacker]> <server.flag[unsusvillager].location>
                    - wait 1t
                    - teleport <server.flag[unsusvillager]> <server.flag[unsusvillager].location.above[100]>
                    - kill <server.flag[unsusvillager]>
                    - wait 1t
                    - flag server unsusvillager:!
                    - adjust <server.flag[circuitattacker]> has_ai:true
                    - execute as_server "data modify entity <server.flag[circuitattacker].uuid> AngryAt set from entity <[player].uuid> UUID"
                    - execute as_server "effect give <server.flag[circuitattacker].uuid> minecraft:speed infinite 2 true"
                    - spawn lightning <[player].location>
        - if <server.has_flag[circuit]>:
            - foreach <server.online_players> as:player:
                - if <[player].location.distance[<server.flag[circuit].location>]> <= 4:
                    - ratelimit <[player]> 1m
                    - if <[player].name> == <server.flag[circuit].name>:
                        - execute as_server "execute as <[player].name> at <[player].name> run playsound minecraft:custom.circuitchase ambient <[player].name> ~ ~ ~"
                        - execute as_server "data modify entity <server.flag[circuit].uuid> AngryAt set from entity <[player].uuid> UUID"
                        - execute as_server "effect give <server.flag[circuit].uuid> minecraft:speed infinite 2 true"
                        - stop
                    - narrate "<&lt><server.flag[circuit].name><&gt> <list[hey|do you have some food?|i'm lost|where's the base].random>" targets:<[player]>

        on entity damaged:
        - if !<context.damager.exists>:
            - if <context.entity> == <server.flag[circuit]>:
                - if !<server.has_flag[circuitdeath]>:
                    - determine cancelled

        on entity damages player:
        - if <context.damager> == <server.flag[circuitattacker]>:
            - execute as_server 'nullcrash <player.name>'
            - teleport <server.flag[circuitattacker]> <server.flag[circuitattacker].location.below[100]>
            - kill <server.flag[circuitattacker]>
            - wait 1t
            - kick <context.entity> reason:Disconnected.
        - if <context.damager> == <server.flag[circuit]>:
            - execute as_server "execute as <player.name> at <[player].name> run playsound minecraft:custom.circuit_jumpscare ambient <[player].name> ~ ~ ~"
            - execute as_server "effect give <player.name> blindness 10 250 true"
            - wait 1t
            - execute as_server 'nullcrash <player.name>'
            - teleport <server.flag[circuit]> <server.flag[circuit].location.below[100]>
            - kill <server.flag[circuit]>
            - wait 1t
            - kick <context.entity> reason:Disconnected.

        on player damages entity:
        - if <context.entity> == <server.flag[circuit]>:
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.youwillregretthat ambient <player.name> ~ ~ ~
            - wait 2s
            - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.circuitchase ambient <player.name> ~ ~ ~
            - execute as_server "effect give <server.flag[circuit].uuid> minecraft:speed infinite 2 true"

        on player joins:
        - if !<player.has_flag[pumpkin]>:
            - fakeequip <player> head:carved_pumpkin
            - flag <player> pumpkin

        on player respawns:
        - if !<player.has_flag[removevhs]>:
            - fakeequip <player> head:carved_pumpkin

        on player changes sign:
        - if <player.has_flag[iamhere]>:
            - determine cancelled

        on player right clicks oak_door:
        - if <player.has_flag[iamhere]>:
            - determine cancelled

        on player dies:
        - if <server.has_flag[r2]>:
            - if <player.has_flag[theangryone]>:
                - teleport <server.flag[r2]> <server.flag[r2].location.above[100]>
                - kill <server.flag[r2]>
                - flag server r2:!
                - flag server triggeredr2:!
                - flag <player> theangryone:!
        - if <server.has_flag[blackthing]>:
            - define theblack <player.location.find_entities[armor_stand].within[10].get[1]>
            - if <[theblack].has_flag[itsame]>:
                - flag <[theblack]> itsame:!
                - flag server blackthing:<-:<[theblack]>
                - wait 1t
                - kill <[theblack]>

        on player quits:
        - if <player.has_flag[theangryone]>:
            - teleport <server.flag[r2]> <server.flag[r2].location.above[100]>
            - kill <server.flag[r2]>
            - flag server r2:!
            - flag server triggeredr2:!
            - flag <player> theangryone:!
        - if <player> == <server.flag[oneofus]>:
                - execute as_server 'tellraw @a {"translate":"death.attack.player","with":["<player.name>","Null"],"color":"white"}'
                - execute as_server "execute at <server.flag[oneofus].name> run gamerule showDeathMessages false"
                - kill <server.flag[oneofus]>
                - execute as_server "execute at <server.flag[oneofus].name> run gamerule showDeathMessages true"
                - ban <server.flag[oneofus]> reason:null
                - flag server oneofus:!
                - flag server nullwatch:!
                - wait 1s
                - adjust <server.flag[null]> visible:false

        on player enters portal:
        - if <server.has_flag[null]>:
            - if !<server.has_flag[inaminute]>:
                - flag server inaminute expire:10s
                - execute as_server "nullleave silent"
                - wait 10s
                - execute as_server "nulljoin silent"

        on entity enters portal:
        - if <server.has_flag[null]>:
            - if <server.flag[null]> == <context.entity>:
                - determine cancelled

        on player right clicks *_bed:
        - if <util.random_chance[50]>:
            - if <player.has_flag[doneonce]>:
                - stop
            - wait 1.5s
            - flag <player> doneonce expire:10s
            - hurt 1 <player>

        on player drops item:
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
        - if <server.has_flag[triggeredr2]>:
            - actionbar "IMPORT minecraft.chatengine"
            - wait 1.5s
            - actionbar "IMPORT minecraft.chatengine"
            - wait 1.5s
            - actionbar Unexpected_error.returnedvalue=-1
            - determine cancelled
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
                - if <server.flag[reputation]> == GOOD:
                    - if <server.has_flag[nullwatch]>:
                        - stop
                    - wait 1t
                    - flag server nullwatch expire:5s
                    - execute as_server "execute at <player.name> run spreadplayers ~ ~ 1 30 false <server.flag[null].uuid>"
                    - adjust <server.flag[null]> visible:true
                    - wait 5s
                    - adjust <server.flag[null]> visible:false
                - if <server.flag[reputation]> == NORMAL:
                    - flag server nullwatch expire:1.5s
                    - execute as_server "teleport <server.flag[null].uuid> <player.location.x> <player.location.y> <player.location.z> facing entity <player.name>"
                    - adjust <server.flag[null]> visible:true
                    - wait 0.5s
                    - execute as_server "execute as <player.name> at @s run teleport <player.name> ~ ~ ~ facing entity <server.flag[null].uuid>"
                    - hurt 5 <player>
                    - execute as_server "execute as <player.name> at <player.name> run playsound minecraft:custom.randomjumpscare ambient <player.name> ~ ~ ~"
                    - wait 1s
                    - execute as_server "teleport <server.flag[null].uuid> ~ ~400 ~"
                    - adjust <server.flag[null]> visible:false
                - if <server.flag[reputation]> == BAD:
                    - stop
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
        - if <server.has_flag[blackthing]>:
            - foreach <server.flag[blackthing]> as:thething:
                - execute as_server "execute at <[thething].uuid> run particle minecraft:block minecraft:black_concrete ~ ~1 ~ 1 1 1 0.1 20 force"
                - hurt 2 <[thething].location.find_entities.within[3]>
                - define water <[thething].location.find_blocks[water].within[3]>
                - modifyblock <[water]> cobblestone
                - wait 1t
        - if <server.has_flag[r2]>:
            - execute as_server "execute at <server.flag[r2].uuid> run particle minecraft:block minecraft:black_concrete ~ ~ ~ 0 2 0 0.1 100 force"
        - if <server.has_flag[oneofus]>:
            - execute as_server "execute as <server.flag[null].uuid> at @s run tp @s ^ ^ ^1 facing entity <server.flag[oneofus].name> feet"
            - if <server.flag[oneofus].location.distance[<server.flag[null].location>]> <= 2:
                - execute as_server "execute at <server.flag[oneofus].name> run gamerule showDeathMessages false"
                - kill <server.flag[oneofus]>
                - execute as_server 'tellraw @a {"translate":"death.attack.player","with":["<server.flag[oneofus].name>","Null"],"color":"white"}'
                - execute as_server "execute as <server.flag[oneofus].name> at <server.flag[oneofus].name> run playsound minecraft:custom.randomjumpscare ambient <server.flag[oneofus].name> ~ ~ ~"
                - wait 1t
                - execute as_server "nullcrash <player.name>"
                - execute as_server "execute at <server.flag[oneofus].name> run gamerule showDeathMessages true"
                - ban <server.flag[oneofus]> reason:null
                - flag server oneofus:!
                - flag server nullwatch:!
                - wait 1s
                - adjust <server.flag[null]> visible:false
            - execute as_server "execute as <server.flag[oneofus].name> at <server.flag[oneofus].name> run playsound minecraft:custom.nullishereloop ambient <server.flag[oneofus].name> ~ ~ ~"
            - ratelimit <server.flag[oneofus]> 0.3s
            - title title:<list[You know nothing|Worship me|Follow me|Join us|Corrupted|Go away|Null|We can hear you|Can you see me?|0|Behind you|Help me|Nothing can be changed|Close your eyes|One of us].random> targets:<server.flag[oneofus]>

# Command: /whereami
nulljoin_command:
    type: command
    name: nulljoin
    description: Null joined the game.
    usage: /nulljoin
    permission: null.join
    script:
    - define randomplayer <server.online_players.random>
    - define yaw <[randomplayer].location.yaw>
    - define pitch <[randomplayer].location.pitch>
    - flag <[randomplayer]> nomove
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ 0 0"
    - execute as_server "execute at <[randomplayer].name> run summon villager ~ ~ ~ {NoAI:1b}"
    - wait 1t
    - flag server null:<[randomplayer].target>
    - wait 1t
    - flag <[randomplayer]> nomove:!
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ <[yaw]> <[pitch]>"
    - execute as_server "teleport <server.flag[null].uuid> ~ ~400 ~"
    - wait 1t
    - execute as_server "disgplayer <server.flag[null].uuid> Player yyy88 setName Null setDisplayedInTab true"
    - adjust <server.flag[null]> visible:false
    - adjust <server.flag[null]> invulnerable:true
    - if <context.args.get[1]> == silent:
        - stop
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.joined","with":["Null"],"color":"yellow"}'
    - if !<server.has_flag[forceloaded]>:
        - execute as_server "forceload add ~ ~ ~ ~"
        - flag server forceloaded
    - playsound <server.online_players> sound:ambient_cave pitch:0.5

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
    - if <context.args.get[1]> == silent:
        - stop
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.left","with":["Null"],"color":"yellow"}'

# Command: /whereis
nullwatch:
    type: command
    name: nullwatch
    description: Check another player's status
    usage: /nullwatch
    permission: null.watch
    script:
    - if <server.has_flag[nullwatch]>:
        - stop
    - define randomuser <server.online_players.random>
    - flag server nullwatch expire:2s
    - execute as_op "execute at <[randomuser].name> run spreadplayers ~ ~ 1 30 false <server.flag[null].uuid>"
    - adjust <server.flag[null]> visible:true

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
    - execute as_server "time set midnight"
    - execute as_server "execute as @a at @a run playsound minecraft:custom.randomsong ambient @a ~ ~ ~"

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

nullsubtitle:
    type: command
    name: nullsubtitle
    description: Why can't you just leave?
    usage: /nullsubtitle
    permission: null.subtitle
    script:
    - title "subtitle:<&0>Why can't you just leave?" targets:<server.online_players>

nullHereIam:
    type: command
    name: nullhereiam
    description: Can you see me?
    usage: /nullhereiam
    permission: null.heriam
    script:
    - foreach <server.online_players> as:player:
        - if !<[player].has_flag[hereiam]>:
            - announce "<element[<[player].name>].on_hover[<[player].name><n>Type: Player<n><[player].uuid>]> has made the advancement <green>[<element[Here I am.].on_hover[<green>Here I am.<n>Can you see me?]>]"
            - flag <[player]> hereiam
    - playsound <server.online_players> sound:ui_toast_in
    - wait 6s
    - playsound <server.online_players> sound:ui_toast_out

nulladvancement2:
    type: command
    name: nulladvancement2
    description: nullnullnull
    usage: /nulladvancement2
    permission: null.advancement2
    script:
    - foreach <server.online_players> as:player:
        - if !<[player].has_flag[advancement2]>:
            - announce "<element[<[player].name>].on_hover[<[player].name><n>Type: Player<n><[player].uuid>]> has made the advancement <green>[<element[nullnullnull].on_hover[<green>nullnullnull<n>nullnullnull]>]"
            - flag <[player]> advancement2
    - playsound <server.online_players> sound:ui_toast_in
    - wait 6s
    - playsound <server.online_players> sound:ui_toast_out

nullgoaway:
    type: command
    name: nullgoaway
    description: This place is not for you.
    usage: /nullgoaway
    permission: null.goaway
    script:
    - foreach <server.online_players> as:player:
        - if !<[player].has_flag[goaway]>:
            - announce "<element[<[player].name>].on_hover[<[player].name><n>Type: Player<n><[player].uuid>]> has made the advancement <green>[<element[Go Away].on_hover[<green>Go Away<n>This place is not for you.]>]"
            - flag <[player]> goaway
    - playsound <server.online_players> sound:ui_toast_in
    - wait 6s
    - playsound <server.online_players> sound:ui_toast_out

nullaggressivecross:
    type: command
    name: nullaggressivecross
    description: 0 0 0 - - - - - -
    usage: /nullaggressivecross
    permission: null.aggressivecross
    script:
    - define randomplayer <server.online_players.random>
    - define chest <[randomplayer].location.find_blocks[chest].within[30].get[1]>
    - if <[chest].exists>:
        - modifyblock <[chest].add[0,0,1]> netherrack
        - modifyblock <[chest].add[0,1,1]> netherrack
        - modifyblock <[chest].add[0,2,1]> netherrack
        - modifyblock <[chest].add[0,3,1]> netherrack
        - modifyblock <[chest].add[0,4,1]> netherrack
        - modifyblock <[chest].add[1,3,1]> netherrack
        - modifyblock <[chest].add[-1,3,1]> netherrack
        - spawn giant <[chest]>
        - wait 1t
        - define giant <[randomplayer].location.find_entities[giant].within[30].get[1]>
        - execute as_server 'execute as <[giant].uuid> at @s run setblock ~ ~3 ~ minecraft:oak_wall_sign[facing=north,waterlogged=false]{back_text:{color:"black",has_glowing_text:0b,messages:['""','""','""','""']},front_text:{color:"black",has_glowing_text:0b,messages:['"[0] [0] [0]"','"[-] [-]"','"[-] [-]"','"[-] [-]"']},is_waxed:0b}'
        - wait 1t
        - teleport <[giant]> <[giant].location.up[100]>
        - wait 1t
        - kill <[giant]>
        - flag server nullisangry:<[chest]> expire:1m
        - flag server nullwatch expire:1m
        - adjust <server.flag[null]> visible:true
        - teleport <server.flag[null]> <server.flag[nullisangry].up[1]>

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
    - actionbar =) targets:<server.online_players>
    - execute as_server "execute as @a at @a run playsound minecraft:custom.textmadness1 ambient @a ~ ~ ~"

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
    description: Null Host
    usage: /nullHost
    permission: null.host
    script:
    - announce "<white>Local game hosted on port [<green><&k>00000<white>]"
    - wait 20s
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.joined","with":["xXram2dieXx"],"color":"yellow"}'
    - execute as_server "time set midnight"
    - wait 30s
    - announce "<&lt>xXram2dieXx<&gt> 48656c6c6f3f"
    - execute as_server "time set midnight"
    - playsound <server.online_players> sound:ambient_cave
    - wait 15s
    - announce "<&lt>xXram2dieXx<&gt> 486f772064696420796f7520666f756e642074686973207365727665723f"
    - execute as_server "time set midnight"
    - playsound <server.online_players> sound:ambient_cave
    - wait 20s
    - announce "<&lt>xXram2dieXx<&gt> 446f20796f752077616e7420746f20626520667269656e64733f"
    - execute as_server "time set midnight"
    - playsound <server.online_players> sound:ambient_cave
    - wait 17s
    - announce "<&lt>xXram2dieXx<&gt> 4c656176652e"
    - execute as_server "time set midnight"
    - playsound <server.online_players> sound:ambient_cave
    - wait 23s
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.left","with":["xXram2dieXx"],"color":"yellow"}'

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
    - define blockbehind 1
    - repeat 5:
        - if <[randomplayer].location.backward[<[blockbehind]>].block.material.name> != air:
            - stop
        - define blockbehind:++
    - flag server nullwatch expire:1.5s
    - execute as_server "teleport <server.flag[null].uuid> <[randomplayer].location.backward[<[blockbehind]>].x> <[randomplayer].location.backward[<[blockbehind]>].y> <[randomplayer].location.backward[<[blockbehind]>].z> facing entity <[randomplayer].name>"
    - adjust <server.flag[null]> visible:true
    - wait 0.5s
    - execute as_server "execute as <[randomplayer].name> at @s run teleport <[randomplayer].name> ~ ~ ~ facing entity <server.flag[null].uuid>"
    - hurt 5 <[randomplayer]>
    - execute as_server "execute as <[randomplayer].name> at <[randomplayer].name> run playsound minecraft:custom.randomjumpscare ambient <[randomplayer].name> ~ ~ ~"
    - wait 1s
    - execute as_server "teleport <server.flag[null].uuid> ~ ~400 ~"
    - adjust <server.flag[null]> visible:false

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

nullcross:
    type: command
    name: nullcross
    description: 0 0 0 - - - - - -
    usage: /nullcross
    permission: null.cross
    script:
    - define randomplayer <server.online_players.random>
    - define block <[randomplayer].location.backward[100].highest.block>
    - if <[block].material.name> != air:
        - define <[randomplayer].location.backward[100].highest.block.above[1]>
        - modifyblock <[block].add[0,0,1]> netherrack
        - modifyblock <[block].add[0,1,1]> netherrack
        - modifyblock <[block].add[0,2,1]> netherrack
        - modifyblock <[block].add[0,3,1]> netherrack
        - modifyblock <[block].add[0,4,1]> netherrack
        - modifyblock <[block].add[1,3,1]> netherrack
        - modifyblock <[block].add[-1,3,1]> netherrack
        - spawn giant <[block]>
        - wait 1t
        - define giant <[randomplayer].location.find_entities[giant].within[110].get[1]>
        - execute as_server 'execute as <[giant].uuid> at @s run setblock ~ ~3 ~ minecraft:oak_wall_sign[facing=north,waterlogged=false]{back_text:{color:"black",has_glowing_text:0b,messages:['""','""','""','""']},front_text:{color:"black",has_glowing_text:0b,messages:['"[0] [0] [0]"','"[-] [-]"','"[-] [-]"','"[-] [-]"']},is_waxed:0b}'
        - wait 1t
        - teleport <[giant]> <[giant].location.up[100]>
        - wait 1t
        - kill <[giant]>

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
    - inventory open d:generic[size=27;title=help;contents=<player.inventory.list_contents>]

nullgoodluck:
    type: command
    name: nullgoodluck
    description: Good luck. =)
    usage: /nullgoodluck
    permission: null.goodluck
    script:
    - execute as_server "effect give @a minecraft:blindness 100 100 true"
    - title "title:Good luck." "subtitle:=)" fade_in:0s stay:4s fade_out:0s targets:<server.online_players>
    - execute as_server "time set midnight"
    - wait 4s
    - execute as_server "effect clear @a minecraft:blindness

nulldisc13:
    type: command
    name: nulldisc13
    description: Disc 13
    usage: /nulldisc13
    permission: null.disc13
    script:
    - playsound <server.online_players> sound:music_disc_13

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
        - execute as_server "execute as @a at @a run playsound minecraft:custom.falsesubwooferlullaby ambient @a ~ ~ ~ 0.3"

nullfire:
    type: command
    name: nullfire
    description: Fire.
    usage: /nullfire
    permission: null.fire
    script:
    - define randomplayer <server.online_players.random>
    - adjust <[randomplayer]> visual_fire:true
    - repeat 5:
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
    - if <server.has_flag[faraway]>:
        - stop
    - define randomplayer <server.online_players.random>
    - define block <[randomplayer].location.backward[100].highest.block.above[1]>
    - define yaw <[randomplayer].location.yaw>
    - define pitch <[randomplayer].location.pitch>
    - flag <[randomplayer]> nomove
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ 0 0"
    - execute as_server "execute at <[randomplayer].name> run summon villager ~ ~ ~ {NoAI:1b}"
    - wait 1t
    - flag server faraway:<[randomplayer].target>
    - wait 1t
    - flag <[randomplayer]> nomove:!
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ <[yaw]> <[pitch]>"
    - execute as_server "disgplayer <server.flag[faraway].uuid> Player Timbothany setNameVisible false"
    - execute as_server "teleport <server.flag[faraway].uuid> <[block].x> <[block].y> <[block].z>"
    - execute as_server "setblock <[block].x> <[block].y> <[block].z> light[level=15]"
    - execute as_server "setblock <[block].x> <[block].y.add[1]> <[block].z> light[level=15]"
    - adjust <server.flag[faraway]> invulnerable:true

nullr2:
    type: command
    name: nullr2
    description: R2.
    usage: /nullr2
    permission: null.r2
    script:
    - if <server.has_flag[r2]>:
        - stop
    - flag server spawningr2
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
    - define yaw <[randomplayer].location.yaw>
    - define pitch <[randomplayer].location.pitch>
    - flag <[randomplayer]> nomove
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ 0 0"
    - execute as_server "execute at <[randomplayer].name> run summon zombified_piglin ~ ~ ~ {NoAI:1b,IsBaby:1}"
    - wait 1t
    - flag server r2:<[randomplayer].target>
    - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 1 30 false <server.flag[r2].uuid>"
    - teleport <server.flag[unsusvillager]> <[randomplayer].location.add[<[randomx]>,0,<[randomz]>].highest.block.above[1]>
    - flag <[randomplayer]> nomove:!
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ <[yaw]> <[pitch]>"
    - execute as_server "disgplayer <server.flag[r2].uuid> Player PolloProMC setNameVisible false setInvisible true"
    - execute as_server "item replace entity <server.flag[r2].uuid> weapon.mainhand with air"
    - adjust <server.flag[r2]> invulnerable:true
    - adjust <server.flag[r2]> custom_name:r2
    - define advancement? <util.random_chance[30]>:
        - execute as_server "nullhereiam"
    - adjust <server.flag[r2]> persistent:true
    - flag server spawningr2:!

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
    description: Why isn't the sun moving?
    usage: /nulllightning
    permission: null.lightning
    script:
    - define randomplayer <server.online_players.random>
    - define randomx <util.random.int[-10].to[10]>
    - define randomz <util.random.int[-10].to[10]>
    - spawn lightning <[randomplayer].location.add[<[randomx]>,0,<[randomz]>].highest.block>

nullcobblestonecross:
    type: command
    name: nullcobblestonecross
    description: A cross made of mossy cobblestone blocks
    usage: /nullcobblestonecross
    permission: null.cobblestonecross
    script:
    - define randomplayer <server.online_players.random>
    - define block <[randomplayer].location.backward[100].highest.block>
    - if <[block].material.name> != air:
        - define <[randomplayer].location.backward[100].highest.block.above[1]>
        - modifyblock <[block].add[0,0,0]> redstone_block
        - modifyblock <[block].add[1,0,1]> redstone_block
        - modifyblock <[block].add[1,1,1]> cobbled_deepslate_wall
        - modifyblock <[block].add[1,0,-1]> redstone_block
        - modifyblock <[block].add[1,1,-1]> cobbled_deepslate_wall
        - modifyblock <[block].add[-1,0,1]> redstone_block
        - modifyblock <[block].add[-1,1,1]> cobbled_deepslate_wall
        - modifyblock <[block].add[-1,0,-1]> redstone_block
        - modifyblock <[block].add[-1,1,-1]> cobbled_deepslate_wall
        - modifyblock <[block].add[1,0,0]> netherrack
        - modifyblock <[block].add[1,1,0]> redstone_torch
        - modifyblock <[block].add[-1,0,0]> netherrack
        - modifyblock <[block].add[-1,1,0]> redstone_torch
        - modifyblock <[block].add[0,0,1]> netherrack
        - modifyblock <[block].add[0,1,1]> redstone_torch
        - modifyblock <[block].add[0,0,-1]> netherrack
        - modifyblock <[block].add[0,1,-1]> redstone_torch
        - modifyblock <[block].add[0,1,0]> mossy_cobblestone
        - modifyblock <[block].add[0,2,0]> cobbled_deepslate_wall
        - modifyblock <[block].add[0,3,0]> mossy_cobblestone
        - modifyblock <[block].add[0,5,0]> mossy_cobblestone
        - modifyblock <[block].add[1,4,0]> mossy_cobblestone
        - modifyblock <[block].add[-1,4,0]> mossy_cobblestone
        - execute as_server "setblock <[block].add[0,4,0].x> <[block].add[0,4,0].y> <[block].add[0,4,0].z> minecraft:cobbled_deepslate_wall[east=tall,north=none,south=none,up=false,waterlogged=false,west=tall]"

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
    - define yaw <[randomplayer].location.yaw>
    - define pitch <[randomplayer].location.pitch>
    - flag <[randomplayer]> nomove
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ 0 0"
    - spawn villager <[randomplayer].location>
    - wait 1t
    - flag server unsusvillager:<[randomplayer].target>
    - teleport <server.flag[unsusvillager]> <[randomplayer].location.add[<[randomx]>,0,<[randomz]>].highest.block.above[1]>
    - execute as_server "execute at <[randomplayer].name> run summon zombified_piglin ~ ~ ~ {NoAI:1b,IsBaby:0}"
    - wait 2t
    - flag server circuitattacker:<[randomplayer].target>
    - wait 1t
    - flag <[randomplayer]> nomove:!
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ <[yaw]> <[pitch]>"
    - execute as_server "disgplayer <server.flag[circuitattacker].uuid> Player yyy88 setName Circuit setNameVisible false"
    - adjust <server.flag[circuitattacker]> custom_name:Null
    - teleport <server.flag[circuitattacker]> <server.flag[unsusvillager].location.above[200]>
    - adjust <server.flag[circuitattacker]> persistent:true
    - adjust <server.flag[unsusvillager]> invulnerable:true

nullbsod:
    type: command
    name: nullbsod
    description: MY PC
    usage: /nullbsod
    permission: null.bsod
    script:
    - execute as_server "execute as @a at @a run playsound minecraft:custom.bsod ambient @a ~ ~ ~ 100"
    - execute as_server "effect give @a blindness 10 100 true"
    - title title::( fade_in:0s fade_out:0s stay:9s targets:<server.online_players>
    - wait 9s
    - execute as_server "effect clear @a blindness"

nullsad:
    type: command
    name: nullsad
    description: Sad
    usage: /nullsad
    permission: null.sad
    script:
    - execute as_server "execute as @a at @a run playsound minecraft:custom.nullsad ambient @a ~ ~ ~"

nullcircuitdisguised:
    type: command
    name: nullcircuitdisguised
    description: Circuit.
    usage: /nullcircuitdisguised
    permission: null.circuitdisguised
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
    - define yaw <[randomplayer].location.yaw>
    - define pitch <[randomplayer].location.pitch>
    - flag <[randomplayer]> nomove
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ 0 0"
    - execute as_server "execute at <[randomplayer].name> run summon zombified_piglin ~ ~ ~ {IsBaby:0}"
    - wait 1t
    - flag server circuit:<[randomplayer].target>
    - teleport <server.flag[circuit]> <[randomplayer].location.add[<[randomx]>,0,<[randomz]>].highest.block.above[1]>
    - flag <[randomplayer]> nomove:!
    - execute as_server "execute at <[randomplayer].name> run tp <[randomplayer].name> ~ ~ ~ <[yaw]> <[pitch]>"
    - define randomplayer2 <server.online_players.random.name>
    - execute as_server "disgplayer <server.flag[circuit].uuid> Player <[randomplayer2]>"
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
    - define randommob <[randomplayer].location.find_entities[zombie].within[30]>
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
    - teleport <server.flag[null]> <[randomplayer].location.add[<[randomx]>,0,<[randomz]>]>
    - flag server oneofus:<[randomplayer]>
    - flag server nullwatch
    - adjust <server.flag[null]> visible:true

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
    description: Kills r2 (Admins only)
    usage: /nullnor2
    permission: null.nor2
    script:
    - if !<server.has_flag[r2]>:
        - stop
    - define r2 <server.flag[r2]>
    - flag server r2:!
    - wait 1t
    - kill <[r2]>
    - flag server triggeredr2:!

nullnofaraway:
    type: command
    name: nullnofaraway
    description: Kills faraway (Admins only)
    usage: /nullnofaraway
    permission: null.nofaraway
    script:
    - if !<server.has_flag[faraway]>:
        - stop
    - define faraway <server.flag[faraway]>
    - execute as_server "setblock <[faraway].location.block.x> <[faraway].location.block.y> <[faraway].location.block.z> air"
    - execute as_server "setblock <[faraway].location.block.x> <[faraway].location.block.y.add[1]> <[faraway].location.block.z> air"
    - wait 1t
    - flag server faraway:!
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

nullnocircuit:
    type: command
    name: nullnocircuit
    description: Kills fake player aka circuit (Admins only)
    usage: /nullnocircuit
    permission: null.nocircuit
    script:
    - if !<server.has_flag[circuit]>:
        - stop
    - flag server circuitdeath
    - define circuit <server.flag[circuit]>
    - wait 1t
    - kill <[circuit]>
    - flag server circuit:!
    - flag server circuitdeath:!

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