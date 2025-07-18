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
            - if !<server.has_flag[reputation]>:
                - flag server reputation:NORMAL
            - if !<server.has_flag[nullwatch]>:
                - execute as_server "disgplayer <server.flag[null].uuid> Player yyy88 setName Null setDisplayedInTab true"
                - if !<server.has_flag[eventnull]>:
                    - flag server eventnull:0
                - flag server eventnull:++
                - if <server.has_flag[notimedevents]>:
                    - stop
                - if <server.flag[eventnull].mod[3]> == 0:
                    - define randomevent <list[nullwatch|nullsong|nullsteps|nulltitle|nullsubtitle|nullhereiam|nulladvancement2|nullgoaway|nullagressivecross|nullhappyface|nullopengl|nullfall|nullhost|nullblackthing|nullhole|nulljumpscare|nullbreak|nullcross|nulldontyousee|nullrandomlook|nullinventory|nullgoodluck|nulldisc13|nullbook|nullslowsong].random>
                    - execute as_server <[randomevent]>
                    - if <server.flag[reputation]> == GOOD:
                        - define maybechest <util.random_chance[30]>
                        - if <[maybechest]>:
                            - execute as_server nullgift
                - if <server.flag[eventnull].mod[10]> == 0:
                    - flag server reputation:<list[GOOD|NORMAL|BAD].random>
        - if !<server.flag[null]>:
            - flag server spawnnull:++
            - if <server.flag[spawnnull].mod[4]> == 0:
                - if <server.has_flag[inaminute]>:
                    - stop
                - else:
                    - execute as_server nulljoin

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
        on player changes sign:
        - if <player.has_flag[iamhere]>:
            - determine cancelled

        on player right clicks oak_door:
        - if <player.has_flag[iamhere]>:
            - determine cancelled

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

        on player chats:
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
                - wait 5s
                - announce "<&lt>Null<&gt> The end is nigh."
                - wait 1s
                - announce "<&lt>Null<&gt> The end is null."
                - wait 0.5s
                - playsound <player> sound:entity_enderman_death pitch:0.5
                - wait 1t
                - teleport <server.flag[null]> <player.location>
                - adjust <server.flag[null]> visible:true
                - execute as_op 'tellraw @a {"translate":"death.attack.player","with":["PolloProMC","Null"],"color":"white"}'
                - execute as_op "gamerule showDeathMessages false"
                - kill <player>
                - wait 1t
                - execute as_op "gamerule showDeathMessages true"
                - kick <player> reason:null
                - wait 0.5s
                - execute as_server "teleport <server.flag[null].uuid> ~ ~400 ~"
                - adjust <server.flag[null]> visible:false
            - else if <context.message> == "Can you see me?":
                - wait 5s
                - announce "<&lt>Null<&gt> Yes."
                - wait 3s
                - announce "<&lt>Null<&gt> Hello."
                - wait 3s
                - spawn lightning <player.location.block>
                - execute as_server "effect give <player.name> minecraft:blindness 2 250 true"
            - else if <context.message> == Friend?:
                - wait 5s
                - if <server.flag[reputation]> == GOOD:
                    - if <server.has_flag[nullwatch]>:
                        - stop
                    - flag server nullwatch expire:5s
                    - execute as_op "execute at <player.name> run spreadplayers ~ ~ 1 30 false <server.flag[null].uuid>"
                    - adjust <server.flag[null]> visible:true
                - if <server.flag[reputation]> == NORMAL:
                    - flag server nullwatch expire:1.5s
                    - execute as_server "teleport <server.flag[null].uuid> <player.location.x> <player.location.y> <player.location.z> facing entity <player.name>"
                    - adjust <server.flag[null]> visible:true
                    - wait 0.5s
                    - execute as_server "execute as <player.name> at @s run teleport <player.name> ~ ~ ~ facing entity <server.flag[null].uuid>"
                    - hurt 5 <player>
                    - playsound <player> sound:entity_enderman_death volume:100
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
                - wait 5s
                - announce "<&lt>Null<&gt> Rot in hell."
                - playsound <player> sound:entity_enderman_death pitch:0.5
                - teleport <server.flag[null]> <player.location>
                - adjust <server.flag[null]> visible:true
                - execute as_op 'tellraw @a {"translate":"death.attack.player","with":["PolloProMC","Null"],"color":"white"}'
                - execute as_op "gamerule showDeathMessages false"
                - kill <player>
                - wait 1t
                - execute as_op "gamerule showDeathMessages true"
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
    - wait 1s
    - execute as_server "time add 600s"
    - nbs play file:Nullsong targets:<server.online_players>
    - wait 22s
    - nbs play file:Nullsong targets:<server.online_players>

nullsteps:
    type: command
    name: nullsteps
    description: Grass break
    usage: /nullsteps
    permission: null.steps
    script:
    - define randomuser <server.online_players.random>
    - repeat 7:
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
        - announce "<element[<[player].name>].on_hover[<[player].name><n>Type: Player<n><[player].uuid>]> has made the advancement <green>[<element[Here I am.].on_hover[<green>Here I am.<n>Can you see me?]>]"
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
        - announce "<element[<[player].name>].on_hover[<[player].name><n>Type: Player<n><[player].uuid>]> has made the advancement <green>[<element[nullnullnull].on_hover[<green>nullnullnull<n>nullnullnull]>]"
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
        - announce "<element[<[player].name>].on_hover[<[player].name><n>Type: Player<n><[player].uuid>]> has made the advancement <green>[<element[Go Away].on_hover[<green>Go Away<n>This place is not for you.]>]"
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
    - playsound <server.online_players> sound:ambient_cave

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
    - repeat 35:
        - if <[randomplayer].location.block.above[<[I]>].material.name> == air:
            - define I:++
        - else:
            - stop
    - execute as_server "effect give <[randomplayer].name> minecraft:blindness 100 250 true"
    - teleport <[randomplayer]> <[randomplayer].location.above[<[I]>]>
    - execute as_server "effect give <[randomplayer].name> minecraft:slow_falling 20 2 true"
    - wait 1s
    - execute as_server "effect clear <[randomplayer].name> minecraft:blindness"

nullHost:
    type: command
    name: nullHost
    description: Null Host
    usage: /nullHost
    permission: null.host
    script:
    - announce "<white>Local game hosted on port [<green><&k>?????<white>]"
    - wait 20s
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.joined","with":["xXram2dieXx"],"color":"yellow"}'
    - wait 30s
    - announce "<&lt>xXram2dieXx<&gt> 48656c6c6f3f"
    - wait 15s
    - announce "<&lt>xXram2dieXx<&gt> 486f772064696420796f7520666f756e642074686973207365727665723f"
    - wait 20s
    - announce "<&lt>xXram2dieXx<&gt> 446f20796f752077616e7420746f20626520667269656e64733f"
    - wait 17s
    - announce "<&lt>xXram2dieXx<&gt> 4c656176652e"
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
    - define block <[randomplayer].location.forward[100].block>
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
    - playsound <[randomplayer]> sound:entity_enderman_death volume:100
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
    - if <[block].material.name> == air:
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
    - if <[block].material.name> != air:
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

nulldontyousee:
    type: command
    name: nulldontyousee
    description: DON'T YOU SEE? DON'T YOU SEE? DON'T YOU SEE?
    usage: /nulldontyousee
    permission: null.dontyousee
    script:
    - execute as_server "effect give @a minecraft:blindness 100 100 true"
    - title "title:DON'T YOU SEE?" "subtitle:DON'T YOU SEE?" fade_in:0s stay:0.5s fade_out:0s targets:<server.online_players>
    - actionbar "DON'T YOU SEE?" targets:<server.online_players>
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
    - execute as_server 'setblock <[block].x> <[block].y> <[block].z> minecraft:chest[facing=east,type=single,waterlogged=false]{Items:[{Count:10b,Slot:13b,id:"minecraft:diamond"}]}'

nullslowsong:
    type: command
    name: nullslowsong
    description: Slow song plays.
    usage: /nullslowsong
    permission: null.slowsong
    script:
    - execute as_server "stopsound @a music"
    - playsound <server.online_players> sound:music_game pitch:0.5

# ADMINS ONLY SECTION.

nulltimedevents:
    type: command
    name: nulltimedevents
    description: Toggle events that happen over time, on by deafult. (Admins only)
    usage: /nulltimedevents
    permission: null.timedevents
    script:
    - if <server.has_flag[notimedevents]>:
        - narrate "Timed events resumed."
        - flag server notimedevents:!
    - else:
        - narrate "Timed events paused."
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