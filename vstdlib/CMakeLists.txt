# vstdlib - Standard library replacement

add_library(vstdlib STATIC
    coroutine.cpp
    cvar.cpp
    jobthread.cpp
    KeyValuesSystem.cpp
    random.cpp
    vcover.cpp
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
)

# Platform-specific sources
if(WIN32)
    target_sources(vstdlib PRIVATE
        processutils.cpp
    )
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        target_sources(vstdlib PRIVATE
            coroutine_win64.masm
            GetStackPtr64.masm
        )
    endif()
endif()

# Defines
target_compile_definitions(vstdlib PUBLIC VSTDLIB_DLL_EXPORT=1)

# Includes
target_include_directories(vstdlib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/public/vstdlib
)

# Dependencies
target_link_libraries(vstdlib PUBLIC tier0 tier1)

# Platform libs
if(APPLE)
    target_link_libraries(vstdlib PRIVATE "-framework CoreServices")
endif()

install(TARGETS vstdlib
    RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
