# vtf - Valve Texture Format

set(platform_special "")
if(WIN32)
    set(platform_special
        s3tc_decode.cpp
    )
endif()

add_library(vtf STATIC
    convert_x360.cpp
    vtf.cpp
    ${platform_special}
)

target_include_directories(vtf PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(vtf PUBLIC
    tier0
    tier1
    tier2
)

install(TARGETS vtf ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
