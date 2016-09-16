function! s:systemlist(cmd) abort
    if type(a:cmd) == type([]) && !has('nvim')
        let cmd = join(a:cmd, " ")
        return systemlist(cmd)
    endif
    return systemlist(a:cmd)
endfunction

function! githubapi#util#Get(url,args) abort
    let cmd = ['curl', '-s', g:githubapi_root_url . a:url]
    if len(a:args) > 0
        call extend(cmd, a:args)
    endif
    call githubapi#util#log('util#Get cmd : ' . string(cmd))
    let result = join(s:systemlist(cmd),"\n")
    return empty(result) ? result : json_decode(result)
endfunction

function! githubapi#util#GetLastPage(url) abort
    let cmd = ['curl', '-si', g:githubapi_root_url . a:url]
    call githubapi#util#log('util#GetLastPage cmd : ' . string(cmd))
    let result = filter(copy(systemlist(cmd)), "v:val =~# '^Link'")
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
    let cmd = ['curl', '-is', g:githubapi_root_url . a:url]
    if len(a:opt) > 0
        call extend(cmd, a:opt)
    endif
    call githubapi#util#log('util#GetStatus cmd : ' . string(cmd))
    let result = filter(copy(systemlist(cmd)), "v:val =~# '^Status:'")
    return matchstr(result[0],'\d\+')
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
function! githubapi#util#GetLog() abort
    return join(s:log, "\n")
endfunction

""
" @public
"
" Clean up the log of the API
function! githubapi#util#CleanLog() abort
    let s:log = []
    echon "Github-api.vim's log has beed cleaned up!"
endfunction
