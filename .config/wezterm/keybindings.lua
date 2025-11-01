-- ============================================================================
-- キーバインド設定
-- ============================================================================
--
-- WezTermのキーバインドを定義します。
-- Leaderキー: Ctrl+s (tmuxのprefixに相当)
--
-- ■ ペイン操作
--   Ctrl+s |       : 縦分割
--   Ctrl+s -       : 横分割
--   Ctrl+s z       : ペインのズーム切り替え
--   Ctrl+s h/j/k/l : ペイン移動（Vim風）
--   Ctrl+s Ctrl+h/j/k/l : ペインサイズ変更
--   Ctrl+s x       : ペインを閉じる
--
-- ■ タブ操作
--   Ctrl+s c       : 新しいタブ
--   Ctrl+s n       : 次のタブ
--   Ctrl+s p       : 前のタブ
--   Ctrl+s t       : タブタイトルを設定
--
-- ■ ワークスペース操作
--   Ctrl+s w       : ワークスペース一覧から選択
--   Ctrl+s Shift+L : 直前のワークスペースに切り替え（tmuxのprefix+L相当）
--   Ctrl+s Shift+W : ワークスペース名を変更
--   Ctrl+s Shift+N : 新しいワークスペースを作成
--
-- ============================================================================

local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

-- タブタイトルのフォールバックマップ
M.tab_titles = {}

function M.setup(config, workspace_state)
  -- prefix相当を Ctrl+s にする
  config.leader = { key="s", mods="CTRL", timeout_milliseconds=1000 }

  config.keys = {
    -- ペイン分割
    { key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

    -- ペイン移動（h/j/k/l）
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

    -- ペインリサイズ
    { key = "h", mods = "LEADER|CTRL", action = act.AdjustPaneSize{ "Left", 6 } },
    { key = "j", mods = "LEADER|CTRL", action = act.AdjustPaneSize{ "Down", 6 } },
    { key = "k", mods = "LEADER|CTRL", action = act.AdjustPaneSize{ "Up", 6 } },
    { key = "l", mods = "LEADER|CTRL", action = act.AdjustPaneSize{ "Right", 6 } },

    -- タブ操作
    { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    { key = "x", mods = "LEADER", action = act.CloseCurrentPane{ confirm = true } },

    -- ワークスペース操作
    { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
    
    -- 直前のワークスペースに切り替え (tmuxの prefix + L 相当)
    { key = "L", mods = "LEADER|SHIFT", action = wezterm.action_callback(function(window, pane)
      if workspace_state.previous then
        window:perform_action(
          act.SwitchToWorkspace({ name = workspace_state.previous }),
          pane
        )
      end
    end)},
    
    -- ワークスペース名を変更
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
    
    -- 新しいワークスペースを作成
    { key = "N", mods = "LEADER|SHIFT", action = act.PromptInputLine({
      description = "新しいワークスペース名を入力してください:",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(
            act.SwitchToWorkspace({ name = line }),
            pane
          )
        end
      end),
    })},
    
    -- タブタイトルを設定
    { key = "t", mods = "LEADER", action = act.PromptInputLine({
      description = "タブタイトルを入力（空でクリア）:",
      action = wezterm.action_callback(function(window, pane, line)
        if pane and pane:tab() then
          local title = (line and line ~= "") and line or ""
          pane:tab():set_title(title)
          local tab_id = pane:tab().tab_id
          if tab_id then
            if title == "" then
              M.tab_titles[tab_id] = nil
            else
              M.tab_titles[tab_id] = title
            end
          end
        end
      end),
    })},
  }
end

return M
