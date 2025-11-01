-- ============================================================================
-- 外観・テーマ設定
-- ============================================================================
--
-- WezTermの見た目に関する設定を定義します。
--
-- ■ テーマ
--   - Catppuccin Mocha（ダークテーマ）
--
-- ■ フォント
--   - JetBrainsMono Nerd Font（Nerd Fonts対応）
--   - フォールバック: JetBrains Mono, Menlo, Noto Sans Mono CJK JP
--   - サイズ: 13.5pt
--
-- ■ 背景
--   - 透明度: 94%
--   - macOSのぼかし効果: 20
--
-- ■ タブバー
--   - シンプルなタブバー（use_fancy_tab_bar = false）
--   - 下部に配置
--   - タブの最大幅: 50文字
--
-- ============================================================================

local wezterm = require 'wezterm'

local M = {}

function M.setup(config)
  -- テーマ
  config.color_scheme = "Catppuccin Mocha"
  
  -- フォント
  config.font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font",
    "JetBrainsMono NF",
    "JetBrains Mono",
    "Menlo",
    "Noto Sans Mono CJK JP",
  })
  config.font_size = 13.5
  
  -- 背景
  config.window_background_opacity = 0.94
  config.macos_window_background_blur = 20
  
  -- 色設定
  config.colors = {
    tab_bar = {
      background = "#1e1e2e",
    },
    split = "#444444",
  }
  
  -- 非アクティブペインの色調整
  config.inactive_pane_hsb = {
    saturation = 0.1,
    brightness = 0.1,
  }
  
  -- ウィンドウ枠
  config.window_frame = {
    active_titlebar_bg = "#1e1e2e",
    inactive_titlebar_bg = "#1e1e2e",
  }
  
  -- タブバー設定
  config.use_fancy_tab_bar = false
  config.enable_tab_bar = true
  config.show_new_tab_button_in_tab_bar = false
  config.show_tab_index_in_tab_bar = false
  config.tab_bar_at_bottom = true
  config.tab_max_width = 50
end

return M
