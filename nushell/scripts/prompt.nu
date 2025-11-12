def windows? [] {
    $nu.os-info.name =~ 'windows'
}

def get-git-status [] {
    let output = gstat

    let branch_name = $output | get branch

    let status = $output
        | reject repo_name tag branch remote state
        | rename '+' '+~' '+-' '+»' '+t' '?' '~' '-' 't' '»' '!' 'c' '↑' '↓' '$'
        | transpose key value
        | where { |it| $it.value > 0 }
        | each {
            |it| insert color {
                match $it.key {
                    '+' | '+~' | '+»' | '+t' => 'green'
                    '+-' | '-' | 'c' => 'red'
                    '!' => 'light_gray'
                    _ => 'yellow'
                }
            }
        }
        | each {|it| $'(ansi $it.color)($it.key)($it.value)(ansi reset)' }
        | str join ' '

    let status = match $status {
        '' => ''
        _ => $":\(($status)(ansi purple)\)"
    }

    let result = $' ($branch_name)($status)'

    match ($output | get branch) {
        '' | 'no_branch' => ''
        _ => $' ($result)'
    }
}

def get-pwd [] {
    let path = pwd
        | if (windows?) { split row '\' } else { split row '/' }
        | where $it != ''
    let home = if (windows?) {
        [$env.HOMEDRIVE $env.HOMEPATH] | path join | split row '\'
    } else {
        $env.HOME | split row '/'
    }

    if ($path | length) > 1 {
        if ($home | all {|it| $it in $path }) {
            let path_without_home = $path | skip ($home | length)
            if ($path_without_home | wrap path | compact | length) > 0 {
                let parent = $path | skip ($home | length) | drop
                if ($parent | wrap parent | compact | length) > 0 {
                    let short_part = $parent
                        | each { |part|
                            if ($part | str starts-with '.') {
                                $'($part | str substring -g 0..1)'
                            } else {
                                $'($part | str substring -g 0..0)'
                            }
                        }
                        | str join '/'
                    $'~/($short_part)/($path | last)'
                } else {
                    $'~/($path | last)'
                }
            } else {
                '~'
            }
        } else {
            let parent = $path
                | drop
                | each { |part|
                    if ($part | str starts-with '.') {
                        $'($part | str substring -g 0..1)'
                    } else {
                        $'($part | str substring -g 0..0)'
                    }
                }
                | str join '/'
            $'/($parent)/($path | last)'
        }
    } else {
        if (windows?) { $'/($path | get 0 | str replace ":" "")' } else { pwd }
    }
}

$env.PROMPT_COMMAND = {
    let current_path = get-pwd

    let git_status = get-git-status

    let cmd_durarion = if ($env.CMD_DURATION_MS | into int) > 0 {
        ' ' ++ ($'($env.CMD_DURATION_MS)ms' | into duration | into string)
    } else { '' }

    $'(ansi cyan)($current_path)(ansi purple)($git_status)(ansi dark_gray)($cmd_durarion)(ansi reset) '
}

$env.PROMPT_COMMAND_RIGHT = {
    let exit_code = if ($env.LAST_EXIT_CODE != 0) {
        $'(ansi red)($env.LAST_EXIT_CODE)(ansi reset) '
    } else { '' }

    let now = date now | format date "%H:%M:%S"

    $'($exit_code)(ansi purple)($now)(ansi reset)'
}

$env.PROMPT_INDICATOR = ' '
$env.PROMPT_INDICATOR_VI_INSERT = ' '
$env.PROMPT_INDICATOR_VI_NORMAL = '$ '
$env.PROMPT_MULTILINE_INDICATOR = ': '
