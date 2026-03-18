# particles - Particle system

add_library(particles STATIC
    particles.cpp
)

target_include_directories(particles PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/public/tier2
)

target_link_libraries(particles PUBLIC
    tier0
    tier1
    tier2
    tier3
    mathlib
)

install(TARGETS particles ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
