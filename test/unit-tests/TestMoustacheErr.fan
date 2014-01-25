using afIoc
using mustache
using afBounce

internal class TestMoustacheErr : Test {
	
	@Inject	private MoustacheTemplates? templates
	private BedServer? bedServer
	
	override Void setup() {
		bedServer = BedServer(T_AppModule#).addModule(MoustacheModule#).startup
		bedServer.injectIntoFields(this)
	}
	
	override Void teardown() {
		bedServer.shutdown
	}

	Void testLineNoIsPickedOutOfMsg() {
		src := 
		"""<html>
		   <head>
		   	<title>{{ title }}</title>
		   	<style>
		   		{{{ bedSheetCss }}}
		   	</style>
		   </head>
		   <body>	
		   	<header>
		   		{{{ alienHeadSvg } dude!
		   		<span class="brand">{{ title }}</span>
		   	</header>

		   	<main>
		   		{{{ content }}}
		   	</main>

		   	<footer>
		   		<a href="http://repo.status302.com/doc/afBedSheet/#overview">Alien-Factory BedSheet {{ version }}</a>
		   	</footer>
		   </body>
		   """

		try {
			templates.renderFromStr(src)
			fail
		} catch (MoustacheErr err) {
			verifyEq(err.errLineNo, 10)
		}
	}	
}


