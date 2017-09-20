cmake_minimum_required (VERSION 2.8.11)
SET(CMAKE_CXX_STANDARD 11)
include(${CMAKE_ROOT}/Modules/ExternalProject.cmake)
project(spack_titan_base)

set(BUILD_PACKAGE "cloverleaf")
set(PACKAGE_PARAMETERS "build=cuda")

if (NOT DEFINED BUILD_PACKAGE)
	message(ERROR "Please specify package to build with Spack -DBUILD_PACKAGE")
endif (NOT DEFINED BUILD_PACKAGE)

if (NOT DEFINED PACKAGE_PARAMETERS)
	message("-DPACKAGE_PARAMETERS not set, assuming not options needed for build")
	set(PACKAGE_PARAMETERS "")
endif (NOT DEFINED PACKAGE_PARAMETERS)

cmake_host_system_information(RESULT BUILD_HOST QUERY HOSTNAME)
if ("${BUILD_HOST}" MATCHES "(titan-ext)[1-7]")
	## Set ProjID for job launching
	set(PROJ_ID "$ENV{PROJ_ID}")
	set(CRAY_MACHINE "Yes")	
	set(CUDA_TOOLKIT_ROOT_DIR "$ENV{CRAY_CUDATOOLKIT_DIR}")
endif("${BUILD_HOST}" MATCHES "(titan-ext)[1-7]")

file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/wrappers)
configure_file (
    "${PROJECT_SOURCE_DIR}/install_wrappers/BuildPackage.ksh.in"
	"${PROJECT_BINARY_DIR}/wrappers/BuildPackage.ksh"
	@ONLY
)
configure_file (
    "${PROJECT_SOURCE_DIR}/install_wrappers/BuildPackage.sh.in"
	"${PROJECT_BINARY_DIR}/wrappers/BuildPackage.sh"
	@ONLY
)

configure_file (
    "${PROJECT_SOURCE_DIR}/install_wrappers/SetModuleEnv.sh.in"
	"${PROJECT_BINARY_DIR}/wrappers/SetModuleEnv.sh"
	@ONLY
)


ExternalProject_Add(
	spack
        GIT_REPOSITORY "https://github.com/bwelton/spack.git"
	GIT_TAG "develop"  
	SOURCE_DIR "${PROJECT_BINARY_DIR}/3rdparty/spack"
	CONFIGURE_COMMAND ""
	BUILD_COMMAND bash ${PROJECT_BINARY_DIR}/wrappers/BuildPackage.sh
        UPDATE_COMMAND ""
	INSTALL_COMMAND ""
)

include(${CMAKE_SOURCE_DIR}/Cloverleaf.cmake)
