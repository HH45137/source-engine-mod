# vgui2 - VGUI2 UI system

add_library(vgui2 STATIC
    src/vgui.cpp
)

target_include_directories(vgui2 PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/public/tier2
)

target_link_libraries(vgui2 PUBLIC
    tier0
    tier1
    tier2
    tier3
)

install(TARGETS vgui2 ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
