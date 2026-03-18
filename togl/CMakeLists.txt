# togl - ToGL OpenGL abstraction

add_library(togl SHARED
    linuxwin/dx9asmtogl2.cpp
    linuxwin/dxabstract.cpp
    linuxwin/glentrypoints.cpp
    linuxwin/glmgr.cpp
    linuxwin/glmgrbasics.cpp
    linuxwin/cglmtex.cpp
    linuxwin/cglmfbo.cpp
    linuxwin/cglmprogram.cpp
    linuxwin/cglmbuffer.cpp
    linuxwin/cglmquery.cpp
    linuxwin/asanstubs.cpp
)

# macOS specific
if(APPLE)
    target_sources(togl PRIVATE
        linuxwin/glmgrcocoa.mm
    )
endif()

# Defines
target_compile_definitions(togl PUBLIC
    TOGL_DLL_EXPORT=1
    strncpy=use_Q_strncpy_instead
    _snprintf=use_Q_snprintf_instead
)

target_include_directories(togl PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(togl PUBLIC
    tier0
    tier1
    tier2
    vstdlib
    mathlib
)

# OpenGL
if(WIN32)
    target_link_libraries(togl PRIVATE opengl32)
elseif(APPLE)
    target_link_libraries(togl PRIVATE OpenGL Carbon)
else()
    target_link_libraries(togl PRIVATE GL)
endif()

install(TARGETS togl RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
