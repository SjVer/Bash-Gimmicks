# shortens the dir part of the prompt when very deep

export DIRDEPTH=4
prompter() {
	# oldprompt="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] "
	realdir=`pwd`
	dir=${realdir//$HOME/\~}
	arrdirs=(${dir//\// })
	len=${#arrdirs[@]}

	if (($len > ($DIRDEPTH + 1))); then
		resultarr=${arrdirs[@]:(len-$DIRDEPTH):len}
		result="../${resultarr// /\/}"
	else
		result=$dir
	fi

	oldprompt="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]${result} \$\[\033[00m\] "
	export PS1=$oldprompt
}
PROMPT_COMMAND=prompter
