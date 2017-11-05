if exists('g:GitHub_api_plugin_loaded')
    finish
endif

let s:save_cpo = &cpoptions
set cpoptions&vim

""
" Github api root url:
"
" default : https://api.github.com/
let g:githubapi_root_url = 'https://api.github.com/'

let g:GitHub_api_plugin_loaded = 1

let &cpoptions = s:save_cpo
unlet s:save_cpo
