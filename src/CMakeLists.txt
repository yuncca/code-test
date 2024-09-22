file(GLOB SUBDIRS LIST_DIRECTORIES true *)

foreach(SUBDIR ${SUBDIRS})
    if(IS_DIRECTORY ${SUBDIR})
        # message(STATUS "Adding subdirectory: ${SUBDIR}")
        add_subdirectory(${SUBDIR})
    endif()
endforeach()