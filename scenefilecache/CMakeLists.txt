# scenefilecache - Scene file cache

add_library(scenefilecache STATIC
    scenefilecache.cpp
)

target_include_directories(scenefilecache PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(scenefilecache PUBLIC
    tier0
    tier1
    tier2
    tier3
    filesystem
)

install(TARGETS scenefilecache ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
