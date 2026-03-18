# game/client - Client DLL

# Collect source files from game/client directory
file(GLOB CLIENT_SOURCES
    "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.c"
)

# Add common sources
set(CLIENT_COMMON_SOURCES
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
)

add_library(client SHARED
    ${CLIENT_SOURCES}
    ${CLIENT_COMMON_SOURCES}
)

# Add in_touch.cpp for touch support
if(ANDROID)
    target_sources(client PRIVATE in_touch.cpp)
endif()

target_compile_definitions(client PRIVATE DISABLE_STEAM=1)

target_include_directories(client PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/game_controls
    ${CMAKE_SOURCE_DIR}/common
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/vgui2/include
    ${CMAKE_SOURCE_DIR}/vgui2/controls
    ${CMAKE_SOURCE_DIR}/game/shared
)

target_link_libraries(client PRIVATE
    tier0
    particles
    dmxloader
    vgui_controls
    matsys_controls
    tier1
    tier2
    tier3
    mathlib
    vstdlib
    choreoobjects
    steam_api
    bitmap
    vtf
)

# Platform libs
if(WIN32)
    target_link_libraries(client PRIVATE user32)
endif()

install(TARGETS client RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
