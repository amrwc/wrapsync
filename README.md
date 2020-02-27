# w(r)ap(sync)

`wrapsync` is a wrapper script for `rsync`. Its main purpose is to simplify `rsync`'ing common directories.

## Setup and usage

1. Prepare the variables inside of the `wrapsync` script file.

   Required:

   - `REMOTE_PATH` – an absolute path to the parent directory on the remote machine, e.g. `jon@ssh.example.com:/home/jon/Documents/repositories`,
   - `LOCAL_PATH` – an absolute path to the local parent directory, e.g. `/usr/Users/jon/Documents/repositories`.

   Optional:

   - `FLAGS` – `rsync` flags; defaults to no flags,
   - `EXCLUDE` – an array of patterns of file names/directory names; what matches these patterns will be excluded from synchronising; defaults to no exclusions; e.g.:
   ```bash
   readonly EXCLUDE=(
      'node_modules'
      'vendor'
      'bin'
      '*.class'
   )
   ```

2. Create a symlink to the script for convenience.

   ```bash
   # Example:
   ln -s "$(pwd)/wrapsync" /usr/local/bin/ws
   ```

3. Now the script can be used from anywhere:

   ```bash
   ws <pull/push> <service> [options]

   # Examples:
   ws push linux --update
   ws pull windows --delete
   ```
