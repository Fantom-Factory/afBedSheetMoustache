using afPlastic::SrcCodeErr
using afPlastic::SrcCodeSnippet

** Indicates a 'Mustache' parsing Err; the stack trace trace contains a code snippet of where the 
** Err occurred.
const class MoustacheErr : Err, SrcCodeErr {
	const override SrcCodeSnippet 	srcCode
	const override Int 				errLineNo
	const override Int 				linesOfPadding

	internal new make(SrcCodeSnippet srcCode, Int errLineNo, Str errMsg, Int linesOfPadding) : super(errMsg) {
		this.srcCode = srcCode
		this.errLineNo = errLineNo
		this.linesOfPadding = linesOfPadding
	}

	@NoDoc
	override Str toStr() {
		trace := causeStr
		trace += snippetStr
		trace += "Stack Trace:"
		return trace
	}
	
	@NoDoc
	protected Str causeStr() {
		cause == null 
			? "${typeof.qname}: ${msg}" 
			: "${cause.typeof.qname}: ${msg}"
	}

	@NoDoc
	Str snippetStr() {
		snippet := "\n${typeof.name.toDisplayName}:\n"
		snippet += toSnippetStr
		return snippet
	}
}

