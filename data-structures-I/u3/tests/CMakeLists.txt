cmake_minimum_required(VERSION 2.6)
 
# Locate GTest
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})
 
# Link runTests with what we want to test and the GTest and pthread library
# add_executable(runTests testArrayList.cpp)
# target_link_libraries(runTests ${GTEST_LIBRARIES} pthread)

add_executable(runBSTTest testBST.cpp)
target_link_libraries(runBSTTest ${GTEST_LIBRARIES} pthread)

add_executable(runAVLTest testAVL.cpp)
target_link_libraries(runAVLTest ${GTEST_LIBRARIES} pthread)