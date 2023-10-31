extension LocalizedString on String
{
	String removeDiacritics()
	{
		String str = this;
		var withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
		var withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
		
		for (int i = 0; i < withDia.length; i++)
		{
			str = str.replaceAll(withDia[i], withoutDia[i]);
		}
		
		return str;
	}
}