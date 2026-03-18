# soundemittersystem - Sound emitter system

add_library(soundemittersystem STATIC
    ../game/shared/interval.cpp
    soundemittersystembase.cpp
    ../public/SoundParametersInternal.cpp
    ../public/tier0/memoverride.cpp
)

target_include_directories(soundemittersystem PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/game/shared
)

target_link_libraries(soundemittersystem PUBLIC
    tier0
    tier1
    tier2
)

install(TARGETS soundemittersystem ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
