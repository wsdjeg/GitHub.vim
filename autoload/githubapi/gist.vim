""
" @public
" List public gists for the specified user:
"
" GET /users/:username/gists
function! githubapi#gist#List(user) abort
    return githubapi#util#Get(join(['users', a:user, 'gists'], '/'), '')
endfunction

""
" @public
" List the authenticated user's gists or if called anonymously, this will return all public gists:
"
" GET /gists
function! githubapi#gist#ListAll(user,password) abort
    if empty(a:user) || empty(a:password)
        return githubapi#util#Get('gists','')
    else
        return githubapi#util#Get('gists',' -u ' . a:user . ':' . a:password)
    endif
endfunction

""
" @public
" List all public gists
"
" Get /gists/public
function! githubapi#gist#ListPublic(since) abort
    let url = 'gists/public'
    if !empty(a:since)
         let url = url . '?since=' . a:since
    endif
    return githubapi#util#Get(url, '')
endfunction

""
" @public
" List starred gists,{since}A timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ.
" Only gists updated at or after this time are returned.
"
" GET /gists/starred
function! githubapi#gist#ListStarred(user,password,since) abort
    let url = 'gists/starred'
    if !empty(a:since)
         let url = url . '?since=' . a:since
    endif
    return githubapi#util#Get(url,' -u ' . a:user . ':' . a:password)
endfunction

""
" @public
" Get a single gist
"
" Github API : GET /gists/:id
function! githubapi#gist#GetSingle(id) abort
    return githubapi#util#Get('gists/' . a:id, '')
endfunction

""
" @public
" Get a specific revision of a gist
"
" Github API : GET /gists/:id/:sha
function! githubapi#gist#GetSingleSha(id,sha) abort
    return githubapi#util#Get(join(['gists', a:id, a:sha], '/'), '')
endfunction

""
" @public
" Create a gist
"
" POST : /gists
" Input: >
"    {
"      "description": "the description for this gist",
"      "public": true,
"      "files": {
"        "file1.txt": {
"          "content": "String file contents"
"        }
"      }
"    }
" <
function! githubapi#gist#Create(desc,filename,content,public,user,password) abort
    let data = {}
    let data.description = a:desc
    let data.public = a:public
    call extend(data, {'files': {a:filename : {'content' :a:content}}})
    return githubapi#util#Get('gists', " -d '" . json_encode(data) . "' -X POST -u " . a:user . ':' .a:password)
endfunction
