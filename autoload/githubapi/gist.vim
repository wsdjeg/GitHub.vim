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


""
" @public
" Edit a gist
"
" PATCH : /gists/:id
" Input: >
"    {
"      "description": "the description for this gist",
"      "files": {
"        "file1.txt": {
"          "content": "updated file contents"
"        },
"        "old_name.txt": {
"          "filename": "new_name.txt",
"          "content": "modified contents"
"        },
"        "new_file.txt": {
"          "content": "a new file"
"        },
"        "delete_this_file.txt": null
"      }
"    }
" <
" Note: All files from the previous version of the gist are carried over by default
" if not included in the object. Deletes can be performed by including the filename
" with a null object.
function! githubapi#gist#Edit(desc,filename,content,public,user,password,id) abort
    let data = {}
    let data.description = a:desc
    let data.public = a:public
    call extend(data, {'files': {a:filename : {'content' :a:content}}})
    return githubapi#util#Get('gists/' . a:id, " -d '" . json_encode(data) . "' -X PATCH -u " . a:user . ':' .a:password)
endfunction

""
" @public
" List gist commits
"
" Github API : GET /gists/:id/commits
function! githubapi#gist#ListCommits(id) abort
    return githubapi#util#Get(join(['gists', a:id, 'commits'], '/'), '')
endfunction

""
" @public
" Star a gist
"
" Github API : PUT /gists/:id/star
function! githubapi#gist#Star(user,password,id) abort
    return githubapi#util#GetStatus(join(['gists', a:id, 'star'], '/'),
                \ ' -X PUT -u ' . a:user . ':' . a:password) == 204
endfunction

""
" @public
" Unstar a gist
"
" Github API : DELETE /gists/:id/star
function! githubapi#gist#Unstar(user,password,id) abort
    return githubapi#util#GetStatus(join(['gists', a:id, 'star'], '/'),
                \ ' -X DELETE -u ' . a:user . ':' . a:password) == 204
endfunction

""
" @public
" Check if a gist is starred
"
" Github API : GET /gists/:id/star
function! githubapi#gist#CheckStar(user,password,id) abort
    return githubapi#util#GetStatus(join(['gists', a:id, 'star'], '/'),
                \ ' -u ' . a:user . ':' . a:password) == 204
endfunction

""
" @public
" Fork a gist
"
" Github API : POST /gists/:id/forks
function! githubapi#gist#Fork(user,password,id) abort
    return githubapi#util#Get(join(['gists', a:id, 'forks'], '/'),
                \ ' -X POST -u ' . a:user . ':' . a:password)
endfunction

""
" @public
" List Fork of a gist
"
" Github API : GET /gists/:id/forks
function! githubapi#gist#ListFork(user,password,id) abort
    return githubapi#util#Get(join(['gists', a:id, 'forks'], '/'),
                \ ' -u ' . a:user . ':' . a:password)
endfunction

""
" @public
" Delete a gist
"
" Github API : DELETE /gists/:id
function! githubapi#gist#Del(user,password,id) abort
    return githubapi#util#GetStatus(join(['gists', a:id], '/'),
                \ ' -X DELETE -u ' . a:user . ':' . a:password) == 204
endfunction
