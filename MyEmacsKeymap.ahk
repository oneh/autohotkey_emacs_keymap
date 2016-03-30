;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MyEmacsKeymap.ahk
;; - An AutoHotkey script to simulate Emacs keybindings on Windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings for testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable warning
;#Warn All, MsgBox
;; replace the existing process with the newly started one without prompt
;#SingleInstance force

;;--------------------------------------------------------------------------
;; Important hotkey prefix symbols
;; Help > Basic Usage and Syntax > Hotkeys
;; # -> Win
;; ! -> Alt
;; ^ -> Control
;; + -> Shift
;;--------------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; These settings are required for this script to work.
#InstallKeybdHook
#UseHook

;; What does this actually do?
SetKeyDelay 0

;; Just to play with non-default send modes
;SendMode Input
;SendMode Play

;; Matching behavior of the WinTitle parameter
;; 1: from the start, 2: anywhere, 3: exact match
;; or RegEx: regular expressions
SetTitleMatchMode 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mark status. 1 = set, 0 = not set
global m_Mark := 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Control functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Determines if this script should be enabled based on "ahk_class" of the
;; active window. "ahk_class" can be identified using Window Spy
;; (right-click on the AutoHotkey icon in the task bar)
m_IsEnabled() {
    global
    ;; List of applications to be ignored by this script
    ;; (Add applications as needed)
    ;; Emacs - NTEmacs
    ;; Vim - GVim
    ;; mintty - Cygwin
    m_IgnoreList := ["Emacs", "Vim", "mintty"]
    for index, element in m_IgnoreList
    {
        IfWinActive ahk_class %element%
            Return 0
    }
    IfWinActive ahk_class ConsoleWindowClass ; Command Prompt
    {
        IfWinActive ahk_exe bash.exe
            Return 0
    }
    Return 1
}
;; Checks if the active window is MS Excel. The main things it does:
;;  C-c a  Activates the selected cell and move the cursor to the end
;;         This key stroke sends {F12}. The "a" is for Append.
;;  C-c i  Activates the selected cell and move the cursor to the beginning
;;         This key stroke sends {F12]{Home}. The "i" is for Insert.
;; Note: In Excel 2013, you may want to disable the quick analysis feature
;; (Options > General > Show Quick Analysis options on selection).
m_IsMSExcel() {
    global
    IfWinActive ahk_class XLMAIN
        Return 1
	Return 0
}
m_IsNotMSExcel() {
    global
    IfWinNotActive ahk_class XLMAIN
        Return 1
	Return 0
}
;; Checks if the active window is Google Sheets.
;; The main purpose is to provide keybindings to edit cells as does with MS
;; Excel.
m_IsGoogleSheets() {
    global
    ;IfWinActive Google Sheets ahk_class MozillaWindowsClass
    IfWinActive ahk_class MozillaWindowClass ; FireFox
        Return 1
IfWinActive Google Sheets ahk_class Chrome_WidgetWin_1 ; Chrome
    Return 1
	Return 0
}
;; Checks if the active window is MS Word. The main things it does:
;;  "kill-line" sends "+{End}+{Left}^c{Del}" instead of "+{End}^c{Del}".
;;  This is to cut out the line feed mark which is usually configured to
;;  be displayed in the View options in MS Word.
m_IsMSWord() {
    global
    IfWinActive ahk_class OpusApp
        Return 1
	Return 0
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Prefix key processing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; These functions just return without any processing.
;; The purpose of these functions is to make sure the hotkey is mapped to
;; the A_PriorHotkey built-in variable when the prefix key is pressed.
;; Ex) To detect whether C-x is pressed as the prefix key:
;;   if (A_PriorHotkey = "^x")
m_EnableControlCPrefix() {
    Return
}
m_EnableControlXPrefix() {
    Return
}
m_EnableControlQPrefix() {
  Return
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs simulating functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Buffers and Files ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-x C-f
m_FindFile() {
    Send ^o
    global m_Mark := 0
}
;; C-x C-s
m_SaveBuffer() {
    Send ^s
    global m_Mark := 0
}
;; C-x C-w
m_WriteFile() {
    Send !fa
    global m_Mark := 0
}
;; C-x k
m_KillBuffer() {
    m_KillEmacs()
}
;; C-x C-c
m_KillEmacs() {
    Send !{F4}
    global m_Mark := 0
}
;; Cursor Motion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-f
m_ForwardChar() {
    global
    if (m_Mark) {
        Send +{Right}
    } else {
        Send {Right}
    }
}
;; C-b
m_BackwardChar() {
    global
    if (m_Mark) {
        Send +{Left}
    } else {
        Send {Left}
    }
}
;; C-n
m_NextLine() {
    global
    if (m_Mark) {
        Send +{Down}
    } else {
        Send {Down}
    }
}
;; C-p
m_PreviousLine() {
    global
    if (m_Mark) {
        Send +{Up}
    } else {
        Send {Up}
    }
}
;; M-f
m_ForwardWord() {
    global
    if (m_Mark) {
        Loop 5
        Send +{Right}
    } else {
        Loop, 5
        Send {Right}
    }
}
;; M-b
m_BackwardWord() {
    global
    if (m_Mark) {
        Loop, 5
        Send +{Left}
    } else {
        Loop, 5
        Send {Left}
    }
}
;; M-n
m_MoreNextLines() {
    global
    if (m_Mark) {
        Loop, 5
        Send +{Down}
    } else {
        Loop, 5
        Send {Down}
    }
}
;; M-p
m_MorePreviousLines() {
    global
    if (m_Mark) {
        Loop, 5
        Send +{Up}
    } else {
        Loop, 5
        Send {Up}
    }
}
;; C-a
m_MoveBeginningOfLine() {
    global
    if (m_Mark) {
        Send +{Home}
    } else {
        Send {Home}
    }
}
;; C-e
m_MoveEndOfLine() {
    global
    if (m_Mark) {
        Send +{End}
    } else {
        Send {End}
    }
}
;; C-v
m_ScrollDown() {
    global
    if (m_Mark) {
        Send +{PgDn}
    } else {
        Send {PgDn}
    }
}
;; M-v
m_ScrollUp() {
    global
    if (m_Mark) {
        Send +{PgUp}
    } else {
        Send {PgUp}
    }
}
;; M-<
m_BeginningOfBuffer() {
    global
    if (m_Mark) {
        Send ^+{Home}
    } else {
        Send ^{Home}
    }
}
;; M->
m_EndOfBuffer() {
    global
    if (m_Mark) {
        Send ^+{End}
  } else {
      Send ^{End}
  }
}
;; Select, Delete, Copy & Paste ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-spc
m_SetMarkCommand() {
    global
    if (m_Mark) {
        m_Mark := 0
        m_ForwardChar()
        m_BackwardChar()
        m_Mark := 1
    } else {
        m_Mark := 1
    }
}
;; C-x h
m_MarkWholeBuffer() {
    Send ^{End}^+{Home}
    global m_Mark := 1
}
;; C-x C-p
m_MarkPage() {
    m_MarkWholeBuffer()
}
;; C-d
m_DeleteChar() {
    Send {Del}
    global m_Mark := 0
}
;; C-b
m_DeleteBackwardChar() {
    Send {BS}
    global m_Mark := 0
}
;; C-k
m_KillLine() {
    If (m_IsMSWord()) {
        ;Send +{End}+{Left}^c{Del}
        Send +{End}+{Left}^x
    } else {
        ;Send +{End}^c{Del}
        Send +{End}^x
    }
    global m_Mark := 0
}
;; C-w
m_KillRegion() {
    Send ^x
    global m_Mark := 0
}
;; M-w
m_KillRingSave() {
    Send ^c
    global m_Mark := 0
}
;; C-y
m_Yank() {
    if (m_IsMSExcel()) {
        ; Added {Esc} to suppress the annoying "Paste Options" hovering menu
        ; that shows up when pasting copied cells. If you want to use the
        ; "Paste Options" menu, use the mouse to paste the copied cells.
        ; Somehow only works with "kill-reagion + yank". Does not work with
        ; "kill-ring-save + yank" - the menu still shows up.
        Send ^v{Esc}
        ;Send ^v
    } else if (m_IsMSWord()) {
        ;Send ^v{Esc}{Esc}{Esc}
        Send ^v
    } else {
        Send ^v
    }
    global m_Mark := 0
}
;; Search ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-s
m_ISearchForward() {
    Send ^f
    global m_Mark := 0
}
;; C-r
m_ISearchBackward() {
    m_IsearchForward()
}
;; Undo and Cancel ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-/
m_Undo() {
    Send ^z
    global m_Mark := 0
}
;; C-g
m_KeyboardQuit() {
    ; MS Excel will ignore "{Esc}" generated by AHK in some cases(?)
    ;if (m_isNotMSExcel())
        ;Send {Esc}
    Send {Esc}
    global m_Mark := 0
}

;; Input Method ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-x C-j
m_ToggleInputMethod() {
    Send {vkF3sc029}
    global m_Mark := 0
}
;; Others ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-m, C-j
m_NewLine() {
    Send {Enter}
    global m_Mark := 0
}
;; (C-o)
m_OpenLine() {
    Send {Enter}{Up}
    global m_Mark := 0
}
;; C-i
m_IndentForTabCommand() {
    Send {Tab}
    global m_Mark := 0
}
;; C-t
m_TransposeChars() {
    m_SetMarkCommand()
    m_ForwardChar()
    m_KillRegion()
    m_BackwardChar()
    m_Yank()
}
;; Keys to send as they are when followed by C-q ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-q C-a
;; For MS Paint
m_RawSelectAll() {
    Send %A_ThisHotkey%
}
;; C-q C-n
;; For Web browsers
m_RawNewWindow() {
    Send %A_ThisHotkey%
}
;; C-q C-p
m_RawPrintBuffer() {
    Send %A_ThisHotkey%
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^Space::
if (m_IsEnabled()) {
    m_SetMarkCommand()
} else {
    Send {CtrlDown}{Space}{CtrlUp}
    ;Send %A_ThisHotkey% ; this ends up with messed up key strokes
}
Return
^/::
if (m_IsEnabled()) {
    m_Undo()
} else {
    Send %A_ThisHotkey%
}
Return
!<::
if (m_IsEnabled()) {
    m_BeginningOfBuffer()
} else {
    Send %A_ThisHotkey%
}
Return
!>::
if (m_IsEnabled()) {
    m_EndOfBuffer()
} else {
    Send %A_ThisHotkey%
}
Return
^\::
if (m_IsEnabled()) {
    m_ToggleInputMethod()
} else {
    Send %A_ThisHotkey%
}
Return
a::
if (m_IsMSExcel() or m_IsGoogleSheets() ) {
    if (A_PriorHotkey = "^c") {
    Send {F2}
} else {
    Send %A_ThisHotkey%
}
} else {
    Send %A_ThisHotkey%
}
Return
^a::
if (m_IsEnabled()) {
    if (A_PriorHotkey = "^q") {
    m_RawSelectAll()
} else {
    m_MoveBeginningOfLine()
}
} else {
    Send %A_ThisHotkey%
}
Return
^b::
if (m_IsEnabled()) {
    m_BackwardChar()
} else {
    Send %A_ThisHotkey%
}
Return
!b::
if (m_IsEnabled()) {
    m_BackwardWord()
} else {
    Send %A_ThisHotkey%
}
Return
^c::
if (m_IsEnabled()) {
    if (A_PriorHotkey = "^x") {
    m_KillEmacs()
} else if (m_IsMSExcel() or m_IsGoogleSheets()) {
    m_EnableControlCPrefix()
    } else {
        Send %A_ThisHotkey%
    }
    } else {
        Send %A_ThisHotkey%
    }
    Return
^d::
if (m_IsEnabled()) {
    m_DeleteChar()
} else {
    Send %A_ThisHotkey%
}
Return
^e::
if (m_IsEnabled()) {
    m_MoveEndOfLine()
} else {
    Send %A_ThisHotkey%
}
Return
^f::
if (m_IsEnabled()) {
    if (A_PriorHotkey = "^x") {
    m_FindFile()
} else {
    m_ForwardChar()
}
} else {
    Send %A_ThisHotkey%
}
Return
!f::
if (m_IsEnabled()) {
    m_ForwardWord()
} else {
    Send %A_ThisHotkey%
}
Return
^g::
if (m_IsEnabled()) {
    m_KeyboardQuit()
} else {
    Send %A_ThisHotkey%
}
Return
h::
if (m_IsEnabled()) {
    if (A_PriorHotkey = "^x") {
    m_MarkWholeBuffer()
} else {
    Send %A_ThisHotkey%
}
} else {
    Send %A_ThisHotkey%
}
Return
^h::
if (m_IsEnabled()) {
    m_DeleteBackwardChar()
} else {
    Send %A_ThisHotkey%
}
Return
i::
if (m_IsMSExcel() or m_IsGoogleSheets()) {
    if (A_PriorHotkey = "^c") {
    Send {F2}{Home}
} else {
    Send %A_ThisHotkey%
}
} else {
    Send %A_ThisHotkey%
}
Return
^j::
if (m_IsEnabled()) {
    if (A_PriorHotkey = "^x") {
    m_ToggleInputMethod()
} else {
    m_NewLine()
}
} else {
    Send %A_ThisHotkey%
}
Return
k::
if (m_IsEnabled()) {
    if (A_PriorHotkey = "^x") {
    m_KillBuffer()
} else {
    Send %A_ThisHotkey%
}
} else {
    Send %A_ThisHotkey%
}
Return
^k::
if (m_IsEnabled()) {
    m_KillLine()
} else {
    Send %A_ThisHotkey%
}
Return
^m::
if (m_IsEnabled()) {
    m_NewLine()
} else {
    Send %A_ThisHotkey%
}
Return
^n::
if (m_IsEnabled()) {
    if (A_PriorHotkey = "^q") {
    m_RawNewWindow()
} else {
    m_NextLine()
    }  
    } else {
        Send %A_ThisHotkey%
    }
    Return
!n::
if (m_IsEnabled()) {
    m_MoreNextLines()
} else {
    Send %A_ThisHotkey%
}
Return
^o::
if (m_IsEnabled()) {
    ;m_ToggleInputMethod()
m_OpenLine()
} else {
    Send %A_ThisHotkey%
}
Return
^p::
if (m_IsEnabled()) {
    if (A_PriorHotkey = "^x") {
    m_MarkPage()
} else if (A_PriorHotkey = "^q") {
    m_RawPrintBuffer()
    } else {
        m_PreviousLine()
    }
    } else {
        Send %A_ThisHotkey%
    }
    Return
!p::
if (m_IsEnabled()) {
    m_MorePreviousLines()
} else {
    Send %A_ThisHotkey%
}
Return
^q::
if (m_IsEnabled()) {
    m_EnableControlQPrefix()
} else {
    Send %A_ThisHotkey%
}
Return
^r::
if (m_IsEnabled()) {
    m_ISearchBackward()
} else {
    Send %A_ThisHotkey%
}
Return
^s::
if (m_IsEnabled()) {
    if (A_PriorHotkey = "^x") {
    m_SaveBuffer()
} else {
    m_ISearchForward()
}
} else {
    Send %A_ThisHotkey%
}
Return
^t::
if (m_IsEnabled()) {
    m_TransposeChars()
} else {
    Send %A_ThisHotkey%
}
Return
u::
if (m_IsEnabled()) {
    if (A_PriorHotkey = "^x") {
    m_Undo()
} else {
    Send %A_ThisHotkey%
}
} else {
    Send %A_ThisHotkey%
}
Return
^v::
if (m_IsEnabled()) {
    m_ScrollDown()
} else {
    Send %A_ThisHotkey%
}
Return
!v::
if (m_IsEnabled()) {
    m_ScrollUp()
} else {
    Send %A_ThisHotkey%
}
Return
^w::
if (m_IsEnabled()) {
    if (A_PriorHotkey = "^x") {
    m_WriteFile()
} else {
    m_KillRegion()
}
} else {
    Send %A_ThisHotkey%
}
Return
!w::
if (m_IsEnabled()) {
    m_KillRingSave()
} else {
    Send %A_ThisHotkey%
}
Return
^x::
if (m_IsEnabled()) {
    m_EnableControlXPrefix()
} else {
    Send %A_ThisHotkey%
}
Return
^y::
if (m_IsEnabled()) {
    m_Yank()
} else {
    Send %A_ThisHotkey%
}
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Administration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^!q::
Suspend, Toggle
Return
^!z::
if (m_IsEnabled()) {
    MsgBox, AutoHotkey emacs keymap is Enabled.
} else {
    MsgBox, AutoHotkey emacs keymap is Disabled.
}
Return
