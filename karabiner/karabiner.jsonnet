// Karabiner-Elements rules for the MacBook built-in keyboard.
// install.sh renders this file with jsonnet and writes the rules into
// ~/.config/karabiner/karabiner.json (selected profile).

local conditions = [
  {
    type: "device_if",
    identifiers: [
      {
        is_built_in_keyboard: true
      }
    ]
  }
];

local from(code) = {
  key_code: code,
  modifiers: {
    optional: [
      "any"
    ]
  }
};

local to(code) = [
  if std.startsWith(code, "s_") then {
    key_code: std.substr(code, 2, std.length(code)),
    modifiers: [ "left_shift" ]
  } else if std.startsWith(code, "c_") then {
    key_code: std.substr(code, 2, std.length(code)),
    modifiers: [ "left_control" ]
  } else {
    key_code: code
  }
];

local base(from_code, to_code) = {
  type: "basic",
  from: from(from_code),
  to: to(to_code),
  conditions: conditions
};

local layer_key(code) = {
  type: "basic",
  from: from(code),
  to: [
    {
      set_variable: {
        name: "layer_val_" + code,
        value: 1
      },
    }
  ],
  to_if_alone: to(code),
  to_after_key_up: [
    {
      set_variable: {
        name: "layer_val_" + code,
        value: 0
      },
    }
  ],
  conditions: conditions
};

local layer(from_code, to_code, layer_code) = {
  type: "basic",
  from: from(from_code),
  to: to(to_code),
  conditions: conditions + [
    {
      type: "variable_if",
      name: "layer_val_" + layer_code,
      value: 1
    }
  ]
};

local combo(from_code1, from_code2, to_code) = {
  type: "basic",
  from: {
    simultaneous: [
      {
        key_code: from_code1
      },
      {
        key_code: from_code2
      }
    ],
    modifiers: {
      optional: [
        "any"
      ]
    }
  },
  to: to(to_code)
};

{
  title: "MacBookPro Built-in Keyboard",
  rules: [
    {
      description: "Base Layer",
      manipulators: [
        base("caps_lock", "left_control"),
      ]
    },
    {
      description: "Space Layer",
      local l(from_code, to_code) = layer(from_code, to_code, "spacebar"),
      manipulators: [
        layer_key("spacebar"),
        l("tab", "escape"),
        l("q", "1"),
        l("w", "2"),
        l("e", "3"),
        l("r", "4"),
        l("t", "5"),
        l("y", "6"),
        l("u", "7"),
        l("i", "8"),
        l("o", "9"),
        l("p", "0"),
        l("a", "open_bracket"),
        l("s", "close_bracket"),
        l("d", "lang2"),
        l("f", "lang1"),
        l("h", "left_arrow"),
        l("j", "down_arrow"),
        l("k", "up_arrow"),
        l("l", "right_arrow"),
        l("semicolon", "backslash"),
        l("quote", "grave_accent_and_tilde"),
        l("z", "open_bracket"),
        l("x", "close_bracket"),
        l("c", "hyphen"),
        l("v", "equal_sign"),
        // l("b", ""),
        l("n", "s_hyphen"),
        l("m", "s_equal_sign"),
        l("comma", "s_open_bracket"),
        l("period", "s_close_bracket"),
        l("slash", "s_backslash"),
        l("right_shift", "s_grave_accent_and_tilde"),
      ]
    },
    {
      description: "Tab Layer",
      local l(from_code, to_code) = layer(from_code, to_code, "tab"),
      manipulators: [
        layer_key("tab"),
        l("q", "f1"),
        l("w", "f2"),
        l("e", "f3"),
        l("r", "f4"),
        l("t", "f5"),
        l("y", "f6"),
        l("u", "f7"),
        l("i", "f8"),
        l("o", "f9"),
        l("p", "f10"),
      ]
    }
  ]
}
