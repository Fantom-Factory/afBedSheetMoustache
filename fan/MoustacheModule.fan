using concurrent
using afIoc
using afIocConfig::FactoryDefaults

** The [Ioc]`http://www.fantomfactory.org/pods/afIoc` module class.
** 
** This class is public so it may be referenced explicitly in test code.
@NoDoc
const class MoustacheModule {
	
	static Void defineServices(ServiceDefinitions defs) {
		defs.add(MoustacheTemplates#)		
	}

	@Contribute { serviceType=ActorPools# }
	static Void contributeActorPools(Configuration config) {
		config["afBedSheetMoustache.fileCache"] = ActorPool() { it.name = "afBedSheetMoustache.fileCache" }
	}

	@Contribute { serviceType=FactoryDefaults# }
	static Void contributeFactoryDefaults(Configuration config) {
		config[MoustacheConfigIds.templateTimeout]	= 10sec
	}
}
