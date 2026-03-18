# inputsystem - Input system

add_library(inputsystem STATIC
    inputsystem.cpp
    joystick_sdl.cpp
    touch_sdl.cpp
    key_translation.cpp
    steamcontroller.cpp
    ../public/tier0/memoverride.cpp
)

target_include_directories(inputsystem PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/common
)

target_link_libraries(inputsystem PUBLIC
    tier0
    tier1 
    tier2
    vstdlib
    SDL2
    steam_api
)

install(TARGETS inputsystem ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
