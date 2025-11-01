
import 'package:flutter_bloc/flutter_bloc.dart';

class AppOnserver extends BlocObserver{
  @override
  void onChange(BlocBase bloc, Change change) {
    print(bloc);
    print(change);
    super.onChange(bloc, change);
  }
}