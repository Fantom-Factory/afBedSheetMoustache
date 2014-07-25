using afIoc
using afBedSheet::Route
using afBedSheet::Routes

@SubModule { modules=[MoustacheModule#] }
internal const class T_AppModule {
	
	static Void bind(ServiceBinder binder) {
//		binder.bindImpl(Router#)
	}

	@Contribute { serviceType=Routes# }
	static Void contributeRoutes(Configuration conf) {
		conf.add(Route(`/musOkay/*`, 	T_PageHandler#moustacheOkay))
		conf.add(Route(`/musErr`, 		T_PageHandler#moustacheErr))
	}
}
