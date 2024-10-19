class DivisionByZeroException implements Exception {
	final String? message;
	
	const DivisionByZeroException(this.message) : super();
}