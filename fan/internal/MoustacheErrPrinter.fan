using afIoc::Inject
using afBedSheet::Config
using web::WebOutStream

internal const class MoustacheErrPrinter {
	
	@Inject	@Config { id="afMoustache.srcCodePadding" } 	
	private const Int srcCodePadding
	
	new make(|This|in) { in(this) }
	
	Void printHtml(WebOutStream out, Err? err) {
		if (err != null && err is MoustacheErr) {
			srcErrLoc := ((MoustacheErr) err).srcErrLoc
			out.h2.w("Moustache Compilation Err").h2End
			
			out.p.w(srcErrLoc.srcLocation).w(" : Line ${srcErrLoc.errLineNo}").br
			out.w("&nbsp;&nbsp;-&nbsp;").writeXml(srcErrLoc.errMsg).pEnd
			
			out.div("class=\"srcLoc\"")
			out.table
			srcErrLoc.srcCodeSnippetMap(srcCodePadding).each |src, line| {
				if (line == srcErrLoc.errLineNo) { out.tr("class=\"errLine\"") } else { out.tr }
				out.td.w(line).tdEnd.td.w(src.toXml).tdEnd
				out.trEnd
			}
			out.tableEnd
			out.divEnd
		}
	}

	Void printStr(StrBuf buf, Err? err) {
		if (err != null && err is MoustacheErr) {
			srcErrLoc := ((MoustacheErr) err).srcErrLoc
			buf.add("\nMoustache Compilation Err:\n")
			buf.add(srcErrLoc.srcCodeSnippet(srcCodePadding))
		}
	}	
}
