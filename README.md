# Apple Pay Unity Plugin
Adds Apple Pay functionality to your Unity project.

## Dependencies
- UniTask (for asynchronous operations)

## Installation
- Drag the `project-root/ApplePayUnityPlugin` into Unity (preferably at `Assets/Plugins/`)

## Usage
- `Unity/Runtime/ApplePay.cs` contains all API with documentation.

## Modify/Update Project
### iOS
- Open `./platforms/ios/ApplePayPlugin_iOS.xcodeproj` and modify the project.
- From top menu choose `Product/Archive`, then choose `Product/Show Build Folder in Finder`, and navigate to `.../Build/Intermediates.noindex/ArchiveIntermediates/ApplePayPlugin_iOS/BuildProductsPath/Release-iphoneos/ApplePayPlugin_iOS.framework`. Right-click -> Show Original, then Copy (and replace) `ApplePayPlugin_iOS.framework` to `./ApplePayPlugin_iOS/iOS/`.

### Android
- N/A
