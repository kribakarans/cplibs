# cplibs
Extract the shared-object dependencies of an executable.

**Mar 13 2022 13:14**
- Implemented command line options
```
$ cplibs --help
Usage: cplibs [OPTION] [FILE] ...
Extract the shared-object dependencies of an executable
Options:
    -d  --directory <target-directory>
                   -- Copy extracted file to the target-directory
    -v  --version  -- Print pckage version
    -h  --help     -- Show this message
```

**References:**<br>
https://gist.github.com/ekimekim/33fbe944508da6cfce86<br>
https://h3manth.com/content/copying-shared-library-dependencies<br>
https://www.commandlinefu.com/commands/view/10238/copy-all-shared-libraries-for-a-binary-to-directory
