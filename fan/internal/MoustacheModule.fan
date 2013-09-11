using afIoc::Contribute
using afIoc::OrderedConfig
using afIoc::MappedConfig
using afIoc::ServiceBinder
using afBedSheet::ErrPrinterHtml
using afBedSheet::ErrPrinterStr
using afBedSheet::FactoryDefaults
using web::WebOutStream

internal class MoustacheModule {
	
	static Void bind(ServiceBinder binder) {
		binder.bindImpl(MoustacheTemplates#).withoutProxy		// has default method args		
	}

	@Contribute { serviceType=FactoryDefaults# }
	static Void contributeFactoryDefaults(MappedConfig config) {
		config[MoustacheConfigIds.templateTimeout]	= 10sec
	}
}
