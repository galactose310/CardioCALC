import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Markdown
{
	// To modify markdown flags, modify the following patterns
	static const String urlStartPattern = "[";
	static const String urlIntermediatePattern = "](";
	static const String urlStopPattern = ")";
	static const String urlStopPatternConfusingChar = "(";
	static const String boldPattern = "**";
	static const String italicStarPattern = "*";
	static const String italicUnderPattern = "_";
	static const String boldAndItalicPattern = "***";
	static const String underlinePattern = "__";
	
	// Markup used to split text into list of strings => can be changed if needed
	static const String markdown = "MARKDOWN:";
	static const String markdownStart = "[";
	static const String markdownStop = "]";
	static String get markdownCloseStart => "$markdownStart/";
	static String get markdownCloseStop => markdownStop;
	
	// Flags to construct markups (ex : [MARKDOWN:bold] is [MARKDOWN: + boldFlag + ])
	static const String basicFlag = "text";
	static const String linkFlag = "link";
	static const String urlFlag = "url";
	static const String boldFlag = "bold";
	static const String italicFlag = "italic";
	static const String boldAnditalicFlag = "bolditalic";
	static const String underlineFlag = "underline";
	
	static Map<String, String> get patternToFlagDictionary => <String, String>
	{
		underlinePattern: underlineFlag,
		boldAndItalicPattern: boldAnditalicFlag,
		boldPattern: boldFlag,
		italicUnderPattern: italicFlag,
		italicStarPattern: italicFlag
	};
	
	static Set<String> get authorizedFlags => <String> { linkFlag, urlFlag, boldFlag, italicFlag, boldAnditalicFlag, underlineFlag };
	
	/*
		* Parse a pre-formatted text (after parsing Markdown to Markup) to a list of TextSpan
	*/
	static List<TextSpan> parse({required String text, Color? hyperlinkTextColor = Colors.blueAccent})
	{
		List<TextSpan> spanList = <TextSpan>[];
		
		List<Map<String, String>> markdownStrings = _markupToDictionnary(_parseMarkdownToMarkup(text));
		
		for(Map<String, String> span in markdownStrings)
		{
			switch (span.keys.first)
			{
				case (linkFlag):
					spanList.add(TextSpan(text: span.values.first)); // Will be formatted after => see case(urlFlag)
					break;
				
				case (urlFlag):
					TapGestureRecognizer recognizer = new TapGestureRecognizer();
					recognizer.onTap = () => launchUrl(Uri.parse(span.values.first));
					TextSpan newLink = TextSpan(
						text: spanList.last.text,
						style: TextStyle(
							decoration: TextDecoration.underline,
							color: hyperlinkTextColor
						),
						recognizer: recognizer
					);
					spanList.last = newLink;
					break;
				
				case (boldFlag):
					spanList.add(TextSpan(
						text: span.values.first,
						style: const TextStyle(fontWeight: FontWeight.bold)
					));
					break;
				
				case (italicFlag):
					spanList.add(TextSpan(
						text: span.values.first,
						style: const TextStyle(fontStyle: FontStyle.italic)
					));
					break;
				
				case (boldAnditalicFlag):
					spanList.add(TextSpan(
						text: span.values.first,
						style: const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
					));
					break;
				
				case (underlineFlag):
					spanList.add(TextSpan(
						text: span.values.first,
						style: const TextStyle(decoration: TextDecoration.underline)
					));
					break;
				
				case (basicFlag):
				default:
					spanList.add(TextSpan(text: span.values.first));
					break;
			}
		}
		
		return spanList;
	}


	/*
		* 
		* NO-SPECIFIC METHODS : USABLE ON EACH UI SYSTEM
		* 
		*/

	// Split a string in a list of Flag =>.substring, based on markup
	static List<Map<String, String>> _markupToDictionnary(String text)
	{
		List<Map<String, String>> textStrings = <Map<String, String>>[];
		
		/*
			* While text is not empty : loop on it to find the next markup
			* If no markup found : add a new Basic string to the list
			* If markup found : verify if the markup is complete and valid => if not, add a new Basic string from 0 index to the unvalid markup
			* If the markup is complete and valid : add a new special string identified by the Flag Key
			* At each step : text is a substring from last verified index to end of text
			*/
		while (text.isNotEmpty)
		{
			int markdownStartIndex = text.indexOf(markdownStart + markdown);
			
			if (markdownStartIndex >= 0)
			{
				int markdownStopIndex = text.indexOf(markdownStop);
				
				if (markdownStopIndex > 0 && markdownStopIndex > markdownStartIndex)
				{
					String markdownFlag = text.substring(markdownStartIndex + markdownStart.length + markdown.length, markdownStopIndex);
					int markdownCloseIndex = text.indexOf(markdownCloseStart + markdown + markdownFlag + markdownCloseStop);
					
					if (markdownFlag.isNotEmpty && authorizedFlags.contains(markdownFlag) && markdownCloseIndex > 0)
					{
						if (markdownStartIndex > 0) textStrings.add({basicFlag: text.substring(0, markdownStartIndex)});
						textStrings.add({markdownFlag: text.substring(markdownStartIndex + markdownStart.length + markdown.length + markdownFlag.length + markdownStop.length, markdownCloseIndex)});
						text = text.substring(markdownCloseIndex + markdownCloseStart.length + markdown.length + markdownFlag.length + markdownCloseStop.length);
					}
					else
					{
						textStrings.add({basicFlag: text.substring(0, markdownStartIndex + markdownStart.length + markdown.length + markdownFlag.length + markdownStop.length)});
						text = text.substring(markdownStartIndex + markdownStart.length + markdown.length + markdownFlag.length + markdownStop.length);
					}
				}
				else
				{
					textStrings.add({basicFlag: text.substring(0, markdownStartIndex + markdownStart.length + markdown.length)});
					text = text.substring(markdownStartIndex + markdownStart.length + markdown.length);
				}
			}
			else
			{
				textStrings.add({basicFlag: text});
				text = "";
			}
		}
		return textStrings;
	}

	// Parse a text from Markdown to markup ; order set to avoid wrong parsing (ex : *** must not be parsed as ** or *)
	static String _parseMarkdownToMarkup(String text)
	{
		return
			_textDecorationParser(italicUnderPattern,
				_textDecorationParser(italicStarPattern,
					_textDecorationParser(boldPattern,
						_textDecorationParser(boldAndItalicPattern,
							_textDecorationParser(underlinePattern,
								_hyperlinkParser(text))))));
	}
	
	// Search and add markups for hypertext links
	static String _hyperlinkParser(String text)
	{
		int urlStartIndex = text.indexOf(urlStartPattern);
		int urlIntermediateIndex = text.indexOf(urlIntermediatePattern);
		if (urlStartIndex < 0 || urlIntermediateIndex < urlStartIndex) return text;
		
		int urlStopIndex = urlIntermediateIndex + text.substring(urlIntermediateIndex).indexOf(urlStopPattern);
		
		int startScanForConfusingChar = urlIntermediateIndex;
		int stopScanForConfusingChar = urlStopIndex;
		
		while(text.substring(startScanForConfusingChar, stopScanForConfusingChar).indexOf(urlStopPatternConfusingChar) > 0)
		{
			startScanForConfusingChar = urlStopIndex;
			urlStopIndex += text.substring(urlStopIndex + 1).indexOf(urlStopPattern) + 1;
			stopScanForConfusingChar = urlStopIndex;
		}
		if (urlStopIndex <= 0 || urlStopIndex < urlIntermediateIndex) return text;
		
		return
			text.substring(0, urlStartIndex) // Before link
			+ markdownStart + markdown + linkFlag + markdownStop + text.substring(urlStartIndex + urlStartPattern.length, urlIntermediateIndex) + markdownCloseStart + markdown + linkFlag + markdownCloseStop // Link text
			+ markdownStart + markdown + urlFlag + markdownStop + text.substring(urlIntermediateIndex + urlIntermediatePattern.length, urlStopIndex) + markdownCloseStart + markdown + urlFlag + markdownCloseStop // Link URL
			+ _hyperlinkParser(text.substring(urlStopIndex + urlStopPattern.length)); // After link
	}

	// Parse text to find valid markdown, and replace it with markups
	// Note : patternToFlagDictionary contains associations between markdown patterns, and markup flags
	static String _textDecorationParser(String markdownPattern, String text)
	{
		int startIndex = text.indexOf(markdownPattern);
		if (startIndex < 0) return text;

		int stopIndex = text.substring(startIndex + markdownPattern.length).indexOf(markdownPattern);
		if (stopIndex <= 0) return text;

		// Parsing stops if substring already contains a valid markup => avoid wrong double parsing
		if (text.substring(startIndex + markdownPattern.length, startIndex + markdownPattern.length + stopIndex).contains(markdownStart + markdown)) return text;
		
		// Parsing stops if substring is after a valid but unclosed LINK or URL markdown flag
		if ((text.substring(0, startIndex).contains(markdownStart + markdown + linkFlag + markdownStop)
			&& !text.substring(0, startIndex).contains(markdownCloseStart + markdown + linkFlag + markdownCloseStop))
			|| (text.substring(0, startIndex).contains(markdownStart + markdown + urlFlag + markdownStop)
			&& !text.substring(0, startIndex).contains(markdownCloseStart + markdown + urlFlag + markdownCloseStop))
			)
			return text;
		
		return
			text.substring(0, startIndex)
			+ markdownStart + markdown + (patternToFlagDictionary[markdownPattern] ?? "") + markdownStop
			+ text.substring(startIndex + markdownPattern.length, startIndex + markdownPattern.length + stopIndex)
			+ markdownCloseStart + markdown + (patternToFlagDictionary[markdownPattern] ?? "") + markdownCloseStop
			+ _textDecorationParser(markdownPattern, text.substring(startIndex + markdownPattern.length + stopIndex + markdownPattern.length));
	}
}