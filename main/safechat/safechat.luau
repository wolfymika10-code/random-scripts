--[[
  Self-contained, readable Chat Menu (refactor by ChatGPT)
  - Uses TextChatService general channel (:SendAsync) to send messages
  - Fetches JSON from GitHub unless safemode is enabled or HTTP is blocked
  - Drop this LocalScript under StarterGui (or anywhere LocalPlayer is available)
]]

local safemode = false -- set true to use the embedded JSON instead of HTTP

-- Services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    warn("ChatMenu: LocalPlayer not available (must run in a LocalScript).")
    return
end

local speeches = {
  utterance = {
    "Use the Chat menu to talk to me.",
    "I can only see menu chats.",
    {
      ["#text"] = "Hello",
      utterance = {
        {
          ["#text"] = "Hi",
          utterance = {
            "Hi there!",
            "Hi everyone",
          },
        },
        {
          ["#text"] = "Howdy",
          utterance = "Howdy partner!",
        },
        {
          ["#text"] = "Greetings",
          utterance = {
            "Greetings everyone",
            "Greetings Robloxians!",
            "Seasons greetings!",
          },
        },
        {
          ["#text"] = "Welcome",
          utterance = {
            "Welcome to my place",
            "Welcome to our base",
            "Welcome to my barbeque",
          },
        },
        "Hey there!",
        {
          ["#text"] = "What's up?",
          utterance = {
            "How are you doing?",
            "How's it going?",
            "What's new?",
          },
        },
        {
          ["#text"] = "Good day",
          utterance = {
            "Good morning",
            "Good afternoon",
            "Good evening",
            "Good night",
          },
        },
        {
          ["#text"] = "Silly",
          utterance = {
            "Waaaaaaaz up?!",
            "Hullo!",
            "Behold greatness, mortals!",
            "Pardon me, is this Sparta?",
            "THIS IS SPARTAAAA!",
          },
        },
        {
          ["#text"] = "Happy Holidays!",
          utterance = {
            "Happy New Year!",
            "Happy Valentine's Day!",
            "Beware the Ides of March!",
            "Happy St. Patrick's Day!",
            "Happy Easter!",
            "Happy Earth Day!",
            "Happy 4th of July!",
            "Happy Thanksgiving!",
            "Happy Halloween!",
            "Happy Hanukkah!",
            "Merry Christmas!",
            "Happy Halloween!",
            "Happy Earth Day!",
            "Happy May Day!",
            "Happy Towel Day!",
            "Happy ROBLOX Day!",
            "Happy LOL Day!",
          },
        },
      },
    },
    {
      ["#text"] = "Goodbye",
      utterance = {
        {
          ["#text"] = "Good Night",
          utterance = {
            "Sweet dreams",
            "Go to sleep!",
            "Lights out!",
            "Bedtime",
            "Going to bed now",
          },
        },
        {
          ["#text"] = "Later",
          utterance = {
            "See ya later",
            "Later gator!",
            "See you tomorrow",
          },
        },
        {
          ["#text"] = "Bye",
          utterance = "Hasta la bye bye!",
        },
        "I'll be right back",
        "I have to go",
        {
          ["#text"] = "Farewell",
          utterance = {
            "Take care",
            "Have a nice day",
            "Goodluck!",
            "Ta-ta for now!",
          },
        },
        {
          ["#text"] = "Peace",
          utterance = {
            "Peace out!",
            "Peace dudes!",
            "Rest in pieces!",
          },
        },
        {
          ["#text"] = "Silly",
          utterance = {
            "To the batcave!",
            "Over and out!",
            "Happy trails!",
            "I've got to book it!",
            "Tootles!",
            "Smell you later!",
            "GG!",
            "My house is on fire! gtg.",
          },
        },
      },
    },
    {
      ["#text"] = "Friend",
      utterance = {
        "Wanna be friends?",
        {
          ["#text"] = "Follow me",
          utterance = {
            "Come to my place!",
            "Come to my base!",
            "Follow me, team!",
            "Follow me",
          },
        },
        {
          ["#text"] = "Your place is cool",
          utterance = {
            "Your place is fun",
            "Your place is awesome",
            "Your place looks good",
            "This place is awesome!",
          },
        },
        {
          ["#text"] = "Thank you",
          utterance = {
            "Thanks for playing",
            "Thanks for visiting",
            "Thanks for everything",
            "No, thank you",
            "Thanx",
          },
        },
        {
          ["#text"] = "No problem",
          utterance = {
            "Don't worry",
            "That's ok",
            "np",
          },
        },
        {
          ["#text"] = "You are ...",
          utterance = {
            "You are great!",
            "You are good!",
            "You are cool!",
            "You are funny!",
            "You are silly!",
            "You are awesome!",
            "You are doing something I don't like, please stop",
          },
        },
        {
          ["#text"] = "I like ...",
          utterance = {
            "I like your name",
            "I like your shirt",
            "I like your place",
            "I like your style",
            "I like you",
            "I like items",
            "I like money",
          },
        },
        {
          ["#text"] = "Sorry",
          utterance = {
            "My bad!",
            "I'm sorry",
            "Whoops!",
            "Please forgive me.",
            "I forgive you.",
            "I didn't mean to do that.",
            "Sorry, I'll stop now.",
          },
        },
      },
    },
    {
      ["#text"] = "Questions",
      utterance = {
        {
          ["#text"] = "Who?",
          utterance = {
            "Who wants to be my friend?",
            "Who wants to be on my team?",
            "Who made this brilliant game?",
            "LOLWHO?",
          },
        },
        {
          ["#text"] = "What?",
          utterance = {
            "What is your favorite animal?",
            "What is your favorite game?",
            "What is your favorite movie?",
            "What is your favorite TV show?",
            "What is your favorite music?",
            "What are your hobbies?",
            "LOLWUT?",
          },
        },
        {
          ["#text"] = "When?",
          utterance = {
            "When are you online?",
            "When is the new version coming out?",
            "When can we play again?",
            "When will your place be done?",
          },
        },
        {
          ["#text"] = "Where?",
          utterance = {
            "Where do you want to go?",
            "Where are you going?",
            "Where am I?!",
            "Where did you go?",
          },
        },
        {
          ["#text"] = "How?",
          utterance = {
            "How are you today?",
            "How did you make this cool place?",
            "LOLHOW?",
          },
        },
        {
          ["#text"] = "Can I...",
          utterance = {
            "Can I have a tour?",
            "Can I be on your team?",
            "Can I be your friend?",
            "Can I try something?",
            "Can I have that please?",
            "Can I have that back please?",
            "Can I have borrow your hat?",
            "Can I have borrow your gear?",
          },
        },
      },
    },
    {
      ["#text"] = "Answers",
      utterance = {
        {
          ["#text"] = "You need help?",
          utterance = {
            "Check out the news section",
            "Check out the help section",
            "Read the wiki!",
            "All the answers are in the wiki!",
            "I will help you with this.",
          },
        },
        {
          ["#text"] = "Some people ...",
          utterance = {
            "Me",
            "Not me",
            "You",
            "All of us",
            "Everyone but you",
            "Builderman!",
            "Telamon!",
            "My team",
            "My group",
            "Mom",
            "Dad",
            "Sister",
            "Brother",
            "Cousin",
            "Grandparent",
            "Friend",
          },
        },
        {
          ["#text"] = "Time ...",
          utterance = {
            "In the morning",
            "In the afternoon",
            "At night",
            "Tomorrow",
            "This week",
            "This month",
            "Sometime",
            "Sometimes",
            "Whenever you want",
            "Never",
            "After this",
            "In 10 minutes",
            "In a couple hours",
            "In a couple days",
          },
        },
        {
          ["#text"] = "Animals",
          utterance = {
            {
              ["#text"] = "Cats",
              utterance = {
                "Lion",
                "Tiger",
                "Leopard",
                "Cheetah",
              },
            },
            {
              ["#text"] = "Dogs",
              utterance = {
                "Wolves",
                "Beagle",
                "Collie",
                "Dalmatian",
                "Poodle",
                "Spaniel",
                "Shepherd",
                "Terrier",
                "Retriever",
              },
            },
            {
              ["#text"] = "Horses",
              utterance = {
                "Ponies",
                "Stallions",
                "Pwnyz",
              },
            },
            {
              ["#text"] = "Reptiles",
              utterance = {
                "Dinosaurs",
                "Lizards",
                "Snakes",
                "Turtles!",
              },
            },
            "Hamster",
            "Monkey",
            "Bears",
            {
              ["#text"] = "Fish",
              utterance = {
                "Goldfish",
                "Sharks",
                "Sea Bass",
                "Halibut",
                "Tropical Fish",
              },
            },
            {
              ["#text"] = "Birds",
              utterance = {
                "Eagles",
                "Penguins",
                "Parakeets",
                "Owls",
                "Hawks",
                "Pidgeons",
              },
            },
            "Elephants",
            {
              ["#text"] = "Mythical Beasts",
              utterance = {
                "Dragons",
                "Unicorns",
                "Sea Serpents",
                "Sphinx",
                "Cyclops",
                "Minotaurs",
                "Goblins",
                "Honest Politicians",
                "Ghosts",
                "Scylla and Charybdis",
              },
            },
          },
        },
        {
          ["#text"] = "Games",
          utterance = {
            {
              ["#text"] = "Roblox",
              utterance = {
                "BrickBattle",
                "Community Building",
                "Roblox Minigames",
                "Contest Place",
              },
            },
            "Action",
            "Puzzle",
            "Strategy",
            "Racing",
            "RPG",
            "Obstacle Course",
            "Tycoon",
            {
              ["#text"] = "Board games",
              utterance = {
                "Chess",
                "Checkers",
                "Settlers of Catan",
                "Tigris and Euphrates",
                "El Grande",
                "Stratego",
                "Carcassonne",
              },
            },
          },
        },
        {
          ["#text"] = "Sports",
          utterance = {
            "Hockey",
            "Soccer",
            "Football",
            "Baseball",
            "Basketball",
            "Volleyball",
            "Tennis",
            "Sports team practice",
            {
              ["#text"] = "Watersports",
              utterance = {
                "Surfing",
                "Swimming",
                "Water Polo",
              },
            },
            {
              ["#text"] = "Winter sports",
              utterance = {
                "Skiing",
                "Snowboarding",
                "Sledding",
                "Skating",
              },
            },
            {
              ["#text"] = "Adventure",
              utterance = {
                "Rock climbing",
                "Hiking",
                "Fishing",
                "Horseback riding",
              },
            },
            {
              ["#text"] = "Wacky",
              utterance = {
                "Foosball",
                "Calvinball",
                "Croquet",
                "Cricket",
                "Dodgeball",
                "Squash",
                "Trampoline",
              },
            },
          },
        },
        {
          ["#text"] = "Movies/TV",
          utterance = {
            "Science Fiction",
            {
              ["#text"] = "Animated",
              utterance = "Anime",
            },
            "Comedy",
            "Romantic",
            "Action",
            "Fantasy",
          },
        },
        {
          ["#text"] = "Music",
          utterance = {
            "Country",
            "Jazz",
            "Rap",
            "Hip-hop",
            "Techno",
            "Classical",
            "Pop",
            "Rock",
          },
        },
        {
          ["#text"] = "Hobbies",
          utterance = {
            {
              ["#text"] = "Computers",
              utterance = {
                "Building computers",
                "Videogames",
                "Coding",
                "Hacking",
              },
            },
            {
              ["#text"] = "The Internet",
              utterance = {
                "lol. teh internets!",
                "Watching vids",
              },
            },
            "Dance",
            "Gymnastics",
            {
              ["#text"] = "Martial Arts",
              utterance = {
                "Karate",
                "Judo",
                "Taikwon Do",
                "Wushu",
                "Street fighting",
              },
            },
            "Listening to music",
            {
              ["#text"] = "Music lessons",
              utterance = {
                "Playing in my band",
                "Playing piano",
                "Playing guitar",
                "Playing violin",
                "Playing drums",
                "Playing a weird instrument",
              },
            },
            "Arts and crafts",
          },
        },
        {
          ["#text"] = "Location",
          utterance = {
            {
              ["#text"] = "USA",
              utterance = {
                {
                  ["#text"] = "West",
                  utterance = {
                    "Alaska",
                    "Arizona",
                    "California",
                    "Colorado",
                    "Hawaii",
                    "Idaho",
                    "Montana",
                    "Nevada",
                    "New Mexico",
                    "Oregon",
                    "Utah",
                    "Washington",
                    "Wyoming",
                  },
                },
                {
                  ["#text"] = "Midwest",
                  utterance = {
                    "Illinois",
                    "Indiana",
                    "Iowa",
                    "Kansas",
                    "Michigan",
                    "Minnesota",
                    "Missouri",
                    "Nebraska",
                    "North Dakota",
                    "Ohio",
                    "South Dakota",
                    "Wisconsin",
                  },
                },
                {
                  ["#text"] = "Northeast",
                  utterance = {
                    "Connecticut",
                    "Delaware",
                    "Maine",
                    "Maryland",
                    "Massachusetts",
                    "New Hampshire",
                    "New Jersey",
                    "New York",
                    "Pennsylvania",
                    "Rhode Island",
                    "Vermont",
                  },
                },
                {
                  ["#text"] = "South",
                  utterance = {
                    "Alabama",
                    "Arkansas",
                    "Florida",
                    "Georgia",
                    "Kentucky",
                    "Louisiana",
                    "Mississippi",
                    "North Carolina",
                    "Oklahoma",
                    "South Carolina",
                    "Tennessee",
                    "Texas",
                    "Virginia",
                    "West Virginia",
                  },
                },
              },
            },
            {
              ["#text"] = "Canada",
              utterance = {
                "Alberta",
                "British Columbia",
                "Manitoba",
                "New Brunswick",
                "Newfoundland",
                "Northwest Territories",
                "Nova Scotia",
                "Nunavut",
                "Ontario",
                "Prince Edward Island",
                "Quebec",
                "Saskatchewan",
                "Yukon",
              },
            },
            "Mexico",
            "Central America",
            {
              ["#text"] = "Europe",
              utterance = {
                {
                  ["#text"] = "Great Britain",
                  utterance = {
                    "England",
                    "Scotland",
                    "Wales",
                    "Northern Ireland",
                  },
                },
                "France",
                "Germany",
                "Spain",
                "Italy",
                "Poland",
                "Switzerland",
                "Greece",
                "Romania",
                "Netherlands",
              },
            },
            {
              ["#text"] = "Asia",
              utterance = {
                "China",
                "India",
                "Japan",
                "Korea",
                "Russia",
                "Vietnam",
              },
            },
            {
              ["#text"] = "South America",
              utterance = {
                "Argentina",
                "Brazil",
              },
            },
            {
              ["#text"] = "Africa",
              utterance = {
                "Eygpt",
                "Swaziland",
              },
            },
            "Australia",
            "Middle East",
            "Antarctica",
            "New Zealand",
          },
        },
        {
          ["#text"] = "Age",
          utterance = {
            "Rugrat",
            "Kid",
            "Tween",
            "Teen",
            "Twenties",
            "Old",
            "Ancient",
            "Mesozoic",
            "I don't want to say my age. Don't ask.",
          },
        },
        {
          ["#text"] = "Mood",
          utterance = {
            "Good",
            "Great!",
            "Not bad",
            "Sad",
            "Hyper",
            "Chill",
            "Happy",
            "Kind of mad",
          },
        },
        "Boy",
        "Girl",
        "I don't want to say boy or girl. Don't ask.",
      },
    },
    {
      ["#text"] = "Game",
      utterance = {
        "Let's build",
        "Let's battle",
        "Nice one!",
        "So far so good!",
        "Lucky shot!",
        "Oh man!",
        "I challenge you to a fight!",
        "Help me with this",
        "Let's go to your game",
        "Can you show me how do to that?",
        "Backflip!",
        "Frontflip!",
        "Dance!",
        "I'm on your side!",
        {
          ["#text"] = "Game Commands",
          utterance = {
            "regen",
            "reset",
            "go",
            "fix",
            "respawn",
          },
        },
      },
    },
    {
      ["#text"] = "Silly",
      utterance = {
        "Muahahahaha!",
        "all your base are belong to me!",
        "GET OFF MAH LAWN",
        "TEH EPIK DUCK IS COMING!!!",
        "ROFL",
        {
          ["#text"] = "1337",
          utterance = {
            "i r teh pwnz0r!",
            "w00t!",
            "z0mg h4x!",
            "ub3rR0xXorzage!",
          },
        },
      },
    },
    {
      ["#text"] = "Yes",
      utterance = {
        "Absolutely!",
        "Rock on!",
        "Totally!",
        "Juice!",
        "Yay!",
        "Yesh",
      },
    },
    {
      ["#text"] = "No",
      utterance = {
        "Ummm. No.",
        "...",
        "Stop!",
        "Go away!",
        "Don't do that",
        "Stop breaking the rules",
        "I don't want to",
      },
    },
    {
      ["#text"] = "Ok",
      utterance = {
        "Well... ok",
        "Sure",
      },
    },
    {
      ["#text"] = "Uncertain",
      utterance = {
        "Maybe",
        "I don't know",
        "idk",
        "I can't decide",
        "Hmm...",
      },
    },
    {
      ["#text"] = ":-)",
      utterance = {
        ":-(",
        ":D",
        ":-O",
        "lol",
        "=D",
        "D=",
        "XD",
        ";D",
        ";)",
        "O_O",
        "=)",
        "@_@",
        ">_<",
        "T_T",
        "^_^",
        "<(0_0<) <(0_0)> (>0_0)> KIRBY DANCE",
        ")';",
        ":3",
      },
    },
    {
      ["#text"] = "Ratings",
      utterance = {
        "Rate it!",
        "I give it a 1 out of 10",
        "I give it a 2 out of 10",
        "I give it a 3 out of 10",
        "I give it a 4 out of 10",
        "I give it a 5 out of 10",
        "I give it a 6 out of 10",
        "I give it a 7 out of 10",
        "I give it a 8 out of 10",
        "I give it a 9 out of 10",
        "I give it a 10 out of 10!",
      },
    },
  },
}

-- Helper: get general chat channel (tries RBXGeneral then General)
local function getGeneralChannel()
    local channels = TextChatService.TextChannels
    return channels.RBXGeneral or channels.General or channels["RBXGeneral"]
end

-- Send chat via TextChatService general channel (safe call)
local function sendChat(message)
    local channel = getGeneralChannel()
    if not channel then
        warn("ChatMenu: general text channel not found; message not sent:", message)
        return
    end
    local ok, err = pcall(function()
        channel:SendAsync(tostring(message))
    end)
    if not ok then
        warn("ChatMenu: failed to SendAsync:", err)
    end
end

-- Create ScreenGui and UI root
local playerGui = LocalPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SafeChatMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Hide on touch devices
if UserInputService.TouchEnabled then
    screenGui.Enabled = false
    Debris:AddItem(screenGui, 5)
    return
end

-- Main button images
local DEFAULT_IMAGE = "rbxassetid://4578446196"
local HOVER_IMAGE = "rbxassetid://4578446576"
local PRESSED_IMAGE = "rbxassetid://4578446426"
local CLICK_SOUND_ID = "rbxassetid://12222170"

-- Main button
local MainButton = Instance.new("ImageButton")
MainButton.Name = "UnnamedGuiItem"
MainButton.Size = UDim2.new(0, 32, 0, 23)
MainButton.Position = UDim2.new(0, 15, 0, 130)
MainButton.BackgroundTransparency = 1
MainButton.Image = DEFAULT_IMAGE
MainButton.Parent = screenGui
MainButton.ZIndex = 100

-- Menu frame (holds all generated buttons)
local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuFrame"
MenuFrame.BackgroundTransparency = 1
MenuFrame.ZIndex = 99
MenuFrame.Position = UDim2.new(1.14, 0, -6.25, 0)
MenuFrame.Size = UDim2.new(0, 135, 0, 1000)
MenuFrame.Parent = screenGui

-- Click sound (template)
local ClickSoundTemplate = Instance.new("Sound")
ClickSoundTemplate.SoundId = CLICK_SOUND_ID
ClickSoundTemplate.PlayOnRemove = true

local Busy = false

-- Utility: clear menu columns at or beyond a given column X offset
local function clearColumnsFromX(xOffset)
    for _, child in ipairs(MainButton:GetChildren()) do
        if child:IsA("GuiObject") and child.Position and child.Position.X then
            local ox = child.Position.X.Offset
            if ox >= xOffset then
                child:Destroy()
            end
        end
    end
end

-- Recursive menu builder
local function createMenuButtons(depth, offsetY, options)
    offsetY = offsetY or 29
    local baseX = depth * 145

    -- remove any columns already at or beyond this target column (prevents duplicates)
    clearColumnsFromX(baseX)

    for i, option in ipairs(options) do
        local text = (type(option) == "table" and option["#text"]) or option
        local utterances = (type(option) == "table" and option.utterance) or nil

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 141, 0, 25)
        btn.Position = UDim2.new(0, baseX, 0, offsetY + (i - 1) * 29)
        btn.BackgroundColor3 = Color3.fromRGB(253, 251, 255)
        btn.AutoButtonColor = false
        btn.TextSize = 12
        btn.Text = tostring(text)
        btn.ZIndex = 99
        btn.Parent = MainButton

        -- Hover visuals and spawn submenu
        btn.MouseEnter:Connect(function()
            -- clear deeper columns so hover doesn't stack duplicates
            local nextColumnX = (depth + 1) * 145
            clearColumnsFromX(nextColumnX)

            -- visually reset siblings in same column
            for _, sibling in ipairs(MenuFrame:GetChildren()) do
                if sibling:IsA("TextButton") and sibling.Position.X.Offset == baseX then
                    sibling.BackgroundColor3 = Color3.fromRGB(253, 251, 255)
                end
            end

            btn.BackgroundColor3 = Color3.fromRGB(177, 176, 179)

            if utterances and type(utterances) ~= "string" then
                -- compute a vertical offset that attempts to center the submenu
                local centerOffset = btn.Position.Y.Offset - math.floor(#utterances / 2) * 29
                createMenuButtons(depth + 1, centerOffset, utterances)
            end
        end)

        -- mouse leave: reset color (optional)
        btn.MouseLeave:Connect(function()
            -- only reset if no deeper hover selected
            btn.BackgroundColor3 = Color3.fromRGB(253, 251, 255)
        end)

        -- click: send chat and close menu
        btn.MouseButton1Click:Connect(function()
            if Busy then return end
            Busy = true
            local sound = ClickSoundTemplate:Clone()
            sound.Parent = workspace
            sound:Destroy() -- plays then removes
            -- Use TextChatService to send
            sendChat(btn.Text)
            MenuFrame:ClearAllChildren()
            MainButton.Image = DEFAULT_IMAGE
            Busy = false
        end)
    end
end

local function clearButtons()
	for _, child in ipairs(MainButton:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy() -- or child.Visible = false
		end
	end
end

local function showUtterance(utteranceName)
	clearButtons()

	local data = SafeChatData[utteranceName]

	for _, option in ipairs(data.Options) do
		local newButton = template:Clone()
		newButton.Text = option.Text
		newButton.Parent = container
		
		newButton.MouseButton1Click:Connect(function()
            clearButtons()
			task.wait(0.1)
			showUtterance(option.Next)
		end)
	end
end

-- Close menu when clicking anywhere (global)
LocalPlayer:GetMouse().Button1Down:Connect(function()
    task.wait(0.1) -- slight delay to allow button click to register first
    clearButtons()
end)

-- Hover the main button (visual)
MainButton.MouseEnter:Connect(function()
    MainButton.Image = HOVER_IMAGE
end)
MainButton.MouseLeave:Connect(function()
    MainButton.Image = DEFAULT_IMAGE
end)

-- Main button click: toggle menu and fetch remote JSON if allowed
MainButton.MouseButton1Click:Connect(function()
    if #MenuFrame:GetChildren() > 0 then
        MenuFrame:ClearAllChildren()
        MainButton.Image = DEFAULT_IMAGE
        return
    end

    MainButton.Image = PRESSED_IMAGE

    -- Attempt to load remote JSON unless safemode enabled
    if not safemode then
        local ok, result = pcall(function()
            local raw = HttpService:GetAsync("https://raw.githubusercontent.com/wolfymika10-code/random-scripts/main/main/safechat/safechat.json")
            return HttpService:JSONDecode(raw)
        end)

        if ok and type(result) == "table" and result.utterance then
            createMenuButtons(0, 29, result.utterance)
            return
        else
            warn("ChatMenu: failed to fetch remote JSON. Enabling safemode fallback. Error:", result)
            -- fall through to safemode below
        end
    end

    -- Safemode fallback using embedded JSON
    if speeches and speeches.utterance then
        createMenuButtons(0, 29, speeches.utterance)
    else
        warn("ChatMenu: no fallback JSON available.")
    end
end)
