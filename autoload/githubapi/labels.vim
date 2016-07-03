""
" @public
" List all labels for this repository
"
" Github API : GET /repos/:owner/:repo/labels
function! githubapi#labels#GetAll(owner,repo) abort
    return githubapi#util#Get(join(['repos', a:owner, a:repo, 'labels'], '/'), [])
endfunction
