# https://github.com/jopohl/sdrbuild/blob/master/mingw-w64-i686.cmake

# toolchain file for cross-compiling for retro Windows x32 (XP, 7)
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_BUILD_TYPE  Debug)
set(TOOLCHAIN_PREFIX  i686-w64-mingw32)

# cross compilers to use for C and C++
set(CMAKE_C_COMPILER   ${TOOLCHAIN_PREFIX}-gcc-win32)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}-g++-win32)
set(CMAKE_RC_COMPILER  ${TOOLCHAIN_PREFIX}-windres)
# set(CMAKE_MC_COMPILER  ${TOOLCHAIN_PREFIX}-windmc)

add_definitions(-mconsole)
# set(CMAKE_AUTORCC ON)

# target environment on the build host system
#   set 1st to dir with the cross compiler's C/C++ headers/libs
# set(CMAKE_FIND_ROOT_PATH /usr/${TOOLCHAIN_PREFIX})

# modify default behavior of FIND_XXX() commands to
# search for headers/libs in the target environment and
# search for programs in the build host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# add_custom_command(
# TARGET ico
# PRE_BUILD
# DEPENDS ${CMAKE_RC_COMPILER}
# COMMAND ${CMAKE_RC_COMPILER} ${rc} ${TMP}/${robj}.rc.obj
# WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}/res"
# COMMENT "Build step to produce the icon file"
# add_executable(ico ${TMP}/${robj}.rc.obj)
# )
