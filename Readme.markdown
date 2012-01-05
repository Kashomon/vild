
###The Vild build tool

Create a yaml file like so in a project directory:

      ---
      build: !javac *.java
      run: !java MyClass
      # etc ...
      ---

And put these into your .vimrc:
    
      map ,b :call Vild("build") <CR>
      map ,B :call Vild("full_compile") <CR>
      map ,r :call Vild("run") <CR>
      "...etc

And you're good to go.
      
