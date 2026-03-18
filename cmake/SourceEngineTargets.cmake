# Helper macros for Source Engine CMake build

# Macro to add a source engine library
macro(add_source_engine_lib NAME)
    add_library(${NAME} ${ARGN})
    target_include_directories(${NAME} PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/public
        ${CMAKE_SOURCE_DIR}/public/tier0
        ${CMAKE_SOURCE_DIR}/public/tier1
    )
endmacro()

# Macro to add tier dependencies
macro(add_tier_deps NAME)
    target_link_libraries(${NAME} PUBLIC
        tier0
        tier1
        tier2
    )
endmacro()
