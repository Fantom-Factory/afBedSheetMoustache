using build

class Build : BuildPod {

	new make() {
		podName = "afBedSheetMoustache"
		summary = "A library for integrating Mustache templates with the BedSheet web framework"
		version = Version("1.0.9")

		meta = [
			"org.name"		: "Alien-Factory",
			"org.uri"		: "http://www.alienfactory.co.uk/",
			"proj.name"		: "BedSheetMoustache",
			"proj.uri"		: "http://repo.status302.com/doc/afBedSheetMoustache/#overview",
			"vcs.uri"		: "https://bitbucket.org/AlienFactory/afbedsheetmoustache",
			"license.name"	: "The MIT Licence",
			"repo.private"	: "true",

			"afIoc.module"	: "afBedSheetMoustache::MoustacheModule"		
		]

		index = [
			"afIoc.module"	: "afBedSheetMoustache::MoustacheModule"
		]

		depends = [
			"sys 1.0", 
			"concurrent 1.0",
			
			"afConcurrent 1.0.0+",
			"afIoc 1.6.0+",
			"afIocConfig 1.0.4+", 
			"afPlastic 1.0.10+",			
			"afBedSheet 1.3.6+", 
			"mustache 1.0",
			
			// for testing
			"afBounce 0.0.6+",
			"afButter 0.0.4+",
			"afSizzle 1.0.0+"
		]

		srcDirs = [`test/`, `test/unit-tests/`, `test/app-tests/`, `test/app/`, `fan/`, `fan/public/`, `fan/internal/`, `fan/internal/utils/`]
		resDirs = [`licence.txt`, `doc/`, `res/`]

		docApi = true
		docSrc = true
	}
	
	@Target { help = "Compile to pod file and associated natives" }
	override Void compile() {
		// see "stripTest" in `/etc/build/config.props` to exclude test src & res dirs
		super.compile
		
		// copy src to %FAN_HOME% for F4 debugging
		log.indent
		destDir := Env.cur.homeDir.plus(`src/${podName}/`)
		destDir.delete
		destDir.create		
		`fan/`.toFile.copyInto(destDir)		
		log.info("Copied `fan/` to ${destDir.normalize}")
		log.unindent
	}
}
