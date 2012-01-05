" Mason File mason.vim:

" build:
" test: 

function Vild_build() 
  call Vild("build")
endfunction


" Todo: Add support for templates-commands in vild files
"       Change vild files to yaml

function Vild(action) 
  " Searches from the directory of the current file upwards until
  " it finds psbuild. 
  " py import vild
  let fname = findfile("vild.yaml", ".;")
  if empty(fname) 
    echo "couldn't find vild" 
  else 
    let buildfile = join(readfile(fname), "\n")
    let cmd = matchstr(buildfile, a:action . "\s*:\s*[^\n]*")
    let cmd = substitute(cmd, a:action . '\s*\:\s*', "", "")
    execute cmd
  endif
endfunction
