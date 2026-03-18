# game/server - Server DLL

# Collect source files from game/server directory
file(GLOB SERVER_SOURCES
    "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.c"
)

# Add common sources
set(SERVER_COMMON_SOURCES
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
)

add_library(server SHARED
    ${SERVER_SOURCES}
    ${SERVER_COMMON_SOURCES}
)

target_compile_definitions(server PRIVATE DISABLE_STEAM=1)

target_include_directories(server PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/game/shared
    ${CMAKE_SOURCE_DIR}/utils/common
    ${CMAKE_SOURCE_DIR}/game/shared/econ
    ${CMAKE_SOURCE_DIR}/NextBot
    ${CMAKE_SOURCE_DIR}/common
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/public
)

target_link_libraries(server PRIVATE
    tier0
    particles
    dmxloader
    tier1
    tier2
    tier3
    mathlib
    vstdlib
    choreoobjects
    steam_api
)

# Platform libs
if(WIN32)
    target_link_libraries(server PRIVATE user32)
endif()

install(TARGETS server RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
