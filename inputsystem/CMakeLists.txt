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
)

target_link_libraries(inputsystem PUBLIC
    tier0
    tier1
    tier2
    vstdlib
    SDL2
    steam_api
)

# Windows-specific libraries
if(WIN32)
    target_link_libraries(inputsystem PUBLIC
        USER32
    )
endif()

# Installation
install(TARGETS inputsystem LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
