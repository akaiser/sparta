/// Equivalent [kReleaseMode] without Flutter dependency
const bool isReleaseMode = bool.fromEnvironment('dart.vm.product');

/// Equivalent [kProfileMode] without Flutter dependency
const bool isProfileMode = bool.fromEnvironment('dart.vm.profile');

/// Equivalent [kDebugMode] without Flutter dependency
const bool isDebugMode = !isReleaseMode && !isProfileMode;
