# studiorender - Studio model renderer

add_library(studiorender STATIC
    studiorender.cpp
)

target_include_directories(studiorender PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/public/tier2
    ${CMAKE_SOURCE_DIR}/public/tier3
)

target_link_libraries(studiorender PUBLIC
    tier0
    tier1
    tier2
    tier3
    mathlib
    materialsystem
)

install(TARGETS studiorender ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
