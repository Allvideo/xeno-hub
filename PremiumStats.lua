return {
    Prefix = "!",
    Commands = {
        Ban = {
            Required = {"Player"},
            Optional = {},
            Description = "Fake bans Player"
        },
        Bang = {
            Required = {"Player"},
            Optional = {},
            Description = "Makes you bang Player"
        },
        Bring = {
            Required = {"Player"},
            Optional = {},
            Description = "Teleports Player to you"
        },
        Crash = {
            Required = {"Player"},
            Optional = {},
            Description = "Crashes Player's game"
        },
        Fling = {
            Required = {"Player"},
            Optional = {},
            Description = "Flings Player"
        },
        Freeze = {
            Required = {"Player"},
            Optional = {},
            Description = "Freezes Player"
        },
        Kick = {
            Required = {"Player"},
            Optional = {"Message"},
            Description = "Kicks Player with Message"
        },
        Kill = {
            Required = {"Player"},
            Optional = {},
            Description = "Kills Player"
        },
        Say = {
            Required = {"Player","Message"},
            Optional = {},
            Description = "Makes Player say Message"
        },
        Shutdown = {
            Required = {"Player"},
            Optional = {},
            Description = "Closes Player's game"
        },
        Unbang = {
            Required = {"Player"},
            Optional = {},
            Description = "Stops banging Player"
        },
        Unfreeze = {
            Required = {"Player"},
            Optional = {},
            Description = "Unfreezes Player"
        }
    },
    Args = {
        Player = {
            ["."] = "Everyone",
            All = "Everyone",
            Me = "You",
            Others = "Everyone except you",
            DisplayName = "User's display name (auto completes)",
            Name = "User's name (auto completes)"
        },
        Message = {"..."}
    }
}
