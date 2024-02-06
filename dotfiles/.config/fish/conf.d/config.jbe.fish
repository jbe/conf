source $HOME/conf/global/envir/load

set local_override_path "$HOME/conf/local/$(hostname)/envir"

if test -f "$local_override_path"
    source "$local_override_path"
end