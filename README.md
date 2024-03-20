# Scylla

Scylla is a World of Warcraft(WOTLK) addon that displays information about your character in a clean and fast way to help plan out your adventures for the session.

## Features

- Displays daily quests
- Shows instance lockouts
- Provides a currency display
- Reputations display

## Preview
![image](https://github.com/Samivv/Scylla/assets/101732172/e3d36d63-5888-4e63-ba30-bb3a7459b50c)



## Installation

1. Download the latest version of the addon from the GitHub repository.
2. Extract the downloaded zip file.
3. Copy the extracted folder to your `World of Warcraft/_classic_/Interface/AddOns` directory.

## Usage

The addon automatically runs when you log into the game. It will display a frame with information about your daily quests, instance lockouts, and currencies.

## Components

The addon is composed of several Lua files, each responsible for a different part of the addon:

- Divider.lua: Creates dividers in the addon's frame.
- Reputations.lua: Handles displaying reputations
- Footer.lua: Handles the creation of the footer section.
- Currencies.lua: Manages the display of currencies.
- FrameCreation.lua: Responsible for creating the main frame of the addon.
- QuestList.lua: Handles the creation and management of the quest list.
- InstanceSection.lua: Manages the display of instance lockouts.
- SlashCommand.lua: Handles slash commands for the addon.
- core.lua: The main file that ties all the components together.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## License

This project is licensed under the MIT License.
