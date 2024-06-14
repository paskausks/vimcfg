require'telescope'.setup{
  defaults = {
      file_ignore_patterns = {
          -- godot
          "^src\\addons\\gdUnit4",
          "^addons/gdUnit4",
          ".stylebox$",
          ".import$",
          ".theme$",
          ".material$",

          -- images
          ".png$",
          ".psd$",
          ".pdf$",
          ".jpg$",
          ".ocf$",
          ".ico$",
          ".kra$",

          -- audio
          ".ogg$",
          ".wav$",
          ".mp3$",

          -- video
          ".webm$",
          ".ogv$",
          ".aep$",

          -- misc
          ".bin$",
          ".mo$",
          ".xls$",
          ".zip$",
          ".otf$",
          ".ttf$",
          ".tmp$",
          "~$",
      },
      path_display = {
          truncate = 3,
      }
  },
}
