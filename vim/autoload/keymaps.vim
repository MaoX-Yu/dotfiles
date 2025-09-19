vim9script

export def SmartBracket(char: string): string
    const current_line = getline('.')
    const col_pos = col('.') - 1
    const char_after = current_line[col_pos : col_pos]
    const special_chars = ["'", '"', '`']

    if char == char_after
        return "\<right>"
    endif

    if index(special_chars, char) != -1
        return char .. char .. "\<left>"
    else
        return char
    endif
enddef
