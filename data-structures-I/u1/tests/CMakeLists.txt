cmake_minimum_required(VERSION 2.6)
 
# Locate GTest
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})
 
# Link runTests with what we want to test and the GTest and pthread library
# add_executable(runTests testArrayList.cpp)
# target_link_libraries(runTests ${GTEST_LIBRARIES} pthread)

add_executable(runArrayListTest testArrayList.cpp)
target_link_libraries(runArrayListTest ${GTEST_LIBRARIES} pthread)

add_executable(runLinkedListTest testLinkedList.cpp)
target_link_libraries(runLinkedListTest ${GTEST_LIBRARIES} pthread)

add_executable(runDoublyLinkedListTest testDoublyLinkedList.cpp)
target_link_libraries(runDoublyLinkedListTest ${GTEST_LIBRARIES} pthread)

add_executable(runLinkedStackTest testLinkedStack.cpp)
target_link_libraries(runLinkedStackTest ${GTEST_LIBRARIES} pthread)

add_executable(runArrayQueueTest testArrayQueue.cpp)
target_link_libraries(runArrayQueueTest ${GTEST_LIBRARIES} pthread)

add_executable(runTestU1 testU1.cpp)
target_link_libraries(runTestU1 ${GTEST_LIBRARIES} pthread)