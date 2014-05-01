using afIoc
using afBounce
using afButter
using afSizzle

internal class TestMoustacheIntegration : Test {

	BedClient? client
	
	override Void setup() {
		client = BedServer(T_AppModule#).addModule(MoustacheModule#).startup.makeClient
	}
	
	override Void teardown() {
		client.shutdown
	}	

	Void testWebOkay() {
		res := client.get(`/musOkay/Beards!`)
		verify(res.asStr.contains("<title>Beards!</title>"))
	}

	Void testErrPageIntegration() {
		client.errOn5xx.enabled = false

		res := client.get(`/musErr`)
		verifyEq(res.statusCode, 500)
		
		title := Element("h2#moustacheErr")
        title.verifyTextEq("Moustache Err")
	}
}
