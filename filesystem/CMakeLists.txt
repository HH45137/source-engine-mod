# filesystem - File system implementation

add_library(filesystem SHARED
    basefilesystem.cpp
    packfile.cpp
    filetracker.cpp
    filesystem_async.cpp
    filesystem_stdio.cpp
    ${CMAKE_SOURCE_DIR}/public/kevvaluescompiler.cpp
    ${CMAKE_SOURCE_DIR}/public/zip_utils.cpp
    QueuedLoader.cpp
)

# Platform-specific sources
if(NOT WIN32)
    target_sources(filesystem PRIVATE
        linux_support.cpp
    )
endif()

# Defines
target_compile_definitions(filesystem PRIVATE
    FILESYSTEM_STDIO_EXPORTS=1
    DONT_PROTECT_FILEIO_FUNCTIONS=1
    SUPPORT_PACKED_STORE=1
    LAUNCHERONLY=1
)

# Includes
target_include_directories(filesystem PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/common
)

# Dependencies
target_link_libraries(filesystem PUBLIC
    tier0
    vpklib
    tier1
    tier2
    vstdlib
)

# Platform-specific libs
if(WIN32)
    target_link_libraries(filesystem PRIVATE shell32)
endif()

install(TARGETS filesystem RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
