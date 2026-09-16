function j
    set --local dir (jump query $argv)
    or return $status

    if test -n "$dir"
        cd -- "$dir"
    end
end
