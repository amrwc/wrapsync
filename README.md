# w(r)ap(sync)

`wrapsync` is a wrapper script for `rsync`. Its main purpose is to simplify `rsync`'ing common directories.

## Setup and usage

1. Prepare the variables inside of the `wrapsync` script file.

   Required:

   - `USERNAME` – SSH login,
   - `REMOTE_PARENT_DIR_PATH` – an absolute path to the parent directory of `REMOTE_DIR_PATH`, e.g. `${USERNAME}@ssh.example.com:/home/jon/Documents/repositories`; this allows for syncing using the `all` option,
   - `REMOTE_DIR_PATH` – an absolute path to the remote directory containing everything we may want to sync, e.g. `${REMOTE_PARENT_DIR_PATH}/services`,
   - `LOCAL_PARENT_DIR_PATH` – an absolute path to the parent directory of `LOCAL_DIR_PATH`, e.g. `/Users/jon/Documents/repositories`; this allows for syncing using the `all` option,
   - `LOCAL_DIR_PATH` – an absolute path to the local directory containing everything we may want to sync, e.g. `${LOCAL_PARENT_DIR_PATH}/services`.

   Optional:

   - `FLAGS` – `rsync` flags; if no flags are given, this option will be omitted,
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
   cd wrapsync
   ln -s "$(pwd)/wrapsync" /usr/local/bin/ws
   ```

3. Now the script can be used from anywhere:

   ```bash
   ws <pull/push> <service> [options]

   # Examples:
   ws push linux --update
   ws pull windows --delete
   ```
