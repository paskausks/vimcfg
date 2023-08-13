require'telescope'.setup{
  defaults = {
      file_ignore_patterns = {
          "^src\\addons\\", -- godot addons
          ".tscn$",
          ".tres$",
          ".stylebox$",
          ".import$",
          ".theme$",
          ".png$",
          ".psd$",
          ".jpg$",
          ".webm$",
          ".ogg$",
          ".wav$",
          ".mp3$",
          ".ttf$",
          ".ocf$",
          ".zip$",
      },
      path_display = {
          truncate = 3,
      }
  },
}
