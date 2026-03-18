# Tier3 - High-level utility library

add_library(tier3 STATIC
    choreoutils.cpp
    mdlutils.cpp
    scenetokenprocessor.cpp
    studiohdrstub.cpp
    tier3.cpp
)

# Includes
target_include_directories(tier3 PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/public/tier2
    ${CMAKE_SOURCE_DIR}/public/tier3
)

# Dependencies
target_link_libraries(tier3 PUBLIC
    tier0
    tier1
    tier2
)

# Installation
install(TARGETS tier3 ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
