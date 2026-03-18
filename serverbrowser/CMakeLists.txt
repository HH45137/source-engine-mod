# serverbrowser - Server browser

add_library(serverbrowser STATIC
    serverbrowser.cpp
)

target_include_directories(serverbrowser PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(serverbrowser PUBLIC
    tier0
    tier1
    tier2
    tier3
)

install(TARGETS serverbrowser ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
