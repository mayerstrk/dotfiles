function tscopen
    set files (tsc --pretty false 2>&1 | grep -oE "^[^(]+" | sort -u)
    
    if test -n "$files"
        nvim $files
    else
        echo "No errors found"
    end
end
