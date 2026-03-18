# choreoobjects - Choreography objects

add_library(choreoobjects STATIC
    ${CMAKE_SOURCE_DIR}/game/shared/choreoactor.cpp
    ${CMAKE_SOURCE_DIR}/game/shared/choreochannel.cpp
    ${CMAKE_SOURCE_DIR}/game/shared/choreoevent.cpp
    ${CMAKE_SOURCE_DIR}/game/shared/choreoscene.cpp
    ${CMAKE_SOURCE_DIR}/game/shared/sceneimage.cpp
)

target_include_directories(choreoobjects PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/game/shared
    ${CMAKE_SOURCE_DIR}/utils/common
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/common
)

target_link_libraries(choreoobjects PUBLIC
    tier0
    tier1
)

install(TARGETS choreoobjects ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
