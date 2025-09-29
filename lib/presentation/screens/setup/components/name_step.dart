import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/presentation/blocs/setup/setup_bloc.dart';
import '../../../blocs/setup/setup_event.dart';
import '../../../blocs/setup/setup_state.dart';
import '../../../widgets/custom_input.dart';


class NameStep extends StatelessWidget {
  const NameStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 0.7.sh,
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "your_name".tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
                fontSize: 32.sp, fontWeight: FontWeight.w700),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: BlocBuilder<SetupBloc, SetupState>(
                  builder: (context,state) {
                    return CustomInput(
                      onChanged: (value) {
                        context.read<SetupBloc>().add(NameChanged(value));
                      } ,
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
