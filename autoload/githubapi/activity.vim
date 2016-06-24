
""
" @public
" List public events
"
" Github API : GET /events
function! githubapi#activity#List_events() abort
    return githubapi#util#Get('events','')
endfunction

""
" @public
" List repository events
"
" Github API : GET /repos/:owner/:repo/events
function! githubapi#activity#List_repo_events(owner,repo) abort
    return githubapi#util#Get(join(['repos', a:owner, a:repo, 'events'], '/'), '')
endfunction

""
" @public
" List public events for a network of repositories
"
" Github API : GET /networks/:owner/:repo/events
function! githubapi#activity#List_net_events(owner,repo) abort
    return githubapi#util#Get(join(['networks', a:owner, a:repo, 'events'], '/'), '')
endfunction
