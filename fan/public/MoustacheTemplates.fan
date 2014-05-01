using afConcurrent::SynchronizedFileMap
using afIoc::Inject
using afIoc::ActorPools
using afIocConfig::Config
using afPlastic::SrcCodeSnippet
using mustache::Mustache
using mustache::MustacheParser

** A cache of 'Mustache' templates.
const mixin MoustacheTemplates {
	
	** Renders a Moustache template.
	abstract Str renderFromStr(Str template, Obj? context := null, [Str:Mustache] partials := [:], Obj?[] callStack := [,], Str indentStr := "")

	** Renders a Moustache template. The template is cached for future use.
	abstract Str renderFromFile(File templateFile, Obj? context := null, [Str:Mustache] partials := [:], Obj?[] callStack := [,], Str indentStr := "")

}

internal const class MoustacheTemplatesImpl : MoustacheTemplates {
	
	@Inject @Config { id="afMoustache.templateTimeout" }
	private const Duration templateTimeout
	
	@Inject	@Config { id="afBedSheet.plastic.srcCodeErrPadding" }
	private const Int srcCodePadding

	private const SynchronizedFileMap cache
	
	new make(ActorPools actorPools, |This|in) { 
		in(this)
		cache = SynchronizedFileMap(actorPools["afMoustache.fileCache"], templateTimeout)
	}
	
	override Str renderFromStr(Str template, Obj? context := null, [Str:Mustache] partials := [:], Obj?[] callStack := [,], Str indentStr := "") {
		moustache := compile(`/rendered/from/str`, template)
		return moustache.render(context, partials, callStack, indentStr)
	}

	override Str renderFromFile(File templateFile, Obj? context := null, [Str:Mustache] partials := [:], Obj?[] callStack := [,], Str indentStr := "") {
		moustache := getTemplateFromFile(templateFile)
		return moustache.render(context, partials, callStack, indentStr)
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
			throw MoustacheErr(srcCode, line, msg, srcCodePadding)
		}
	}
}
