# launcher - Game launcher

# Base sources
set(LAUNCHER_SOURCES
    launcher.cpp
    ${CMAKE_SOURCE_DIR}/public/filesystem_init.cpp
    reslistgenerator.cpp
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
)

# Android-specific sources
if(ANDROID)
    list(APPEND LAUNCHER_SOURCES
        android/main.cpp
        android/crashhandler.cpp
    )
endif()

add_library(launcher STATIC
    ${LAUNCHER_SOURCES}
)

# Defines
target_compile_definitions(launcher PUBLIC
    LAUNCHERONLY=1
)

target_include_directories(launcher PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/android/libunwind
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/common
)

# SDL include
if(USE_SDL AND SDL2_FOUND)
    target_include_directories(launcher PRIVATE ${SDL2_INCLUDE_DIRS})
endif()

# Dependencies
target_link_libraries(launcher PUBLIC
    tier0
    tier1
    tier2
    tier3
    vstdlib
    steam_api
    appframework
)

# SDL dependency
if(USE_SDL AND SDL2_FOUND)
    target_link_libraries(launcher PRIVATE ${SDL2_LIBRARIES})
endif()

# Platform libs
if(WIN32)
    target_link_libraries(launcher PRIVATE
        user32
        ole32
        shell32
    )
endif()

# ToGL (optional)
if(USE_TOGL)
    target_link_libraries(launcher PUBLIC togl)
endif()

# UNWIND (optional, for stack unwinding)
if(USE_UNWIND)
    target_link_libraries(launcher PUBLIC unwind)
endif()

install(TARGETS launcher ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
