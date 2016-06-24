
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

""
" @public
" List public events for an organization
"
" Github API : GET /orgs/:org/events
function! githubapi#activity#List_org_events(org) abort
    return githubapi#util#Get(join(['orgs/', a:org, 'events'], '/'), '')
endfunction

""
" @public
" List events that a user has received
"
" These are events that you've received by watching repos and following users.
" If you are authenticated as the given user, you will see private events.
" Otherwise, you'll only see public events.
"
" Github API : GET /users/:username/received_events
function! githubapi#activity#List_user_events(user) abort
    return githubapi#util#Get(join(['users', a:user, 'received_events'], '/'), '')
endfunction

""
" @public
" List public events that a user has received
"
" Github API : GET /users/:username/received_events/public
function! githubapi#activity#List_public_user_events(user) abort
    return githubapi#util#Get(join(['users', a:user, 'received_events', 'public'], '/'), '')
endfunction

""
" @public
" List events performed by a user
"
" If you are authenticated as the given user, you will see your private events.
" Otherwise, you'll only see public events.
"
" Github API : GET /users/:username/events
function! githubapi#activity#Performed_events(user) abort
    return githubapi#util#Get(join(['users', a:user, 'events'], '/'), '')
endfunction

""
" @public
" List public events performed by a user
"
" Github API : GET /users/:username/events/public
function! githubapi#activity#Performed_events(user) abort
    return githubapi#util#Get(join(['users', a:user, 'events', 'public'], '/'), '')
endfunction

""
" @public
" List events for an organization
"
" NOTE:This is the user's organization dashboard. You must be authenticated as the user to view this.
"
" Github API : GET /users/:username/events/orgs/:org
function! githubapi#activity#List_user_org_events(user,org,password) abort
   return githubapi#util#Get(join(['users', a:user, 'events', 'org', a:org], '/'), ' -u ' . a:user . ':' . a:password)
endfunction
