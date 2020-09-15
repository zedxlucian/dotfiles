function Osc52Yank()
        let buffer=system('base64 | tr -d "\n"', @0)
        let buffer="\e]52;c;".buffer."\e\\"
        call writefile([buffer], g:tty, 'b')
	silent exe "!echo -ne ".shellescape(buffer).
		\ " > ".shellescape(g:tty)
endfunction

augroup Yank
augroup END
