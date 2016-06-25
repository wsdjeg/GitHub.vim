function! githubapi#util#Get(url,args) abort
    let cmd = 'curl -s "' .g:githubapi_root_url . a:url . '"'
    if !empty(a:args)
        let cmd = cmd . a:args
    endif
    let result = join(systemlist(cmd),"\n")
    return empty(result) ? result : json_decode(result)
endfunction

function! githubapi#util#GetLastPage(url) abort
    let result = systemlist('curl -si "' . g:githubapi_root_url . a:url . '" | grep -E "^Link"')
    if len(result) > 0
        let line = result[0]
        if !empty(line) && !empty(matchstr(line, 'rel="last"'))
            return split(matchstr(line,'=\d\+',0,2),'=')[0]
        endif
    else
        return 1
    endif
endfunction

function! githubapi#util#GetStatus(url,opt) abort
    return matchstr(systemlist('curl -is "' . g:githubapi_root_url . a:url . '" ' . a:opt . ' | grep -E "^Status:"')[0],'\d\+')
endfunction

""
" @public
" Get current time in a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
function! githubapi#util#Get_current_time() abort
   return strftime('%Y-%m-%dT%TZ')
endfunction
