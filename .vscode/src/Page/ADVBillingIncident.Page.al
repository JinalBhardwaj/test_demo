/// <summary>
/// Page ADV Billing Incident (ID 50000).
/// </summary>
page 50000 "ADV Billing Incident"
{
    PageType = List;
    Caption = 'Billing Incidents';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ADV Billing Incident";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Incident Code"; Rec."Incident Code")
                {
                    ApplicationArea = All;

                }
                field("Incident Name"; Rec."Incident Name")
                {
                    ApplicationArea = all;
                }
                field("Comm. Milest. Considered"; REC."Comm. Milest. Considered")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    /*
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
            myInt: Integer;*/
}