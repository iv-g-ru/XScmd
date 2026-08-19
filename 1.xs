pr[hello,_from_XS-cmd!]
pr[write_help_or_?_for_help]

var[com]
var[err]

:::loop
	
	pr[]
	pr[write_command:]
	in[com]
	
	ifdo[=com:?help|help]
	ifdo[=com:??|help]
	ifdo[=com:?exit|exit]
	ifdo[=com:?calc|calc]
	ifdo[=com:?sys|sys]
	ifdo[=com:?file|file]
	
	::add loopbody
	
    go[loop]

::add commands

::nc help
	
	pr[HELP!]
	pr[commands:]
	pr[for_help:_help_or_?]
	pr[for_exit:_exit]
	pr[for_calculator:_calc]
	pr[for_do_comand_in_system:_sys]
	pr[for_work_with_file:_file]
	::add help
	
::end

::nc exit
	
	pr[exit?_(+_for_exit)]
	in[com]
	if[=com:?+]
		::exit
	
::end

::nc calc
	var[a]
	var[b]
	var[r]
	
	set[r|none]
	pr[calc!]
	trydo[calc0|err]
	ifdo[err|err]
	pr[result:]
	pr[r]
	
	del[a]
	del[b]
	del[r]
::end

::nc calc0
	
	pr[write_operand_1]
	in[a]
	pr[write_operator]
	in[com]
	pr[write_operand_2]
	in[b]
	
	trydo[calc1|err]
	ifdo[err|calc2]
	
	if[=com:?+]
		+[r|a|b]
	if[=com:?-]
		-[r|a|b]
	if[=com:?*]
		*[r|a|b]
	if[=com:?/]
		/[r|a|b]
	
::end

::nc calc1
	typeset[int|a]
	typeset[int|b]
::end

::nc calc2
	typeset[float|a]
	typeset[float|b]
::end

::nc sys
	arr[r|1]
	var[i]
	var[size]
	var[r]
	
	pr[SYS!]
	pr[write_command_for_system]
	in[com]
	trydo[sys0|err]
	ifdo[err|err]
	
	del[r]
	del[i]
	del[size]
	arrdel[r]
::end

::nc sys0
	
	:sys::outdo[com|r]
	arrsiz[r|size]
	:::sysloop
		arrget[r|i|r]
		pr[r]
		ifgo[=i|<size|sysloop]
	
::end

::nc err
	pr[error!]
	pr[err]
	var[err]
::end

::nc file
	var[args]
	
	pr[FILE!]
	pr[write_open_or_read_for_open_file]
	pr[write_write_for_write_text_in_file]
	pr[write_add_for_write_text_in_file_end]
	pr[write_newf_for_create_file]
	pr[write_newd_for_create_directory]
	pr[write_list_for_see_file_in_directory]
	pr[write_newd_for_create_directory]
	pr[Enter_or_0_for_end_FILE]
	
	:::fileloop
		pr[]
		pr[command:]
		in[com]
		pr[agrs:]
		in[args]
		ifgo[=com:?open|readf]
		ifgo[=com:?read|readf]
		ifgo[=com:?write|writef]
		ifgo[=com:?add|addf]
		ifgo[=com:?newf|newf]
		ifgo[=com:?newd|newd]
		ifgo[=com:?del|delf]
		ifgo[=com:?list|listd]
		ifgo[=com:?0|filend]
		go[fileloop]
	
	:::readf
		pr[READ]
		read[args]
		var[i]
		var[d]
		var[max]
		arrsiz[read|max]
		pr[=size_:+max]
		:::readloop
			arrget[read|i|d]
			pr[d]
			=i|+1
			ifgo[=i:<max|readloop]
		
		arrdel[read]
		del[d]
		del[i]
		del[max]
		go[fileloop]
	
	:::writef
		pr[WRITE]
		var[i]
		var[d]
		var[max]
		pr[write_number_lines]
		in[max]
		arr[data|max]
		:::writeloop
			in[d]
			arrset[data|i|d]
			=i|+1
			ifgo[=i:<max|writeloop]
		
		write[args]
		arrdel[data]
		del[d]
		del[i]
		go[fileloop]
	
	:::addf
		pr[WRITE-ADD]
		var[d]
		pr[Enter_or_0_for_end_write]
		arr[data|1]
		
		:::write_add_loop
			in[d]
			ifgo[=d:?0|write_add_end]
			arrset[data|0|d]
			write[args|1]
			go[write_add_loop]
		
		:::write_add_end
		
		arrdel[data]
		del[d]
		go[fileloop]
	
	:::newd
		pr[NEW_D]
		dnew[args]
		go[fileloop]
	
	:::newf
		pr[NEW_F]
		fnew[args]
		go[fileloop]
	
	:::delf
		pr[DELITE]
		delite[args]
		go[fileloop]
	
	:::listd
		pr[=FILE_IN_:+args]
		list[args]
		var[i]
		var[d]
		var[max]
		arrsiz[files|max]
		pr[=size_:+max]
		:::listloop
			arrget[files|i|d]
			pr[d]
			=i|+1
			ifgo[=i:<max|listloop]
		
		arrdel[files]
		del[d]
		del[i]
		del[max]
		go[fileloop]
	
	
	:::filend
	pr[END_FILE]
	del[args]
::end

::add file
