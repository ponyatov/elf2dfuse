cmake_minimum_required(VERSION 3.22)
get_filename_component(PROJECT_NAME ${CMAKE_SOURCE_DIR} NAME_WE)
project(${PROJECT_NAME} LANGUAGES C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CWD ${CMAKE_SOURCE_DIR})
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CWD}/cmake)
set(BIN ${CWD}/bin)
set(INC ${CWD}/inc)
set(SRC ${CWD}/src)
set(TMP ${CWD}/tmp)

file(GLOB_RECURSE A
    "${SRC}/*.s*"
)
file(GLOB_RECURSE C
    "${SRC}/*.c*"
)
file(GLOB_RECURSE H
    "${INC}/*.h*"
)

include_directories(
    ${INC} ${TMP}
)

add_executable(${CMAKE_PROJECT_NAME}
    ${C} ${H} ${A}
)

target_link_libraries(${PROJECT_NAME})

include(version)
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME ${BIN_OUTPUT_NAME})
install(TARGETS ${CMAKE_PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX})
