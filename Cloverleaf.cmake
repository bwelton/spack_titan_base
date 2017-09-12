# Number of nodes to run experiments on
set(NODES "1")
# Wall time for the test run
set(TIME "00:30:00")
# Project ID to run the 
set(PROJ_ID "$ENV{PROJ_ID}")
# Make the output log directory
make_directory("${PROJECT_BINARY_DIR}/logs")
set(LOG_DIR "${PROJECT_BINARY_DIR}/logs")
make_directory("${PROJECT_BINARY_DIR}/cleaf_data")
set(DATA_DIRECTORY "${PROJECT_BINARY_DIR}/cleaf_data")
configure_file (
    "${PROJECT_SOURCE_DIR}/install_wrappers/RunWrapper.ksh.in"
	"${PROJECT_BINARY_DIR}/wrappers/RunWrapper.ksh"
	@ONLY
)

