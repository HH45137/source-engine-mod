# unicode - Unicode support

add_library(unicode STATIC
    unicode.cpp
)

target_include_directories(unicode PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(unicode PUBLIC
    tier0
    tier1
)

install(TARGETS unicode ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
