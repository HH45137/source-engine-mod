# Tier2 - Advanced utility library

add_library(tier2 STATIC
    beamsegdraw.cpp
    defaultfilesystem.cpp
    dmconnect.cpp
    fileutils.cpp
    keybindings.cpp
    ${CMAKE_SOURCE_DIR}/public/map_utils.cpp
    ${CMAKE_SOURCE_DIR}/public/materialsystem/MaterialSystemUtil.cpp
    camerautils.cpp
    meshutils.cpp
    p4helpers.cpp
    renderutils.cpp
    riff.cpp
    soundutils.cpp
    tier2.cpp
    util_init.cpp
    utlstreambuffer.cpp
    vconfig.cpp
    keyvaluesmacros.cpp
)

target_include_directories(tier2 PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/common
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/public/tier2
)

target_link_libraries(tier2 PUBLIC
    tier0
    tier1
    vstdlib
)

install(TARGETS tier2 ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
