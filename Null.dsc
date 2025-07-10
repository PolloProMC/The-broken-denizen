nullexist:
    type: world
    debug: true
    events:
        on delta time secondly:
        - if <server.has_flag[null]>:
            - if !<server.has_flag[nullwatch]>:
                - teleport <server.flag[null]> <server.online_players.random.location.above[100]>
                - adjust <server.flag[null]> visible:false
                - adjust <server.flag[null]> invulnerable:true
        - foreach <server.online_players_flagged[whereiwas]> as:wherei:
            - if !<[wherei].has_flag[iamhere]>:
                - teleport <[wherei]> <[wherei].flag[whereiwas]>
                - wait 1t
                - flag <[wherei]> whereiwas:!
                - execute as_server "gamemode survival <[wherei].name>"
        - if <server.has_flag[blackthing]>:
            - foreach <server.flag[blackthing]> as:thething:
                - execute as_server "execute as <[thething].uuid> at @s run tp @s ^ ^ ^0.25 facing entity @a[limit=1,sort=nearest] feet"

        on entity transforms:
        - if <server.flag[null]> == <context.entity>:
            - determine cancelled

        on delta time minutely:
        - execute as_server "disgplayer <server.flag[null].uuid> Player yyy88 setName Null setDisplayedInTab true"

        on player walks:
        - if <server.has_flag[nullwatch]>:
            - execute as_server "execute as <server.flag[null].uuid> at @s run tp @s ~ ~ ~ facing entity @a[limit=1,sort=nearest] feet"
        - if <server.has_flag[nullisangry]>:
            - foreach <server.online_players> as:player:
                - if <[player].location.distance[<server.flag[nullisangry]>]> <= 7:
                    - execute as_server nullsummoned
                    - wait 1t
                    - flag server nullisangry:!
        on player changes sign:
        - if <player.has_flag[iamhere]>:
            - determine cancelled

        on player right clicks oak_door:
        - if <player.has_flag[iamhere]>:
            - determine cancelled

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
    - execute as_op "tp <player.name> ~ ~ ~ 0 0"
    - execute as_op "summon villager ~ ~ ~ {NoAI:1b}"
    - wait 1t
    - flag server null:<player.target>
    - execute as_server "disgplayer <server.flag[null].uuid> Player yyy88 setName Null setDisplayedInTab true"
    - teleport <server.flag[null]> <player.location.up[100]>
    - adjust <server.flag[null]> visible:false
    - if <context.args.get[1]> == silent:
        - stop
    - execute as_server 'tellraw @a {"translate":"multiplayer.player.joined","with":["Null"],"color":"yellow"}'

nullleave_command:
    type: command
    name: nullleave
    description: Null left the game
    usage: /nullleave
    permission: null.leave
    script:
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
    - nbs play file:randomsongflute targets:<server.online_players>
    - wait 22s
    - nbs play file:randomsongflute targets:<server.online_players>

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

nullstatue:
    type: command
    name: nullstatue
    description: 0 0 0 - - - - - -
    usage: /nullstatue
    permission: null.statue
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
    - flag server nullisangry:<[chest]>
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
    - adjust <server.flag[null]> visible:false
    - teleport <server.flag[null]> <server.flag[nullisangry].up[100]>
    - spawn lightning <server.flag[nullisangry].up[1]>
    - wait 1t
    - flag server nullisangry:!
    - flag server nullwatch:! expire:1m

nullback:
    type: command
    name: nullback
    description: =)
    usage: /nullback
    permission: null.back
    script:
    - foreach <server.online_players> as:player:
        - flag <[player]> sentback:<[player].location>
    - wait 7s
    - foreach <server.online_players> as:player:
        - teleport <[player]> <[player].flag[sentback]>
        - actionbar =) targets:<server.online_players>
        - playsound <server.online_players> sound:ambient_cave

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
    - wait 5s
    - announce "<yellow>OpenGL Error<white>: 1282 (Invalid operation)"
    - wait 1s
    - announce "<yellow>OpenGL Error<white>: 1282 (Invalid operation)"
    - wait 1s
    - announce "<yellow>OpenGL Error<white>: 1282 (Invalid operation)"
    - wait 3s
    - announce "<yellow>OpenGL Error<white>: 0 (Here I am.)"
    - playsound <server.online_players> sound:ambient_cave

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
    - execute as_server "effect give <[randomplayer].name> minecraft:blindness 2 250 true"
    - execute as_server "effect give <[randomplayer].name> minecraft:slow_falling 20 2 true"
    - teleport <[randomplayer]> <[randomplayer].location.above[<[I]>]>

nullHost:
    type: command
    name: nullHost
    description: Null Host
    usage: /nullHost
    permission: null.host
    script:
    - announce "<white>Local game hosted on port [<green><&k>25567<white>]"
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
    - spawn armor_stand <[randomplayer].location>
    - execute as_server "execute at <[randomplayer].name> run teleport <[randomplayer].name> ~ ~ ~ 0 0"
    - wait 1t
    - define target <[randomplayer].target>
    - execute as_server "execute at <[randomplayer].name> run spreadplayers ~ ~ 1 30 false <[target].uuid>"
    - wait 1t
    - flag server blackthing:->:<[target]>
    - adjust <[target]> invulnerable:true
    - adjust <[target]> visible:false
    - adjust <[target]> gravity:false
    - flag <[target]> itsame

nullnoblackthing:
    type: command
    name: nullnoblackthing
    description: For admins only
    usage: /nullnoblackthing
    permission: null.nullnoblackthing
    script:
    - define theblack <player.location.find_entities[armor_stand].within[10].get[1]>
    - if <[theblack].has_flag[itsame]>:
        - flag <[theblack]> itsame:!
        - flag server blackthing:<-:<[theblack]>
        - wait 1t
        - kill <[theblack]>