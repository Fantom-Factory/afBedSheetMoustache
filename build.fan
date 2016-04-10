using build

class Build : BuildPod {

	new make() {
		podName = "afBedSheetMoustache"
		summary = "Integrates Mustache templates with the BedSheet web framework"
		version = Version("1.0.14")

		meta = [
			"proj.name"		: "BedSheet Moustache",
			"afIoc.module"	: "afBedSheetMoustache::MoustacheModule",
			"repo.tags"		: "web",
			"repo.public"	: "true"
		]

		index = [
			"afIoc.module"	: "afBedSheetMoustache::MoustacheModule"
		]

		depends = [
			"sys        1.0.68 - 1.0", 
			"concurrent 1.0.68 - 1.0",
			
			// ---- Core ------------------------
			"afConcurrent 1.0.12 - 1.0",
			"afIoc        3.0.0  - 3.0",
			"afIocConfig  1.1.0  - 1.1", 
			"afPlastic    1.1.0  - 1.1",			
			"afBedSheet   1.5.0  - 1.5", 
			"mustache     1.0",
			
			// ---- Test ------------------------
			"afBounce     1.1.0 - 1.1",
			"afButter     1.1.8 - 1.1",
			"afSizzle     1.0.0 - 1.0"
		]

		srcDirs = [`fan/`, `test/`, `test/app/`, `test/app-tests/`, `test/unit-tests/`]
		resDirs = [`doc/`]

		meta["afBuild.testPods"]	= "afBounce afButter afSizzle"
	}
}
