set background=dark
if exists('g:colors_name')
hi clear
if exists('syntax_on')
syntax reset
endif
endif
let g:colors_name = 'lushwal'
highlight Normal guifg=#D5D5D8 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight! link User Normal
highlight Bold guifg=#D5D5D8 guibg=#1C1F26 guisp=NONE blend=NONE gui=bold
highlight Boolean guifg=#85858E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Character guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight ColorColumn guifg=#A9A9AD guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Comment guifg=#D5D5D8 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight Conceal guifg=#959597 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight! link Whitespace Conceal
highlight Conditional guifg=#CCC7CB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Constant guifg=#85858E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Cursor guifg=#1C1F26 guibg=#D5D5D8 guisp=NONE blend=NONE gui=NONE
highlight CursorColumn guifg=#A9A9AD guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CursorLine guifg=#959597 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CursorLineNr guifg=#D5D5D8 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight Debug guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Define guifg=#CCC7CB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Delimiter guifg=#86858E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticError guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticHint guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticInfo guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticUnderlineError guifg=#828089 guibg=NONE guisp=#828089 blend=NONE gui=underline
highlight DiagnosticUnderlineHint guifg=#ADAEB3 guibg=NONE guisp=#ADAEB3 blend=NONE gui=underline
highlight DiagnosticUnderlineInfo guifg=#9A9AA2 guibg=NONE guisp=#9A9AA2 blend=NONE gui=underline
highlight DiagnosticUnderlineWarn guifg=#8A8D93 guibg=NONE guisp=#8A8D93 blend=NONE gui=underline
highlight DiagnosticWarn guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffAdd guifg=#808289 guibg=#959597 guisp=NONE blend=NONE gui=bold
highlight! link DiffAdded DiffAdd
highlight DiffChange guifg=#BDBDC1 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight DiffDelete guifg=#828089 guibg=#959597 guisp=NONE blend=NONE gui=bold
highlight! link DiffRemoved DiffDelete
highlight! link diffRemoved DiffDelete
highlight DiffFile guifg=#828089 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight DiffLine guifg=#9A9AA2 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight DiffNewFile guifg=#808289 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight DiffText guifg=#9A9AA2 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight Directory guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight EndOfBuffer guifg=#D5D5D8 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight Error guifg=#828089 guibg=#D5D5D8 guisp=NONE blend=NONE gui=NONE
highlight ErrorMsg guifg=#828089 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight Exception guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Float guifg=#85858E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight FoldColumn guifg=#9A9AA2 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight Folded guifg=#D5D5D8 guibg=#959597 guisp=NONE blend=NONE gui=italic
highlight Function guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Identifier guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight IncSearch guifg=#959597 guibg=#85858E guisp=NONE blend=NONE gui=NONE
highlight Include guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Italic guifg=#D5D5D8 guibg=#1C1F26 guisp=NONE blend=NONE gui=italic
highlight Keyword guifg=#CCC7CB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Label guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LineNr guifg=#BDBDC1 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight Macro guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MatchParen guifg=#D5D5D8 guibg=#BDBDC1 guisp=NONE blend=NONE gui=NONE
highlight MiniCompletionActiveParameter guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniCursorword guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=underline
highlight! link MiniCursorwordCurrent MiniCursorword
highlight MiniIndentscopePrefix guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=nocombine
highlight MiniIndentscopeSymbol guifg=#959597 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight MiniJump guifg=#9A9AA2 guibg=NONE guisp=#BDBDC1 blend=NONE gui=underline
highlight MiniJump2dSpot guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=undercurl
highlight MiniStarterCurrent guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniStarterFooter guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MiniStarterHeader guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MiniStarterInactive guifg=#D5D5D8 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight MiniStarterItem guifg=#D5D5D8 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight MiniStarterItemBullet guifg=#86858E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniStarterItemPrefix guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniStarterQuery guifg=#808289 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniStarterSection guifg=#86858E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineDevinfo guifg=#D5D5D8 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineFileinfo guifg=#D5D5D8 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineFilename guifg=#8A8D93 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineInactive guifg=#A9A9AD guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeCommand guifg=#1C1F26 guibg=#ADAEB3 guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeInsert guifg=#1C1F26 guibg=#9A9AA2 guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeNormal guifg=#1C1F26 guibg=#808289 guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeOther guifg=#1C1F26 guibg=#CCC7CB guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeReplace guifg=#1C1F26 guibg=#828089 guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeVisual guifg=#1C1F26 guibg=#85858E guisp=NONE blend=NONE gui=NONE
highlight MiniSurround guifg=#959597 guibg=#85858E guisp=NONE blend=NONE gui=NONE
highlight MiniTablineCurrent guifg=#BDBDC1 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight MiniTablineFill guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniTablineHidden guifg=#808289 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight MiniTablineModifiedCurrent guifg=#D5D5D8 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight MiniTablineModifiedHidden guifg=#A9A9AD guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight MiniTablineModifiedVisible guifg=#D5D5D8 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight MiniTablineVisible guifg=#BDBDC1 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight MiniTestEmphasis guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MiniTestFail guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MiniTestPass guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MiniTrailspace guifg=#828089 guibg=#D5D5D8 guisp=NONE blend=NONE gui=NONE
highlight ModeMsg guifg=#808289 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MoreMsg guifg=#808289 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NonText guifg=#BDBDC1 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Number guifg=#85858E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Operator guifg=#D5D5D8 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight PMenu guifg=#D5D5D8 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight PMenuSel guifg=#D5D5D8 guibg=#9A9AA2 guisp=NONE blend=NONE gui=NONE
highlight PmenuSbar guifg=#A9A9AD guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight PmenuThumb guifg=#D5D5D8 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight PreProc guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Question guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Repeat guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Search guifg=#BDBDC1 guibg=#8A8D93 guisp=NONE blend=NONE gui=NONE
highlight! link MiniTablineTabpagesection Search
highlight SignColumn guifg=#A9A9AD guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight Special guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight SpecialChar guifg=#86858E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight SpecialKey guifg=#BDBDC1 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight SpellBad guifg=#828089 guibg=NONE guisp=#828089 blend=NONE gui=underline
highlight SpellCap guifg=#8A8D93 guibg=NONE guisp=#8A8D93 blend=NONE gui=underline
highlight SpellLocal guifg=#ADAEB3 guibg=NONE guisp=#ADAEB3 blend=NONE gui=underline
highlight SpellRare guifg=#CCC7CB guibg=NONE guisp=#CCC7CB blend=NONE gui=underline
highlight Statement guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLine guifg=#D5D5D8 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight StatusLineNC guifg=#A9A9AD guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight StatusLineTerm guifg=#808289 guibg=#808289 guisp=NONE blend=NONE gui=NONE
highlight StatusLineTermNC guifg=#8A8D93 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight StorageClass guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight String guifg=#808289 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Structure guifg=#CCC7CB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TabLine guifg=#BDBDC1 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight TabLineFill guifg=#BDBDC1 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight TabLineSel guifg=#808289 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight Tag guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Title guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Todo guifg=#8A8D93 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight TooLong guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Type guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Typedef guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Underlined guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight VertSplit guifg=#D5D5D8 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight! link WinSeparator VertSplit
highlight Visual guifg=#1C1F26 guibg=#A9A9AD guisp=NONE blend=NONE gui=NONE
highlight VisualNOS guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WarningMsg guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WildMenu guifg=#D5D5D8 guibg=#9A9AA2 guisp=NONE blend=NONE gui=NONE
highlight WinBar guifg=#D5D5D8 guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight WinBarNC guifg=#A9A9AD guibg=#1C1F26 guisp=NONE blend=NONE gui=NONE
highlight gitCommitOverflow guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight gitCommitSummary guifg=#808289 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight helpCommand guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight helpExample guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @attribute guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @boolean guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @character guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @character.special guifg=#86858E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @comment guifg=#D5D5D8 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @conditional guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @constant guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @constant.builtin guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @constant.macro guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @constructor guifg=#D5D5D8 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @debug guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @define guifg=#CCC7CB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @exception guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @field guifg=#808289 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @float guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @function guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @function.builtin guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @function.macro guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @include guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @keyword guifg=#CCC7CB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @keyword.function guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @keyword.operator guifg=#CCC7CB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @label guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @method guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @namespace guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @none guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @number guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @operator guifg=#D5D5D8 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @parameter guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @preproc guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @property guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @punctuation.bracket guifg=#D5D5D8 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @punctuation.delimiter guifg=#D5D5D8 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @punctuation.special guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @repeat guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @storageclass guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @string guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @string.escape guifg=#808289 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @string.regex guifg=#808289 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @string.special guifg=#86858E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @symbol guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @tag guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @tag.attribute guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @tag.delimiter guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text guifg=#808289 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.bold guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @text.danger guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.diff.add guifg=#808289 guibg=#959597 guisp=NONE blend=NONE gui=bold
highlight @text.diff.delete guifg=#828089 guibg=#959597 guisp=NONE blend=NONE gui=bold
highlight @text.emphasis guifg=#CCC7CB guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @text.environment guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.environment.name guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.literal guifg=#808289 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.math guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.note guifg=#ADAEB3 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.reference guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.strike guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=strikethrough
highlight @text.title guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @text.todo guifg=#8A8D93 guibg=#959597 guisp=NONE blend=NONE gui=NONE
highlight @text.underline guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=underline
highlight @text.uri guifg=NONE guibg=#959597 guisp=NONE blend=NONE gui=underline
highlight @type guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @type.builtin guifg=#9A9AA2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @type.definition guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @variable guifg=#8A8D93 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @variable.builtin guifg=#828089 guibg=NONE guisp=NONE blend=NONE gui=NONE
