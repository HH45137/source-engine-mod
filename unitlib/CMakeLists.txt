# unitlib - Unit test library

add_library(unitlib STATIC
    unitlib.cpp
)

target_include_directories(unitlib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(unitlib PUBLIC
    tier0
    tier1
)

install(TARGETS unitlib ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
