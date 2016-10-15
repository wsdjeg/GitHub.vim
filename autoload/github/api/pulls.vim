""
" @public
" List all the PRs of a repo.
"
" Github API : GET /repos/:owner/:repo/pulls
function! githubapi#pulls#ListAllPRs(owner,repo) abort
    return githubapi#util#Get(join(['repos', a:owner, a:repo, 'pulls'], '/'), [])
endfunction

""
" @public
" Get a single pull request
"
" Github API : GET /repos/:owner/:repo/pulls/:number
function! githubapi#pulls#Get(owner,repo,number) abort
    return githubapi#util#Get(join(['repos', a:owner, a:repo, 'pulls', a:number], '/'), [])
endfunction

""
" @public
" Create a pull request
"
" Input: >
"    {
"      "title": "Amazing new feature",
"      "body": "Please pull this in!",
"      "head": "octocat:new-feature",
"      "base": "master"
"    }
" <
" or: >
"    {
"      "issue": 5,
"      "head": "octocat:new-feature",
"      "base": "master"
"    }
" <
" Github API : POST /repos/:owner/:repo/pulls
function! githubapi#pulls#create(owner,repo,user,password,pull) abort
    return githubapi#util#Get(join(['repos', a:owner, a:repo, 'pulls'], '/'),
                \ ['-X', 'POST',
                \ '-d', json_encode(a:pull),
                \ '-u', a:user . ':' . a:password])
endfunction

""
" @public
" Update a pull request
"
" Input: >
"    {
"      "title": "new title",
"      "body": "updated body",
"      "state": "open"
"    }
" <
" Github API : PATCH /repos/:owner/:repo/pulls/:number
function! githubapi#pulls#update(owner,repo,number,pull,user,password) abort
    return githubapi#util#Get(join(['repos', a:owner, a:repo, 'pulls', a:number], '/'),
                \ ['-X', 'PATCH',
                \ '-d', json_encode(a:pull),
                \ '-u', a:user . ':' . a:password])
endfunction

""
" @public
" List commits on a pull request
"
" Github API : GET /repos/:owner/:repo/pulls/:number/commits
function! githubapi#pulls#ListCommits(owner,repo,number) abort
    return githubapi#util#Get(join(['repos', a:owner, a:repo, 'pulls', a:number, 'commits'], '/'), [])
endfunction

""
" @public
" List pull requests files
"
" Github API : GET /repos/:owner/:repo/pulls/:number/files
function! githubapi#pulls#ListFiles(owner,repo,number) abort
    return githubapi#util#Get(join(['repos', a:owner, a:repo, 'pulls', a:number, 'files'], '/'), [])
endfunction

""
" @public
" Get if a pull request has been merged
"
" Github API : GET /repos/:owner/:repo/pulls/:number/merge
function! githubapi#pulls#CheckMerged(owner,repo,number) abort
    return githubapi#util#GetStatus(join(['repos', a:owner, a:repo , 'pulls', a:number, 'merge'], '/'), []) == 204
endfunction

""
" @public
" Merge a pull request (Merge Button)
"
" Github API : PUT /repos/:owner/:repo/pulls/:number/merge
function! githubapi#pulls#Merge(owner,repo,number,msg,user,password) abort
   return githubapi#util#Get(join(['repos', a:owner, a:repo, 'pulls', a:number, 'merge'], '/'),
               \ ['-X', 'PUT',
               \ '-d', json_encode(a:msg),
               \ '-u', a:user . ':' . a:password])
endfunction
