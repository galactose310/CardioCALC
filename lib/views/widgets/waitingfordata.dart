part of 'widgets.dart';

class WaitingForDataBody extends StatelessWidget
{
	const WaitingForDataBody({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return Container(
			constraints: const BoxConstraints.expand(),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					const CircularProgressIndicator(),
					const SizedBox(height: 20),
					Text(AppLocalizations.of(context)!.waitingData)
				]
			)
		);
	}
}