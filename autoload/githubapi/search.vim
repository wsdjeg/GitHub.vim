""
" @public
" Search for repos, for how to {sort} result, you can use `stars`,`forks` and
" `updated`. and for {order} you can use `asc` and `desc`.for {q} see:
" Input: >
"                 {
"                 'in'       : 'name,description',
"                 'size'     : '',
"                 'forks'    : '',
"                 'fork'     : '',
"                 'created'  : '',
"                 'pushed'   : '',
"                 'user'     : '',
"                 'language' : '',
"                 'stars'    : '',
"                 'keywords' : ''
"                 }
" <
"
" Github API : GET /search/repositories
function! githubapi#search#SearchRepos(q,sort,order) abort
    let url = 'search/repositories'
    let _sort = ['stars', 'forks', 'updated']
    let _order = ['asc', 'desc']
    let url = githubapi#util#parserArgs(url, 'sort', a:sort, _sort, '')
    if index(_sort, a:sort) != -1
        let url = githubapi#util#parserArgs(url, 'order', a:order, _order, 'desc')
    endif
    if stridx(url, '?') == -1
        let url .= '?'
    else
        let url .= '&'
    endif
    let url .= s:parser(a:q, s:repo_scopes)
    return githubapi#util#Get(url, [])
endfunction

function! githubapi#search#SearchCode(q,sort,order) abort
    let url = 'search/code'
    let _sort = ['indexed']
    let _order = ['asc', 'desc']
    let url = githubapi#util#parserArgs(url, 'sort', a:sort, _sort, '')
    if index(_sort, a:sort) != -1
        let url = githubapi#util#parserArgs(url, 'order', a:order, _order, 'desc')
    endif
    if stridx(url, '?') == -1
        let url .= '?'
    else
        let url .= '&'
    endif
    let url .= s:parser(a:q, s:code_scopes)
    return githubapi#util#Get(url, [])
endfunction

function! githubapi#search#SearchIssues(q,sort,order) abort
    let url = 'search/issues'
    let _sort = ['comments', 'created', 'updated']
    let _order = ['asc', 'desc']
    let url = githubapi#util#parserArgs(url, 'sort', a:sort, _sort, '')
    if index(_sort, a:sort) != -1
        let url = githubapi#util#parserArgs(url, 'order', a:order, _order, 'desc')
    endif
    if stridx(url, '?') == -1
        let url .= '?'
    else
        let url .= '&'
    endif
    let url .= s:parser(a:q, s:issues_scopes)
    return githubapi#util#Get(url, [])
endfunction

function! githubapi#search#SearchUsers(q,sort,order) abort
    let url = 'search/users'
    let _sort = ['followers', 'repositories', 'joined']
    let _order = ['asc', 'desc']
    let url = githubapi#util#parserArgs(url, 'sort', a:sort, _sort, '')
    if index(_sort, a:sort) != -1
        let url = githubapi#util#parserArgs(url, 'order', a:order, _order, 'desc')
    endif
    if stridx(url, '?') == -1
        let url .= '?'
    else
        let url .= '&'
    endif
    let url .= s:parser(a:q, s:users_scopes)
    return githubapi#util#Get(url, [])
endfunction

" default scopes
let s:repo_scopes = {
            \ 'in'       : 'name,description',
            \ 'size'     : '',
            \ 'forks'    : '',
            \ 'fork'     : '',
            \ 'created'  : '',
            \ 'pushed'   : '',
            \ 'user'     : '',
            \ 'language' : '',
            \ 'stars'    : '',
            \ 'keywords' : ''
            \ }
let s:code_scopes = {
            \ 'in'        : 'file',
            \ 'path'      : '',
            \ 'filename'  : '',
            \ 'extension' : '',
            \ 'user'      : '',
            \ 'size'      : '',
            \ 'forks'     : '',
            \ 'fork'      : '',
            \ 'language'  : ''
            \ }
" https://help.github.com/articles/searching-issues/
let s:issues_scopes = {
            \ 'type'      : 'pr,issue',
            \ 'in'        : 'title,body,comments',
            \ 'author'    : '',
            \ 'assignee'  : '',
            \ 'mentions'  : '',
            \ 'commenter' : '',
            \ 'involves'  : '',
            \ 'team'      : '',
            \ 'state'     : '',
            \ 'label'     : '',
            \ 'milestone' : '',
            \ 'no'        : '',
            \ 'language'  : '',
            \ 'is'        : '',
            \ 'created'   : '',
            \ 'updated'   : '',
            \ 'merged'    : '',
            \ 'status'    : '',
            \ 'head'      : '',
            \ 'base'      : '',
            \ 'closed'    : '',
            \ 'comments'  : '',
            \ 'user'      : ''
            \ }
let s:users_scopes = {
            \ 'type' : 'org,user',
            \ 'in' : 'username,email',
            \ 'repos' : '',
            \ 'location' : '',
            \ 'language' : '',
            \ 'created' : '',
            \ 'followers' : ''
            \ }
function! s:parser(q,scopes) abort
    let scopes = copy(a:scopes)
    " parser q
    let rs = ''
    if type(a:q) == type({})
        if has_key(a:q, 'keywords')
            let rs .= 'q=' . get(a:q, 'keywords')
            call remove(a:q, 'keywords')
        endif
        for scope in keys(scopes)
            if has_key(a:q, scope) && !empty(get(a:q, scope))
                let rs .= '+' . scope . ':' . get(a:q, scope)
            endif
        endfor
    elseif type(a:q) == type('')
        let rs .= 'q=' . a:q
    endif
    return rs
endfunction

fu! s:valid(args,base) abort
    if type(a:args) == type('') && index(a:base, a:args) != -1
        return 1
    endif
    if type(a:args) != type(a:base)
        return 0
    endif
    for a in a:args
        if index(a:base, a) == -1
            return 0
        endif
    endfor
    return 1
endf
