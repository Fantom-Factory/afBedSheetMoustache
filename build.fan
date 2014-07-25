using build

class Build : BuildPod {

	new make() {
		podName = "afBedSheetMoustache"
		summary = "A library for integrating Mustache templates with the BedSheet web framework"
		version = Version("1.0.10")

		meta = [
			"proj.name"		: "BedSheet Moustache",
			"afIoc.module"	: "afBedSheetMoustache::MoustacheModule",		
			"repo.private"	: "false"
		]

		index = [
			"afIoc.module"	: "afBedSheetMoustache::MoustacheModule"
		]

		depends = [
			"sys 1.0", 
			"concurrent 1.0",
			
			// ---- Core ------------------------
			"afConcurrent 1.0.6+",
			"afIoc 1.7.2+",
			"afIocConfig 1.0.10+", 
			"afPlastic 1.0.16+",			
			"afBedSheet 1.3.12+", 
			"mustache 1.0",
			
			// ---- Test ------------------------
			"afBounce 0.0.6+",
			"afButter 0.0.4+",
			"afSizzle 1.0.0+"
		]

		srcDirs = [`test/`, `test/unit-tests/`, `test/app-tests/`, `test/app/`, `fan/`, `fan/public/`, `fan/internal/`, `fan/internal/utils/`]
		resDirs = [`res/`]
	}
	
	override Void compile() {
		// remove test pods from final build
		testPods := "afBounce afButter afSizzle".split
		depends = depends.exclude { testPods.contains(it.split.first) }
		super.compile
	}
}
