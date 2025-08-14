# The Broken Denizen.

This is just a little denizen script I decided to make. It's the broken script mod, but on plugin.

Sorry for the messy code, credits to the original creator of _The Broken Script_

**Requirements:**
- Libs disguises
- The resource pack provided
- Denizen script
- Minecraft version **1.21.3 or lower.**

---

# What can this plugin do?

Plugin can:

- Disable chat messages  
- Grief bases  
- **Crash** Minecraft clients
- Make you unable to exit the server

---

# Installation guide

1. Install Denizen script and drop it into your plugins folder.
2. Set up script folder, If missing, create: plugins/Denizen/scripts/
3. Add Null.dsc Put Null.dsc inside the scripts folder. Optionally, edit nullcrash to insert a crash of your liking.
4. Install Lib's Disguises and add it to the plugins folder
5. Place the provided Generated folder into your server’s "world" directory.
6. Start the server.
7. Have fun! (And get scared maybe.)

---

# About crashes.

This plugin has events that crash the Minecraft client, but **no crash method is provided**.  
You must research and supply one yourself (e.g. particle crash).

To insert a crash, go to the bottom of the script, above the ignore section, and look for the "nullcrash" command.
You can insert a crash of your choise there.

If no crash is chosen, the plugin will just kick the player.
