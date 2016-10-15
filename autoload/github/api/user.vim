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
" List the authenticated user's followers:
"
" Github API : GET /user/followers
function! githubapi#user#GetFollowers(user,password) abort
    return githubapi#util#Get(join(['user', 'followers'], '/'),
                \ ['-u', a:user . ':' . a:password])
endfunction

""
" @public
" Check if you are following a user
"
" Github API : GET /user/following/:username
function! githubapi#user#CheckFollowing(username,user,password) abort
    return githubapi#util#GetStatus(join(['user', 'following', a:username], '/'),
                \ ['-u', a:user . ':' . a:password]) == 204
endfunction

""
" @public
" follow a user
"
" Github API :  PUT /user/following/:username
function! githubapi#user#Follow(username,user,password) abort
    return githubapi#util#GetStatus(join(['user', 'following', a:username], '/'),
                \ ['-X', 'PUT',
                \ '-u', a:user . ':' .a:password]) == 204
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

""
" @public
" Get your organization membership
"
" Github API : GET /user/memberships/orgs/:org
function! githubapi#user#GetOrgMembership(user,password,org) abort
    return githubapi#util#Get(join(['user', 'memberships', 'orgs', a:org], '/'),
                \ ['-u', a:user . ':' . a:password])
endfunction

""
" @public
" Edit your organization membership
"
" Input: >
"    {
"      "state": "active"
"    }
" <
" Github API : PATCH /user/memberships/orgs/:org
function! githubapi#user#EditOrgMembership(org,state,user,password) abort
    return githubapi#util#Get(join(['user', 'memberships', 'org', a:org], '/'),
                \ ['-X', 'PATCH',
                \ '-d', json_encode(a:state),
                \ '-u', a:user . ':' . a:password])
endfunction

"Get the authenticated user
"GET /user
function! githubapi#user#GetUser(username,password) abort
    return githubapi#util#Get('user' , ['-u', a:username . ':' . a:password])
endfunction

""
" @public
" Update the authenticated user
"
" Input >
"    {
"    "name": "monalisa octocat",
"    "email": "octocat@github.com",
"    "blog": "https://github.com/blog",
"    "company": "GitHub",
"    "location": "San Francisco",
"    "hireable": true,
"    "bio": "There once..."
"    }
" <
" Github API : PATCH /user
function! githubapi#user#UpdateUser(data,user,password) abort
    return githubapi#util#Get('user', ['-X', 'PATCH', '-d', a:data, '-u', a:user . ':' . a:password])
endfunction

""
" @public
" List emails for a user
"
" Github API : GET /user/emails
function! githubapi#user#ListEmails(user,password) abort
    return githubapi#util#Get(join(['user', 'emails'], '/'),
                \ ['-u', a:user . ':' . a:password])
endfunction

""
" @public
" Add email address(es)
"
" Github API : POST /user/emails
function! githubapi#user#AddEmails(user,password,emails) abort
    return githubapi#util#Get(join(['user', 'emails'], '/'),
                \ ['-X', 'POST',
                \ '-d', json_encode(a:emails),
                \ '-u', a:user . ':' . a:password])
endfunction

""
" @public
" Delete email address(es)
"
" Github API : DELETE /user/emails
function! githubapi#user#DeleteEmails(user,password,emails) abort
    return githubapi#util#Get(join(['user', 'emails'], '/'),
                \ ['-X', 'DELETE',
                \ '-d', json_encode(a:emails),
                \ '-u', a:user . ':' . a:password])
endfunction

""
" @public
" Unfollow a user
"
" Github API : DELETE /user/following/:username
function! githubapi#user#UnFollow(username,user,password) abort
    return githubapi#util#GetStatus(join(['user', 'following', a:username], '/'),
                \ ['-u', a:user . ':' . a:password]) == 204
endfunction
