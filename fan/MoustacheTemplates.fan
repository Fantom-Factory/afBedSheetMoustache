using afConcurrent::SynchronizedFileMap
using afIoc::Inject
using afConcurrent::ActorPools
using afIocConfig::Config
using afPlastic::SrcCodeSnippet
using mustache::Mustache
using mustache::MustacheParser

** (Service) -
** A cache of 'Mustache' templates.
const mixin MoustacheTemplates {
	
	** Renders a Moustache template.
	abstract Str renderFromStr(Str template, Obj? context := null, [Str:Mustache]? partials := null, Obj?[]? callStack := null, Str? indentStr := null)

	** Renders a Moustache template. The template is cached for future use.
	abstract Str renderFromFile(File templateFile, Obj? context := null, [Str:Mustache]? partials := null, Obj?[]? callStack := null, Str? indentStr := null)

}

internal const class MoustacheTemplatesImpl : MoustacheTemplates {
	
	@Inject @Config { id="afMoustache.templateTimeout" }
	private const Duration templateTimeout
	
	private const SynchronizedFileMap cache
	
	new make(ActorPools actorPools, |This|in) { 
		in(this)
		cache = SynchronizedFileMap(actorPools["afBedSheetMoustache.fileCache"], templateTimeout)
	}
	
	override Str renderFromStr(Str template, Obj? context := null, [Str:Mustache]? partials := null, Obj?[]? callStack := null, Str? indentStr := null) {
		moustache := compile(`/rendered/from/str`, template)
		return moustache.render(context, partials ?: [:], callStack ?: [,], indentStr ?: Str.defVal)
	}

	override Str renderFromFile(File templateFile, Obj? context := null, [Str:Mustache]? partials := null, Obj?[]? callStack := null, Str? indentStr := null) {
		moustache := getTemplateFromFile(templateFile)
		return moustache.render(context, partials ?: [:], callStack ?: [,], indentStr ?: Str.defVal)
	}
	
	private Mustache getTemplateFromFile(File file) {
		cache.getOrAddOrUpdate(file) |->Obj| {
			return compile(file.normalize.uri, file.readAllStr)
		}
	}

	private Mustache compile(Uri loc, Str src) {
		try {
			return Mustache(src.in)
			
		} catch (ParseErr err) {
			// the (?s) is to allow '.' to match \n
			reg := Regex<|(?s)^Line ([0-9]+?): (.+)|>.matcher(err.msg)
			if (!reg.find)
				throw err
			
			line 	:= reg.group(1).toInt
			msg 	:= reg.group(2).splitLines.join.replace("\t", " ")	// take out the new line chars
			srcCode	:= SrcCodeSnippet(loc, src)
			throw MoustacheErr(srcCode, line, msg, 5)
		}
	}
}
