import 'package:bayat/features/cv_apply/presentation/bloc/request_jobs/jobs_application_cubit.dart';
import 'package:bayat/features/cv_apply/presentation/bloc/request_jobs/request_jobs_state.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/stepindicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'animationbotton.dart';

class JobApplicationFormView extends StatefulWidget {
  final int job; // job id
  final List<GlobalKey<FormState>> formKeys;

  const JobApplicationFormView({
    super.key,
    required this.job,
    required this.formKeys,
  });

  @override
  State<JobApplicationFormView> createState() => _JobApplicationFormViewState();
}

class _JobApplicationFormViewState extends State<JobApplicationFormView>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final double titleFontSize =
    isMobile ? 18 : MediaQuery.of(context).size.width < 1200 ? 22 : 24;

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.blue.shade700,
        colorScheme: ColorScheme.light(
          primary: Colors.blue.shade700,
          secondary: Colors.blueAccent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.blue.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          ),
          prefixIconColor: Colors.blue.shade700,
          labelStyle: TextStyle(color: Colors.blue.shade700),
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          title: Text(
            'طلب التقديم - ${widget.job}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: titleFontSize,
            ),

          ),
          centerTitle: true,
        ),
        body: BlocBuilder<JobApplicationCubit, JobApplicationState>(
          builder: (context, state) {
            if (state is JobApplicationLoading ||
                state is JobApplicationSubmitting) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is JobApplicationFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              );
            } else if (state is JobApplicationSuccess) {
              return const Center(
                child: Text(
                  '✅ تم إرسال الطلب بنجاح',
                ),
              );
            } else if (state is JobApplicationLoaded) {
              return _buildLoadedUI(context, state);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildLoadedUI(BuildContext context, JobApplicationLoaded state) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  buildStepIndicator(state),
                  const SizedBox(height: 24),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _buildStepContent(context, state),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildNavigationButtons(context, state),
                  const SizedBox(height: 16),
                  Text(
                    '${state.calculateProgress().toStringAsFixed(0)}% مكتمل',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, JobApplicationLoaded state) {
    final cubit = context.read<JobApplicationCubit>();
    switch (state.currentStep) {
      case 0:
        return Form(
          key: widget.formKeys[0],
          child: Column(
            children: [
              TextFormField(
                controller: state.controllers['full_name'],
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) => cubit.validateRequired(v, 'الاسم الكامل'),
              ),
              const SizedBox(height: 16),

              // حقل تاريخ الميلاد مع DatePicker
              TextFormField(
                controller: state.controllers['date_of_birth'],
                readOnly: true, // يمنع الكتابة اليدوية
                decoration: const InputDecoration(
                  labelText: 'تاريخ الميلاد (yyyy-MM-dd)',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    locale: const Locale("ar", "DZ"), // عربي
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      state.controllers['date_of_birth']!.text =
                          formattedDate;
                    });
                  }
                },
                validator: cubit.validateDate,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: state.controllers['email'],
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: cubit.validateEmail,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: state.controllers['phone'],
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: cubit.validatePhone,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: state.controllers['wilaya']!.text.isEmpty
                    ? null
                    : state.controllers['wilaya']!.text,
                decoration: const InputDecoration(
                  labelText: 'الولاية',
                  prefixIcon: Icon(Icons.location_city),
                ),
                items: state.wilayas.map((wilaya) {
                  return DropdownMenuItem(
                    value: wilaya,
                    child: Text(
                      wilaya,
                    ),
                  );
                }).toList(),
                onChanged: (val) =>
                state.controllers['wilaya']!.text = val ?? '',
                validator: (v) => cubit.validateRequired(v, 'الولاية'),
              ),
            ],
          ),
        );

      case 1:
        return Form(
          key: widget.formKeys[1],
          child: Column(
            children: [
              TextFormField(
                controller: state.controllers['baladiya'],
                decoration: const InputDecoration(
                  labelText: 'البلدية',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (v) => cubit.validateRequired(v, 'البلدية'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: state.controllers['address'],
                decoration: const InputDecoration(
                  labelText: 'العنوان',
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (v) => cubit.validateRequired(v, 'العنوان'),
              ),
            ],
          ),
        );

      case 2:
        return Form(
          key: widget.formKeys[2],
          child: TextFormField(
            controller: state.controllers['intermediary_number'],
            decoration: const InputDecoration(
              labelText: 'الرقم الوسيط',
              prefixIcon: Icon(Icons.confirmation_number),
            ),
            validator: (v) => cubit.validateRequired(v, 'الرقم الوسيط'),
          ),
        );

      case 3:
        return Column(
          children: [
            Text(
              'رفع السيرة الذاتية',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 16),
            if (state.cvFileName == null)
              const Text(
                'يرجى رفع السيرة الذاتية لإكمال الطلب',
                style: TextStyle(color: Colors.redAccent),
              ),
            const SizedBox(height: 16),
            AnimatedButton(
              label: state.cvFileName == null
                  ? 'رفع السيرة الذاتية'
                  : 'تغيير السيرة الذاتية',
              onPressed: () => context.read<JobApplicationCubit>().pickCV(context),
              isPrimary: true,
            ),
            if (state.cvFileName != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(state.cvFileName!),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => context.read<JobApplicationCubit>().removeCV(),
                  ),
                ],
              ),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  Widget _buildNavigationButtons(
      BuildContext context, JobApplicationLoaded state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        state.currentStep > 0
            ? AnimatedButton(
          label: 'رجوع',
          onPressed: () => context.read<JobApplicationCubit>().previousStep(),
          isPrimary: false,
        )
            : TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء', style: TextStyle(color: Colors.redAccent)),
        ),
        AnimatedButton(
          label: state.currentStep == 3 ? 'إرسال' : 'التالي',
          onPressed: state.currentStep == 3 && state.cvFileName == null
              ? null
              : () => context.read<JobApplicationCubit>().nextStep(widget.formKeys, context),
          isPrimary: true,
          isDisabled: state.currentStep == 3 && state.cvFileName == null,
        ),
      ],
    );
  }
}
