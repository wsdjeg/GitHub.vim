function! githubapi#util#Get(url,args) abort
    let cmd = 'curl -s ' .g:githubapi_root_url . a:url
    if !empty(a:args)
        let cmd = cmd . a:args
    endif
    return json_decode(join(systemlist(cmd),"\n"))
endfunction

function! githubapi#util#GetLastPage(url) abort
    let result = systemlist('curl -si ' . g:githubapi_root_url . a:url . '| grep -E "^Link"')
    if len(result) > 0
        let line = result[0]
        if !empty(line) && !empty(matchstr(line, 'rel="last"'))
            return split(matchstr(line,'=\d\+',0,2),'=')[0]
        endif
    else
        return 1
    endif
endfunction
