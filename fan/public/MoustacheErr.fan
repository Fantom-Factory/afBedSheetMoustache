using afIoc::SrcErrLocation

** Indicates a 'Mustache' parsing Err; the stack trace trace contains a code snippet of where the 
** Err occurred.
const class MoustacheErr : Err {

	internal const SrcErrLocation srcErrLoc
	internal const Int srcCodePadding

	internal new make(SrcErrLocation srcErrLoc, Int srcCodePadding := 5) : super(srcErrLoc.errMsg) {
		this.srcErrLoc = srcErrLoc
		this.srcCodePadding = srcCodePadding
	}

	override Str toStr() {
		buf := StrBuf()
		buf.add("${typeof.qname}: ${msg}")
		buf.add("\nMoustache Compilation Err:\n")

		buf.add(srcErrLoc.srcCodeSnippet(srcCodePadding))

		buf.add("\nStack Trace:")
		return buf.toStr
	}
}
