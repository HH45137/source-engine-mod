# appframework - Application framework

add_library(appframework STATIC
    AppSystemGroup.cpp
    ${CMAKE_SOURCE_DIR}/public/filesystem_init.cpp
)

# Platform-specific sources
if(WIN32)
    target_sources(appframework PRIVATE
        VguiMatSysApp.cpp
        WinApp.cpp
    )
else()
    target_sources(appframework PRIVATE
        posixapp.cpp
    )
endif()

# SDL support
if(USE_SDL)
    target_sources(appframework PRIVATE
        sdlmgr.cpp
    )
endif()

# macOS OpenGL
if(APPLE AND USE_TOGL)
    target_sources(appframework PRIVATE
        glmrendererinfo_osx.mm
    )
endif()

# Includes
target_include_directories(appframework PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

# SDL include
if(USE_SDL AND SDL2_FOUND)
    target_include_directories(appframework PRIVATE ${SDL2_INCLUDE_DIRS})
endif()

# Dependencies
target_link_libraries(appframework PUBLIC
    tier0
    tier1
    tier2
    tier3
)

# SDL dependency
if(USE_SDL AND SDL2_FOUND)
    target_link_libraries(appframework PRIVATE ${SDL2_LIBRARIES})
endif()

# macOS specific libs
if(APPLE)
    target_link_libraries(appframework PRIVATE
        "-framework Foundation"
        "-framework AppKit"
        "-framework IOKit"
    )
endif()

# Installation
install(TARGETS appframework ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
