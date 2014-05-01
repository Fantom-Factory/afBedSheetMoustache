using concurrent
using afIoc
using afIocConfig::FactoryDefaults

** The [Ioc]`http://www.fantomfactory.org/pods/afIoc` module class.
** 
** This class is public so it may be referenced explicitly in test code.
@NoDoc
const class MoustacheModule {
	
	static Void bind(ServiceBinder binder) {
		binder.bind(MoustacheTemplates#).withoutProxy		// has default method args		
	}

	@Contribute { serviceType=ActorPools# }
	static Void contributeActorPools(MappedConfig config) {
		config["afMoustache.fileCache"] = ActorPool()
	}

	@Contribute { serviceType=FactoryDefaults# }
	static Void contributeFactoryDefaults(MappedConfig config) {
		config[MoustacheConfigIds.templateTimeout]	= 10sec
	}
}
