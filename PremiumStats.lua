return {
    Prefix = "!",
    Commands = {
        {
            Name = "Ban",
            Required = {"Player"},
            Optional = {}
        },
        {
            Name = "Bang",
            Required = {"Player"},
            Optional = {}
        },
        {
            Name = "Bring",
            Required = {"Player"},
            Optional = {}
        },
        {
            Name = "Crash",
            Required = {"Player"},
            Optional = {}
        },
        {
            Name = "Fling",
            Required = {"Player"},
            Optional = {}
        },
        {
            Name = "Freeze",
            Required = {"Player"},
            Optional = {}
        },
        {
            Name = "Kick",
            Required = {"Player"},
            Optional = {"Message"}
        },
        {
            Name = "Kill",
            Required = {"Player"},
            Optional = {}
        },
        {
            Name = "Say",
            Required = {"Player","Message"},
            Optional = {}
        },
        {
            Name = "Shutdown",
            Required = {"Player"},
            Optional = {}
        },
        {
            Name = "Unbang",
            Required = {"Player"},
            Optional = {}
        },
        {
            Name = "Unfreeze",
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
