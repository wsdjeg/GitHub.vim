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
    let url = githubapi#util#parserArgs(url, 'sort', a:sort, ['stars', 'forks', 'updated'], '')
    if index(['stars', 'forks', 'updated'], a:sort) != -1
        let url = githubapi#util#parserArgs(url, 'order', a:order, ['asc', 'desc'], 'desc')
    endif
    if stridx(url, '?') == -1
        let url .= '?'
    else
        let url .= '&'
    endif
    let url .= s:Parser(a:q)
    return githubapi#util#Get(url, [])
endfunction

function! s:Parser(q) abort
    let scopes = {
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
    " parser q
    let rs = ''
    if type(a:q) == type({})
        if has_key(a:q, 'keywords')
            let rs .= 'q=' . get(a:q, 'keywords')
            call remove(a:q, 'keywords')
        endif
        for scope in keys(scopes)
            let rs .= '+' . scope . ':' . get(a:q, scope, get(scopes, scope))
        endfor
    elseif type(a:q) == type('')
        let rs .= 'q=' . a:q
    endif
    return rs
endfunction
