import os
from typing import List, Tuple

file_locations: List[Tuple[str, str]] = [
    ("zsh/.zshrc", "~/.zshrc"),
    ("zsh/.zprofile", "~/.zprofile"),
    ("termite/config", "~/.config/termite/config"),
    ("nvim/init.vim", "~/.config/nvim/init.vim"),
    ("i3/config", "~/.i3/config"),
    ("polybar/config", "~/.config/polybar/config"),
    ("polybar/pavolume.sh", "~/.config/polybar/pavolume.sh"),
    (
        "polybar/scripts/math-shortcut",
        "~/.config/polybar/scripts/math-shortcut"
    ),
    ("polybar/scripts/spotify", "~/.config/polybar/scripts/spotify.sh"),
    (
        "polybar/scripts/ControlProgramMuteStatus",
        "~/.config/polybar/scripts/ControlProgramMuteStatus"
    ),
    (
        "polybar/scripts/math-shortcut-interpreter",
        "~/.config/polybar/scripts/math-shortcut-interpreter"
    ),
    ("dunst/dunstrc", "~/.config/dunst/dunstrc"),
    ("dunst/test-notifications", "~/.config/dunst/test-notifications"),
    ("compton/compton.conf", "~/.config/compton.conf"),
    ("rofi/config.rasi", "~/.config/rofi/config.rasi"),
    ("neofetch/config", "~/.config/neofetch/config"),
    ("xcompose/.XCompose", "~/.XCompose"),
    ("sh/profile", "~/.profile")
]


def get_normalized_locations():
    for repo_location, location in file_locations:
        yield (
            __normalize_repo_location(repo_location),
            __normalize_location(location)
        )


def __normalize_repo_location(repo_location):
    repo_location = os.path.join("files", repo_location)
    return repo_location


def __normalize_location(location):
    location = os.path.expanduser(location)
    return location
