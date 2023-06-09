# extend cd a bit with history:
function cd () 
{ 
    local hnum=16;
    local new_dir index dir cnt;
    if ! [ $# -eq 0 ]; then
        if [[ $# -eq 2 && $1 = "--" ]]; then
            shift;
        else
            if ! { 
                [ $# -eq 1 ] && [[ $1 =~ ^(-[0-9]{,2}|-|--|[^-].*)$ ]]
            }; then
                builtin cd "$@";
                return;
            fi;
        fi;
    fi;
    [ "$1" = "--" ] && { 
        dirs -v;
        return
    };
    new_dir=${1:-$HOME};
    if [[ "$new_dir" =~ ^-[0-9]{,2}$ ]]; then
        index=${new_dir:1};
        if [ -z "$index" ]; then
            new_dir=$OLDPWD;
        else
            new_dir=$(dirs -l +$index) || return;
        fi;
    fi;
    pushd -- "$new_dir" > /dev/null || return;
    popd -n +$hnum &> /dev/null || true;
    new_dir=$PWD cnt=1;
    while dir=$(dirs -l +$cnt 2> /dev/null); do
        if [ "$dir" = "$new_dir" ]; then
            popd -n +$cnt > /dev/null;
            continue;
        fi;
        let cnt++;
    done


	if [ "$LS_ON_CD" == "true" ]; then
		ls
	fi
}
