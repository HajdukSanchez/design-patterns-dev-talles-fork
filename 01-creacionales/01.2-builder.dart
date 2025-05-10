//! Tarea: crear un QueryBuilder para construir consultas SQL
/**
 * Debe de tener los siguientes métodos:
 * - constructor(table: string)
 * - select(fields: string[]): QueryBuilder -- si no se pasa ningún campo, se seleccionan todos con el (*)
 * - where(condition: string): QueryBuilder - opcional
 * - orderBy(field: string, order: string): QueryBuilder - opcional
 * - limit(limit: number): QueryBuilder - opcional
 * - execute(): string - retorna la consulta SQL
 *
 ** Ejemplo de uso:
  const usersQuery = new QueryBuilder("users") // users es el nombre de la tabla
    .select("id", "name", "email")
    .where("age > 18")
    .where("country = 'Cri'")
    .orderBy("name", "ASC")
    .limit(10)
    .execute();

  console.log('Consulta: ', usersQuery);
  // Select id, name, email from users where age > 18 and country = 'Cri' order by name ASC limit 10;
 */
class QueryBuilder {
  QueryBuilder({required String table}) : _table = table;

  final String _table;
  List<String> get _defaultSelect => ['*'];
  List<String> _select = [];
  List<String> _where = [];
  List<String> _order = [];
  int? _limit;

  String build() {
    String query = 'SELECT';
    // Add SELECT section
    query += ' ${(_select.isEmpty ? _defaultSelect : _select).join(", ")}';
    // Add FROM section
    query += ' FROM ${_table}';
    // Add WHERE sections
    query += ' ${_where.join(" AND ")}';
    // Add ORDER section
    query += ' ${_order.join(', ')}';
    // Add LIMIT section
    if (_limit != null) {
      query += ' LIMIT ${_limit}';
    }

    return query;
  }

  QueryBuilder select(List<String> fields) {
    if (fields.isEmpty) {
      // Mark all fields
      _select = _defaultSelect;
    } else {
      _select = fields;
    }
    return this;
  }

  QueryBuilder where(String condition) {
    _where.add(condition);
    return this;
  }

  QueryBuilder orderBy(String field, String order) {
    _order.add('ORDER BY $field $order');
    return this;
  }

  QueryBuilder limit(int limit) {
    _limit = limit;
    return this;
  }
}

void main(List<String> args) {
  final usersQuery =
      QueryBuilder(table: 'Users')
          .select(["id", "name", "email"])
          .where("age > 18")
          .where("country = 'Cri'")
          .orderBy("name", "ASC")
          .orderBy("lastName", "DESC")
          .limit(10)
          .build();
  print(usersQuery);

  final allQuery =
      QueryBuilder(table: 'Users')
          .where("age > 18")
          .where("country = 'Cri'")
          .orderBy("name", "ASC")
          .limit(10)
          .build();
  print(allQuery);
}
