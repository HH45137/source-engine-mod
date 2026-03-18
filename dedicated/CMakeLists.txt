# dedicated - Dedicated server library

# Base sources
set(DEDICATED_SOURCES
    filesystem.cpp
    ${CMAKE_SOURCE_DIR}/public/filesystem_init.cpp
    ${CMAKE_SOURCE_DIR}/common/netapi.cpp
    ${CMAKE_SOURCE_DIR}/common/SteamAppStartup.cpp
    sys_common.cpp
    sys_ded.cpp
    console/conproc.cpp
    console/textconsole.cpp
    ${CMAKE_SOURCE_DIR}/filesystem/filetracker.cpp
    ${CMAKE_SOURCE_DIR}/filesystem/basefilesystem.cpp
    ${CMAKE_SOURCE_DIR}/filesystem/packfile.cpp
    ${CMAKE_SOURCE_DIR}/filesystem/filesystem_async.cpp
    ${CMAKE_SOURCE_DIR}/filesystem/filesystem_stdio.cpp
    ${CMAKE_SOURCE_DIR}/filesystem/QueuedLoader.cpp
    ${CMAKE_SOURCE_DIR}/public/zip_utils.cpp
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
)

# Platform-specific sources
if(WIN32)
    list(APPEND DEDICATED_SOURCES
        sys_windows.cpp
        vgui/CreateMultiplayerGameServerPage.cpp
        vgui/MainPanel.cpp
        ${CMAKE_SOURCE_DIR}/public/vgui_controls/vgui_controls.cpp
        vgui/vguihelpers.cpp
        console/TextConsoleWin32.cpp
    )
else()
    list(APPEND DEDICATED_SOURCES
        sys_linux.cpp
        console/TextConsoleUnix.cpp
        ${CMAKE_SOURCE_DIR}/filesystem/linux_support.cpp
    )
endif()

add_library(dedicated STATIC
    ${DEDICATED_SOURCES}
)

# Defines
target_compile_definitions(dedicated PUBLIC
    LAUNCHERONLY=1
    SUPPORT_PACKED_STORE=1
    DEDICATED=1
)

target_include_directories(dedicated PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/common
)

# Platform libs
target_link_libraries(dedicated PUBLIC
    tier0
    vpklib
    tier1
    tier2
    tier3
    vstdlib
    steam_api
    appframework
    mathlib
)

# Platform-specific libs
if(WIN32)
    target_link_libraries(dedicated PRIVATE
        vgui_controls
        user32
        shell32
    )
endif()

install(TARGETS dedicated ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
