cmake_minimum_required(VERSION 3.16)
project(Task1_QT VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Qml Gui)

set(SOURCES
    main.cpp
)

set(RESOURCES
    resources.qrc
)

add_executable(${PROJECT_NAME} ${SOURCES} ${RESOURCES})
target_link_libraries(${PROJECT_NAME} PRIVATE Qt6::Quick Qt6::Qml Qt6::Gui)
