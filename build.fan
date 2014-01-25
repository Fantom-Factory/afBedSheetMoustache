using build::BuildPod

class Build : BuildPod {

	new make() {
		podName = "afBedSheetMoustache"
		summary = "A library for integrating Mustache templates with the afBedSheet web framework"
		version = Version("1.0.6")

		meta = [
			"org.name"		: "Alien-Factory",
			"org.uri"		: "http://www.alienfactory.co.uk/",
			"proj.name"		: "BedSheetMoustache",
			"proj.uri"		: "http://repo.status302.com/doc/afBedSheetMoustache/#overview",
			"vcs.uri"		: "https://bitbucket.org/AlienFactory/afbedsheetmoustache",
			"license.name"	: "BSD 2-Clause License",
			"repo.private"	: "false",

			"afIoc.module"	: "afBedSheetMoustache::MoustacheModule"		
		]

		index = [
			"afIoc.module"	: "afBedSheetMoustache::MoustacheModule"
		]

		depends = [
			"sys 1.0", 
			"web 1.0",
			
			"afIoc 1.5.2+", 
			"afIocConfig 1.0.2+", 
			"afPlastic 1.0.10+",
			
			"afBedSheet 1.3.0+", 
			"mustache 1.0",
			
			// for testing
			"afBounce 0+"
		]

		srcDirs = [`test/`, `test/unit-tests/`, `test/app-tests/`, `test/app/`, `fan/`, `fan/public/`, `fan/internal/`, `fan/internal/utils/`]
		resDirs = [`doc/`, `res/`]

		docApi = true
		docSrc = true

		// exclude test code when building the pod
		srcDirs = srcDirs.exclude { it.toStr.startsWith("test/") }				
	}
}
