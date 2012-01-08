#The Vild build tool

## Installing 

Clone the github directrory into ~/.vim/plugin  

    cd ~/.vim/plugin
    git clone git://github.com/Kashomon/vild.git

## Using

Create a "vild.yaml" file like so in a project directory:

    ---
    build: !javac *.java
    run: !java MyClass
    dir: /path/to/some/dir
    # etc ...
    ---

And put these into your .vimrc:
    
    map ,b :call Vild_Execute("build") <CR>
    map ,r :call Vild_Execute("run") <CR>
    map ,e :echo Vild_Get("dir") <CR>
    "...etc

And you're good to go.

## Advanced Features
      
Vild also has the ability for the user to provide references.

    ---
    proj_root: /path/to/my/project/root 
    export_project_root: let g:my_project_root = $vild:proj_root
    ---

Be careful!  

Vild will recursively fill out your references, and so it's easy
to create infinitely loops.  Watch out for circular references.

