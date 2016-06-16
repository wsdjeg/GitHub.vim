"List who the authenticated user is following:
"GET /user/following
function! githubapi#user#ListFollowing(auth) abort
   let following = []
   for i in range(1,githubapi#util#GetLastPage('user/following'))
       call extend(following,githubapi#util#Get('user/following?page=' . i,''))
   endfor
   return following
endfunction
