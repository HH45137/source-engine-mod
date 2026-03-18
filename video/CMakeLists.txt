# video - Video playback

add_library(video SHARED
    videoservices.cpp
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
)

target_include_directories(video PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/common
)

target_link_libraries(video PUBLIC
    tier0
    tier1
    tier2
    tier3
    vstdlib
)

# Platform libs
if(WIN32)
    target_link_libraries(video PRIVATE user32)
elseif(APPLE)
    target_link_libraries(video PRIVATE CoreGraphics)
endif()

install(TARGETS video RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
