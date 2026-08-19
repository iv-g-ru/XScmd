

::cm read   //input - name file for read, output- arr read , result read
	::push a
	::push b
    var[a]
    var[b]
    arr[read|0]
    
    have[arg0|a]
    ifgo[=a:?0|readend]
    var[a]
    
    +[b|cmd.exe::/c_type_"|arg0|"]
    :sys::outdo[b|read]
    
    :::readend
    del[a]
    del[b]
	::pop b
	::pop a
::end

::cm write	//input	arg0 - name file for write, arg1 -  if  arg1 or arg1 is none clear file and write , else add data in file end, data from arr data
	::push a
	::push b
	::push c
	var[a]
	var[b]
	var[c]
	
	have[arg0|a]
    ifgo[=a:?0|writend]
	var[a]
	
	arrhave[data|a]
    ifgo[=a:?0|writend]
    var[a]
	
	have[arg1|a]
	ifgo[=a:?0|write_start_loop]
	ifgo[arg1|write_start_loop]
	+[c|cmd.exe::/c_type_nul_>_"|arg0|"]
	:sys::do[c]
	
	:::write_start_loop
	var[a]
	arrsiz[data|a]
	:::write_loop
		arrget[data|b|c]
		+[c|cmd.exe::/c_echo_|c|_>>_"|arg0|"]
		:sys::do[c]
		
		=b|+1
		ifgo[=b:<a|write_loop]
	
	
	:::writend
	del[a]
	del[b]
	del[c]
	::pop c
	::pop b
	::pop a
::end

::cm fnew   //input - name file for create
	::push a
	::push b
    var[a]
    var[b]
    
    have[arg0|a]
    ifgo[=a:?0|fend]
	
	+[b|cmd.exe::/c_type_nul_>_"|arg0|"]
    :sys::do[b]
    
    :::fend
    del[a]
    del[b]
	::pop b
	::pop a
::end

::cm dnew	//input - name directory for create
	::push a
	::push b
    var[a]
    var[b]
    
    have[arg0|a]
    ifgo[=a:?0|dend]
	
	+[b|cmd.exe::/c_mkdir_"|arg0|"]
    :sys::do[b]
    
    :::dend
    del[a]
    del[b]
	::pop b
	::pop a
::end

::cm list	//input - name directory , output- arr files name all file in directory 
	::push a
	::push b
    var[a]
    var[b]
	arr[files|0]
    
    have[arg0|a]
    ifgo[=a:?0|listend]
	
	+[b|cmd.exe::/c_dir_"|arg0|"_/b]
    :sys::outdo[b|files]
	pr[b]
    
    :::listend
    del[a]
    del[b]
	::pop b
	::pop a
::end

::cm delite	//input - name file for delite 
	::push a
	::push b
    var[a]
    var[b]
    
    have[arg0|a]
    ifgo[=a:?0|delitend]
	
	+[b|cmd.exe::/c_del_"|arg0|"]
    :sys::do[b]
    
    :::delitend
    del[a]
    del[b]
	::pop b
	::pop a
::delite