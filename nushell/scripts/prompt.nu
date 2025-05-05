def get_git_info [] {
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

    let branch_icon = match ($output | get branch) {
        '' | 'no_branch' => ''
        _ => ''
    }

    let result = $'($branch_icon) ($branch_name)($status)'

    match ($output | get branch) {
        '' | 'no_branch' => ''
        _ => $' ($result)'
    }
}

def last_dir [] {
    if $env.PWD == $env.HOME {
        '~'
    } else {
        $env.PWD | path split | last
    }
}

$env.PROMPT_COMMAND = {||
    let exit_sign = if ($env.LAST_EXIT_CODE == 0) {
        $' (ansi '#a6da95') '
    } else {
        $' (ansi '#ed8796') '
    }

    let current_path = last_dir

    let cmd_durarion = if ($env.CMD_DURATION_MS | into int) > 0 {
        ' ' ++ ($'($env.CMD_DURATION_MS)ms' | into duration | into string)
    } else { '' }

    let git_info = get_git_info

    $'(ansi '#91d7e3')($current_path)(ansi '#f5bde6')($git_info)(ansi '#939ab7')($cmd_durarion)($exit_sign)(ansi reset)'
}

$env.PROMPT_COMMAND_RIGHT = ''

$env.PROMPT_INDICATOR = ''
$env.PROMPT_INDICATOR_VI_INSERT = ''
$env.PROMPT_INDICATOR_VI_NORMAL = ''
$env.PROMPT_MULTILINE_INDICATOR = ''
