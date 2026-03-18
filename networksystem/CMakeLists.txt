# networksystem - Network system

add_library(networksystem STATIC
    networksystem.cpp
    netchannel.cpp
    networkclient.cpp
    networkserver.cpp
    udp_process.cpp
    udp_socket.cpp
)

target_include_directories(networksystem PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

target_link_libraries(networksystem PUBLIC
    tier0
    tier1
    tier2
)

install(TARGETS networksystem ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
