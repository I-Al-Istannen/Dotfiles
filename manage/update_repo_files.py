#!/bin/env python
import os
import shutil
import sys
from argparse import ArgumentParser

from filemappings import get_normalized_locations


# noinspection PyShadowingNames
def copy_to_repo(dry_run: bool = False):
    for repo_location, location in get_normalized_locations():
        ensure_parent_exists(repo_location, dry_run)

        if not dry_run:
            shutil.copy2(location, repo_location)
        else:
            print("Copying '{0:<60}' to '{1}'".format(location, repo_location))
    print("Files copied to this repo")


# noinspection PyShadowingNames
def ensure_parent_exists(path, dry_run: bool):
    if dry_run:
        print("    Ensuring parent of '{0}' exists.".format(path))
        return

    dirname = os.path.dirname(path)
    if not os.path.exists(dirname):
        os.makedirs(dirname)


def generate_backup_path(location):
    return location + ".pre-install-script"


# noinspection PyShadowingNames
def copy_from_repo(dry_run: bool = False):
    for repo_location, location in get_normalized_locations():

        ensure_parent_exists(location, dry_run)

        if os.path.exists(location):
            backup_path = generate_backup_path(location)

            if not dry_run:
                shutil.move(location, backup_path)
            else:
                print(
                      "Backing up: '{0:<60}' to '{1}'".format(location,
                                                              backup_path)
                )

        if not dry_run:
            shutil.copy(repo_location, location)
        else:
            print("Copying     '{0:<60}' to '{1}'".format(repo_location,
                                                          location))
    print("Files copied to the system directories")


# noinspection PyShadowingNames
def restore_to_backup(dry_run: bool = False):
    for repo_location, location in get_normalized_locations():
        backup_path = generate_backup_path(location)

        if not os.path.exists(backup_path):
            if dry_run:
                print("Skipping '{0}' as it has no backup".format(backup_path))
            continue

        if not dry_run:
            shutil.move(backup_path, location)
        else:
            print("Copying  '{0:<60}' to '{1}'".format(backup_path, location))

    print("Backup restored")


def ensure_user_name_is_wiped():
    user_name = os.getenv("USER", str)

    if not user_name:
        print("System did not expose the $USER variable. Exiting.")
        exit(0)

    found_match = False

    for _, location in get_normalized_locations():
        with open(location, "r") as file:
            for line_number, line in enumerate(file.readlines()):
                if user_name in line:
                    found_match = True
                    print(
                          "Found user name in line {0} of '{1}'".format(
                                line_number, location
                          )
                    )

    if found_match:
        print("Your user name was found. Exiting action!")
        exit(0)
    else:
        print("Did not find a match. Username seems to be safe.")


if __name__ == '__main__':
    parser = ArgumentParser(
          prog="Update Repo script",
          description="A program to update the dotfiles"
    )
    parser.add_argument(
          "--to-repo",
          dest="to_repo",
          help="Copy to the repo",
          default=False,
          action="store_true"
    )
    parser.add_argument(
          "--from-repo",
          dest="from_repo",
          help="Copy from the repo",
          default=False,
          action="store_true"
    )
    parser.add_argument(
          "--restore-backup",
          dest="restore_backup",
          help="Restores the backup",
          default=False,
          action="store_true"
    )
    parser.add_argument(
          "--dry",
          dest="dry_run",
          help="Prints what it does, performs no action",
          default=False,
          action="store_true"
    )

    namespace = parser.parse_args(sys.argv[1:])

    dry_run = namespace.dry_run

    os.chdir("..")

    if namespace.to_repo:
        ensure_user_name_is_wiped()
        copy_to_repo(dry_run=dry_run)
    elif namespace.from_repo:
        copy_from_repo(dry_run=dry_run)
    elif namespace.restore_backup:
        restore_to_backup(dry_run=dry_run)
    else:
        print("No option given!")
        parser.print_help()
        exit(1)
