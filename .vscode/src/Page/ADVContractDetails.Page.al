/// <summary>
/// Page ADV Contract Details (ID 50004).
/// </summary>
page 50004 "ADV Contract Details"
{
    PageType = List;
    Caption = 'Contract Detail';
    ApplicationArea = All;
    UsageCategory = Tasks;
    CardPageId = "ADV Contract Detail";
    SourceTable = "ADV Contract Header";
    Editable = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Contract No."; REC."Contract No.")
                {
                    ApplicationArea = All;

                }
                field("Customer Name"; REC."Customer Name")
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field("Start Date"; REC."Start Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; REC."End Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}