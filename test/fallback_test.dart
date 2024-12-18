import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i18n_extension/i18n_extension.dart';

void main() {
  //
  test(
      "If the translation to the exact locale is found, this will be returned. "
      "Otherwise, it tries to return a translation for the general language of the locale. "
      "Otherwise, it tries to return a translation for any locale with that language. "
      "Otherwise, it tries to return the key itself (which is the translation for the default locale).",
      () {
    // Translations exist for "en-US": ----------------

    // There's an EXACT translation for this exact locale.
    I18n.define(const Locale('es', 'US'));
    expect("Mobile phone".i18n_1, "Mobile phone");

    // There's NO exact translation, and NO general translation.
    // So uses any other translation in "en".
    I18n.define(const Locale("en", "UK"));
    expect("Mobile phone".i18n_1, "Mobile phone");

    // There's NO general "en" translation, so uses any other translation in "en".
    I18n.define(const Locale("en"));
    expect("Mobile phone".i18n_1, "Mobile phone");

    // Ignores ending with "_".
    I18n.define(const Locale("en", "us_"));
    expect("Mobile phone".i18n_1, "Mobile phone");

    // Translations exist for "pt-BR" and "pt-PT": ----------------

    // There's an EXACT translation for this exact locale.
    I18n.define(const Locale('pt', 'BR'));
    expect("Mobile phone".i18n_1, "Celular");

    // There's an EXACT translation for this exact locale.
    I18n.define(const Locale("pt", "PT"));
    expect("Mobile phone".i18n_1, "Telemóvel");

    // There's NO exact translation, and NO general translation.
    // So uses any other translation in "pt".
    I18n.define(const Locale("pt", "MO"));
    expect("Mobile phone".i18n_1, "Celular");

    // There's NO general "pt" translation, so uses any other translation in "pt".
    I18n.define(const Locale("pt"));
    expect("Mobile phone".i18n_1, "Celular");

    // There's NO translation at all in this language.
    I18n.define(const Locale("xx"));
    expect("Mobile phone".i18n_1, "Mobile phone");

    // There's NO translation at all in this locale.
    I18n.define(const Locale("xx", "yy"));
    expect("Mobile phone".i18n_1, "Mobile phone");

    // Translations exist for "pt-BR" and "pt": ----------------

    // There's an EXACT translation for this exact locale.
    I18n.define(const Locale('pt', 'BR'));
    expect("Address".i18n_1, "Endereço");

    // There's NO exact translation,
    // So uses the GENERAL translation in "pt".
    I18n.define(const Locale("pt", "PT"));
    expect("Address".i18n_1, "Morada");

    // There's the exact GENERAL translation in "pt".
    I18n.define(const Locale("pt"));
    expect("Address".i18n_1, "Morada");

    // There's NO translation at all in this language.
    I18n.define(const Locale("xx"));
    expect("Address".i18n_1, "Address");

    // There's NO translation at all in this locale.
    I18n.define(const Locale("xx", "yy"));
    expect("Address".i18n_1, "Address");

    // Ignores ending with "_".
    I18n.define(const Locale("pt", "_"));
    expect("Address".i18n_1, "Morada");
  });

  test(
      "If the translation to the exact locale is found, this will be returned. "
      "Otherwise, it tries to return a translation for the general language of the locale. "
      "Otherwise, it tries to return a translation for any locale with that language. "
      "Otherwise, it tries to return the key itself (which is the translation for the default locale).",
      () {
    // Translations exist for "en": ----------------

    // There's an EXACT translation for this exact locale.
    I18n.define(const Locale("en"));
    expect("Mobile phone".i18n_2, "Mobile phone");

    // There's NO exact translation, so uses general "en".
    I18n.define(const Locale('es', 'US'));
    expect("Mobile phone".i18n_2, "Mobile phone");

    // Ignores country with "_".
    I18n.define(const Locale("en", "_us"));
    expect("Mobile phone".i18n_2, "Mobile phone");

    // Translations exist for "pt-BR" and "pt-PT": ----------------

    // There's an EXACT translation for this exact locale.
    I18n.define(const Locale('pt', 'BR'));
    expect("Mobile phone".i18n_2, "Celular");

    // There's an EXACT translation for this exact locale.
    I18n.define(const Locale("pt", "PT"));
    expect("Mobile phone".i18n_2, "Telemóvel");

    // There's NO exact translation, and NO general translation.
    // So uses any other translation in "pt".
    I18n.define(const Locale("pt", "MO"));
    expect("Mobile phone".i18n_2, "Celular");

    // There's NO general "pt" translation, so uses any other translation in "pt".
    I18n.define(const Locale("pt"));
    expect("Mobile phone".i18n_2, "Celular");

    // There's NO translation at all in this language.
    I18n.define(const Locale("xx"));
    expect("Mobile phone".i18n_2, "Mobile phone");

    // There's NO translation at all in this locale.
    I18n.define(const Locale("xx", "YY"));
    expect("Mobile phone".i18n_2, "Mobile phone");

    // Ignores country with "_".
    I18n.define(const Locale("pt", "_br"));
    expect("Mobile phone".i18n_2, "Celular");

    // Translations exist for "pt-BR" and "pt": ----------------

    // There's an EXACT translation for this exact locale.
    I18n.define(const Locale('pt', 'BR'));
    expect("Address".i18n_2, "Endereço");

    // There's NO exact translation,
    // So uses the GENERAL translation in "pt".
    I18n.define(const Locale("pt", "PT"));
    expect("Address".i18n_2, "Morada");

    // There's the exact GENERAL translation in "pt".
    I18n.define(const Locale("pt"));
    expect("Address".i18n_2, "Morada");

    // There's NO translation at all in this language.
    I18n.define(const Locale("xx"));
    expect("Address".i18n_2, "Address");

    // There's NO translation at all in this locale.
    I18n.define(const Locale("xx", "YY"));
    expect("Address".i18n_2, "Address");
  });

  test("Ignores spaces or underscore.", () {
    //
    expect(Translations.byText("en").defaultLocaleStr, "en");
    expect(Translations.byText("en-US").defaultLocaleStr, "en-US");

    expect(
        () => Translations.byText("en_us").defaultLocaleStr,
        throwsA(isA<TranslationsException>().having((e) => e.msg, 'msg',
            'Locale "en_us" is not a valid BCP47 language tag. Try "en-US".')));
    expect(
        () => Translations.byText("en_").defaultLocaleStr,
        throwsA(isA<TranslationsException>().having((e) => e.msg, 'msg',
            'Locale "en_" is not a valid BCP47 language tag. Try "en".')));

    I18n.define(const Locale("en"));
    expect(I18n.languageTag, "en");

    I18n.define(const Locale("en", "_"));
    expect(I18n.languageTag, "en");

    I18n.define(const Locale("en", "-"));
    expect(I18n.languageTag, "en");

    I18n.define(const Locale('en', 'US'));
    expect(I18n.languageTag, "en-US");

    I18n.define(const Locale('es', 'US'));
    expect(I18n.languageTag, "es-US");

    I18n.define(const Locale(" en", "us "));
    expect(I18n.languageTag, "en-US");

    I18n.define(const Locale("  en", "us _ "));
    expect(I18n.languageTag, "en-US");

    I18n.define(const Locale("  en", "us - "));
    expect(I18n.languageTag, "en-US");
  });
}

extension Localization on String {
  //
  static var t1 = Translations.byText("en-US") +
      {
        "en-US": "Mobile phone",
        "pt-BR": "Celular",
        "pt-PT": "Telemóvel",
      } +
      {
        "en-US": "Address",
        "pt-BR": "Endereço",
        "pt": "Morada",
      };

  static var t2 = Translations.byText("en") +
      {
        "en": "Mobile phone",
        "pt-BR": "Celular",
        "pt-PT": "Telemóvel",
      } +
      {
        "en": "Address",
        "pt-BR": "Endereço",
        "pt": "Morada",
      };

  String get i18n_1 => localize(this, t1);

  String get i18n_2 => localize(this, t2);
}
