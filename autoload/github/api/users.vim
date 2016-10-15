""
" @public
" Get all users
"
" Github API : GET /users
function! githubapi#users#GetAllUsers() abort
    return githubapi#util#Get('users', [])
endfunction


function! githubapi#users#starred(user,page) abort
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
    for page in range(1,pages)
        let repos = githubapi#users#starred(a:user, page)
        for repo in repos
            call add(rel, repo)
        endfor
    endfor
    return rel
endfunction

" get a single user
" GET /users/:username
function! githubapi#users#GetUser(username) abort
   return githubapi#util#Get('users/' . a:username, [])
endfunction

"List followers of a user
"GET /users/:username/followers
function! githubapi#users#ListFollowers(username) abort
   let followers = []
   for i in range(1,githubapi#util#GetLastPage('users/' . a:username . '/followers'))
       call extend(followers,githubapi#util#Get('users/' . a:username . '/followers?page=' . i, []))
   endfor
   return followers
endfunction

"List users followed by another user
"GET /users/:username/following
function! githubapi#users#ListFollowing(username) abort
   let following = []
   for i in range(1,githubapi#util#GetLastPage('users/' . a:username . '/following'))
       call extend(following,githubapi#util#Get('users/' . a:username . '/following?page=' . i, []))
   endfor
   return following
endfunction

""
" @public
" List orgs of a specified user.
"
" Github API : /users/:username/orgs
function! githubapi#users#ListAllOrgs(user) abort
    return githubapi#util#Get(join(['users', a:user, 'orgs'], '/'))
endfunction

""
" @public
" Check if one user follows another
"
" Github API : GET /users/:username/following/:target_user
function! githubapi#users#CheckTargetFollow(username,target) abort
    return githubapi#util#GetStatus(join(['users', a:username, 'following', a:target], '/'),[])
endfunction
