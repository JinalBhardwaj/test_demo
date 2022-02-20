/// <summary>
/// Page ADV Contract Detail Subform (ID 50002).
/// </summary>
page 50003 "ADV Contract Detail Subform"
{
    PageType = ListPart;
    Caption = 'Contract Detail Subform';
    SourceTable = "ADv Contract Line";
    AutoSplitKey = true;
    MultipleNewLines = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Line)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Milestone Code"; Rec."Milestone Code")
                {
                    ApplicationArea = all;
                }
                field("Milestone Name"; Rec."Milestone Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Milestone Type"; Rec."Milestone Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Commission %"; Rec."Commission %")
                {
                    ApplicationArea = all;
                }
                field("Absolute/Cumulative"; Rec."Absolute/Cumulative")
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

     var*/

}