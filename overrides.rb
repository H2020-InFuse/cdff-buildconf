# Write in this file customization code that will get executed after all the
# soures have beenloaded.

# Uncomment to reenable building the RTT test suite
# This is disabled by default as it requires a lot of time and memory
#
# Autobuild::Package['rtt'].define "BUILD_TESTING", "ON"

# Package specific prefix:
# Autobuild::Package['rtt'].prefix='/opt/autoproj/2.0'
#
# See config.yml to set the prefix:/opt/autoproj/2.0 globally for all packages.

# Ensure all packages use the workspace-installed Boost 1.66 headers AND libs,
# not the system Boost 1.83 (which would cause an ABI mismatch with the 1.66 headers
# that are picked up via CPATH=/opt/workspace/install/include).
Autoproj.env_set 'BOOST_ROOT', "#{ENV['AUTOPROJ_CURRENT_ROOT']}/install"
Autobuild::Package.each do |_, pkg|
    next unless pkg.kind_of?(Autobuild::CMake)
    pkg.define 'BOOST_ROOT', "#{ENV['AUTOPROJ_CURRENT_ROOT']}/install"
    pkg.define 'Boost_NO_SYSTEM_PATHS', 'TRUE'
end

Autobuild::Package['cdff/CDFF'].define 'BUILD_SHARED_LIBS', 'TRUE'
Autoproj.env_add "CDFF", "$AUTOPROJ_CURRENT_ROOT/cdff/CDFF/build"
# HACK: should be removed when libraries of CDFF are installed correctly
# obtained, e.g., with ls -d Common/*/ | tr "\n" ":"
Autoproj.env_add_path 'LD_LIBRARY_PATH', "$CDFF/Common/Converters/:$CDFF/Common/Helpers/:$CDFF/Common/Loggers/:$CDFF/Common/Types/:$CDFF/Common/Validators/:$CDFF/Common/Visualizers/"
Autoproj.env_add_path 'LD_LIBRARY_PATH', "$CDFF/DFNs/:$CDFF/DFNs/BundleAdjustment/:$CDFF/DFNs/CamerasTransformEstimation/:$CDFF/DFNs/DepthFiltering/:$CDFF/DFNs/FeaturesDescription2D/:$CDFF/DFNs/FeaturesDescription3D/:$CDFF/DFNs/FeaturesExtraction2D/:$CDFF/DFNs/FeaturesExtraction3D/:$CDFF/DFNs/FeaturesMatching2D/:$CDFF/DFNs/FeaturesMatching3D/:$CDFF/DFNs/ForceMeshGenerator/:$CDFF/DFNs/FundamentalMatrixComputation/:$CDFF/DFNs/ImageFiltering/:$CDFF/DFNs/KFCorrection/:$CDFF/DFNs/KFPrediction/:$CDFF/DFNs/PerspectiveNPointSolving/:$CDFF/DFNs/PointCloudAssembly/:$CDFF/DFNs/PointCloudFiltering/:$CDFF/DFNs/PointCloudReconstruction2DTo3D/:$CDFF/DFNs/PointCloudTransform/:$CDFF/DFNs/PrimitiveMatching/:$CDFF/DFNs/Registration3D/:$CDFF/DFNs/StereoReconstruction/:$CDFF/DFNs/Transform3DEstimation/:$CDFF/DFNs/Voxelization/:$CDFF/DFNs/ImagePairCorrection/:$CDFF/DFNs/ImagePairDegradation/:$CDFF/DFNs/StereoDegradation/:$CDFF/DFNs/DisparityImage/:$CDFF/DFNs/DisparityFiltering/:$CDFF/DFNs/DisparityToPointCloudWithIntensity/:$CDFF/DFNs/DisparityToPointcloud/:$CDFF/DFNs/VisualOdometry/:$CDFF/DFNs/ImageDegradation/:$CDFF/DFNs/DisparityToPointCloud"
Autoproj.env_add_path 'LD_LIBRARY_PATH', "$CDFF/DFPCs/:$CDFF/DFPCs/AbsoluteLocalization/:$CDFF/DFPCs/CMakeFiles/:$CDFF/DFPCs/DEMBuilding/:$CDFF/DFPCs/HapticScanning/:$CDFF/DFPCs/LIDARMapBasedLocalization/:$CDFF/DFPCs/LIDARPoseGraphSlam/:$CDFF/DFPCs/PointCloudModelLocalisation/:$CDFF/DFPCs/PoseFusion/:$CDFF/DFPCs/Reconstruction3D/:$CDFF/DFPCs/ReconstructionAndIdentification/:$CDFF/DFPCs/VisualOdometry_LAAS/:$CDFF/DFPCs/VisualOdometry_MAG/:$CDFF/DFPCs/VisualSlamDepth/:$CDFF/DFPCs/VisualSlamStereo/:$CDFF/DFPCs/MidRange3DModelTracking/:$CDFF/DFNs/DisparityToPointCloud:$CDFF/DFPCs/ModelBasedTracker/"
Autoproj.env_add_path 'LD_LIBRARY_PATH'

# This is how you can cross-compile all packages with autoproj:
# set -march=sandybridge for all cmake packages
# TODO: this does not yet work to run CDFF-Dev on the CI server
#Autobuild::Package.each do |name, pkg|
#    if pkg.kind_of?(Autobuild::CMake)
#        cxx_flags = "#{pkg.defines['CMAKE_CXX_FLAGS']} #{ENV['CXXFLAGS']}"
#        pkg.define "CMAKE_CXX_FLAGS", "#{cxx_flags} -march=sandybridge"
#    end
#end

