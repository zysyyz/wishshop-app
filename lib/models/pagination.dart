class Pagination {
  int currentPage;
  int from;
  int lastPage;
  int perPage;
  int to;
  int total;

  Pagination({
    this.currentPage,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage   : json['current_page'],
      from          : json['from'],
      lastPage      : json['last_page'],
      perPage       : json['per_page'],
      to            : json['to'],
      total         : json['total'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'current_page'  : currentPage,
      'from'          : from,
      'last_page'     : lastPage,
      'per_page'      : perPage,
      'to'            : to,
      'total'         : total,
    };
}
