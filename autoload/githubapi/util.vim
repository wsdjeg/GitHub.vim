function! githubapi#util#Get(url,args) abort
    let cmd = 'curl -s "' .g:githubapi_root_url . a:url . '"'
    if !empty(a:args)
        let cmd = cmd . a:args
    endif
    call githubapi#util#log('util#Get cmd : ' . cmd)
    let result = join(systemlist(cmd),"\n")
    return empty(result) ? result : json_decode(result)
endfunction

function! githubapi#util#GetLastPage(url) abort
    let cmd = 'curl -si "' . g:githubapi_root_url . a:url . '" | grep -E "^Link"'
    call githubapi#util#log('util#GetLastPage cmd : ' . cmd)
    let result = systemlist(cmd)
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
    let cmd = 'curl -is "' . g:githubapi_root_url . a:url . '" ' . a:opt . ' | grep -E "^Status:"'
    call githubapi#util#log('util#GetStatus cmd : ' . cmd)
    return matchstr(systemlist(cmd)[0],'\d\+')
endfunction

""
" @public
" Get current time in a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
function! githubapi#util#Get_current_time() abort
   return strftime('%Y-%m-%dT%TZ')
endfunction

let s:log = []
function! githubapi#util#log(log) abort
    call add(s:log, a:log)
endfunction

""
" @public
" view the log of API
function! githubapi#util#ViewLog() abort
    echon join(s:log, "\n")
endfunction

""
" @public
"
" Clean up the log of the API
function! githubapi#util#CleanLog() abort
    let s:log = []
    echon "Github-api.vim's log has beed cleaned up!"
endfunction
