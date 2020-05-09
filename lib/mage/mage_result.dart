


class MageResult<T> {
  T _value;

  get value => _value;

  MageResult<T> setValue(T val) {
    this._value = val;
    return this;
  }
}