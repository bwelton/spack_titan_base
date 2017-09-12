## Titan Specific Variables To Build Run Scripts

# Number of nodes to run experiments on
set(NODES "1")
# Wall time for the test run
set(TIME "00:30:00")
# Project ID to run the 
set(PROJ_ID "$ENV{PROJ_ID}")
# Make the output log directory
make_directory("${PROJECT_BINARY_DIR}/logs")
set(LOG_DIR "${PROJECT_BINARY_DIR}/logs")

configure_file (
    "${PROJECT_SOURCE_DIR}/install_wrappers/RunWrappers.ksh.in"
	"${PROJECT_BINARY_DIR}/wrappers/RunWrappers.ksh"
	@ONLY
)

configure_file (
    "${PROJECT_SOURCE_DIR}/install_wrappers/download_data.sh.in"
	"${PROJECT_BINARY_DIR}/wrappers/download_data.sh"
	@ONLY
)
configure_file (
    "${PROJECT_SOURCE_DIR}/install_wrappers/Prepdata.ksh.in"
	"${PROJECT_BINARY_DIR}/wrappers/Prepdata.ksh"
	@ONLY
)
make_directory("${PROJECT_BINARY_DIR}/mnist_data")

## Download the test data
add_custom_target(download_data 
				  DEPENDS spack
				  COMMAND bash ${PROJECT_BINARY_DIR}/wrappers/download_data.sh)