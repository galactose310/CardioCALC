extension SortedList<T> on List
{
	void addSorted(T item)
	{
		if(T is Comparable<T>)
		{
			int index = 0;
			while (index < this.length && this[index].compareTo(item) < 0)
				index++;
			this.insert(index, item);
		}
		
		else this.add(item);
	}
}

extension SortedSet<T> on Set
{
	bool addSorted(T item)
	{
		if(this.contains(item)) return false;

		if(T is Comparable<T>) this.toList().addSorted(item);
		else this.add(item);
		
		return true;
	}
}