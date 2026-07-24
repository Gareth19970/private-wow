# 🎮 Private WoW - WotLK 3.3.5a Private Server with AI Bots

A complete guide to running your own World of Warcraft: Wrath of the Lich King (3.3.5a) private server with AI companion bots. Play solo or with friends through all of WoW's content with AI teammates.

![WoW Version](https://img.shields.io/badge/WoW-3.3.5a-blue)
![AzerothCore](https://img.shields.io/badge/AzerothCore-WotLK-green)
![Playerbots](https://img.shields.io/badge/Module-Playerbots-orange)

## 📋 Table of Contents

- [What You'll Get](#what-youll-get)
- [Requirements](#requirements)
- [Quick Start (5 Minutes)](#quick-start-5-minutes)
- [Detailed Setup Guide](#detailed-setup-guide)
- [Configuring Your Server](#configuring-your-server)
- [Managing AI Bots](#managing-ai-bots)
- [MultiBot Addon (Recommended)](#multibot-addon-recommended)
- [Playing Through Expansions](#playing-through-expansions)
- [Common Commands](#common-commands)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)

---

## What You'll Get

✅ **Your own WoW server** running on your PC  
✅ **AI companion bots** that fight, heal, and follow you  
✅ **500+ random bots** populating the world  
✅ **Dungeon Finder** support with bot teammates  
✅ **Battlegrounds** with bot players  
✅ **Full progression** - Vanilla → TBC → WotLK  
✅ **MultiBot addon** - GUI to manage bots easily  

---

## Requirements

### Software Needed

| Software | Version | Download |
|----------|---------|----------|
| **WoW Client** | 3.3.5a (WotLK) | [Google "WoW 3.3.5a client"] |
| **MySQL** | 8.0+ | [Download MySQL](https://dev.mysql.com/downloads/mysql/) |
| **Visual Studio** | 2022+ | [Download VS](https://visualstudio.microsoft.com/) (Community is free) |
| **Git** | Latest | [Download Git](https://git-scm.com/) |
| **CMake** | 3.20+ | [Download CMake](https://cmake.org/download/) |
| **Boost** | 1.74+ | [Download Boost](https://www.boost.org/) |
| **OpenSSL** | 1.1.1+ | [Download OpenSSL](https://slproweb.com/products/Win32OpenSSL.html) |

### Hardware

- **Minimum:** 4GB RAM, 2 CPU cores
- **Recommended:** 8GB RAM, 4 CPU cores
- **Storage:** ~20GB for server + client

---

## Quick Start (5 Minutes)

> **Already have the server files compiled?** Just do steps 3-5!

### Step 1: Install Prerequisites

```bash
# Install MySQL, add to PATH
# Install Visual Studio 2022 with C++ workload
# Install Git, CMake, Boost, OpenSSL
```

### Step 2: Get the Files

```bash
git clone https://github.com/YOUR_USERNAME/private-wow.git
cd private-wow
```

### Step 3: Setup Databases

```bash
# Open Command Prompt as Administrator
cd scripts
setup.bat
```

Enter your MySQL password when prompted. This creates all required databases.

### Step 4: Configure

Edit these files with your settings:

**`configs/authserver.conf`**
```
LoginDatabaseInfo = "127.0.0.1;3306;root;YOUR_PASSWORD;acore_auth"
```

**`configs/worldserver.conf`**
```
LoginDatabaseInfo     = "127.0.0.1;3306;root;YOUR_PASSWORD;acore_auth"
WorldDatabaseInfo     = "127.0.0.1;3306;root;YOUR_PASSWORD;acore_world"
CharacterDatabaseInfo = "127.0.0.1;3306;root;YOUR_PASSWORD;acore_characters"
DataDir = "C:/Program Files (x86)/World of Warcraft"
```

### Step 5: Launch

```bash
scripts\start.bat
```

### Step 6: Connect

1. Open WoW 3.3.5a client
2. Set realmlist to `127.0.0.1`
3. Login: `ADMIN` / `admin`
4. Create a character and enter the world!

---

## Detailed Setup Guide

### 1. Building from Source (Skip if you have pre-built files)

```bash
# Clone AzerothCore with Playerbots
git clone https://github.com/liyunfan1223/azerothcore-wotlk.git
cd azerothcore-wotlk
git checkout Playerbot

# Add Playerbots module
cd modules
git clone https://github.com/mod-playerbots/mod-playerbots.git mod-playerbots
cd ..

# Build with CMake
mkdir build
cd build
cmake .. -G "Visual Studio 17 2022" -A x64 -DTOOLS=1 -DWITH_WARNINGS=0

# Open in Visual Studio and build RelWithDebInfo configuration
```

### 2. Extract Client Data

After building, extract DBC/Maps/VMaps from your WoW client:

```bash
# Run these from the build output directory
map_extractor.exe "C:\Path\To\WoW\Data\"
vmap4_extractor.exe "C:\Path\To\WoW\Data\"
vmap4_assembler.exe vmaps vmaps_output
mmaps_generator.exe
```

Copy extracted files to your WoW `Data/` folder.

### 3. Install MultiBot Addon

```bash
cd "C:\Path\To\WoW\Interface\AddOns"
git clone https://github.com/Macx-Lio/MultiBot.git MultiBot
```

---

## Configuring Your Server

### Key Settings in `worldserver.conf`

```ini
# Expansion: 0=Vanilla, 1=TBC, 2=WotLK
Expansion = 0

# Level cap (start with 60 for vanilla progression)
MaxPlayerLevel = 60

# XP rates (increase for faster leveling)
Rate.XP.Kill = 1
Rate.XP.Quest = 1

# Movement speed (1=normal, 5=5x speed)
Rate.MoveSpeed.Player = 1

# Start level for new characters
StartPlayerLevel = 1
```

### Key Settings in `playerbots.conf`

```ini
# Enable bots
AiPlayerbot.Enabled = 1

# How many random bots
AiPlayerbot.RandomBotAccountCount = 500

# Auto-login bots
AiPlayerbot.RandomBotAutologin = 1

# Bot level range
AiPlayerbot.RandomBotMinLevel = 1
AiPlayerbot.RandomBotMaxLevel = 60

# Allow LFG queuing
AiPlayerbot.RandomBotJoinLfg = 1
```

---

## Managing AI Bots

### Adding Bots

```
.playerbots bot add NAME          - Add specific bot
.playerbots bot addclass tank     - Add a tank bot
.playerbots bot addclass healer   - Add a healer bot
.playerbots bot addclass dps      - Add a DPS bot
```

### Bot Commands

```
.bot follow                       - Bots follow you
.bot stay                         - Bots stay in place
.bot attack                       - Bots attack your target
.bot passive                      - Bots don't attack
.bot formation line               - Line formation
.bot formation circle             - Circle formation
```

### Removing Bots

```
.playerbots bot remove NAME       - Remove specific bot
.playerbots bot reset             - Remove all your bots
```

---

## MultiBot Addon (Recommended)

The MultiBot addon gives you a graphical interface to manage bots.

### Install

```bash
cd "WoW\Interface\AddOns"
git clone https://github.com/Macx-Lio/MultiBot.git MultiBot
```

### Usage

1. Type `/multibot` or `/mb` in chat
2. Click the blue icon to open the interface
3. **Left-click** character buttons to add them to your party
4. Use the toolbar for:
   - Attack/Defend commands
   - Follow/Stay toggle
   - Formation settings
   - Inventory management
   - Talent/spell management

### Features

- **Class filtering** - Find tanks, healers, DPS quickly
- **Auto-formation** - Set bot positions
- **Inventory management** - Equip/sell items on bots
- **Talent management** - Configure bot builds
- **Beastmaster support** - Control hunter pets

---

## Playing Through Expansions

### Phase 1: Vanilla (Level 1-60)

```ini
# worldserver.conf
Expansion = 0
MaxPlayerLevel = 60
```

Content: Deadmines → Molten Core → Blackwing Lair → Ahn'Qiraj → Naxxramas

### Phase 2: The Burning Crusade (Level 60-70)

```ini
# worldserver.conf
Expansion = 1
MaxPlayerLevel = 70
```

Content: Hellfire Citadel → Coilfang → Tempest Keep → Black Temple

### Phase 3: Wrath of the Lich King (Level 70-80)

```ini
# worldserver.conf
Expansion = 2
MaxPlayerLevel = 80
```

Content: Utgarde → Nexus → Ulduar → Trial of the Crusader → Icecrown Citadel

**Restart the worldserver after changing expansion settings.**

---

## Common Commands

### GM Commands

```
.modify level 60                  - Set your level
.modify money 1000000            - Add gold (copper)
.additem 6948                     - Add Hearthstone
.mod speed 1                      - Set movement speed
.gm on                            - Enable GM mode
.gm off                           - Disable GM mode
.account set gmlevel 3            - Set GM level
```

### Bot Commands

```
.playerbots bot add NAME          - Add bot to party
.playerbots bot remove NAME       - Remove bot from party
.playerbots bot list              - List available bots
.playerbots bot init auto         - Auto-initialize bots
```

### Useful Commands

```
.reload config                    - Reload config files
.server shutdown 5                - Shutdown in 5 minutes
.server restart                   - Restart server
```

---

## Troubleshooting

### "Access Denied" when connecting

- Check MySQL is running
- Verify password in config files
- Ensure port 3306 is not blocked

### "Could not find database driver"

- Install MySQL Connector/C
- Add MySQL to PATH environment variable

### Bots not appearing

- Check `AiPlayerbot.RandomBotAutologin = 1`
- Wait 2-3 minutes after server start
- Use `.playerbots bot maintenance` to refresh

### Slow performance

- Reduce `AiPlayerbot.RandomBotAccountCount` (try 200)
- Lower `Rate.MoveSpeed.Player` to 1
- Close other applications

### WoW client won't connect

- Set realmlist to `127.0.0.1` in `realmlist.wtf`
- Ensure WoW version is 3.3.5a (build 12340)
- Check firewall isn't blocking ports 3724/8085

---

## FAQ

**Q: Can I play with friends?**  
A: Yes! They just need to point their realmlist to your IP address.

**Q: Do bots level up?**  
A: Yes, random bots level up automatically. You can set max level in config.

**Q: Can I do dungeons with bots?**  
A: Yes! Add a tank and healer bot, then use Dungeon Finder.

**Q: How do I change XP rates?**  
A: Edit `Rate.XP.Kill` and `Rate.XP.Quest` in `worldserver.conf`.

**Q: Bots are too strong/too weak?**  
A: Adjust `AiPlayerbot.RandomBotMaxLevel` and equipment settings.

**Q: Can I reset bot levels?**  
A: Delete bot characters in MySQL or let them regenerate on next restart.

---

## Credits

- [AzerothCore](https://github.com/azerothcore/azerothcore-wotlk) - Server emulator
- [mod-playerbots](https://github.com/mod-playerbots/mod-playerbots) - AI bot module
- [MultiBot](https://github.com/Macx-Lio/MultiBot) - Bot management addon

---

## License

This project is for educational purposes. World of Warcraft is a trademark of Blizzard Entertainment.
