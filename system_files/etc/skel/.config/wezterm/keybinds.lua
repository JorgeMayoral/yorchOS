local wezterm = require 'wezterm'
local action = wezterm.action

local keys = {
    -- Pane Keybinds
    {
        key = "n",
        mods = "ALT",
        action = wezterm.action.SplitPane {
            direction = 'Right',
            size = { Percent = 50 },
        },
    },
    {
        key = "n",
        mods = "ALT|SHIFT",
        action = wezterm.action.SplitPane {
            direction = 'Down',
            size = { Percent = 50 },
        },
    },
    {
        key = "x",
        mods = "ALT",
        action = wezterm.action.CloseCurrentPane {
            confirm = false,
        },
    },
    -- {
    --     key = 'LeftArrow',
    --     mods = 'ALT',
    --     action = wezterm.action.ActivatePaneDirection 'Left',
    -- },
    -- {
    --     key = 'RightArrow',
    --     mods = 'ALT',
    --     action = wezterm.action.ActivatePaneDirection 'Right',
    -- },
    -- {
    --     key = 'UpArrow',
    --     mods = 'ALT',
    --     action = wezterm.action.ActivatePaneDirection 'Up',
    -- },
    -- {
    --     key = 'DownArrow',
    --     mods = 'ALT',
    --     action = wezterm.action.ActivatePaneDirection 'Down',
    -- },
    {
        key = '+',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },
    {
        key = '-',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = '+',
        mods = 'ALT|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Up', 5 }
    },
    {
        key = '-',
        mods = 'ALT|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 },
    },

    -- Tab Keybinds
    {
        key = 't',
        mods = 'ALT',
        -- action = wezterm.action.SpawnTab 'CurrentPaneDomain',
        action = wezterm.action.SpawnTab 'DefaultDomain',
    },
    {
        key = 'x',
        mods = 'ALT|SHIFT',
        action = wezterm.action.CloseCurrentTab { confirm = false },
    },
}

for i = 1, 8 do
    -- ALT + number to activate that tab
    table.insert(keys, {
      key = tostring(i),
      mods = 'ALT',
      action = wezterm.action.ActivateTab(i - 1),
    })
    -- F1 through F8 to activate that tab
    table.insert(keys, {
      key = 'F' .. tostring(i),
      action = wezterm.action.ActivateTab(i - 1),
    })
end

return keys
