# dedicated - Dedicated server library

add_library(dedicated STATIC
    dedicated.cpp
)

target_include_directories(dedicated PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(dedicated PUBLIC
    tier0
    tier1
    tier2
    tier3
)

install(TARGETS dedicated ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
