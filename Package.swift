import PackageDescription

let package = Package(
  dependencies: [
    .Package(url: "../Dispatch", majorVersion: 1),
    .Package(url: "../R", majorVersion: 1)
  ]
)
