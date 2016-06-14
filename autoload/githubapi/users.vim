function! githubapi#users#starred(user,page) abort
    echom a:user . "--" . a:page
    return json_decode(join(systemlist('curl -s https://api.github.com/users/' .
                \a:user . '/starred' . '?page=' . a:page ),"\n"))
endfunction

function! githubapi#users#starred_pages(user) abort
    let l:i = systemlist('curl -si https://api.github.com/users/' . a:user . '/starred | grep -E "^Link"')[0]
    return split(matchstr(l:i,'=\d\+',0,2),'=')[0]
endfunction

function! githubapi#users#GetStarred(user) abort
    let rel = []
    let pages = githubapi#users#starred_pages(a:user)
    echom pages
    for page in range(1,pages)
        let repos = githubapi#users#starred(a:user, page)
        for repo in repos
            call add(rel, repo.full_name)
        endfor
    endfor
    return rel
endfunction
