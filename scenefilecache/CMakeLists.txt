# scenefilecache - Scene file cache

add_library(scenefilecache SHARED
    SceneFileCache.cpp
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
)

# Defines
target_compile_definitions(scenefilecache PUBLIC
    _WINDOWS=1
)

target_include_directories(scenefilecache PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/game/shared
)

target_link_libraries(scenefilecache PUBLIC
    tier0
    tier1
)

# Platform libs
if(ANDROID)
    target_link_libraries(scenefilecache PRIVATE android_support)
endif()

install(TARGETS scenefilecache RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
