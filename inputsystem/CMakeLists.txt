# inputsystem - Input system

# Define VERSION_SAFE_STEAM_API_INTERFACES (from wscript configure)
add_definitions(-DVERSION_SAFE_STEAM_API_INTERFACES)

# Source files
set(INPUTSYSTEM_SOURCES
    inputsystem.cpp
    joystick_sdl.cpp
    touch_sdl.cpp
    key_translation.cpp
    steamcontroller.cpp
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
)

# Windows-specific source files
if(WIN32)
    list(APPEND INPUTSYSTEM_SOURCES novint.cpp)
endif()

add_library(inputsystem SHARED
    ${INPUTSYSTEM_SOURCES}
)

target_include_directories(inputsystem PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/common
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/thirdparty/SDL
)

# Find SDL2 library
if(WIN32)
    if(CMAKE_BUILD_TYPE STREQUAL "Debug" OR CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
        set(SDL2_CONFIG "lib/win32/amd64/SDL2.lib" CACHE PATH "SDL2 library path")
    else()
        set(SDL2_CONFIG "lib/win32/amd64/SDL2.lib" CACHE PATH "SDL2 library path")
    endif()
    find_library(SDL2_LIBRARY NAMES SDL2 PATHS ${CMAKE_SOURCE_DIR}/lib/win32/amd64 ${CMAKE_SOURCE_DIR}/lib/win32/x86)
endif()

target_link_libraries(inputsystem PUBLIC
    tier0
    tier1
    tier2
    vstdlib
    ${SDL2_LIBRARY}
    stub_steam
)

# Windows-specific libraries
if(WIN32)
    target_link_libraries(inputsystem PUBLIC
        USER32
    )
endif()

# Copy stub_steam DLL to output directory on Windows
if(WIN32)
    add_custom_command(TARGET inputsystem POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            $<TARGET_FILE:stub_steam>
            $<TARGET_FILE_DIR:inputsystem>
    )
endif()

# Installation
install(TARGETS inputsystem LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
