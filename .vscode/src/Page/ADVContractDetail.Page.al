/// <summary>
/// Page ADV Contract Detail (ID 50002).
/// </summary>
page 50002 "ADV Contract Detail"
{
    PageType = Card;
    Caption = 'Contract Detail';
    SourceTable = "ADV Contract Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Contract No."; REC."Contract No.")
                {
                    ApplicationArea = All;

                }
                field("Customer No."; REC."Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; REC."Customer Name")
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field("Document Date"; REC."Document Date")
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
            part(Line; "ADV Contract Detail Subform")
            {
                ApplicationArea = all;
                Caption = 'Lines';
                SubPageLink = "Document No." = field("Contract No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Calculate Commission")
            {
                ApplicationArea = All;
                ToolTip = 'For Calculating the Commission.';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Calculate;

                trigger OnAction()
                begin
                    CalculateCommission();
                    Message('Commission Calculated');
                end;
            }
        }
    }
    /*
          var
              myInt: Integer;*/
    /// <summary>
    /// CalculateCommission is process to calculate the commission of the contract.
    /// </summary>
    procedure CalculateCommission()
    var
        //myInt: Integer;'
        Milestone: Record "ADV Milestone Table";
        Incident: Record "ADV Billing Incident";
        ContLine: Record "ADv Contract Line";
        CustMgmt: Record "ADV Customer Management";
        CustMgmt2: Record "ADV Customer Management";
        AmountCheck: Decimal;
        CommissionAmt: Decimal;
    begin
        CustMgmt.Reset();
        CustMgmt.SetRange("Contract ID", Rec."Contract No.");
        if CustMgmt.FindSet() then
            repeat
                //Calculation for Cummulative amount on amount based.
                ContLine.Reset();
                ContLine.SetRange("Document No.", Rec."Contract No.");
                ContLine.SetRange("Absolute/Cumulative", ContLine."Absolute/Cumulative"::Cumulative);
                if ContLine.FindSet() then
                    repeat
                        AmountCheck := (CustMgmt."CV Amount" * ContLine."Milestone %") / 100;
                        if AmountCheck <= CustMgmt."Cumulative Amount" then begin
                            CommissionAmt := 0;
                            CustMgmt2.Reset();
                            CustMgmt2.SetRange("Serial no.", CustMgmt."Serial no.");
                            CustMgmt2.SetRange("Comm. Milest. Considered", true);
                            if CustMgmt2.FindFirst() then begin
                                CustMgmt2."Commission Computed" := true;
                                CustMgmt2."Commission Calc. Date" := WorkDate();
                                CommissionAmt := (CustMgmt."CV Amount" * ContLine."Commission %") / 100;
                                CustMgmt2."Commission Amount" := CommissionAmt;
                                CustMgmt2."Milestone Applied" := ContLine."Milestone Code";
                                CustMgmt2.Modify();
                            end;
                        end;
                    until ContLine.Next() = 0;

                //Calculation for Absolute amount on amount based.
                ContLine.Reset();
                ContLine.SetRange("Document No.", Rec."Contract No.");
                ContLine.SetRange("Absolute/Cumulative", ContLine."Absolute/Cumulative"::Absolute);
                if ContLine.FindSet() then
                    repeat
                        AmountCheck := (CustMgmt."CV Amount" * ContLine."Milestone %") / 100;
                        if AmountCheck <= CustMgmt."Cumulative Amount" then begin
                            CommissionAmt := 0;
                            CustMgmt2.Reset();
                            CustMgmt2.SetRange("Serial no.", CustMgmt."Serial no.");
                            if CustMgmt2.FindFirst() then begin
                                CustMgmt2."Commission Computed" := true;
                                CustMgmt2."Commission Calc. Date" := WorkDate();
                                CommissionAmt := (CustMgmt."CV Amount" * ContLine."Commission %") / 100;
                                CustMgmt2."Commission Amount" := CommissionAmt;
                                CustMgmt2."Milestone Applied" := ContLine."Milestone Code";
                                CustMgmt2.Modify();
                            end;
                        end;
                    until ContLine.Next() = 0;


            until CustMgmt.Next() = 0;
    end;
}