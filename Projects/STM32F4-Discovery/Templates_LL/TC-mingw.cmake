# the name of the target operating system
set(CMAKE_SYSTEM_NAME Generic-ELF)
set(CMAKE_SYSTEM_PROCESSOR arm)

# which compilers to use for C and C++
set(CMAKE_C_COMPILER   arm-none-eabi-gcc.exe)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++.exe)

set(CMAKE_EXE_LINKER_FLAGS "--specs=nosys.specs" CACHE INTERNAL "")

# where is the target environment located
set(CMAKE_FIND_ROOT_PATH  "C:/Program Files (x86)/Arm GNU Toolchain arm-none-eabi/13.2 Rel1/bin")

# adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)