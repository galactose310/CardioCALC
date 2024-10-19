part of '../widgets.dart';

class TextFieldTile extends StatelessWidget
{
	final String title;
	final String? unit;
	final bool isValid;
	final bool isUnusual;
	final int maxLength;
	final Function(String)? onChanged;
	final TextEditingController? controller;
	final TextInputAction textInputAction;
	
	const TextFieldTile({
		Key? key,
		required this.title,
		this.unit,
		this.isValid = true,
		this.isUnusual = false,
		this.maxLength = 6,
		this.onChanged,
		this.controller,
		this.textInputAction = TextInputAction.next
	}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		Color validationStatusColor;
		if(!isValid) validationStatusColor = Colors.red;
		else if(isUnusual) validationStatusColor = Colors.amber;
		else validationStatusColor = Theme.of(context).colorScheme.primary;
		
		Widget? floatingLabelMessage;
		if(!isValid) floatingLabelMessage = Text('Valeur impossible', style: TextStyle(color: validationStatusColor));
		else if(isUnusual) floatingLabelMessage = Text('Valeur extrême', style: TextStyle(color: validationStatusColor));
		
		return ListTile(
			title: Text(this.title),
			titleAlignment: ListTileTitleAlignment.top,
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
						enabledBorder: OutlineInputBorder(
							borderSide: BorderSide(color: validationStatusColor)
						),
						focusedBorder: OutlineInputBorder(
							borderSide: BorderSide(width: 2, color: validationStatusColor)
						),
						errorBorder: OutlineInputBorder(
							borderSide: BorderSide(color: validationStatusColor)
						),
						focusedErrorBorder: OutlineInputBorder(
							borderSide: BorderSide(color: validationStatusColor)),
						disabledBorder: const OutlineInputBorder(
							borderSide: BorderSide(color: Colors.grey)),
						label: floatingLabelMessage,
						floatingLabelAlignment: FloatingLabelAlignment.start,
						floatingLabelStyle: const TextStyle(fontSize: 14),
						suffixIcon: this.unit == null ? null :
							Padding(
								padding: const EdgeInsets.only(right: 12),
								child: Text(
									this.unit!,
									style: Theme.of(context).textTheme.subtitle1
								)
							),
						suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
						counterText: ''
					),
					onChanged: this.onChanged,
					textInputAction: this.textInputAction
				)
			)
		);
	}
}