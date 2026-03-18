# datacache - Data cache

add_library(datacache SHARED
    datacache.cpp
    mdlcache.cpp
    ${CMAKE_SOURCE_DIR}/public/studio.cpp
    ${CMAKE_SOURCE_DIR}/public/studio_virtualmodel.cpp
    ${CMAKE_SOURCE_DIR}/common/studiobyteswap.cpp
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
)

target_include_directories(datacache PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/common
)

target_link_libraries(datacache PUBLIC
    tier0
    tier1
    tier2
    tier3
)

install(TARGETS datacache RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
