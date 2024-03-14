import ProjectDescription

let appName = "YPTravelSchedule"
let bundleIdPrefix = "ru.sas"

// условия проекта
let destinations: Destinations = [.iPhone]
let deploymentTargets: DeploymentTargets = .iOS("15.0")
let infoPlist: [String: Plist.Value] = [
	"UILaunchScreen": [:], // держим в уме "UILaunchStoryboardName": "LaunchScreen.storyboard"
	"UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"]
]

// подключаем swiftlint
let swiftlintScriptString = """
	export PATH="$PATH:/opt/homebrew/bin"
	if which swiftlint > /dev/null; then
		swiftlint
	else
		echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
	exit 1
	fi
	"""
let swiftLintScript = TargetScript.pre(
	script: swiftlintScriptString,
	name: "Run SwiftLint",
	basedOnDependencyAnalysis: false
)

let target = Target(
	name: appName,
	destinations: destinations,
	product: .app,
	bundleId: "\(bundleIdPrefix).\(appName)",
	deploymentTargets: deploymentTargets,
	infoPlist: .extendingDefault(with: infoPlist),
	sources: [
		"\(appName)/Sources/**"
	],
	resources: [
		"\(appName)/Resources/**"
	],
	scripts: [
		swiftLintScript
	]
)

let targetTest = Target(
	name: "\(appName)Tests",
	destinations: destinations,
	product: .unitTests,
	bundleId: "\(bundleIdPrefix).\(appName)Tests",
	deploymentTargets: deploymentTargets,
	infoPlist: .none, // нам не надо ничего настраивать поэтому .none или .default
	sources: [
		"Tests/\(appName)Tests/Sources/**"
	],
	resources: [],
	dependencies: [
		.target(name: appName) // добавление зависимости
	]
)

let project = Project(
	name: appName,
	targets: [
		target,
		targetTest
	]
)
