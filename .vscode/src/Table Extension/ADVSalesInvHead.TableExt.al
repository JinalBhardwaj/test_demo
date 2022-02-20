/// <summary>
/// TableExtension ADV Sales Inv Head (ID 50002) extends Record Sales Invoice Header.
/// Used to add field from customer Management
/// </summary>
tableextension 50002 "ADV Sales Inv Head" extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "Contract ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Cust. Mgmt. SerialNo."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Management Serial No.';
        }
    }

}