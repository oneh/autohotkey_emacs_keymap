# AutoHotkey を使って Windows で Emacs キーバインド

このスクリプト `MyEmacsKeymap.ahk` は、Windows の操作に Emacs キーバインドを割り当てた AutHotkey スクリプトで、私が Windows を快適に操作するために個人的に使用しているものです。

このスクリプトは以下のサイトで公開されているものを参考に、自分用に編集したものです。

* WindowsでEmacs風キーバインド
  * https://github.com/usi3/emacs.ahk
* Windows の操作を emacs のキーバインドで行うための設定（AutoHotKey版）
  * http://www49.atwiki.jp/ntemacs/pages/20.html

## 設定済みのキーバインド

個人的に「これだけあればまあ快適かな」と思える範囲でカバーしています。

<table>
<tr>
<th colspan="2" align="left">バッファとファイル</th><th colspan="2" align="left">選択、削除、コピー・ペースト</th>
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
<th colspan="2" align="left">カーソル移動</th><td><code>C-k</code></td><td>kill-line</td>
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
<td><code>C-p</code></td><td>previous-line</td><th colspan="2" align="left">検索</th>
</tr>
<tr>
<td><code>M-f</code></td><td>forward-char x 5 [*1]</td><td><code>C-s</code></td><td>isearch-forward [*2]</td>
</tr>
<tr>
<td><code>M-b</code></td><td>backward-char x 5 [*1]</td><td><code>C-r</code></td><td>isearch-forward [*2]</td>
</tr>
<tr>
<td><code>M-n</code></td><td>next-line x 5 [*1]</td><th colspan="2" align="left">アンドゥ、キャンセル</th>
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
<td><code>C-v</code></td><td>scroll-down</td><th colspan="2" align="left">その他</th>
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
<th colspan="2" align="left">言語入力システム切替</th><td><code>C-o</code></td><td>open-line</td>
</tr>
<tr>
<td><code>C-x C-j</code></td><td>toggle-input-method</td><td><code>C-t</code></td><td>transpose-chars</td>
</tr>
<tr>
<td><code>C-\</code></td><td>toggle-input-method</td><td></td><td></td>
</tr>
<tr>
<th colspan="4" align="left">Microsoft Excel、Google スプレッドシート[*3]</th>
</tr>
<tr>
<td><code>C-c a</code></td><td colspan="3">選択されたセルを活性化しカーソルを最後に移す (Append) (<code>F2</code>)</td>
</tr>
<tr>
<td><code>C-c i</code></td><td colspan="3">選択されたセルを活性化しカーソルを最初に移す (Insert) (<code>F2 + Home</code>)</td>
</tr>
<tr>
<th colspan="4" align="left">C-q プレフィックス: 一時的に Emacs キーバインディングを無効化[*4]</th>
</tr>
<tr>
<td><code>C-q C-a</code></td><td>(すべて選択) [*5]</td><td><code>C-q C-n</code></td><td>(新規ウィンドウ) [*6]</td>
</tr>
<tr>
<td><code>C-q C-p</code></td><td>(印刷)</td><td></td><td></td>
</tr>
<tr>
<th colspan="4" align="left">C-M キー: 管理用キー</th>
</tr>
<tr>
<td><code>C-M-q</code></td><td colspan="3">スクリプト実行の停止と再開の切替</td>
</tr>
<tr>
<td><code>C-M-z</code></td><td colspan="3">フォーカスされているアプリケーションでキーバインドが有効化されるかどうかの確認</td>
</tr>
</table>

\*1. 単語単位ではなく5回分移動します。例えば `M-f`、`M-b` はカーソルを5回移動します。`M-n`、`M-p` は Emacs のキーバインドには存在しませんが、Web ブラウジングをするときなどに、ページ単位だと進みすぎるが1回のスクロールでは遅すぎるといった場合に便利です。<br/>
\*2. 検索はインクリメンタルではありません。後方検索もなしです。<br/>
\*3. 操作対象が Google スプレッドシートかどうかの判断は `m_IsGoogleSheets()` 関数の `IfWinActive` で行っています。私の場合、大雑把に FireFox か Google Chrome であれば `true` としていますが、より適切な判断をしたい場合はスクリプトを編集してください。<br/>
\*4. `C-q` でツールを一時的に無効にするのは、かつて使用していた XKeymacs に慣らったものです。私は XKaymecs を長年使用していたため、印刷する時に `C-q C-p` と打つのが体に染み付いています。<br/>
\*5. 私の場合、Microsoft Paint では `C-x h` や `C-x C-p` が効かないため替わりにこれを使用することがあります。<br/>
\*6. 私の場合、Web ブラウザでこれを使用することがあります。

## 使い方

AutoHotkey (http://ahkscript.org) を起動して、このスクリプト `MyEmacsKeymap.ahk` をロードします。AutoHotkey を新規インストールした場合、次の手順で使うことができます。

1) インストールディレクトリに `AutoHotkey.ahk` の名前で空のファイルを作成し、次の行を追加します:
```ahk
#include %A_ScriptDir%\MyEmacsKeymap.ahk
```
2) `MyEmacsKeymap.ahk` を同ディレクトリにコピーします。

3) `AutHotkey.exe` を実行します。

補足: AutoHotkey をスクリプトファイルを指定せずに実行した場合、プログラムは最初に AutoHotkey の実行ファイルが置かれているディレクトリの `AutoHotkey.ahk` を探します。このディレクトリは `A_ScriptDir` ビルトイン変数に保持されており、`%A_ScriptDir%` で参照できます。

* AutoHotkey Biginner Tutorial
  * https://autohotkey.com/docs/Tutorial.htm
* AutoHotkey Wiki (日本語) - 使用方法
  * http://ahkwiki.net/Usage

## 使用上の注意

### キーを押し続けた時にキーが slip する

環境によってはキーを押し続けたときにキーが slip してしまうかもしれません。例えば `C-f` を押し続けたときに、`f` が単独で出力されたり、オリジナルのキーマップで判定されて検索ボックスが表示されたりします。この現象は、Windows コントロールパネルでキーボードの「表示の間隔（Repeat Rate）」を遅くすることで抑制することが可能です。

ちなみに、AutoHotkey の `SendMode` の指定を変更することで現象を抑制できないか試したのですが、私が試した範囲では完全な対策にはなりませんでした。

### 特定のアプリケーションを操作対象から除外したい

`m_IsEnabled` 関数の `m_IgnoreList` に、除外したいアプリケーションの `ahk_class` を追加してください。各アプリケーションにおける `ahk_class` の値は AutoHotkey 付属の Window Spy (`AU3_Spy.exe`) を使用して特定することができます。

デフォルトでは、`Emacs`、`Vim` (GVim)、`mintty` (Cygwin Terminal) が操作対象から除外されています。

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
### スクリプト実行を一時的に停止したい

`C-M-q` がスクリプト実行の停止と再開を制御するスイッチとして働きます。これはタスクバーの AutoHotkey アイコンで右クリックメニューから "Suspend Hotkeys" を選択するのと同じ働きをします。

### 一部のアプリケーションで期待通りに動作しないキーがある

個人的には、これはそういうものだと割り切って使用しています。ニーズに合わせてスクリプトは自由に編集してください。
