using afIoc::SrcErrLocation

const class MoustacheErr : Err {

	internal const SrcErrLocation srcErrLoc
	internal const Int noOfLinesOfPadding

	internal new make(SrcErrLocation srcErrLoc, Int noOfLinesOfPadding := 5) : super(srcErrLoc.errMsg) {
		this.srcErrLoc = srcErrLoc
		this.noOfLinesOfPadding = noOfLinesOfPadding
	}

	override Str toStr() {
		buf := StrBuf()
		buf.add("${typeof.qname}: ${msg}")
		buf.add("\nMoustache Compilation Err:\n")

		buf.add(srcErrLoc.srcCodeSnippet(noOfLinesOfPadding))

		buf.add("\nStack Trace:")
		return buf.toStr
	}
}
