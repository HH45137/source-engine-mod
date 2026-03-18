# dedicated_main - Dedicated server executable

add_executable(dedicated_main
    dedicated_main.cpp
)

target_include_directories(dedicated_main PRIVATE
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(dedicated_main PRIVATE
    tier0
    tier1
    tier2
    tier3
    dedicated
    engine
)

install(TARGETS dedicated_main RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
