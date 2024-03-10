#!/usr/bin/env python3.7

import iterm2
import os

def mac_os_ui_mode():
    command = "defaults read -g AppleInterfaceStyle"
    res = os.popen(command).read().strip()
    return res

async def profile_to_use(connection):
    if mac_os_ui_mode() == 'Dark':
        target_profile_name = 'Nord'
    else:
        target_profile_name = 'Edge Light'

    profiles = await iterm2.PartialProfile.async_query(connection)
    for profile in profiles:
        if profile.name == target_profile_name:
            return profile

# ---------------

async def set_default_profile(connection, profile_to_apply):
    await profile_to_apply.async_make_default()

async def update_profile_for_sessions(connection, profile_to_apply):
    app = await iterm2.async_get_app(connection)
    for tab in app.current_window.tabs:
        for session in tab.sessions:
            await session.async_set_profile(profile_to_apply)


async def main(connection):
    target_profile = await profile_to_use(connection)
    await set_default_profile(connection, target_profile)
    await update_profile_for_sessions(connection, target_profile)

# -------------------------------------------------------------

iterm2.run_until_complete(main)
