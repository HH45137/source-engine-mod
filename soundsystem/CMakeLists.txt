# soundsystem - Sound system

add_library(soundsystem STATIC
    soundsystem.cpp
)

target_include_directories(soundsystem PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(soundsystem PUBLIC
    tier0
    tier1
    tier2
)

install(TARGETS soundsystem ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
