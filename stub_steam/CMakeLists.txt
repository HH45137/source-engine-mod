# stub_steam - Steam API stub

add_library(stub_steam SHARED
    steam_api.cpp
)

target_include_directories(stub_steam PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
)

target_link_libraries(stub_steam PUBLIC tier0)

install(TARGETS stub_steam RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
