using afIoc::Contribute
using afIoc::OrderedConfig
using afIoc::MappedConfig
using afIoc::ServiceBinder
using afIocConfig::FactoryDefaults
using web::WebOutStream

** The [afIoc]`http://repo.status302.com/doc/afIoc/#overview` module class.
internal class MoustacheModule {
	
	@NoDoc
	static Void bind(ServiceBinder binder) {
		binder.bind(MoustacheTemplates#).withoutProxy		// has default method args		
	}

	@NoDoc
	@Contribute { serviceType=FactoryDefaults# }
	static Void contributeFactoryDefaults(MappedConfig config) {
		config[MoustacheConfigIds.templateTimeout]	= 10sec
	}
}
