return {
    Prefix = "!",
    Commands = {
        Ban = {
            Required = {"Player"},
            Optional = {}
        },
        Bang = {
            Required = {"Player"},
            Optional = {}
        },
        Bring = {
            Required = {"Player"},
            Optional = {}
        },
        Crash = {
            Required = {"Player"},
            Optional = {}
        },
        Fling = {
            Required = {"Player"},
            Optional = {}
        },
        Freeze = {
            Required = {"Player"},
            Optional = {}
        },
        Kick = {
            Required = {"Player"},
            Optional = {"Message"}
        },
        Kill = {
            Required = {"Player"},
            Optional = {}
        },
        Say = {
            Required = {"Player","Message"},
            Optional = {}
        },
        Shutdown = {
            Required = {"Player"},
            Optional = {}
        },
        Unbang = {
            Required = {"Player"},
            Optional = {}
        },
        Unfreeze = {
            Required = {"Player"},
            Optional = {}
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
        Message = {}
    }
}
