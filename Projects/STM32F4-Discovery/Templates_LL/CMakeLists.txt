# Specify the minimum version of CMake
cmake_minimum_required(VERSION 3.30)

# Set the project name
project(MyProject C)



set (LINKER_SCRIPT            "${CMAKE_SOURCE_DIR}/STM32CubeIDE/STM32F407VGTX_FLASH.ld")
set (MCPU                     "-mcpu=Cortex-M4")
set (MFPU                 "-mfpu=fpv4-sp-d16")
set (MFLOAT_ABI               "")
set (RUNTIME_LIBRARY          "--specs=nano.specs")
set (RUNTIME_LIBRARY_SYSCALLS "--specs=nosys.specs")
# Include directories
include_directories(
    ${CMAKE_SOURCE_DIR}/../../../Drivers/STM32F4xx_HAL_Driver/Inc/
    ${CMAKE_SOURCE_DIR}/../../../Drivers/CMSIS/Device/ST/STM32F4xx/Include
    ${CMAKE_SOURCE_DIR}/../../../Drivers/CMSIS/Core/Include
    ${CMAKE_SOURCE_DIR}/Inc
)

# Gather sources
file(GLOB SOURCES "${CMAKE_SOURCE_DIR}/Src/*.c")

# Gather low-level driver sources and exclude specific files
file(GLOB ALL_LL_SOURCES "${CMAKE_SOURCE_DIR}/../../../Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_*")

set(EXCLUDE_FILES
    "${CMAKE_SOURCE_DIR}/../../../Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_fmc.c"
    "${CMAKE_SOURCE_DIR}/../../../Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_fsmc.c"
    "${CMAKE_SOURCE_DIR}/../../../Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_sdmmc.c"
    "${CMAKE_SOURCE_DIR}/../../../Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_usb.c"
)


set(LL_SOURCES "")

foreach(source_file ${ALL_LL_SOURCES})
    if (NOT source_file IN_LIST EXCLUDE_FILES)
        list(APPEND LL_SOURCES ${source_file})
    endif()
endforeach()

# Specify the startup script
set(STARTUP_SCRIPT ${CMAKE_SOURCE_DIR}/STM32CubeIDE/Example/Startup/startup_stm32f407vgtx.s)

# Add all sources including the startup file
list(APPEND SOURCES ${LL_SOURCES} ${STARTUP_SCRIPT})


# Add an executable target
add_executable(my_program ${SOURCES})

# Define preprocessor macros
target_compile_definitions(my_program PRIVATE STM32F407xx)


set (CMAKE_C_FLAGS "${MCPU} -std=gnu11 ${MFPU} ${MFLOAT_ABI} ${RUNTIME_LIBRARY} -mthumb -Wall -Werror")
set (CMAKE_EXE_LINKER_FLAGS "-T${LINKER_SCRIPT} ${RUNTIME_LIBRARY_SYSCALLS} -Wl,-Map=test.map -Wl,--gc-sections -static -Wl,--start-group -lc -lm -Wl,--end-group")
set (CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS} -x assembler-with-cpp")