function __fish_jbe_bin_needs_command
    set cmd (commandline -opc)
    if test (count $cmd) -eq 1
        return 0
    end
    return 1
end

function __fish_jbe_bin_using_command
    set -l cmd (commandline -opc)
    set -l subcmd $argv[1]
    if test (count $cmd) -gt 1
        if test $cmd[2] = $subcmd
            return 0
        end
    end
    return 1
end

function __fish_jbe_bin_get_script_files
    for file in $HOME/conf/global/bin/*
        if test -f $file
            echo (basename $file)
        end
    end
end

complete -f -c jbe-bin -n '__fish_jbe_bin_needs_command' -a 'list' -d 'List scripts'
complete -f -c jbe-bin -n '__fish_jbe_bin_needs_command' -a 'add' -d 'Add a new script'
complete -f -c jbe-bin -n '__fish_jbe_bin_needs_command' -a 'edit' -d 'Edit an existing script'
complete -f -c jbe-bin -n '__fish_jbe_bin_needs_command' -a 'rm' -d 'Remove a script'
complete -f -c jbe-bin -n '__fish_jbe_bin_needs_command' -a 'rename' -d 'Rename a script'
complete -f -c jbe-bin -n '__fish_jbe_bin_needs_command' -a 'usage' -d 'Display usage information'

complete -f -c jbe-bin -n '__fish_jbe_bin_using_command edit' -a '(__fish_jbe_bin_get_script_files)' # -d 'Script name'
complete -f -c jbe-bin -n '__fish_jbe_bin_using_command rm' -a '(__fish_jbe_bin_get_script_files)' # -d 'Script name'
complete -f -c jbe-bin -n '__fish_jbe_bin_using_command rename' -a '(__fish_jbe_bin_get_script_files)' # -d 'Old script name'


