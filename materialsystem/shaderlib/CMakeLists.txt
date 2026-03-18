# shaderlib - Shader library

add_library(shaderlib STATIC
    BaseShader.cpp
    ShaderDLL.cpp
    shaderlib_cvar.cpp
)

target_include_directories(shaderlib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/..
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(shaderlib PUBLIC
    tier0
    tier1
    tier2
)

install(TARGETS shaderlib ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
