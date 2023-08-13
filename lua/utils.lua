function is_windows()
    return string.lower(jit.os) == "windows"
end

return {
    is_windows = is_windows
}
