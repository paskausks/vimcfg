require'telescope'.setup{
  defaults = {
      file_ignore_patterns = {
          -- godot
          "^src\\addons\\gdUnit4",
          "^addons/gdUnit4",
          ".tscn$",
          --".tres$",
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
