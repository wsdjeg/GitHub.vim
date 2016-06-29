" List organization repositories
" GET /orgs/:org/repos
function! githubapi#orgs#ListRepos(org) abort
   let repos = []
   for i in range(1,githubapi#util#GetLastPage('orgs/' . a:org . '/repos'))
       call extend(repos,githubapi#util#Get('orgs/' . a:org . '/repos?page=' . i,[]))
   endfor
   return repos
endfunction
