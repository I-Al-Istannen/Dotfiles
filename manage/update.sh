#!/bin/env bash

execute_python_copy_script() {
    python update_repo_files.py "$@"
}

options="Copy-to-repo Copy-from-repo Restore-Backup Exit"
select opt in ${options}; do
    if [[ "$opt" = "Copy-to-repo" ]]; then
        echo "Okay. Installing files."
        execute_python_copy_script --to-repo
        exit
    elif [ "$opt" = "Copy-from-repo" ]; then
        execute_python_copy_script --from-repo
        exit
    elif [ "$opt" = "Restore-Backup" ]; then
        execute_python_copy_script --restore-backup
        exit
    elif [ "$opt" = "Exit" ]; then
        echo "Bye :)"
        exit
    else
        clear
        echo "Bad option given!"
    fi
done
