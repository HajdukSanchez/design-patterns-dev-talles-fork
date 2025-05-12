/**
 * 	!Descripción:
  1.	Completen las clases SalesReport e InventoryReport para implementar
      la interfaz Report, generando el contenido de cada reporte en el método generate.

  2.	Implementen las clases SalesReportFactory e InventoryReportFactory
      para crear instancias de SalesReport y InventoryReport, respectivamente.

	3.	Prueben el programa generando diferentes tipos de reportes usando
      el prompt para seleccionar el tipo de reporte.
 */

abstract interface class Report {
  void generate();
}

class SalesReport implements Report {
  @override
  void generate() {
    print('Generating sales report');
  }
}

class InventoryReport implements Report {
  @override
  void generate() {
    print('Generating Inventory report');
  }
}

abstract class ReportFactory {
  Report createReport();

  void generateReport() {
    final report = createReport();
    report.generate();
  }
}

class SalesReportFactory extends ReportFactory {
  @override
  Report createReport() {
    return SalesReport();
  }
}

class InventoryReportFactory extends ReportFactory {
  @override
  Report createReport() {
    return InventoryReport();
  }
}

enum ReportType { sales, inventory }

void main() {
  final reportType = ReportType.sales;
  final ReportFactory reportFactory = switch (reportType) {
    ReportType.inventory => InventoryReportFactory(),
    ReportType.sales => SalesReportFactory(),
  };
  reportFactory.generateReport();
}
