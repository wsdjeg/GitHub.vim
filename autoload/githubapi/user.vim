"List who the authenticated user is following:
"GET /user/following
function! githubapi#user#ListFollowing(auth) abort
   let following = []
   for i in range(1,githubapi#util#GetLastPage('user/following'))
       call extend(following,githubapi#util#Get('user/following?page=' . i, ['-H', 'Authorization:' . a:auth]))
   endfor
   return following
endfunction

""
" @public
" List all orgs for the auth user.
"
" Github API : GET /user/orgs
function! githubapi#user#ListOrgs(auth) abort
    return githubapi#util#Get(join(['user', 'orgs'], '/'),
                \ ['-H', 'Authorization:' . a:auth])
endfunction
