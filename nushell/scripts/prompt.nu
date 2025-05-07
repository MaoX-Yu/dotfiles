def is-windows [] {
    $nu.os-info.name =~ 'windows'
}

def get-git-status [] {
    let output = gstat

    let branch_name = $output | get branch

    let status = $output
        | reject repo_name tag branch remote
        | rename '+' '+~' '+-' '+»' '+t' '?' '~' '-' 't' '»' '!' 'c' '↑' '↓' '$'
        | transpose key value
        | where { |it| $it.value > 0 }
        | each {
            |it| insert color {
                match $it.key {
                    '+' | '+~' | '+»' | '+t' => '#a6da95'
                    '+-' | '-' | 'c' => '#ed8796'
                    '!' => '#939ab7'
                    _ => '#eed49f'
                }
            }
        }
        | each {|it| $'(ansi $it.color)($it.key)($it.value)(ansi reset)' }
        | str join ' '

    let status = match $status {
        '' => ''
        _ => $":\(($status)(ansi '#f5bde6')\)"
    }

    let result = $' ($branch_name)($status)'

    match ($output | get branch) {
        '' | 'no_branch' => ''
        _ => $' ($result)'
    }
}

def get-pwd [] {
    let path = pwd
        | if (is-windows) { split row '\' } else { split row '/' }
        | where $it != ''
    let home = if (is-windows) {
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
                                $'($part | str substring 0..1)'
                            } else {
                                $'($part | str substring 0..0)'
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
                        $'($part | str substring 0..1)'
                    } else {
                        $'($part | str substring 0..0)'
                    }
                }
                | str join '/'
            $'/($parent)/($path | last)'
        }
    } else {
        if (is-windows) { $'/($path | get 0 | str replace ":" "")' } else { pwd }
    }
}

$env.PROMPT_COMMAND = {
    let user = if (is-windows) { $env.USERNAME } else { $env.USER }

    let exit_sign = if ($env.LAST_EXIT_CODE == 0) {
        $' (ansi '#a6da95') '
    } else {
        $' (ansi '#ed8796') '
    }

    let current_path = get-pwd

    let cmd_durarion = if ($env.CMD_DURATION_MS | into int) > 0 {
        ' ' ++ ($'($env.CMD_DURATION_MS)ms' | into duration | into string)
    } else { '' }

    let git_status = get-git-status

    $'(ansi '#eed49f')($user)(ansi reset) in (ansi '#91d7e3')($current_path)(ansi '#f5bde6')($git_status)(ansi '#939ab7')($cmd_durarion)($exit_sign)(ansi reset)'
}

$env.PROMPT_COMMAND_RIGHT = { date now | format date "%H:%M:%S" }

$env.PROMPT_INDICATOR = ''
$env.PROMPT_INDICATOR_VI_INSERT = ''
$env.PROMPT_INDICATOR_VI_NORMAL = ''
$env.PROMPT_MULTILINE_INDICATOR = ''
