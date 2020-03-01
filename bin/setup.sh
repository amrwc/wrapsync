#!/usr/bin/env bash

readonly FILE_NAME='wrapsync'

function replace_constant() {
	local escaped_replacement=$(printf '%s' "${2}" | sed 's:[][\/.^$*@]:\\&:g')
	perl -pi -e "s/${1}/${escaped_replacement}/g" "${FILE_NAME}"
}

# Backup the file
cp "${FILE_NAME}" "${FILE_NAME}.bak"

# Set the required variables
read -rp 'Your SSH username: ' ssh_username
to_be_replaced='SSH_USERNAME='\''CHANGE_ME'\'''
replacement="SSH_USERNAME='${ssh_username}'"
replace_constant "${to_be_replaced}" "${replacement}"

read -rp 'Remote paretnt dirirectory path (full SSH URL): ' remote_parent_dir_path
to_be_replaced='REMOTE_PARENT_DIR_PATH="\$\{SSH_USERNAME\}\@ssh.example.com:CHANGE_ME"'
replacement="REMOTE_PARENT_DIR_PATH='${remote_parent_dir_path}'"
replace_constant "${to_be_replaced}" "${replacement}"

read -rp 'Remote directory path (full SSH URL): ' remote_dir_path
to_be_replaced='REMOTE_DIR_PATH="\$\{REMOTE_PARENT_DIR_PATH\}\/CHANGE_ME"'
replacement="REMOTE_DIR_PATH='${remote_dir_path}'"
replace_constant "${to_be_replaced}" "${replacement}"

read -rp 'Local parent directory (prefer absolute paths): ' local_parent_dir_path
to_be_replaced='LOCAL_PARENT_DIR_PATH='\''CHANGE_ME'\'''
replacement="LOCAL_PARENT_DIR_PATH='${local_parent_dir_path}'"
replace_constant "${to_be_replaced}" "${replacement}"

read -rp 'Local directory (prefer absolute paths): ' local_dir_path
to_be_replaced='LOCAL_DIR_PATH="\$\{LOCAL_PARENT_DIR_PATH\}\/CHANGE_ME"'
replacement="LOCAL_DIR_PATH='${local_dir_path}'"
replace_constant "${to_be_replaced}" "${replacement}"

read -rp 'Rsync flags (just the letters) [aP]: ' rsync_flags
to_be_replaced='FLAGS='\''aP'\'''
replacement="FLAGS='${rsync_flags:-aP}'"
replace_constant "${to_be_replaced}" "${replacement}"

read -rp 'Rsync excludes (wrap in quotes and separate with spaces if multiple): ' rsync_excludes
to_be_replaced='EXCLUDE=\(\)'
replacement_without_spaces=$(printf "%s" "${rsync_excludes}" | sed -e "s/ /' '/g" | sed -e "s/\"/'/g")
replacement="EXCLUDE=(${replacement_without_spaces})"
replace_constant "${to_be_replaced}" "${replacement}"

# Add symlink for convenience
ln -s "$(pwd)/wrapsync" /usr/local/bin/ws
