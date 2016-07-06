" List organization repositories
" GET /orgs/:org/repos
function! githubapi#orgs#ListRepos(org) abort
   let repos = []
   for i in range(1,githubapi#util#GetLastPage('orgs/' . a:org . '/repos'))
       call extend(repos,githubapi#util#Get('orgs/' . a:org . '/repos?page=' . i,[]))
   endfor
   return repos
endfunction

""
" @public
" Get an organization
"
" Github API : GET /orgs/:org
function! githubapi#orgs#Get(org) abort
    return githubapi#util#Get(join(['orgs', a:org], '/'), [])
endfunction

""
" @public
" Edit an organization
"
" Github API : PATCH /orgs/:org
" Input: >
"    {
"      "billing_email": "support@github.com",
"      "blog": "https://github.com/blog",
"      "company": "GitHub",
"      "email": "support@github.com",
"      "location": "San Francisco",
"      "name": "github",
"      "description": "GitHub, the company."
"    }
" <
function! githubapi#orgs#Edit(org,orgdata,user,password) abort
    return githubapi#util#Get(join(['orgs', a:org], '/'),
                \ ['-X', 'PATCH', '-d', json_encode(a:orgdata),
                \ '-u', a:user .':'. a:password])
endfunction
