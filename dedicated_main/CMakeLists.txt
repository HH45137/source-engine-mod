# dedicated_main - Dedicated server executable

set(DEDICATED_MAIN_SOURCES
    main.cpp
)

# Platform-specific sources
if(WIN32)
    list(APPEND DEDICATED_MAIN_SOURCES
        dedicated_main.rc
    )
endif()

add_executable(dedicated_main
    ${DEDICATED_MAIN_SOURCES}
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

# Platform-specific libs
if(WIN32)
    target_link_libraries(dedicated_main PRIVATE
        user32
        shell32
    )
else()
    target_link_libraries(dedicated_main PRIVATE
        dl
    )
endif()

install(TARGETS dedicated_main RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
