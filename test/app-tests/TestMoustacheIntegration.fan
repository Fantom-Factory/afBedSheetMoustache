using afIoc
using afBedSheet

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
		res := client.get(`/musErr`)
		verifyEq(res.statusCode, 500)
		verify(res.asStr.contains("<h2>Moustache Compilation Err</h2>"))
	}
}
