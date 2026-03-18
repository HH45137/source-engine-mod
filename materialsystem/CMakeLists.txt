# materialsystem - Material system

add_library(materialsystem STATIC
    CColorCorrection.cpp
    cmaterial.cpp
    cmaterial_queuefriendly.cpp
    CMaterialSubRect.cpp
    cmaterialvar.cpp
    cmatnullrendercontext.cpp
    colorspace.cpp
    ctexture.cpp
    ../public/filesystem_helpers.cpp
    imagepacker.cpp
    mat_stub.cpp
    materialsystem_global.cpp
    morph.cpp
    occlusionquerymgr.cpp
    shadersystem.cpp
    texturemanager.cpp
    pch_materialsystem.cpp
    cmaterialdict.cpp
    cmaterialsystem.cpp
    cmatlightmaps.cpp
    cmatrendercontext.cpp
    cmatqueuedrendercontext.cpp
    ctexturecompositor.cpp
    ../public/tier0/memoverride.cpp
)

target_include_directories(materialsystem PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/public/tier2
    ${CMAKE_SOURCE_DIR}/public/tier3
)

target_link_libraries(materialsystem PUBLIC
    tier0
    tier1
    tier2
    tier3
    vtf
    bitmap
)

install(TARGETS materialsystem ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
