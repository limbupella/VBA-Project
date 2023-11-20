Module 3 Assignment
Sub Stockanalysis()

Dim ws As Worksheet

For Each ws In ThisWorkbook.Worksheets

Dim Ticker As String
Dim YearlyChange As Double
Dim PercentChange As Double
Dim TotalStockVolume As Double
Dim OpeningPrice As Double
Dim ClosingPrice As Double
Dim Summary_Table_Row As Double

TotalStockVolume = 0
Summary_Table_Row = 2

'Loop through all worksheets
RowCount = ws.Cells(Rows.Count, "A").End(xlUp).Row

ws.Range("I1").Value = "Ticker"
ws.Range("J1").Value = "Yearly Change"
ws.Range("K1").Value = "Percent Change"
ws.Range("L1").Value = "Total Stock Volume"
ws.Range("O2").Value = "Greatest % increase"
ws.Range("O3").Value = "Greatest % decrease"
ws.Range("O4").Value = "Greatest total volume"
ws.Range("P1").Value = "Ticker"
ws.Range("Q1").Value = "value"

OpeningPrice = ws.Cells(2, 3).Value
 
 ' Loop through all stocks
For i = 2 To RowCount

 ' Check if we are still within the same credit card brand, if it is not...
 If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then

' Set the Ticker
 Ticker = ws.Cells(i, 1).Value
' Add to the TotalStockVolume
TotalStockVolume = TotalStockVolume + ws.Cells(i, 7).Value
' Print the Credit Card Brand in the Summary Table
ws.Range("I" & Summary_Table_Row).Value = Ticker
ClosingPrice = ws.Cells(i, 6).Value
YearlyChange = ClosingPrice - OpeningPrice
PercentChange = YearlyChange / OpeningPrice
      
ws.Range("J" & Summary_Table_Row).Value = YearlyChange
ws.Range("K" & Summary_Table_Row).Value = PercentChange
ws.Range("K" & Summary_Table_Row).NumberFormat = "0.00%"
 
 ' Print the Brand Amount to the Summary Table
ws.Range("L" & Summary_Table_Row).Value = TotalStockVolume

If ws.Range("J" & Summary_Table_Row).Value > 0 Then
ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 4

ElseIf ws.Range("J" & Summary_Table_Row).Value < 0 Then
       ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 3
        End If
        
        ' Add one to the summary table row
        Summary_Table_Row = Summary_Table_Row + 1
        
' Reset the TotalStockVolume
TotalStockVolume = 0
OpeningPrice = ws.Cells(i + 1, 3).Value
' If the cell immediately following a row is the same brand...

    Else
' Add to the TotalStockVolume
TotalStockVolume = TotalStockVolume + ws.Cells(i, 7).Value
    End If
Next i
        Set r = ws.Range("K2:K" & Rows.Count)
    ws.Range("Q2").Value = Application.WorksheetFunction.Max(r)
    ws.Range("Q3").Value = Application.WorksheetFunction.Min(r)
    
    Set r = ws.Range("L2:L" & Rows.Count)
    ws.Range("Q4").Value = Application.WorksheetFunction.Max(r)
    
    increase_number = WorksheetFunction.Match(WorksheetFunction.Max(ws.Range("K2:K" & RowCount)), ws.Range("K2:K" & RowCount), 0)
    ws.Range("P2").Value = ws.Cells(increase_number + 1, 9)
    
    decrease_number = WorksheetFunction.Match(WorksheetFunction.Min(ws.Range("K2:K" & RowCount)), ws.Range("K2:K" & RowCount), 0)
    ws.Range("P3").Value = ws.Cells(decrease_number + 1, 9)
    
    greatest_total_volume = WorksheetFunction.Match(WorksheetFunction.Max(ws.Range("L2:L" & RowCount)), ws.Range("L2:L" & RowCount), 0)
    ws.Range("P4").Value = ws.Cells(greatest_total_volume + 1, 9)
   
   Next ws
End Sub

