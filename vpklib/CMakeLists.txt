# vpklib - Valve Package library

add_library(vpklib STATIC
    packedstore.cpp
    ${CMAKE_SOURCE_DIR}/common/simplebitstring.cpp
)

target_include_directories(vpklib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/common
)

target_link_libraries(vpklib PUBLIC
    tier0
    tier1
)

install(TARGETS vpklib ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
