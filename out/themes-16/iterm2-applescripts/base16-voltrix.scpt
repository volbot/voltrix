(*
    base16 voltrix
    Scheme author: allomyrina volbot (http://volbot.org)
    Template author: Tinted Theming (https://github.com/tinted-theming)
*)
tell application "iTerm2"
    tell current session of current window
        set background color to {2827, 2313, 4112}
        set foreground color to {65535, 65535, 65535}

        -- Set ANSI Colors
        set ANSI black color to {14135, 12336, 18761}
        set ANSI red color to {57054, 18247, 31097}
        set ANSI green color to {18247, 31097, 57054}
        set ANSI yellow color to {57054, 18247, 50629}
        set ANSI blue color to {31097, 57054, 18247}
        set ANSI magenta color to {57054, 44204, 18247}
        set ANSI cyan color to {57054, 18247, 31097}
        set ANSI white color to {65535, 65535, 65535}

        -- Set Bright ANSI Colors
        set ANSI bright black color to {15163, 13364, 20046}
        set ANSI bright red color to {57054, 18247, 31097}
        set ANSI bright green color to {18247, 31097, 57054}
        set ANSI bright yellow color to {57054, 18247, 50629}
        set ANSI bright blue color to {31097, 57054, 18247}
        set ANSI bright magenta color to {57054, 44204, 18247}
        set ANSI bright cyan color to {57054, 18247, 31097}
        set ANSI bright white color to {18247, 15934, 24415}
    end tell
end tell
