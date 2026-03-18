# stub_steam - Steam API stub

# On Windows, build as SHARED to generate an import library (.lib) 
# that properly exports symbols for both regular linking and __imp_ import linking
if(WIN32)
    add_library(stub_steam SHARED
        steam_api.cpp
    )
    # Define STEAM_API_EXPORTS when building the DLL
    target_compile_definitions(stub_steam PRIVATE STEAM_API_EXPORTS)
else()
    add_library(stub_steam STATIC
        steam_api.cpp
    )
endif()

target_include_directories(stub_steam PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
)

target_link_libraries(stub_steam PUBLIC tier0)

install(TARGETS stub_steam RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
