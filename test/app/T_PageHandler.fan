using afIoc::Inject
using afIoc::Registry
using afBedSheet

internal const class T_PageHandler {

	@Inject	private const MoustacheTemplates moustacheTemplates

	new make(|This|in) { in(this) }

	Obj moustacheOkay(Str title) {
		text := moustacheTemplates.renderFromFile(`test/app/okay.moustache`.toFile, ["title" : title])
		return Text.fromHtml(text)
	}
	
	Obj moustacheErr() {
		text := moustacheTemplates.renderFromFile(`test/app/compilationErr.moustache`.toFile, [:])
		return Text.fromHtml(text)
	}
	
}
