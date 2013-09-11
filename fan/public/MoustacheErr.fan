using afPlastic::SrcCodeErr
using afPlastic::SrcCodeSnippet

** Indicates a 'Mustache' parsing Err; the stack trace trace contains a code snippet of where the 
** Err occurred.
const class MoustacheErr : Err, SrcCodeErr {
	const override SrcCodeSnippet 	srcCode
	const override Int 				errLineNo
	private const  Int 				linesOfPadding

	internal new make(SrcCodeSnippet srcCode, Int errLineNo, Str errMsg, Int linesOfPadding) : super(errMsg) {
		this.srcCode = srcCode
		this.errLineNo = errLineNo
		this.linesOfPadding = linesOfPadding
	}
	
	override Str toStr() {
		print(msg, linesOfPadding)
	}
}

