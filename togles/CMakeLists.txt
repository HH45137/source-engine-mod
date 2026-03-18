# togles - ToGL ES OpenGL ES abstraction

add_library(togles SHARED
    togles.cpp
)

target_include_directories(togles PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(togles PUBLIC
    tier0
    tier1
    tier2
)

# OpenGL ES
if(PLATFORM_ANDROID)
    target_link_libraries(togles PRIVATE GLESv2)
endif()

install(TARGETS togles RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
