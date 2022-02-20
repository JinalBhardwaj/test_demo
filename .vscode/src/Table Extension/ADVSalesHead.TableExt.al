/// <summary>
/// TableExtension ADV Sales Head (ID 50001) extends Record Sales Header.
/// Used to add field from customer Management
/// </summary>
tableextension 50001 "ADV Sales Head" extends "Sales Header"
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