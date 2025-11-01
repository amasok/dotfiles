local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

-- prefix相当を Ctrl+s にする
config.leader = { key="s", mods="CTRL", timeout_milliseconds=1000 }

-- キーバインド定義
config.keys = {
  -- leaderキーを使って操作
  -- 縦分割: Ctrl+s |
  { key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

  -- 横分割: Ctrl+s -
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },


  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  -- ペイン移動（h/j/k/l）
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

  -- ペインリサイズ（Ctrlを押しながら方向キー）
  { key = "h", mods = "LEADER|CTRL", action = act.AdjustPaneSize{ "Left", 6 } },
  { key = "j", mods = "LEADER|CTRL", action = act.AdjustPaneSize{ "Down", 6 } },
  { key = "k", mods = "LEADER|CTRL", action = act.AdjustPaneSize{ "Up", 6 } },
  { key = "l", mods = "LEADER|CTRL", action = act.AdjustPaneSize{ "Right", 6 } },

  -- 新しいタブ
  { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },

  -- タブ移動
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },

  -- ペインを閉じる
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane{ confirm = true } },

  -- ワークスペース関連のキーバインド
  -- Ctrl+s w: ワークスペース一覧から選択して切り替え
  { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
  
  -- Ctrl+s Shift+W: ワークスペース名を変更
  { key = "W", mods = "LEADER|SHIFT", action = act.PromptInputLine({
    description = "ワークスペース名を入力してください:",
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        wezterm.mux.rename_workspace(
          wezterm.mux.get_active_workspace(),
          line
        )
      end
    end),
  })},
  
  -- Ctrl+s n: 新しいワークスペースを作成
  { key = "N", mods = "LEADER|SHIFT", action = act.PromptInputLine({
    description = "新しいワークスペース名を入力してください:",
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        window:perform_action(
          act.SwitchToWorkspace({
            name = line,
          }),
          pane
        )
      end
    end),
  })},
}

-- テーマ（おしゃれにする）
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "JetBrainsMono NF",
  "JetBrains Mono",
  "Menlo",
  "Noto Sans Mono CJK JP",
})
config.font_size = 13.5
config.window_background_opacity = 0.94
config.macos_window_background_blur = 20
config.use_fancy_tab_bar = true

config.colors = {
  tab_bar = {
    background = "#1e1e2e",
  },

  split = "#444444",
}

config.inactive_pane_hsb = {
  saturation = 0.1,
  brightness = 0.1,
}

-- 枠線の色設定
config.window_frame = {
  active_titlebar_bg = "#1e1e2e",
  inactive_titlebar_bg = "#1e1e2e",
}

local mux = wezterm.mux
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = true


-- ペインごとにパスを表示する擬似オーバーレイ
wezterm.on("pane-focus-changed", function(window, pane)
  local cwd_uri = pane:get_current_working_dir()
  local cwd = ""
  if cwd_uri then
    cwd = cwd_uri:match("file://[^/]*(/.*)")
    cwd = cwd:gsub("/Users/[^/]+", "~")
  end

  -- オーバーレイ内容
  local text = " " .. cwd .. " "
  local overlay = wezterm.format({
    { Background = { Color = "#313244" } },
    { Foreground = { Color = "#cdd6f4" } },
    { Text = text },
  })

  -- 画面上部に擬似的に表示
  window:show_overlay(overlay, { x = 0, y = 0 }, wezterm.time.now() + 1.5)
end)

-- ステータスバーの左端にワークスペース名を表示
wezterm.on("update-status", function(window, pane)
  local workspace = window:active_workspace()
  local cells = {}

  -- ワークスペース名を左端に表示
  table.insert(cells, wezterm.format({
    { Background = { Color = "#89b4fa" } },
    { Foreground = { Color = "#1e1e2e" } },
    { Text = " " .. workspace .. " " },
  }))

  -- 日時を右端に表示（オプション）
  local date = wezterm.strftime(" %Y-%m-%d %H:%M:%S ")
  table.insert(cells, wezterm.format({
    { Background = { Color = "#313244" } },
    { Foreground = { Color = "#cdd6f4" } },
    { Text = date },
  }))

  window:set_left_status(cells[1])
  window:set_right_status(cells[2])
end)

return config

