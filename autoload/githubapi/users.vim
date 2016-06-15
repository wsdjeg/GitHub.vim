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

" get a single user
" GET /users/:username
function! githubapi#users#GetUser(username) abort
   return githubapi#util#Get('users/' . a:username, '') 
endfunction

"Get the authenticated user
"GET /user
function! githubapi#users#GetAuthUser(username,password) abort
    return githubapi#util#Get('user' ,' -u ' . a:username . ':' . a:password)
endfunction

"List followers of a user
"GET /users/:username/followers
function! githubapi#users#ListFollowers(username) abort
   let followers = []
   for i in range(1,githubapi#util#GetLastPage('users/' . a:username . '/followers'))
       call extend(followers,githubapi#util#Get('users/' . a:username . '/followers?page=' . i,''))
   endfor
   return followers
endfunction
