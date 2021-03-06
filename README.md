# w(r)ap(sync)

`wrapsync` is a wrapper script for `rsync`. Its main purpose is to simplify `rsync`'ing common directories.

_NOTE: This project is somewhat deprecated in favour of [wrapsync2][wrapsync2]._

## Setup and usage

### Setup script

```bash
cd wrapsync
./bin/setup.sh
```

Example walkthrough:

```
cd wrapsync
./bin/setup.sh
$ Your SSH username: amrwc
$ Remote parent directory path (full SSH URL): amrwc@ssh-amrwc.example.com:/programming
$ Remote directory path (full SSH URL): amrwc@ssh-amrwc.example.com:/programming/repositories
$ Local parent directory (prefer absolute paths): /Users/amrwc/Documents/programming
$ Local directory (prefer absolute paths): /Users/amrwc/Documents/programming/repositories
$ Rsync flags (just the letters) [aP]: P
$ Rsync excludes (wrap in quotes and separate with spaces if multiple): "node_modules vendor bin *.class"
```

Now that the script has been prepared, it can be used as follows:

```bash
# Example project path: /Users/amrwc/Documents/programming/repositories/coolproject
ws push coolproject --delete

# Upload all projects from the `repositories` directory to the remote server
ws push all
```

### Manual setup

1. Prepare the variables inside of the `wrapsync` script file.

   Required:

   - `USERNAME` – SSH login,
   - `REMOTE_PARENT_DIR_PATH` – an absolute path to the parent directory of `REMOTE_DIR_PATH`, e.g. `${USERNAME}@ssh.example.com:/home/jon/Documents/repositories`; this enables syncing using the `all` option,
   - `REMOTE_DIR_PATH` – an absolute path to the remote directory containing everything we may want to sync, e.g. `${REMOTE_PARENT_DIR_PATH}/services`,
   - `LOCAL_PARENT_DIR_PATH` – an absolute path to the parent directory of `LOCAL_DIR_PATH`, e.g. `/Users/jon/Documents/repositories`; this enables syncing using the `all` option,
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

[wrapsync2]: https://github.com/amrwc/wrapsync2
