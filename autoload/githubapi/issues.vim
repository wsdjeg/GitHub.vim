""
" List issues
" List all issues assigned to the authenticated user across all visible
" repositories including owned repositories, member repositories, and
" organization repositories:
"
" Github API : GET /issues
" @public
function! githubapi#issues#List_All(user,password) abort
    let issues = []
    for i in range(1,githubapi#util#GetLastPage('issues -u ' . a:user . ':' . a:password))
        call extend(issues,githubapi#util#Get('issues?page=' . i,' -u ' . a:user . ':' . a:password))
    endfor
    return issues
endfunction

""
" List all issues across owned and member repositories assigned to the
" authenticated user:
"
" Github API : GET /user/issues
" @public
function! githubapi#issues#List_All_for_User(user,password) abort
    let issues = []
    for i in range(1,githubapi#util#GetLastPage('user/issues -u ' . a:user . ':' . a:password))
        call extend(issues,githubapi#util#Get('user/issues?page=' . i,' -u ' . a:user . ':' . a:password))
    endfor
    return issues
endfunction

""
" List all issues for a given organization assigned to the authenticated user:
"
" Github API : GET /orgs/:org/issues
" @public
function! githubapi#issues#List_All_for_User_In_Org(org,user,password) abort
    let issues = []
    for i in range(1,githubapi#util#GetLastPage('orgs/' . a:org . '/issues -u ' . a:user . ':' . a:password))
        call extend(issues,githubapi#util#Get('orgs/' . a:org . '/issues?page=' . i,' -u ' . a:user . ':' . a:password))
    endfor
    return issues
endfunction

""
" List issues for a repository
" GET /repos/:owner/:repo/issues
" NOTE: this only list opened issues and pull request
function! githubapi#issues#List_All_for_Repo(owner,repo) abort
    let issues = []
    for i in range(1,githubapi#util#GetLastPage('repos/' . a:owner . '/' . a:repo . '/issues'))
        call extend(issues,githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues?page=' . i, ''))
    endfor
    return issues
endfunction

""
" Get a single issue
" @public
" GET /repos/:owner/:repo/issues/:number
function! githubapi#issues#Get_issue(owner,repo,num) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues/' . a:num, '')
endfunction

""
" @public
" Create an issue
"
" Github API : POST /repos/:owner/:repo/issues
"
" Input: >
"   {
"    "title": "Found a bug",
"    "body": "I'm having a problem with this.",
"    "assignee": "octocat",
"    "milestone": 1,
"    "labels": [
"      "bug"
"    ]
"   }
" <
function! githubapi#issues#Create(owner,repo,user,password,json) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues',
                \ ' -X POST -d ' . shellescape(a:json)
                \ . ' -u ' . a:user . ':' . a:password)
endfunction

""
" Edit an issue
" PATCH /repos/:owner/:repo/issues/:number
function! githubapi#issues#Edit(owner,repo,num,user,password,json) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues/' . a:num,
                \ ' -X PATCH -d ' . shellescape(a:json)
                \ . ' -u ' . a:user . ':' . a:password)
endfunction

""
" @public
" Lock an issue
"
" Github APi : PUT /repos/:owner/:repo/issues/:number/lock
function! githubapi#issues#Lock(owner,repo,num,user,password) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues/' . a:num . '/lock',
                \ ' -X PUT  -u ' . a:user . ':' . a:password
                \ . ' -H "Accept: application/vnd.github.the-key-preview"')
endfunction

""
" @public
" Unlock an issue
"
" Github API : DELETE /repos/:owner/:repo/issues/:number/lock
function! githubapi#issues#Unlock(owner,repo,num,user,password) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues/' . a:num . '/lock',
                \ ' -X DELETE  -u ' . a:user . ':' . a:password
                \ . ' -H "Accept: application/vnd.github.the-key-preview"')
endfunction

""
" @public
" Lists all the available assignees to which issues may be assigned.
"
" Github API : GET /repos/:owner/:repo/assignees
function! githubapi#issues#List_assignees(owner,repo) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/assignees', '')
endfunction

""
" @public
" Check assignee
"
" Github API : GET /repos/:owner/:repo/assignees/:assignee
function! githubapi#issues#Check_assignee(owner,repo,assignee) abort
    return githubapi#util#GetStatus('repos/' . a:owner . '/'
                \ . a:repo . '/assignees/' . a:assignee, '') ==# 204
endfunction

""
" @public
" Add assignees to an Issue
"
" Github API : POST /repos/:owner/:repo/issues/:number/assignees
"
" NOTE: need `Accep:application/vnd.github.cerberus-preview+json`
"
" Input: >
"   {
"    "assignees": [
"      "hubot",
"      "other_assignee"
"    ]
"   }
" <
function! githubapi#issues#Addassignee(owner,repo,num,assignees,user,password) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues/' . a:num . '/assignees',
                \ ' -X POST -d ' . shellescape(a:assignees) . ' -u ' . a:user . ':' . a:password
                \ . ' -H "Accept: application/vnd.github.cerberus-preview+json"')
endfunction

""
" @public
" Remove assignees from an Issue
"
" DELETE /repos/:owner/:repo/issues/:number/assignees
"
" Input: >
"   {
"    "assignees": [
"      "hubot",
"      "other_assignee"
"    ]
"   }
" <
" NOTE: need `Accep:application/vnd.github.cerberus-preview+json`
function! githubapi#issues#Removeassignee(owner,repo,num,assignees,user,password) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues/' . a:num . '/assignees',
                \ ' -X DELETE -d ' . shellescape(a:assignees) . ' -u ' . a:user . ':' . a:password
                \ . ' -H "Accept: application/vnd.github.cerberus-preview+json"')
endfunction

""
" @public
" List comments on an issue, updated at or after {since} .
" {since} : YYYY-MM-DDTHH:MM:SSZ
"
" Github API : GET /repos/:owner/:repo/issues/:number/comments
function! githubapi#issues#List_comments(owner,repo,num,since) abort
    let comments = []
    for i in range(1,githubapi#util#GetLastPage('repos/' . a:owner . '/' . a:repo
                \. '/issues/' . a:num . '/comments'
                \. (empty(a:since) ? '' : '?since='.a:since)))
        call extend(comments,githubapi#util#Get('repos/' . a:owner . '/' . a:repo
                \. '/issues/' . a:num . '/comments?page=' . i
                \. (empty(a:since) ? '' : '&since='.a:since), ''))
    endfor
    return comments
endfunction

""
" @public
" List comments in a repository
"
" Github API : GET /repos/:owner/:repo/issues/comments
function! githubapi#issues#List_All_comments(owner,repo,sort,desc,since) abort
    let url = 'repos/' . a:owner . '/' . a:repo . '/issues/comments'
    if index(['created','updated'], a:sort) != -1
        let url = url . '?sort=' . a:sort
        if index(['asc','desc'], a:desc) != -1
            let url = url . '&direction=' . a:desc
        endif
        if !empty(a:since)
            let url = url . '&since=' . a:since
        endif
    else
        if !empty(a:since)
            let url = url . '?since=' . a:since
        endif
    endif
    let comments = []
    for i in range(1,githubapi#util#GetLastPage(url))
        call extend(comments,githubapi#util#Get(url . (stridx(url,'?') == -1 ? '?page='  : '&page=') . i ,''))
    endfor
    return comments
endfunction

""
" @public
" Get a single comment
"
" Github API : GET /repos/:owner/:repo/issues/comments/:id
function! githubapi#issues#Get_comment(owner,repo,id) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues/comments/' . a:id, '')
endfunction

""
" @public
" Create a comment
"
" Input: >
"   {
"       "body": "Me too"
"   }
" <
" Github API : POST /repos/:owner/:repo/issues/:number/comments
function! githubapi#issues#Create_comment(owner,repo,num,json,user,password) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues/' . a:num . '/comments/',
                \' -X POST -u ' . a:user . ':' . a:password . ' -d ' . shellescape(a:json))
endfunction

""
" @public
" Edit a comment
"
" Input: >
"   {
"       "body": "Me too"
"   }
" <
" Github API : PATCH /repos/:owner/:repo/issues/comments/:id
function! githubapi#issues#Edit_comment(owner,repo,id,json,user,password) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues/'  . '/comments/' . a:id,
                \' -X PATCH -u ' . a:user . ':' . a:password . ' -d ' . shellescape(a:json))
endfunction

""
" @public
" Delete a comment
"
" Github API : ELETE /repos/:owner/:repo/issues/comments/:id
function! githubapi#issues#Delete_comment(owner,repo,id,user,password) abort
    return githubapi#util#GetStatus('repos/' . a:owner . '/'
                \ . a:repo . '/issues/comments/' . a:id,
                \ ' -u ' . a:user . ':' . a:password . ' -X DELETE') ==# 204
endfunction

""
" @public
" List events for an issue
" Github API : GET /repos/:owner/:repo/issues/:issue_number/events
function! githubapi#issues#List_events(owner,repo,num) abort
    let url = join(['repos',a:owner,a:repo,'issues',a:num,'events'], '/')
    let events = []
    for i in range(1,githubapi#util#GetLastPage(url))
        call extend(events,githubapi#util#Get(url . '?page=' . i, ''))
    endfor
    return events
endfunction

function! s:GetEvent(event) abort
   let events = {
               \ 'closed' : 'The issue was closed by the actor. When the commit_id is present, '
               \ . 'it identifies the commit that closed the issue using "closes / fixes #NN" syntax.',
               \ 'reopened' : 'The issue was reopened by the actor.',
               \ 'subscribed' : 'The actor subscribed to receive notifications for an issue.',
               \ 'merged' : 'The issue was merged by the actor. The `commit_id` attribute is the SHA1 of the HEAD commit that was merged.',
               \ 'referenced' : 'The issue was referenced from a commit message. '
               \ . 'The `commit_id` attribute is the commit SHA1 of where that happened.',
               \ 'mentioned' : 'The actor was @mentioned in an issue body.',
               \ 'assigned' : 'The issue was assigned to the actor.',
               \ 'unassigned' : 'The actor was unassigned from the issue.',
               \ 'labeled' : 'A label was added to the issue.',
               \ 'unlabeled' : 'A label was removed from the issue.',
               \ 'milestoned' : 'The issue was added to a milestone.',
               \ 'demilestoned' : 'The issue was removed from a milestone.',
               \ 'renamed' : 'The issue title was changed.',
               \ 'locked' : 'The issue was locked by the actor.',
               \ 'unlocked' : 'The issue was unlocked by the actor.',
               \ 'head_ref_deleted' : 'The pull request`s branch was deleted.',
               \ 'head_ref_restored' : 'The pull request`s branch was restored. '
               \ }
   let event = json_decode(a:event).event
   return get(events, event)
endfunction

""
" @public
" List events for a repository
"
" Github API : GET /repos/:owner/:repo/issues/events
function! githubapi#issues#List_events_for_repo(owner,repo) abort
    let url = join(['repos', a:owner, a:repo, 'issues','events'], '/')
    let events = []
    for i in range(1,githubapi#util#GetLastPage(url))
        call extend(events,githubapi#util#Get(url . '?page=' . i, ''))
    endfor
    return events
endfunction

""
" @public
" Get a single event
"
" Github API : GET /repos/:owner/:repo/issues/events/:id
function! githubapi#issues#Get_event(owner,repo,id) abort
    return githubapi#util#Get('repos/' . a:owner . '/' . a:repo . '/issues/events/' . a:id, '')
endfunction
