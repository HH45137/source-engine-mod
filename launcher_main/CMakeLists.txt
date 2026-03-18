# launcher_main - Launcher main executable

add_executable(hl2_launcher
    main.cpp
)

# Platform-specific sources
if(WIN32)
    target_sources(hl2_launcher PRIVATE
        launcher_main.rc
    )
endif()

target_include_directories(hl2_launcher PRIVATE
    ${CMAKE_SOURCE_DIR}/public
)

target_link_libraries(hl2_launcher PRIVATE
    tier0
    tier1
    tier2
    tier3
    launcher
    appframework
    engine
)

# Platform libs
if(WIN32)
    target_link_libraries(hl2_launcher PRIVATE user32 shell32)
else()
    target_link_libraries(hl2_launcher PRIVATE dl log)
endif()

install(TARGETS hl2_launcher RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
