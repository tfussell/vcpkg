include(vcpkg_common_functions)

set(XLNT_VERSION 1.0.0)
set(XLNT_HASH f3d663cbe962c80ab684e677f1cc970aa1311d989f44a5d5d8311f93d69f4474b5bbd594796ad43a3b13d0a02bc040f877cad2979495a70a3a171ce94c20eae7)
set(XLNT_SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/xlnt-${XLNT_VERSION})

vcpkg_download_distfile(ARCHIVE
    URLS https://github.com/tfussell/xlnt/archive/v${XLNT_VERSION}.zip
    FILENAME xlnt-${XLNT_VERSION}.zip
    SHA512 ${XLNT_HASH}
)

vcpkg_extract_source_archive(${ARCHIVE})

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(STATIC OFF)
else()
    set(STATIC ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${XLNT_SOURCE_PATH}
    OPTIONS -DTESTS=OFF -DSAMPLES=OFF -DBENCHMARKS=OFF -DSTATIC=${STATIC}
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(INSTALL ${XLNT_SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/xlnt RENAME copyright)

vcpkg_copy_pdbs()
