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

" Notification Reasons
function! s:notification_reason(n) abort
    let reasons = {
                \ 'subscribed': 	'The notification arrived because you`re watching the repository',
                \ 'manual': 	'The notification arrived because you`ve specifically decided'
                \ . ' to subscribe to the thread (via an Issue or Pull Request)',
                \ 'author': 	'The notification arrived because you`ve created the thread',
                \ 'comment': 	'The notification arrived because you`ve commented on the thread',
                \ 'mention': 	'The notification arrived because you were specifically @mentioned in the content',
                \ 'team_mention': 	'The notification arrived because you were on a team that was mentioned (like @org/team)',
                \ 'state_change': 	'The notification arrived because you changed the thread state '
                \ . '(like closing an Issue or merging a Pull Request)',
                \ 'assign': 	'The notification arrived because you were assigned to the Issue',
                \}
    return { 'reason' : a:n.reason . '->' . reasons[a:n.reason]}
endfunction

""
" @public
" List your notifications
"
" Github API : /notifications
function! githubapi#activity#List_notifications(user,password) abort
    return githubapi#util#Get('notifications',' -u ' . a:user . ':' . a:password)
endfunction

""
" @public
" List your notifications in a repository
"
" Github API : GET /repos/:owner/:repo/notifications
function! githubapi#activity#List_notifications_for_repo(onwer,repo,user,password) abort
    return githubapi#util#Get(join(['repos', a:onwer, a:repo, 'notifications'], '/'),
                \ ' -u ' . a:user . ':' . a:password)
endfunction

""
" @public
" Mark as read,you need use {last_read_at} as args.
" This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ. Default: Time.now
"
" Github API : PUT /notifications
function! githubapi#activity#Mark_All_as_read(user,password,last_read_at) abort
    let time = !empty(a:last_read_at) ? a:last_read_at : githubapi#util#Get_current_time()
    let data = {}
    let data.last_read_at = time
    return githubapi#util#GetStatus('notifications', ' -d ' . "'" . json_encode(data)
                \ . "'" . ' -X PUT -u ' . a:user . ':' . a:password)
endfunction

""
" @public
" Mark notifications as read in a repository
"
" Github API : PUT /repos/:owner/:repo/notifications
function! githubapi#activity#Mark_All_as_read_for_repo(owner,repo,user,password,last_read_at) abort
    let time = !empty(a:last_read_at) ? a:last_read_at : githubapi#util#Get_current_time()
    let data = {}
    let data.last_read_at = time
    return githubapi#util#GetStatus(join(['repos', a:owner, a:repo, 'notifications'], '/'), ' -d ' . "'" . json_encode(data)
                \ . "'" . ' -X PUT -u ' . a:user . ':' . a:password)
endfunction

""
" @public
" View a single thread
"
" Github API : GET /notifications/threads/:id
function! githubapi#activity#Get_thread(id,user,password) abort
    return githubapi#util#Get(join(['notifications', 'threads', a:id], '/'),' -u ' . a:user . ':' . a:password)
endfunction

""
" @public
" Mark a thread as read
"
" Github API : PATCH /notifications/threads/:id
function! githubapi#activity#Mark_thread(id,user,password) abort
    return githubapi#util#GetStatus(join(['notifications', 'threads', a:id], '/'),' -X PATCH -u ' . a:user . ':' . a:password) == 205
endfunction

""
" @public
" Get a Thread Subscription
"
" Github API : GET /notifications/threads/:id/subscription
function! githubapi#activity#Get_thread_sub(id,user,password) abort
    return githubapi#util#Get(join(['notifications', 'threads', a:id, 'subscription'], '/'),' -u ' . a:user . ':' . a:password)
endfunction

""
" @public
" Set a Thread Subscription
"
" This lets you subscribe or unsubscribe from a conversation.
" Unsubscribing from a conversation mutes all future notifications
" (until you comment or get @mentioned once more).
"
" Github API : PUT /notifications/threads/:id/subscription
function! githubapi#activity#Set_thread_sub(id,user,password,subscribed,ignored) abort
   let data = {}
   let data.subscribed = a:subscribed
   let data.ignored = a:ignored
   return githubapi#util#Get(join(['notifications', 'threads', a:id, 'subscription'], '/'),
               \ ' -u ' . a:user . ':' . a:password . ' -X PUT -d ' . "'" . json_encode(data) . "'")
endfunction

""
" @public
" Delete a Thread Subscription
"
" Github API : DELETE /notifications/threads/:id/subscription
function! githubapi#activity#Del_thread_sub(id,user,password) abort
    return githubapi#util#GetStatus(join(['notifications', 'threads', a:id, 'subscription'], '/'),
                \' -u ' . a:user . ':' . a:password) == 204
endfunction
