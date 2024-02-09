## Config
- `karabiner.json` is reloaded automatically
- See logs in Karabiner Elements > Logs

## Mappings overview

1. Native mappings *not used* (Settings > Keyboard > Keyboard Shortcuts)
```
Caplock -> Capslock
Control -> Control
Option -> Option
Command -> Command
Globe -> Globe
```

2. Karabiner Elements (karabiner.json)
```
Order:
1. Catch events from hardware.
2. Apply Simple Modifications.
3. Apply Complex Modifications.
4. Apply Function Keys Modifications. (change f1…f12 keys to media controls)
5. Post events to applications via a virtual keyboard.
```

2.1. Simple Modifications```
fn -> left_control
left_control -> fn
caps_lock -> vk_none
grave_accent_and_tilde (`) -> non_us_backslash
non_us_backslash -> grave_accent_and_tilde (`)
```

2.2. Complex Modifications

- Order is important, first defined consumes the event first, therefore put more concrete at top.
- Map modifiers as modifiers and not `key_code`, instead use `"any": "key_code"` for blanket mapping.
	- This doesn't work, just **explicitly list all** you need, most control, clearest, even though cumbersome.
  - Or maybe using `to_if_alone` works?
