" List issues
" List all issues assigned to the authenticated user across all visible
" repositories including owned repositories, member repositories, and 
" organization repositories:
" GET /issues
function! githubapi#issues#List_All(user,password) abort
    let issues = []
    for i in range(1,githubapi#util#GetLastPage('issues -u ' . a:user . ':' . a:password))
        call extend(issues,githubapi#util#Get('issues?page=' . i,' -u ' . a:user . ':' . a:password))
    endfor
    return issues
endfunction

" List all issues across owned and member repositories assigned to the
" authenticated user:
" GET /user/issues
function! githubapi#issues#List_All_for_User(user,password) abort
    let issues = []
    for i in range(1,githubapi#util#GetLastPage('user/issues -u ' . a:user . ':' . a:password))
        call extend(issues,githubapi#util#Get('user/issues?page=' . i,' -u ' . a:user . ':' . a:password))
    endfor
    return issues
endfunction

" List all issues for a given organization assigned to the authenticated user:
" GET /orgs/:org/issues
function! githubapi#issues#List_All_for_User_In_Org(org,user,password) abort
    let issues = []
    for i in range(1,githubapi#util#GetLastPage('orgs/' . a:org . '/issues -u ' . a:user . ':' . a:password))
        call extend(issues,githubapi#util#Get('orgs/' . a:org . '/issues?page=' . i,' -u ' . a:user . ':' . a:password))
    endfor
    return issues
endfunction

" List issues for a repository
" GET /repos/:owner/:repo/issues
" NOTE: this only list opened issues and pull request
function! githubapi#issues#List_All_for_Repo(owner,repo) abort
    let issues = []
    for i in range(1,githubapi#util#GetLastPage('repos/' . a:owner . '/' . a:repo . '/issues'))
        call extend(issues,githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues', ''))
    endfor
    return issues
endfunction

" Get a single issue
" GET /repos/:owner/:repo/issues/:number
function! githubapi#issues#Get_issue(owner,repo,num) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues/' . a:num, '')
endfunction

" Create an issue
" POST /repos/:owner/:repo/issues
function! githubapi#issues#Create(owner,repo,user,password,json) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues',' -X POST -d ' . shellescape(a:json) . ' -u ' . a:user . ':' . a:password)
endfunction

