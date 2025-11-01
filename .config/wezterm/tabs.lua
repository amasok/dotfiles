-- ============================================================================
-- タブのフォーマット設定
-- ============================================================================
--
-- タブのタイトル表示をカスタマイズします。
--
-- ■ 表示内容の優先順位
--   1. 明示的に設定されたタブタイトル（Ctrl+s t で設定）
--   2. フォールバックマップに保存されたタイトル
--   3. ペインのタイトル（OSC escape sequenceで設定されたもの）
--   4. カレントディレクトリパス（自動生成）
--
-- ■ パス表示形式
--   - ホームディレクトリは ~ に置換
--   - 階層が深い場合は最後の3階層を表示（例: …/dir1/dir2/dir3）
--   - 階層が浅い場合はそのまま表示
--
-- ■ 色設定
--   - アクティブタブ: 青背景（Catppuccin Blue）
--   - 非アクティブタブ: ダークグレー背景
--   - ホバー時: グレー背景
--
-- ============================================================================

local wezterm = require 'wezterm'

local M = {}

function M.setup(tab_titles)
  -- タブのタイトルをカスタマイズ
  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    local cwd_uri = pane.current_working_dir
    
    local display_title = ""
    
    if cwd_uri then
      local cwd = cwd_uri.file_path or ""
      
      -- ホームディレクトリを~に置き換え
      local home = wezterm.home_dir
      if cwd:sub(1, #home) == home then
        cwd = "~" .. cwd:sub(#home + 1)
      end
      
      -- パスを/で分割
      local parts = {}
      local path_without_tilde = cwd:gsub("^~/", "")
      if path_without_tilde ~= "" then
        for part in path_without_tilde:gmatch("[^/]+") do
          table.insert(parts, part)
        end
      end
      
      -- 階層に応じて表示
      if #parts == 0 then
        display_title = "~"
      elseif #parts == 1 then
        display_title = parts[1]
      elseif #parts == 2 then
        display_title = parts[1] .. "/" .. parts[2]
      elseif #parts == 3 then
        display_title = parts[1] .. "/" .. parts[2] .. "/" .. parts[3]
      else
        local n = #parts
        display_title = "…/" .. parts[n-2] .. "/" .. parts[n-1] .. "/" .. parts[n]
      end
    else
      display_title = "?"
    end
    
    local index = tab.tab_index + 1
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
    
    -- タイトルの優先順位
    local explicit_tab = tab.tab_title
    local pane_title = pane.title
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
end

return M
