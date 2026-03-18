# unittests - Unit tests

enable_testing()

add_executable(tier0test
    tier0test.cpp
)
target_link_libraries(tier0test PRIVATE tier0 unitlib)
add_test(NAME tier0test COMMAND tier0test)

add_executable(tier1test
    tier1test.cpp
)
target_link_libraries(tier1test PRIVATE tier1 unitlib)
add_test(NAME tier1test COMMAND tier1test)

add_executable(tier2test
    tier2test.cpp
)
target_link_libraries(tier2test PRIVATE tier2 unitlib)
add_test(NAME tier2test COMMAND tier2test)

add_executable(tier3test
    tier3test.cpp
)
target_link_libraries(tier3test PRIVATE tier3 unitlib)
add_test(NAME tier3test COMMAND tier3test)

install(TARGETS tier0test tier1test tier2test tier3test
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
