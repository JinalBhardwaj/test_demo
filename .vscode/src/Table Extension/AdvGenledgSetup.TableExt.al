/// <summary>
/// TableExtension Adv Gen ledg Setup (ID 50000) extends Record General Ledger Setup.
/// </summary>
tableextension 50000 "Adv Gen ledg Setup" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Contract No's"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Billing GL Acc."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
            Caption = 'Billing GL Account';
        }
    }

    var

}