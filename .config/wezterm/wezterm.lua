-- ============================================================================
-- WezTerm メイン設定ファイル
-- ============================================================================
-- 
-- 各モジュールを読み込んで、WezTermの設定を構築します。
-- 設定を変更する場合は、以下の各ファイルを編集してください：
--
-- - keybindings.lua : キーバインド設定（ペイン/タブ/ワークスペース操作）
-- - appearance.lua  : 外観設定（テーマ/フォント/色/透明度）
-- - tabs.lua        : タブの表示設定（タイトルフォーマット/パス表示）
-- - statusbar.lua   : ステータスバー設定（ワークスペース/Git/日時表示）
--
-- ============================================================================

local wezterm = require 'wezterm'

-- 各モジュールを読み込み
local keybindings = require 'keybindings'
local appearance = require 'appearance'
local tabs = require 'tabs'
local statusbar = require 'statusbar'

local config = {}

-- ワークスペース履歴を管理するグローバル状態
local workspace_state = {
  previous = nil,
  current = nil,
}

-- キーバインド設定（workspace_stateを渡す）
keybindings.setup(config, workspace_state)

-- 外観設定
appearance.setup(config)

-- タブ設定
tabs.setup(keybindings.tab_titles)

-- ステータスバー設定（workspace_stateを渡す）
statusbar.setup(workspace_state)

return config
