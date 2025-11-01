-- ============================================================================
-- ステータスバー設定
-- ============================================================================
--
-- Starship風のかっこいいステータスバーを表示します。
--
-- ■ 左側の表示内容
--   [ワークスペース名] [カレントディレクトリ] [Gitブランチ]
--   - ワークスペース: 青背景 + アイコン
--   - ディレクトリ: スカイブルー + フォルダアイコン
--   - Gitブランチ: ピーチ色 + ブランチアイコン
--   - Powerline風のセパレーター（）で区切り
--
-- ■ 右側の表示内容
--   [日付] [時刻]
--   - 日付: ラベンダー色 + カレンダーアイコン（YYYY-MM-DD形式）
--   - 時刻: グリーン色 + 時計アイコン（HH:MM形式）
--
-- ■ カラーパレット
--   - Catppuccin Mocha テーマの色を使用
--
-- ============================================================================

local wezterm = require 'wezterm'

local M = {}

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

function M.setup(workspace_state)
  wezterm.on("update-status", function(window, pane)
    local workspace = window:active_workspace()

    -- ワークスペースが変わったら履歴を更新
    if workspace and workspace ~= workspace_state.current then
      workspace_state.previous = workspace_state.current
      workspace_state.current = workspace
    elseif workspace and workspace_state.current == nil then
      -- 初回起動時
      workspace_state.current = workspace
    end
    
    -- カレントディレクトリを取得
    local cwd_uri = pane:get_current_working_dir()
    local cwd = ""
    if cwd_uri then
      cwd = cwd_uri.file_path
      cwd = cwd:gsub(wezterm.home_dir, "~")
      local basename = cwd:match("([^/]+)$") or cwd
      cwd = basename
    end

    -- Git情報を取得
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

    -- 右側のステータス（日時）
    local right_status = {}
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
end

return M
