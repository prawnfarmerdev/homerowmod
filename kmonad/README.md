# Homerow Mod KMonad Configurations

This directory contains KMonad configuration files for Homerow Mods, suitable for practicing Emacs.

## Files

- `windows.kbd` - Configuration for Windows
- `linux.kbd` - Configuration for Linux (using uinput)

## Layout

The configuration uses the **GACS** order (GUI, Alt, Control, Shift) on the left hand, mirrored on the right hand:

| Left hand | Key | Modifier |
|-----------|-----|----------|
| Pinky     | A   | GUI (Meta) |
| Ring      | S   | Alt       |
| Middle    | D   | Control   |
| Index     | F   | Shift     |

| Right hand | Key | Modifier |
|------------|-----|----------|
| Index      | J   | Shift    |
| Middle     | K   | Control  |
| Ring       | L   | Alt      |
| Pinky      | ;   | GUI (Meta) |

Home row keys `G` and `H` are left unmodified.

## Tapping Term

The tapping term is set to **200ms**. This means:
- Press and release a home row key within 200ms to type the letter.
- Hold the key longer than 200ms to activate the modifier.

## Usage

### Install KMonad

First, install KMonad for your operating system:

- **Linux**: Follow instructions at [KMonad installation](https://github.com/kmonad/kmonad/blob/master/doc/installation.md)
- **Windows**: Download the binary from [releases](https://github.com/kmonad/kmonad/releases)
- **macOS**: Use Homebrew or compile from source

### Running KMonad

#### Windows

Open a terminal in this directory and run:

```bash
kmonad windows.kbd
```

#### Linux

You may need to grant permissions for uinput. One approach is to add your user to the `input` group and create a udev rule.

Alternatively, you can use a device file. Edit `linux.kbd` to comment out the `uinput-sink` line and uncomment the `device-file` line, then replace the path with your keyboard's device path (found in `/dev/input/by-id/`).

Run:

```bash
kmonad linux.kbd
```

## Sway Configuration

If you use sway, the default configuration may have `caps:ctrl_modifier` which remaps Caps Lock to Control. This conflicts with KMonad's Caps Lock layer toggle.

We've already removed this line from your sway config (`~/.config/sway/config`). To apply the change:

```bash
swaymsg reload
```

Or log out and back in.

## Systemd Service (Autostart)

To run KMonad automatically on startup using systemd:

1. **Run the setup script** (after logging out/in for group changes):
   ```bash
   ./setup-linux.sh
   ```

2. **Enable and start the service**:
   ```bash
   ./manage-service.sh enable-now
   ```
   Or manually:
   ```bash
   systemctl --user enable --now kmonad-homerow.service
   ```

3. **Check status**:
   ```bash
   ./manage-service.sh status
   ```

The service will automatically start on login and restart if it fails.

**Service management commands**:
- `./manage-service.sh start` - Start service
- `./manage-service.sh stop` - Stop service  
- `./manage-service.sh restart` - Restart service
- `./manage-service.sh disable` - Disable autostart

**Note**: The service waits 3 seconds after graphical session starts to ensure sway is ready.

## Customization

- To change the tapping term, edit the `200` value in each `tap-hold-next-release` line.
- To change the modifier order, adjust the aliases accordingly.
- To include more keys in the configuration, add them to `defsrc` and `deflayer`.

## Gaming Layer

The configuration includes a gaming layer that disables home row mods for gaming:

- **Caps Lock key**: Tap for Caps Lock, hold for 200ms to toggle between homerowmods and gaming layers.
- **Gaming layer**: Home row keys A, S, D, F, J, K, L, ; revert to normal letters (no modifiers when held).
- **Other keys**: ESC, Tab, Enter, G, H remain unchanged.

To switch to gaming layer:
1. Hold Caps Lock for >200ms (until you feel/hear the layer switch).
2. The home row keys now act as normal letters.
3. To switch back, hold Caps Lock again for >200ms.

## Emacs Tips

With this homerow mod setup:

- **Ctrl** is under your left middle finger (D) and right middle finger (K).
- **Alt** is under your left ring finger (S) and right ring finger (L).
- **Shift** is under your left index finger (F) and right index finger (J).
- **Super** (GUI) is under your left pinky (A) and right pinky (;).

Common Emacs shortcuts:

- `C-x` = hold D (or K) while tapping X
- `M-x` = hold S (or L) while tapping X
- `C-M-f` = hold D and S together (adjacent fingers)
- `C-x C-s` = hold D, tap X, tap S (while still holding D)

Practice by typing normally; the modifiers will activate only when you hold the keys longer.

## Troubleshooting

- If modifiers activate accidentally, increase the tapping term (e.g., to 250).
- If modifiers are too slow to activate, decrease the tapping term (e.g., to 150).
- On Linux, if uinput fails, check permissions or use device-file method.
- Ensure your system keyboard layout is set to US QWERTY (the keycodes are based on that).

## References

- [A guide to home row mods](https://precondition.github.io/home-row-mods)
- [KMonad documentation](https://github.com/kmonad/kmonad)
- [KMonad configuration tutorial](https://github.com/kmonad/kmonad/blob/master/keymap/tutorial.kbd)