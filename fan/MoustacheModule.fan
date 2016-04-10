using concurrent
using afIoc
using afConcurrent::ActorPools
using afIocConfig::FactoryDefaults

** The [Ioc]`pod:afIoc` module class.
** 
** This class is public so it may be referenced explicitly in test code.
@NoDoc
const class MoustacheModule {
	
	Void defineServices(RegistryBuilder defs) {
		defs.addService(MoustacheTemplates#)
	}

	@Contribute { serviceType=ActorPools# }
	Void contributeActorPools(Configuration config) {
		config["afBedSheetMoustache.fileCache"] = ActorPool() { it.name = "afBedSheetMoustache.fileCache" }
	}

	@Contribute { serviceType=FactoryDefaults# }
	Void contributeFactoryDefaults(Configuration config) {
		config[MoustacheConfigIds.templateTimeout]	= 10sec
	}
}
