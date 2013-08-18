using build::BuildPod

class Build : BuildPod {

	new make() {
		podName = "afBedSheetMoustache"
		summary = ""
		version = Version([0,0,1])

		meta	= [	"org.name"		: "Alien-Factory",
					"org.uri"		: "http://www.alienfactory.co.uk/",
					"vcs.uri"		: "https://bitbucket.org/SlimerDude/afbedsheetmoustache",
					"proj.name"		: "AF-BedSheetMoustache",
					"license.name"	: "BSD 2-Clause License",
					"repo.private"	: "true",
			
					"afIoc.module"	: "afBedSheet::BedSheetModule"		
				]

		depends = ["sys 1.0", "web 1.0",
					"afIoc 1.4+", "afBedSheet 1.0+", "mustache 1.0"]
		srcDirs = [`test/`, `test/unit-tests/`, `test/app-tests/`, `test/app/`, `fan/`, `fan/public/`, `fan/internal/`, `fan/internal/utils/`]
		resDirs = [`doc/`]

		docApi = true
		docSrc = true

		// exclude test code when building the pod
		srcDirs = srcDirs.exclude { it.toStr.startsWith("test/") }				
	}
}
