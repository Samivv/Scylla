Scylla is a World of Warcraft addon that provides a user-friendly interface for managing quests, instance lockouts, and currencies.

Features
Displays a list of current quests
Shows instance lockouts
Provides a currency display
Allows for easy management through slash commands
Structure
The addon is structured into several components, each responsible for a specific part of the functionality:

FrameCreation.lua: Responsible for creating the base frame of the addon.
QuestList.lua: Handles the creation and management of the quest list.
Divider.lua: Used to create dividers between different sections of the addon.
InstanceSection.lua: Manages the instance lockouts section.
Footer.lua: Creates the footer of the addon.
Currencies.lua: Handles the currency display.
SlashCommand.lua: Implements the slash commands for managing the addon.
The main logic of the addon is contained in core.lua.

Usage
After installing and enabling the addon, you will see the frame open on login. You can also use the /scylla command to open the addon when closed.

License
This project is licensed under the MIT License.
