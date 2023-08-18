require'telescope'.setup{
  defaults = {
      file_ignore_patterns = {
          -- godot
          "^src\\addons\\",
          ".tscn$",
          ".tres$",
          ".stylebox$",
          ".import$",
          ".theme$",

          -- images
          ".png$",
          ".psd$",
          ".pdf$",
          ".jpg$",
          ".ocf$",

          -- audio
          ".ogg$",
          ".wav$",
          ".mp3$",

          -- video
          ".webm$",

          -- misc
          ".zip$",
          ".otf$",
          ".ttf$",
      },
      path_display = {
          truncate = 3,
      }
  },
}
