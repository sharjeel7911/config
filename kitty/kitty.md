Here is a clean, organized reference sheet for Kitty keyboard shortcuts, grouped by workflow.

```
                  _  ___ _   _ _   _ 
                 | |/ (_) |_| |_| |
                 | ' /| |  _|  _|_|
                 |_|\_|_|\__|\__|  

          K I T T Y   C H E A T   S H E E T
/home/shar/Screenshots/Screenshot From 2026-09-13 11-02-58.png
```

---

### Window Management (Splits)

| Action | Linux / BSD | macOS |
| --- | --- | --- |
| **New window (split)** | `Ctrl + Shift + Enter` | `Cmd + Enter` |
| **Close window** | `Ctrl + Shift + W` | `Shift + Cmd + D` |
| **Next window** | `Ctrl + Shift + ]` | `Cmd + ]` |
| **Previous window** | `Ctrl + Shift + [` | `Cmd + [` |
| **Move window forward** | `Ctrl + Shift + F` | `Cmd + F` |
| **Move window backward** | `Ctrl + Shift + B` | `Cmd + B` |
| **Focus specific window** | `Ctrl + Shift + 1` … `9` | `Cmd + 1` … `9` |
| **Switch layout** | `Ctrl + Shift + L` | `Cmd + L` |
| **New OS window** | `Ctrl + Shift + N` | `Cmd + N` |

---

### Tab Management

| Action | Linux / BSD | macOS |
| --- | --- | --- |
| **New tab** | `Ctrl + Shift + T` | `Cmd + T` |
| **Close tab** | `Ctrl + Shift + Q` | `Cmd + W` |
| **Next tab** | `Ctrl + Shift + Right` | `Ctrl + Tab` / `Shift + Cmd + ]` |
| **Previous tab** | `Ctrl + Shift + Left` | `Shift + Ctrl + Tab` / `Shift + Cmd + [` |
| **Move tab forward** | `Ctrl + Shift + .` | `Ctrl + Shift + .` |
| **Move tab backward** | `Ctrl + Shift + ,` | `Ctrl + Shift + ,` |
| **Set tab title** | `Ctrl + Shift + Alt + T` | `Shift + Cmd + I` |

---

### Clipboard & Selection

| Action | Linux / BSD | macOS |
| --- | --- | --- |
| **Copy** | `Ctrl + Shift + C` | `Cmd + C` |
| **Paste** | `Ctrl + Shift + V` | `Cmd + V` |
| **Paste from selection** | `Ctrl + Shift + S` | `Cmd + S` |
| **Pass selection to program** | `Ctrl + Shift + O` | `Cmd + O` |

---

### Font & Layout Controls

| Action | Shortcut |
| --- | --- |
| **Increase font size** | `Ctrl + Shift + Equal` (`+`) |
| **Decrease font size** | `Ctrl + Shift + Minus` (`-`) |
| **Reset font size** | `Ctrl + Shift + Backspace` |
| **Toggle fullscreen** | `Ctrl + Shift + F11` |
| **Toggle maximized** | `Ctrl + Shift + F10` |

---

### Navigation & Scrollback

| Action | Shortcut |
| --- | --- |
| **Scroll line up / down** | `Ctrl + Shift + Up` / `Down` |
| **Scroll page up / down** | `Ctrl + Shift + PageUp` / `PageDown` |
| **Jump to top / bottom** | `Ctrl + Shift + Home` / `End` |
| **Previous / next prompt** | `Ctrl + Shift + Z` / `X` |
| **Browse scrollback in pager** | `Ctrl + Shift + H` |
| **Open URL under cursor** | `Ctrl + Shift + E` |

---

### Configuration & Utilities

| Action | Shortcut |
| --- | --- |
| **Edit `kitty.conf**` | `Ctrl + Shift + F2` |
| **Reload configuration** | `Ctrl + Shift + F5` |
| **Debug configuration** | `Ctrl + Shift + F6` |
| **Open Kitty shell** | `Ctrl + Shift + Escape` |
| **Clear terminal** | `Ctrl + Shift + Delete` |

---

### Custom Mappings Tip

You can add or override any shortcut by editing `~/.config/kitty/kitty.conf`:

```conf
# Example: Use Alt+Enter for split, Alt+h/j/k/l for navigation
map alt+enter new_window
map alt+left  neighboring_window left
map alt+right neighboring_window right
map alt+up    neighboring_window up
map alt+down  neighboring_window down

```
