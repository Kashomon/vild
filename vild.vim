" Copyright (C) 2011 by Joshua Hoak
" Licensed under the MIT License 

function Vild_build() 
  call Vild_Execute("build")
endfunction

" Todo: Add support for templates-commands in vild files
function Vild_Execute(action) 
  let cmd = Vild_Get(a:action)
  if !empty(cmd)
    execute cmd
  endif
endfunction

function! Vild_Get(action)
  " Searches from the directory of the current file upwards until
  " it finds psbuild. 
  let fname = findfile("vild.yaml", ".;")
  if empty(fname) 
    echo "couldn't find vild" 
    return ""
  else 
    let buildfile = join(readfile(fname), "\n")
    let cmd = matchstr(buildfile, a:action . "\s*:\s*[^\n]*")
    let cmd = substitute(cmd, a:action . '\s*\:\s*', "", "")
    let cmd = s:Replacer(cmd, buildfile)
    return cmd
  endif
endfunction

function s:Replacer(cmd, buildfile)
  if match(a:cmd, "\$vild\:\w*") != -1
    let to_find = matchstr(a:cmd, "\$vild\:[a-zA-Z_]*")
    let to_find = substitute(to_find, "\$vild\:", "", "")
    let next_cmd = matchstr(a:buildfile, to_find . "\s*:\s*[^\n]*")
    let next_cmd = substitute(next_cmd, to_find . '\s*\:\s*', "", "")
    let out = substitute(a:cmd, "\$vild\:[a-zA-Z_]*", next_cmd, "g")
    return s:Replacer(out, a:buildfile)
  else 
    return a:cmd
  endif 
endfunction

autocmd BufNewFile vild.yaml call Vild_GenerateSkeleton()

function! Vild_GenerateSkeleton()
  let out = ""
  \ . "---\n"
  \ . "build: echo \"Not yet created\"\n"
  \ . "run: echo \"Not yet created\"\n"
  \ . "dir: " . expand("%:p:h") . "\n"
  \ . "---"
  s/^/\=out/
endfunction
