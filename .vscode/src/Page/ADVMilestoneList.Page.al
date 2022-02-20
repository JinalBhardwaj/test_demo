/// <summary>
/// Page Adv Milestone List (ID 50000).
/// </summary>
page 50001 "ADV Milestone List"
{
    PageType = List;
    Caption = 'Milestone List';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ADV Milestone Table";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Milestone Code"; REC."Milestone Code")
                {
                    ApplicationArea = All;
                }
                field("Milestone Name"; REC."Milestone Name")
                {
                    ApplicationArea = all;
                }
                field("Milestone Type"; REC."Milestone Type")
                {
                    ApplicationArea = all;
                }
                field("Milestone Criteria"; REC."Milestone Criteria")
                {
                    ApplicationArea = all;
                }
                field("SDR Due Calculation"; REC."SDR Due Calculation")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    /* actions
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