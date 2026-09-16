function __jump_track_pwd --on-variable PWD
    # Run silently in the background so it never blocks your terminal
    jump add >/dev/null 2>&1 &
end
