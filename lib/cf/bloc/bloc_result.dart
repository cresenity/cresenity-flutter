


class CFBlocResult<T> {
  T _value;

  get value => _value;

  CFBlocResult<T> setValue(T val) {
    this._value = val;
    return this;
  }
}