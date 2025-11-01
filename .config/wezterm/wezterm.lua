local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

local config = {}

-- 直前のワークスペース名を記録する変数
local previous_workspace = nil

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

  -- Ctrl+s l: 直前のワークスペースに切り替え (tmuxの prefix + L 相当)
  { key = "l", mods = "LEADER", action = wezterm.action_callback(function(window, pane)
    if previous_workspace then
      local current = window:active_workspace()
      window:perform_action(
        act.SwitchToWorkspace({ name = previous_workspace }),
        pane
      )
      -- 切り替え後、現在のワークスペースを次回の「直前」として記録
      previous_workspace = current
    end
  end)},
  
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
  -- Ctrl+s t: タブのタイトルを設定
  { key = "t", mods = "LEADER", action = act.PromptInputLine({
    description = "タブタイトルを入力（空でクリア）:",
    action = wezterm.action_callback(function(window, pane, line)
      if pane and pane:tab() then
        local title = (line and line ~= "") and line or ""
        pane:tab():set_title(title)
        -- フォールバックマップにも保存
        local tab_id = pane:tab().tab_id
        if tab_id then
          if title == "" then
            tab_titles[tab_id] = nil
          else
            tab_titles[tab_id] = title
          end
        end
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

config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 50  -- タブの最大幅を50文字に設定（デフォルトは16）

-- WezTerm の SetTabTitle が使えない環境のためのフォールバックマップ
local tab_titles = {}

-- タブのタイトルをカスタマイズ
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local cwd_uri = pane.current_working_dir
  
  -- ディレクトリパスを取得
  local cwd = ""
  local display_title = ""
  
  if cwd_uri then
    -- URIからファイルパスを取得
    cwd = cwd_uri.file_path or ""
    
    -- ホームディレクトリを~に置き換え
    local home = wezterm.home_dir
    if cwd:sub(1, #home) == home then
      cwd = "~" .. cwd:sub(#home + 1)
    end
    -- パスを/で分割（~は除外）
    local parts = {}
    local path_without_tilde = cwd:gsub("^~/", "")  -- ~/ を除去してから分割
    if path_without_tilde ~= "" then
      for part in path_without_tilde:gmatch("[^/]+") do
        table.insert(parts, part)
      end
    end
    -- 少なくとも現在のディレクトリを表示、可能なら3階層まで
    if #parts == 0 then
      display_title = "~"
    elseif #parts == 1 then
      -- 1階層のみ: ~/dir
      display_title = parts[1]
    elseif #parts == 2 then
      -- 2階層: dir1/dir2
      display_title = parts[1] .. "/" .. parts[2]
    elseif #parts == 3 then
      -- 3階層: dir1/dir2/dir3
      display_title = parts[1] .. "/" .. parts[2] .. "/" .. parts[3]
    else
      -- 4階層以上: 最後の3つを表示
      local n = #parts
      display_title = "…/" .. parts[n-2] .. "/" .. parts[n-1] .. "/" .. parts[n]
    end
  else
    display_title = "?"
  end
  -- タブ番号
  local index = tab.tab_index + 1
  -- アクティブかどうか
  local is_active = tab.is_active
  -- 色設定
  local bg = "#313244"  -- 非アクティブ
  local fg = "#bac2de"
  if is_active then
    bg = "#89b4fa"  -- アクティブ（青）
    fg = "#1e1e2e"
  elseif hover then
    bg = "#45475a"  -- ホバー
  end
  -- 優先順位: 明示的に設定されたタブタイトル > pane.title（OSCで設定） > cwdベース表示
  local explicit_tab = tab.tab_title
  local pane_title = pane.title
  -- フォールバックマップから値を取る
  local fallback_tab = tab_titles[tab.tab_id]
  local title_text = (explicit_tab and explicit_tab ~= "") and explicit_tab
                     or (fallback_tab and fallback_tab ~= "") and fallback_tab
                     or (pane_title and pane_title ~= "") and pane_title
                     or ("" .. index .. ": " .. display_title)
  local title = " " .. title_text .. " "
  return {
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = title },
  }
end)

-- ステータスバーをStarship風にかっこよく表示
wezterm.on("update-status", function(window, pane)
  -- Catppuccin Mocha カラーパレット
  local colors = {
    rosewater = "#f5e0dc",
    flamingo = "#f2cdcd",
    pink = "#f5c2e7",
    mauve = "#cba6f7",
    red = "#f38ba8",
    maroon = "#eba0ac",
    peach = "#fab387",
    yellow = "#f9e2af",
    green = "#a6e3a1",
    teal = "#94e2d5",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#89b4fa",
    lavender = "#b4befe",
    text = "#cdd6f4",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#9399b2",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#585b70",
    surface1 = "#45475a",
    surface0 = "#313244",
    base = "#1e1e2e",
    mantle = "#181825",
    crust = "#11111b",
  }

  -- 現在のワークスペース名
  local workspace = window:active_workspace()

  -- 初回起動時に現在のワークスペースを記録
  if workspace and previous_workspace == nil then
    previous_workspace = workspace
  end
  
  -- カレントディレクトリを取得
  local cwd_uri = pane:get_current_working_dir()
  local cwd = ""
  if cwd_uri then
    cwd = cwd_uri.file_path
    cwd = cwd:gsub(wezterm.home_dir, "~")
    -- ディレクトリ名のみを表示（パスが長い場合）
    local basename = cwd:match("([^/]+)$") or cwd
    cwd = basename
  end

  -- Git情報を取得（オプション）
  local git_branch = ""
  local success, stdout, stderr = wezterm.run_child_process({
    "git",
    "-C",
    cwd_uri and cwd_uri.file_path or ".",
    "branch",
    "--show-current"
  })
  if success then
    git_branch = stdout:gsub("%s+", "")
  end

  -- 左側のステータス（ワークスペース + ディレクトリ + Git）
  local left_status = {}
  -- ワークスペース
  table.insert(left_status, { Background = { Color = colors.blue } })
  table.insert(left_status, { Foreground = { Color = colors.base } })
  table.insert(left_status, { Text = " 󱂬 " .. workspace .. " " })
  -- セパレーター
  table.insert(left_status, { Background = { Color = colors.surface0 } })
  table.insert(left_status, { Foreground = { Color = colors.blue } })
  table.insert(left_status, { Text = "" })
  -- ディレクトリ
  if cwd ~= "" then
    table.insert(left_status, { Background = { Color = colors.surface0 } })
    table.insert(left_status, { Foreground = { Color = colors.sky } })
    table.insert(left_status, { Text = "  " .. cwd .. " " })
  end
  -- Git ブランチ
  if git_branch ~= "" then
    table.insert(left_status, { Background = { Color = colors.surface1 } })
    table.insert(left_status, { Foreground = { Color = colors.surface0 } })
    table.insert(left_status, { Text = "" })
    table.insert(left_status, { Background = { Color = colors.surface1 } })
    table.insert(left_status, { Foreground = { Color = colors.peach } })
    table.insert(left_status, { Text = "  " .. git_branch .. " " })
    table.insert(left_status, { Background = { Color = colors.base } })
    table.insert(left_status, { Foreground = { Color = colors.surface1 } })
    table.insert(left_status, { Text = "" })
  else
    table.insert(left_status, { Background = { Color = colors.base } })
    table.insert(left_status, { Foreground = { Color = colors.surface0 } })
    table.insert(left_status, { Text = "" })
  end

  -- 右側のステータス（日時 + バッテリー）
  local right_status = {}
  -- 日時
  local date = wezterm.strftime("%H:%M")
  local day = wezterm.strftime("%Y-%m-%d")
  table.insert(right_status, { Background = { Color = colors.base } })
  table.insert(right_status, { Foreground = { Color = colors.surface0 } })
  table.insert(right_status, { Text = "" })
  table.insert(right_status, { Background = { Color = colors.surface0 } })
  table.insert(right_status, { Foreground = { Color = colors.lavender } })
  table.insert(right_status, { Text = " 󰃰 " .. day .. " " })
  table.insert(right_status, { Background = { Color = colors.surface1 } })
  table.insert(right_status, { Foreground = { Color = colors.surface0 } })
  table.insert(right_status, { Text = "" })
  table.insert(right_status, { Background = { Color = colors.surface1 } })
  table.insert(right_status, { Foreground = { Color = colors.green } })
  table.insert(right_status, { Text = "  " .. date .. " " })

  window:set_left_status(wezterm.format(left_status))
  window:set_right_status(wezterm.format(right_status))
end)

return config

