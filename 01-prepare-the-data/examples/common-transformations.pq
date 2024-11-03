// Common Power Query Transformations Examples

// 1. Combine Multiple Excel Files from Folder
let
    Source = Folder.Files("C:\Data"),
    FilteredFiles = Table.SelectRows(Source, each [Extension] = ".xlsx"),
    AddCustom = Table.AddColumn(FilteredFiles, "Excel Data", each Excel.Workbook([Content])),
    ExpandedExcel = Table.ExpandTableColumn(AddCustom, "Excel Data", {"Data"}, {"Data"}),
    ExpandedData = Table.ExpandTableColumn(ExpandedExcel, "Data", {"Column1", "Column2", "Column3"})
in
    ExpandedData

// 2. Clean and Transform Customer Data
let
    Source = Excel.Workbook(File.Contents("Sample.xlsx"), null, true),
    CustomerTable = Source{[Item="Customers",Kind="Table"]}[Data],
    // Remove blank rows
    RemoveBlanks = Table.SelectRows(CustomerTable, each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    // Clean and transform columns
    CleanedData = Table.TransformColumns(RemoveBlanks, {
        {"CustomerName", Text.Proper},
        {"Email", Text.Lower},
        {"Phone", each Text.Select(_, {"0".."9"})}
    }),
    // Add custom column
    AddCustomColumn = Table.AddColumn(CleanedData, "FullAddress",
        each [Address] & ", " & [City] & ", " & [Country])
in
    AddCustomColumn

// 3. Sales Data Transformation
let
    Source = Sql.Database("ServerName", "DatabaseName"),
    SalesTable = Source{[Schema="dbo",Item="Sales"]}[Data],
    // Filter last 12 months
    FilteredRows = Table.SelectRows(SalesTable, 
        each [Date] >= Date.AddMonths(Date.From(DateTime.LocalNow()), -12)),
    // Add calculated columns
    AddCalculations = Table.AddColumn(FilteredRows, "TotalAmount", 
        each [Quantity] * [UnitPrice], Currency.Type),
    // Group by month
    GroupedByMonth = Table.Group(AddCalculations, 
        {"Year", "Month"}, {
            {"TotalSales", each List.Sum([TotalAmount]), Currency.Type},
            {"OrderCount", each Table.RowCount(_), Int64.Type}
        })
in
    GroupedByMonth

// 4. Error Handling Examples
let
    Source = Excel.Workbook(File.Contents("DataFile.xlsx"), null, true),
    DataTable = Source{[Item="Sheet1",Kind="Table"]}[Data],
    // Handle errors in number conversion
    SafeNumbers = Table.TransformColumns(DataTable, {
        {"Amount", each try Number.From(_) otherwise 0},
        {"Quantity", each try Int64.From(_) otherwise 0}
    }),
    // Remove error rows
    RemoveErrors = Table.RemoveRowsWithErrors(SafeNumbers, {"Amount", "Quantity"})
in
    RemoveErrors

// 5. Date Table Generation
let
    // Parameters
    StartDate = #date(2020, 1, 1),
    EndDate = #date(2024, 12, 31),
    // Generate dates
    DateList = List.Dates(StartDate, Duration.Days(EndDate - StartDate) + 1, #duration(1,0,0,0)),
    // Convert to table
    DateTable = Table.FromList(DateList, Splitter.SplitByNothing()),
    // Rename column
    RenamedColumns = Table.RenameColumns(DateTable, {{"Column1", "Date"}}),
    // Add columns
    AddColumns = Table.AddColumn(RenamedColumns, "Year", each Date.Year([Date])),
    AddMonthNum = Table.AddColumn(AddColumns, "MonthNo", each Date.Month([Date])),
    AddMonth = Table.AddColumn(AddMonthNum, "Month", each Date.MonthName([Date])),
    AddQuarter = Table.AddColumn(AddMonth, "Quarter", each "Q" & Text.From(Date.QuarterOfYear([Date])))
in
    AddQuarter

// 6. Merge Multiple Sources Example
let
    // Load first table
    Orders = Excel.Workbook(File.Contents("Orders.xlsx"), null, true),
    OrdersTable = Orders{[Item="Sheet1",Kind="Table"]}[Data],
    // Load second table
    Products = Excel.Workbook(File.Contents("Products.xlsx"), null, true),
    ProductsTable = Products{[Item="Sheet1",Kind="Table"]}[Data],
    // Merge tables
    MergedTables = Table.NestedJoin(
        OrdersTable, {"ProductID"},
        ProductsTable, {"ProductID"},
        "ProductDetails",
        JoinKind.LeftOuter
    ),
    // Expand merged columns
    ExpandedTable = Table.ExpandTableColumn(
        MergedTables, 
        "ProductDetails", 
        {"ProductName", "Category", "UnitPrice"}
    )
in
    ExpandedTable

// 7. Pivot Table Example
let
    Source = Excel.Workbook(File.Contents("SalesData.xlsx"), null, true),
    SalesTable = Source{[Item="Sheet1",Kind="Table"]}[Data],
    // Pivot data
    PivotedTable = Table.Pivot(
        SalesTable,
        List.Distinct(SalesTable[Region]),
        "Region",
        "Sales",
        List.Sum
    )
in
    PivotedTable
