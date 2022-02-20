/// <summary>
/// PageExtension ADV Gen led Set (ID 50000) extends Record General Ledger Setup.
/// </summary>
pageextension 50000 "ADV Gen led Set" extends "General Ledger Setup"
{
    layout
    {
        addafter("Bank Account Nos.")
        {
            field("Contract No's"; Rec."Contract No's")
            {
                ApplicationArea = all;
                Caption = 'Contract Nos.';
                ToolTip = 'Specifies the Contract Detail NO. series';
            }
            field("Billing GL Acc."; Rec."Billing GL Acc.")
            {
                ApplicationArea = all;
                Caption = 'Billing GL Account';
                ToolTip = 'Specifies the billing GL value that has been considered for commission';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}