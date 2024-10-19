part of 'ventriculartachycardia_bloc.dart';

abstract class VentricularTachycardiaEvent extends Equatable
{
	const VentricularTachycardiaEvent();
	
	@override
	List<Object> get props => [];
}

class YourEvent extends VentricularTachycardiaEvent
{
	const YourEvent({required this.var1});
	final bool var1;
	@override
	List<Object> get props => [var1];
}