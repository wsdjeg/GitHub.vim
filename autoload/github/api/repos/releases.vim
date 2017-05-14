""
" @public
" Create an release
"
" Input: >
" {
"  "tag_name": "v1.0.0",
"  "target_commitish": "master",
"  "name": "v1.0.0",
"  "body": "Description of the release",
"  "draft": false,
"  "prerelease": false
" }
" <
" Github API : POST /repos/:owner/:repo/releases
function! github#api#repos#releases#Create(owner,repo,user,password, release) abort
    return github#api#util#Get('repos/' . a:owner . '/' . a:repo . '/releases',
                \ ['-X', 'POST', '-d', json_encode(a:release),
                \ '-u', a:user . ':' . a:password])
endfunction
