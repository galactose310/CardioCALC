extension NumInRange on num {
	bool isBetween(num start, num end) {
		return start <= this && this <= end;
	}
}