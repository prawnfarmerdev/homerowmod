# Sway Configuration for Homerow Mods

This directory contains Sway configuration changes needed for KMonad Homerow Mods compatibility.

## Changes Made

### 1. Removed `caps:ctrl_modifier`
**File**: `~/.config/sway/config`  
**Change**: Removed the line `xkb_options caps:ctrl_modifier` from the `input type:keyboard` section.

**Before**:
```bash
input type:keyboard {
    xkb_options caps:ctrl_modifier
}
```

**After**:
```bash
input type:keyboard {
}
```

**Reason**: KMonad uses Caps Lock as a layer toggle key (tap for Caps Lock, hold for gaming layer). The `caps:ctrl_modifier` option remaps Caps Lock to Control when held, which conflicts with KMonad's functionality.

### 2. Removed KMonad exec line (optional)
**File**: `~/.config/sway/config`  
**Change**: Removed the line that starts KMonad from sway's autostart section.

**Before**:
```bash
# Start KMonad for Homerow Mods (try systemd first, fallback to direct)
exec systemctl --user start kmonad-homerow.service 2>/dev/null || sleep 2 && /usr/sbin/kmonad /home/okra/projects/homerowmod/kmonad/linux.kbd
```

**After**: Line removed.

**Reason**: KMonad is now managed by systemd user service (`kmonad-homerow.service`) which starts automatically on login. This avoids dual startup issues and provides better service management.

## Applying Changes

1. **Manual edit**: Edit `~/.config/sway/config` and make the changes above.
2. **Using patch**: Apply the provided patch file.
3. **Replace config**: Copy `config.example` to `~/.config/sway/config` (backup your original first).

After making changes, reload sway:
```bash
swaymsg reload
```

Or log out and back in.

## Files

- `config.example` - Example sway config with KMonad compatibility changes
- `README.md` - This documentation
- `sway-config.patch` - Patch file for applying changes (if needed)

## Notes

- These changes are only needed if you use sway as your window manager.
- The changes are minimal and only affect Caps Lock behavior and KMonad startup.
- All other sway configuration remains unchanged.