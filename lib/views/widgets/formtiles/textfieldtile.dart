part of '../widgets.dart';

class TextFieldTile extends StatelessWidget
{
	final String title;
	final String? unit;
	final int maxLength;
	final Function(String)? onChanged;
	final TextEditingController? controller;
	final TextInputAction textInputAction;
	
	const TextFieldTile({
		Key? key,
		required this.title,
		this.unit,
		this.maxLength = 6,
		this.onChanged,
		this.controller,
		this.textInputAction = TextInputAction.next
	}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return ListTile(
			title: Text(this.title),
			trailing: SizedBox(
				width: 120,
				child: TextField(
					controller: this.controller,
					maxLines: 1,
					maxLength: 6,
					keyboardType: TextInputType.number,
					inputFormatters: <TextInputFormatter>[
						FilteringTextInputFormatter.allow(RegExp("[0-9.]*"))
					],
					decoration: InputDecoration(
						isDense: true,
						contentPadding: const EdgeInsets.all(12),
						border: const OutlineInputBorder(),
						suffixIcon: this.unit == null ? null :
							Padding(
								padding: const EdgeInsets.only(right: 12),
								child: Text(
									this.unit!,
									style: Theme.of(context).textTheme.subtitle1
								)
							),
						suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
						counterText: ""
					),
					onChanged: this.onChanged,
					textInputAction: this.textInputAction
				)
			)
		);
	}
}