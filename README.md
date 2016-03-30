# Emacs Keybindings on Windows with AutoHotkey

`MyEmacsKeymap.ahk` is an AutoHotkey script to simulate Emacs keybindings on Windows.

This script is made largely based on the scripts provided in the following web sites.

* WindowsでEmacs風キーバインド
  * https://github.com/usi3/emacs.ahk
* Windows の操作を emacs のキーバインドで行うための設定（AutoHotKey版）
  * http://www49.atwiki.jp/ntemacs/pages/20.html

## Implemented Keybindings

<table>
<tr>
<th colspan="2" align="left">Buffers and Files</th><th colspan="2" align="left">Select, Delete, Copy & Paste</th>
</tr>
<tr>
<td><code>C-x C-f</code></td><td>find-file</td><td><code>C-SPC</code></td><td>set-mark-command</td>
</tr>
<tr>
<td><code>C-x C-s</code></td><td>save-buffer</td><td><code>C-x h</code></td><td>mark-whole-buffer</td>
</tr>
<tr>
<td><code>C-x C-w</code></td><td>write-file</td><td><code>C-x C-p</code></td><td>mark-page</td>
</tr>
<tr>
<td><code>C-x k</code></td><td>kill-buffer</td><td><code>C-d</code></td><td>delete-char</td>
</tr>
<tr>
<td><code>C-x C-c</code></td><td>kill-emacs</td><td><code>C-b</code></td><td>delete-backward-char</td>
</tr>
<tr>
<th colspan="2" align="left">Cursor Motion</th><td><code>C-k</code></td><td>kill-line</td>
</tr>
<tr>
<td><code>C-f</code></td><td>forward-char</td><td><code>C-w</code></td><td>kill-region</td>
</tr>
<tr>
<td><code>C-b</code></td><td>backward-char</td><td><code>M-w</code></td><td>kill-ring-save</td>
</tr>
<tr>
<td><code>C-n</code></td><td>next-line</td><td><code>C-y</code></td><td>yank</td>
</tr>
<tr>
<td><code>C-p</code></td><td>previous-line</td><th colspan="2" align="left">Search</th>
</tr>
<tr>
<td><code>M-f</code></td><td>forward-char x 5 [*1]</td><td><code>C-s</code></td><td>isearch-forward [*2]</td>
</tr>
<tr>
<td><code>M-b</code></td><td>backward-char x 5 [*1]</td><td><code>C-r</code></td><td>isearch-forward [*2]</td>
</tr>
<tr>
<td><code>M-n</code></td><td>next-line x 5 [*1]</td><th colspan="2" align="left">Undo, Cancel</th>
</tr>
<tr>
<td><code>M-p</code></td><td>previous-line x 5 [*1]</td><td><code>C-/</code></td><td>undo</td>
</tr>
<tr>
<td><code>C-a</code></td><td>move-beginning-of-line</td><td><code>C-x u</code></td><td>undo</td>
</tr>
<tr>
<td><code>C-e</code></td><td>move-end-of-line</td><td><code>C-g</code></td><td>keyboard-quit</td>
</tr>
<tr>
<td><code>C-v</code></td><td>scroll-down</td><th colspan="2" align="left">Others</th>
</tr>
<tr>
<td><code>M-v</code></td><td>scroll-up</td><td><code>C-m</code></td><td>new-line</td>
</tr>
<tr>
<td><code>M-<</code></td><td>beginning-of-buffer</td><td><code>C-i</code></td><td>indent-for-tab-command</td>
</tr>
<tr>
<td><code>M-></code></td><td>end-of-buffer</td><td><code>C-j</code></td><td>new-line</td>
</tr>
<tr>
<th colspan="2" align="left">Input Method Switching</th><td><code>C-o</code></td><td>open-line</td>
</tr>
<tr>
<td><code>C-x C-j</code></td><td>toggle-input-method</td><td><code>C-t</code></td><td>transpose-chars</td>
</tr>
<tr>
<td><code>C-\</code></td><td>toggle-input-method</td><td></td><td></td>
</tr>
<tr>
<th colspan="4" align="left">Microsoft Excel, Google Sheets [*3]</th>
</tr>
<tr>
<td><code>C-c a</code></td><td colspan="3">Activates the selected cell with the cursor at the end (Append) (<code>F2</code>)</td>
</tr>
<tr>
<td><code>C-c i</code></td><td colspan="3">Activates the selected cell with the cursor at the beginning (Insert) (<code>F2 + Home</code>)</td>
</tr>
<tr>
<th colspan="4" align="left">C-q prefix: Temporarily disabling Emacs keybindings[*4]</th>
</tr>
<tr>
<td><code>C-q C-a</code></td><td>(Select All) [*5]</td><td><code>C-q C-n</code></td><td>(New Window) [*6]</td>
</tr>
<tr>
<td><code>C-q C-p</code></td><td>(Print)</td><td></td><td></td>
</tr>
<tr>
<th colspan="4" align="left">C-M keys: Special keys for administration</th>
</tr>
<tr>
<td><code>C-M-q</code></td><td colspan="3">Suspends or resumes the execution of this script</td>
</tr>
<tr>
<td><code>C-M-z</code></td><td colspan="3">Tells whether the implemented keybindings should be enabled or not for the application you are on</td>
</tr>
</table>

\*1. `M-f` and `M-b` move the cursor 5 times instead of moving through words. While `M-n` and `M-p` do not exist in Emacs keybindings, they can be a good middle ground when `C-n` / `C-p` are too slow and `C-v` / `M-v` are too fast for page scrolling.<br/>
\*2. Search is not incremental. Backward search is not implemented, either.<br/>
\*3. Whether the active application is Google Sheets is determined at `IfWinActive` in the `m_IsGoogleSheets()` function. The condition I set is very rough and it returns `true` whenever I am using FireFox or Google Chrome. You may want to modify the code to set a more suitable condition.<br/>
\*4. The idea of using `C-q` to temporarily turn off the tool is from XKeymacs, another keybinding tool I used to use. I have used XKeymacs for so long that it has become almost a reflex to type `C-q C-p` for printing.<br/>
\*5. Personally I use `C-q C-a` with Microsoft Paint, where `C-x h` and `C-x C-p` both do not work.<br/>
\*6. Personally I use `C-q C-n` with Web browsers.

## Usage

Launch AutoHotkey (http://ahkscript.org) and load `MyEmacsKeymap.ahk`. If you have a fresh installation of AutoHotkey, follow the steps below.

1) Create an empty file named `AutoHotkey.ahk` in the installation directory and add the following line to the file:
```ahk
#include %A_ScriptDir%\MyEmacsKeymap.ahk
```
2) Copy `MyEmacsKeymap.ahk` in the same directory

3) Start `AutHotkey.exe`

Note: If you run AutoHotkey without specifying a script file, the program will first look for `AutoHotkey.ahk` in the directory where the AutoHotkey executable resides. The path to this directory is stored in the `A_ScriptDir` built-in variable, and can be referenced as `%A_ScriptDir%`.

Refer to the following link for a tutorial on how to use AutoHotkey:

* AutoHotkey Biginner Tutorial
  * https://autohotkey.com/docs/Tutorial.htm

## Notes

### How to prevent "key slips" when holding down keys

"Key slips" may occur when holding down keys. For example, when holding down `C-f`, the letter `f` may slip and appear on its own in the output, or the original Windows keymap gets incorrectly passed and the search box may pop up. These symptoms can be suppressed by lowering the Repeat Rate of the keyboard in Control Panel.

### How to prevent certain applications from getting affected by this script

Add the `ahk_class` value of such applications to the `m_IgnoreList` list in the `m_IsEnabled` function. The `ahk_class` value of each application can be identified using Window Spy (`AU3_Spy.exe`) that comes with AutoHotkey.

The default ignore list includes `Emacs`, `Vim` (GVim), and `mintty` (Cygwin Terminal).

```ahk
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
```

### How to suspend and resume the execution of this script

`C-M-q` works as a toggle switch to suspend and resume the execution of this script. Pressing `C-M-q` is the same as selecting "Suspend Hotkeys" from the right-click menu in the AutoHotkey task bar icon.

### Sometimes it may not work as expected...

It is a limitation of this script. The porpuse of this script is just to make Windows a little more comfortable to use, not to perfectly emulate Emacs functionality. Also feel free to modify this script as fits your needs.
