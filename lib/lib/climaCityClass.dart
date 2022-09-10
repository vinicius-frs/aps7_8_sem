class ClimaCity{
  String _nome;
  String _pais;
  String _climaDesc;
  String _climaIcon;
  double _temp;
  double _tempMin;
  double _tempMax;

  //Construtor
  ClimaCity(this._nome, this._pais, this._climaDesc, this._climaIcon, this._temp, this._tempMin, this._tempMax);

  //Getters & Setters
  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  String get climaDesc => _climaDesc;

  set climaDesc(String value) {
    _climaDesc = value;
  }

  String get climaIcon => _climaIcon;

  set climaIcon(String value) {
    _climaIcon = value;
  }

  double get temp => _temp;

  set temp(double value) {
    _temp = value;
  }

  double get tempMin => _tempMin;

  set tempMin(double value) {
    _tempMin = value;
  }

  double get tempMax => _tempMax;

  set tempMax(double value) {
    _tempMax = value;
  }
}