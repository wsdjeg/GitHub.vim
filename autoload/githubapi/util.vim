function! githubapi#util#Get(url,args) abort
    let cmd = 'curl -s ' .g:githubapi_root_url . a:url
    if !empty(a:args)
        let cmd = cmd . a:args
    endif
    return json_decode(join(systemlist(cmd),"\n"))
endfunction
