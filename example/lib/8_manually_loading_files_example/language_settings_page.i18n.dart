// Developed by Marcelo Glasberg (2019) https://glasberg.dev and https://github.com/marcglasberg
// For more info, see: https://pub.dartlang.org/packages/i18n_extension
import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //
  static final _t = Translations.byText("en-US") +
      {
        "en-US": "Language Settings Page",
        "pt-BR": "Configuração de Idioma",
        "es-ES": "Configuración de idioma",
      };

  String get i18n => localize(this, _t);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

  Map<String?, String> allVersions() => localizeAllVersions(this, _t);
}
