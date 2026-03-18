# launcher - Game launcher

add_library(launcher STATIC
    launcher.cpp
)

target_include_directories(launcher PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(launcher PUBLIC
    tier0
    tier1
    tier2
    tier3
    appframework
)

install(TARGETS launcher ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
