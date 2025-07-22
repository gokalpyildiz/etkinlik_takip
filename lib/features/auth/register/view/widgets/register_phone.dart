part of '../register_view.dart';

class _RegisterPhone extends StatelessWidget {
  const _RegisterPhone();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return MyTextFormField(
      keyboardType: Platform.isIOS ? const TextInputType.numberWithOptions(signed: true) : TextInputType.phone,
      validator: (p0) => ValidationsFunctions.validatePhone(p0, requiredPhoneLength: 13, isRequired: false),
      onChanged: (p0) => cubit.phone = p0,
      autofillHints: const [AutofillHints.telephoneNumber],
      inputFormatters: [InputFormatterFunctions.instance.phoneFormatter2],
      hintText: '5 xx xxx xx xx',
      prefixIcon: IconButton(
        onPressed: () {},
        icon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CountryCodePicker(
              padding: EdgeInsets.zero,
              initialSelection: cubit.countryCode?.code,
              showFlagDialog: true,
              favorite: [cubit.countryCode?.code ?? "TR"],
              onChanged: (value) {
                cubit.countryCode = value;
              },
              builder: (country) {
                return Row(
                  children: [
                    if (country?.flagUri != null)
                      Image.asset(
                        country!.flagUri!,
                        package: 'country_code_picker',
                        width: 20,
                        height: 16,
                        // width: country.flagWidth,
                      ),
                    const SizedBox(width: 4),
                    Text(country?.name ?? ''),
                    //Text('Azərbaycan'),
                    const SizedBox(width: 4),
                  ],
                );
              },
              dialogSize: const Size(300, 400),
            ),
            Icon(Icons.arrow_drop_up),
          ],
        ),
      ),
    );
  }
}
