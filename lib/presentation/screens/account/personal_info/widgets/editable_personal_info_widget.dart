import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../blocs/user_panel/user_bloc.dart';
import '../../../../blocs/user_panel/user_event.dart';
import '../../../../blocs/user_panel/user_state.dart';

class EditablePersonalInfoWidget extends StatefulWidget {
  const EditablePersonalInfoWidget({super.key});

  @override
  State<EditablePersonalInfoWidget> createState() => _EditablePersonalInfoWidgetState();
}

class _EditablePersonalInfoWidgetState extends State<EditablePersonalInfoWidget> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool isEditable = false;

  String _selectedGender = 'female';
  DateTime _selectedDate = DateTime.now();
  String _selectedCountryCode = '+44';

  final List<String> _genders = ['male', 'female',];
  final List<Map<String, String>> _countryCodes = [
    {'code': '+44', 'flag': 'assets/flags/en.svg', 'country': 'England'},
    {'code': '+998', 'flag': 'assets/icons/uz.svg', 'country': 'Uzbekistan'},
    {'code': '+7', 'flag': 'assets/icons/ru.svg', 'country': 'Russia'},
  ];

  File? _avatarFile;
  bool _isUploadingAvatar = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() {
        _avatarFile = File(picked.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showGenderBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colors.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'select_gender'.tr(),
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: context.colors.scrim,
              ),
            ),
            const SizedBox(height: 20),
            ..._genders.map((gender) => InkWell(
              onTap: () {
                setState(() {
                  _selectedGender = gender;
                });
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Icon(
                      gender == 'male' ? Icons.male : Icons.female,
                      color: _selectedGender == gender
                          ? context.colors.primary
                          : context.colors.scrim,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      gender.tr(),
                      style: GoogleFonts.urbanist(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: _selectedGender == gender
                            ? context.colors.primary
                            : context.colors.scrim,
                      ),
                    ),
                    const Spacer(),
                    if (_selectedGender == gender)
                      Icon(
                        Icons.check,
                        color: context.colors.primary,
                      ),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.colors.primary,
              onPrimary: Colors.white,
              surface: context.colors.surface,
              onSurface: context.colors.scrim,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showCountryCodeBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colors.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select Country'.tr(),
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: context.colors.scrim,
              ),
            ),
            const SizedBox(height: 20),
            ..._countryCodes.map((country) => InkWell(
              onTap: () {
                setState(() {
                  _selectedCountryCode = country['code']!;
                });
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      country['flag']!,
                      width: 24,
                      height: 18,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${country['country']} (${country['code']})',
                      style: GoogleFonts.urbanist(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: _selectedCountryCode == country['code']
                            ? context.colors.primary
                            : context.colors.scrim,
                      ),
                    ),
                    const Spacer(),
                    if (_selectedCountryCode == country['code'])
                      Icon(
                        Icons.check,
                        color: context.colors.primary,
                      ),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  Widget _buildEditableField({
    required String label,
    required Widget child,
  }) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.tr(),
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w600,
            color: context.colors.scrim,
            fontSize: 20.sp,
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    Widget? prefixIcon,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.outline,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: context.colors.outline),
      ),
      child: TextField(
        enabled: enabled,
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.urbanist(
          fontWeight: FontWeight.w600,
          color: context.colors.scrim,
          fontSize: 18.sp,
        ),
        decoration: InputDecoration(
          hintText: hintText.tr(),
          hintStyle: GoogleFonts.urbanist(
            fontWeight: FontWeight.w400,
            color: context.colors.scrim.withOpacity(0.6),
            fontSize: 18.sp,
          ),
          prefixIcon: prefixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }

  Widget _buildTappableField({
    required String text,
     VoidCallback? onTap,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: context.colors.outline,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: context.colors.outline),
        ),
        child: Row(
          children: [
            if (prefixIcon != null) ...[
              prefixIcon,
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  color: context.colors.scrim,
                  fontSize: 18.sp,
                ),
              ),
            ),
            if (suffixIcon != null) suffixIcon,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        }
        if (state.error != null) return Text('Error: ${state.error}');

        if (!isEditable) {
          _nameController.text = state.name;
          _emailController.text = state.email;

          final phoneParts = _splitPhoneNumber(state.phone);
          _selectedCountryCode = phoneParts['countryCode'] ?? '+44';
          _phoneController.text = phoneParts['number'] ?? '';

          _selectedGender = state.gender;

          if (state.birthday.isNotEmpty) {
            try {
              final parts = state.birthday.split('/');
              _selectedDate = DateTime(
                int.parse(parts[2]),
                int.parse(parts[1]),
                int.parse(parts[0]),
              );
            } catch (e) {
              print('Error parsing date: $e');
            }
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            // avatar:
            Stack(
              children: [
                // Avatar image with loading indicator
                _isUploadingAvatar
                    ? CircularProgressIndicator()
                    : CircleAvatar(
                  radius: 30.r,
                  backgroundImage: _getAvatarImage(state),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => setState(() => isEditable = true),
                    child: SvgPicture.asset("assets/icons/pencil.svg"),
                  ),
                ),
              ],
            ),

            if (isEditable)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.camera);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(width: 1,color: context.colors.primary),
                      ),
                      child: Center(
                        child: Icon(Icons.camera_alt_outlined,color: context.colors.primary,),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(width: 1,color: context.colors.primary),
                      ),
                      child: Center(
                        child: Icon(Icons.photo,color: context.colors.primary,),
                      ),
                    ),
                  ),
                ],
              ),

            // name
            _buildEditableField(
              label: "full_name",
              child: _buildTextField(
                controller: _nameController,
                hintText: "Enter fullname",
                enabled: isEditable,
              ),
            ),

            // email:
            _buildEditableField(
              label: "email",
              child: _buildTextField(
                controller: _emailController,
                hintText: "Enter email",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "assets/icons/email.svg",
                    width: 17.92,
                    height: 16.25,
                  ),
                ),
                enabled: isEditable,
              ),
            ),

            // phone_number:
            _buildEditableField(
              label: "phone_number",
              child: Row(
                children: [
                  GestureDetector(
                    onTap: isEditable ? _showCountryCodeBottomSheet : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      decoration: BoxDecoration(
                        color: context.colors.outline,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        border: Border.all(width: 1, color: context.colors.outline),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            _countryCodes.firstWhere((c) => c['code'] == _selectedCountryCode)['flag']!,
                            width: 17.92,
                            height: 16.25,
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            "assets/icons/arrow_down.svg",
                            width: 12,
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // phone_input:
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colors.outline,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(width: 1, color: context.colors.outline),
                      ),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w600,
                          color: context.colors.scrim,
                          fontSize: 18.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter phone number'.tr(),
                          hintStyle: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w400,
                            color: context.colors.scrim.withOpacity(0.6),
                            fontSize: 18.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                          prefixText: '$_selectedCountryCode ',
                          prefixStyle: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w600,
                            color: context.colors.scrim,
                            fontSize: 18.sp,
                          ),
                          enabled: isEditable,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // gender:
            _buildEditableField(
              label: "gender",
              child: _buildTappableField(
                text: _selectedGender.tr(),
                onTap: isEditable ? _showGenderBottomSheet : null,
                suffixIcon: SvgPicture.asset(
                  "assets/icons/arrow_down.svg",
                  width: 12,
                  height: 12,
                ),
                enabled: isEditable,
              ),
            ),

            // birthdate:
            _buildEditableField(
              label: "date_of_birth",
              child: _buildTappableField(
                text: _formatDate(_selectedDate),
                onTap: isEditable ? _showDatePicker : null,
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: context.colors.scrim,
                  size: 18,
                ),
                enabled: isEditable,
              ),
            ),

            // save
            const SizedBox(height: 20),

            if (isEditable)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<UserProfileBloc>().add(
                    SaveUserProfile(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: '$_selectedCountryCode ${_phoneController.text}',
                      gender: _selectedGender,
                      birthday: _formatDate(_selectedDate),
                      // avatarFile: _avatarFile,
                    ),
                  );
                  setState(() => isEditable = false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'save'.tr(),
                  style: GoogleFonts.urbanist(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  ImageProvider _getAvatarImage(UserProfileState state) {
    if (_avatarFile != null) return FileImage(_avatarFile!);
    if (state.avatarUrl.isNotEmpty) return NetworkImage(state.avatarUrl);
    return const AssetImage("assets/images/female_avatar.png");
  }
  Map<String, String> _splitPhoneNumber(String fullPhone) {
    for (var country in _countryCodes) {
      final code = country['code']!;
      if (fullPhone.startsWith(code)) {
        return {
          'countryCode': code,
          'number': fullPhone.substring(code.length).trim(),
        };
      }
    }
    return {'countryCode': '+44', 'number': fullPhone};
  }

}
