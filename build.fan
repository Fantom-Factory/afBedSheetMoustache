using build

class Build : BuildPod {

	new make() {
		podName = "afBedSheetMoustache"
		summary = "A library for integrating Mustache templates with the BedSheet web framework"
		version = Version("1.0.12")

		meta = [
			"proj.name"		: "BedSheet Moustache",
			"afIoc.module"	: "afBedSheetMoustache::MoustacheModule",		
			"repo.public"	: "true"
		]

		index = [
			"afIoc.module"	: "afBedSheetMoustache::MoustacheModule"
		]

		depends = [
			"sys 1.0", 
			"concurrent 1.0",
			
			// ---- Core ------------------------
			"afConcurrent 1.0.6  - 1.0",
			"afIoc        2.0.0  - 2.0",
			"afIocConfig  1.0.14 - 1.0", 
			"afPlastic    1.0.16 - 1.0",			
			"afBedSheet   1.3.16 - 1.4", 
			"mustache     1.0",
			
			// ---- Test ------------------------
			"afBounce 1.0.14+",
			"afButter 1.0.2+",
			"afSizzle 1.0.0+"
		]

		srcDirs = [`test/`, `test/unit-tests/`, `test/app-tests/`, `test/app/`, `fan/`]
		resDirs = [`doc/`]
	}
	
	override Void compile() {
		// remove test pods from final build
		testPods := "afBounce afButter afSizzle".split
		depends = depends.exclude { testPods.contains(it.split.first) }
		super.compile
	}
}
