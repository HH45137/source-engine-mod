# vguimatsurface - VGUI Material Surface

add_library(vguimatsurface STATIC
    Clip2D.cpp
    Cursor.cpp
    ../public/filesystem_helpers.cpp
    FontTextureCache.cpp
    Input.cpp
    MatSystemSurface.cpp
    asanstubs.cpp
    TextureDictionary.cpp
    ../vgui2/src/vgui_key_translation.cpp
    ../public/vgui_controls/vgui_controls.cpp
    ../public/tier0/memoverride.cpp
)

target_include_directories(vguimatsurface PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/public/tier2
)

target_link_libraries(vguimatsurface PUBLIC
    tier0
    tier1
    tier2
    tier3
    vgui2
    materialsystem
)

install(TARGETS vguimatsurface ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
