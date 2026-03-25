cmake_minimum_required(VERSION 3.10.2)
project(arith)

# Build a shared library named libarith.so from the source files
add_library(arith SHARED
    ../../../../../calculations/arithmetics.cpp
)

# Include directories
target_include_directories(arith PUBLIC
    ../../../../../calculations
)

# Standard Android libraries
find_library(log-lib log)
target_link_libraries(arith ${log-lib})
