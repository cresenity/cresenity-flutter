
/**
 * Created by ipul on 10/23/19.
 */

class Pagination {
  int _total;
  int _lastPage;
  int _perPage;
  int _currentPage;

  Pagination.fromJson(Map<String, dynamic> json) {
    print('pagination => $json');
    _total = json['total'];
    _lastPage = json['lastPage'];
    _perPage = json['perPage'];
    _currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this._total;
    data['lastPage'] = this._lastPage;
    data['perPage'] = this._perPage;
    data['currentPage'] = this._currentPage;
    return data;
  }

  int get currentPage => _currentPage;

  int get perPage => _perPage;

  int get lastPage => _lastPage;

  int get total => _total;


}