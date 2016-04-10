using afIoc
using afBedSheet::Route
using afBedSheet::Routes

@SubModule { modules=[MoustacheModule#] }
internal const class T_AppModule {
	
	Void defineServices(RegistryBuilder defs) {
//		binder.bindImpl(Router#)
	}

	@Contribute { serviceType=Routes# }
	Void contributeRoutes(Configuration conf) {
		conf.add(Route(`/musOkay/*`, 	T_PageHandler#moustacheOkay))
		conf.add(Route(`/musErr`, 		T_PageHandler#moustacheErr))
	}
}
