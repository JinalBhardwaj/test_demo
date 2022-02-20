/// <summary>
/// Page ADV Customer Management (ID 50005).
/// </summary>
page 50005 "ADV Customer Management"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Customer Management';
    UsageCategory = History;
    SourceTable = "ADV Customer Management";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Serial no."; REC."Serial no.")
                {
                    ApplicationArea = All;
                }
                field("Contract ID"; REC."Contract ID")
                {
                    ApplicationArea = All;
                    /*trigger OnValidate()
                    begin
                        UpdateCumulative();
                    end;*/
                }
                field("Application No."; REC."Application No.")
                {
                    ApplicationArea = all;
                }
                field("Customer ID"; REC."Customer ID")
                {
                    ApplicationArea = All;
                }
                field("CV Amount"; REC."CV Amount")
                {
                    ApplicationArea = all;
                }
                field("Incident Code"; REC."Incident Code")
                {
                    ApplicationArea = all;
                }
                field("Incident Name"; REC."Incident Name")
                {
                    ApplicationArea = all;
                }
                field("Incident Amount"; REC."Incident Amount")
                {
                    ApplicationArea = all;
                }
                field("GST Amount"; REC."GST Amount")
                {
                    ApplicationArea = all;
                }
                field("Incident Date"; REC."Incident Date")
                {
                    ApplicationArea = all;
                }
                field("Incident Status"; REC."Incident Status")
                {
                    ApplicationArea = all;
                }
                field("Cumulative Amount"; REC."Cumulative Amount")
                {
                    ApplicationArea = all;
                }
                field("Comm. Amt. Considered"; REC."Comm. Amt. Considered")
                {
                    ApplicationArea = all;
                    Caption = 'Commisionable Amount Considered';
                }
                field("Prior Commission Amount"; REC."Prior Commission Amount")
                {
                    ApplicationArea = all;
                }
                field("Commission Computed"; REC."Commission Computed")
                {
                    ApplicationArea = all;
                }
                field("Commission Calc. Date"; REC."Commission Calc. Date")
                {
                    ApplicationArea = all;
                }
                field("Commission Amount"; REC."Commission Amount")
                {
                    ApplicationArea = all;
                }
                field("Milestone Applied"; REC."Milestone Applied")
                {
                    ApplicationArea = all;
                }
                field("To be Invoiced"; REC."To be Invoiced")
                {
                    ApplicationArea = all;
                }
                field("Invoice No."; REC."Invoice No.")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    //  Editable = false;
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        if SalesHeader.Get(SalesHeader."Document Type"::Invoice, Rec."Invoice No.") then
                            Page.Run(Page::"Sales Invoice", SalesHeader)
                    end;

                }
                field("Invoice Date"; REC."Invoice Date")
                {
                    ApplicationArea = all;
                    Caption = 'Invoiced Date';
                }
                field("Invoice Amount"; REC."Invoice Amount")
                {
                    ApplicationArea = all;
                    Caption = 'Invoiced Amount';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Sales Invoice")
            {
                ApplicationArea = All;
                Caption = 'Create Sales Invoice';
                ToolTip = 'For Creating the Sales Invoice of the Incident';
                Image = CreateJobSalesInvoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()

                begin


                    CusMgmt2.Reset();
                    CusMgmt2.SetRange("Application No.", Rec."Application No.");
                    cusMgmt2.SetRange("Comm. Milest. Considered", true);
                    CusMgmt2.SetRange("Serial no.", Rec."Serial no.");
                    CusMgmt2.SetFilter("Invoice No.", '<>%1', '');
                    if CusMgmt2.FindFirst() then
                        Error('Invoice has already generated for the Invoice amount ₹%1', Rec."To be Invoiced");

                    CusMgmt2.Reset();
                    CusMgmt2.SetRange("Application No.", Rec."Application No.");
                    cusMgmt2.SetRange("Comm. Milest. Considered", true);
                    CusMgmt2.SetFilter("Serial no.", '<%1', Rec."Serial no.");
                    CusMgmt2.SetFilter("Invoice No.", '<>%1', '');
                    CusMgmt2.SetFilter("Invoice Amount", '=%1', 0);
                    if CusMgmt2.FindFirst() then
                        Error('Before generating new Invoice either process the older Invoice or delete the older Invoice');

                    CusMgmt2.Reset();
                    CusMgmt2.SetRange("Application No.", Rec."Application No.");
                    cusMgmt2.SetRange("Comm. Milest. Considered", true);
                    CusMgmt2.SetFilter("Serial no.", '>=%1', Rec."Serial no.");
                    CusMgmt2.SetFilter("Invoice No.", '=%1', '');
                    if CusMgmt2.FindFirst() then
                        CreateSalesInvoice(Rec."Contract ID", Rec."Serial no.");

                end;
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    begin
        Incidentdataupdate();
        UpdateCumulative();
        ConsiCommAmtTotal();
        CalculatePriorandTobeInv();
    end;

    trigger OnAfterGetRecord()
    begin
        Incidentdataupdate();
        UpdateCumulative();
        ConsiCommAmtTotal();
        CalculatePriorandTobeInv();
    end;

    var
        CusMgmt: Record "ADV Customer Management";
        CusMgmt2: Record "ADV Customer Management";
    /// <summary>
    /// UpdateCumulative 
    /// To update the cumulative amount of the table based on Application no.
    /// </summary>
    procedure UpdateCumulative()
    var
        CustMgmt: Record "ADV Customer Management";
        custMgmt2: Record "ADV Customer Management";
        CUAmt: Decimal;
    begin

        CustMgmt.Reset();
        CustMgmt.SetRange("Application No.", Rec."Application No.");
        If CustMgmt.FindSet() then
            repeat
                CUAmt := 0;
                custMgmt2.Reset();
                custMgmt2.SetRange("Application No.", CustMgmt."Application No.");
                custMgmt2.SetFilter("Serial no.", '<=%1', CustMgmt."Serial no.");
                IF custMgmt2.FindSeT() THEN
                    REPEAT
                        CUAmt += CustMgmt2."Incident Amount" + CustMgmt2."GST Amount";
                    until CustMgmt2.Next() = 0;
                CustMgmt."Cumulative Amount" := CUAmt;
                CustMgmt.Modify();
            UNTIL CustMgmt.Next() = 0;

    end;

    /// <summary>
    /// ConsiCommAmtTotal
    /// To see the total of Considered Commission Amount based on the incident
    /// </summary>
    procedure ConsiCommAmtTotal()
    var
        CustMgmt: Record "ADV Customer Management";
        custMgmt2: Record "ADV Customer Management";
        ConsComAmt: Decimal;
    begin

        CustMgmt.Reset();
        CustMgmt.SetRange("Application No.", Rec."Application No.");
        CustMgmt.SetRange("Comm. Milest. Considered", true);
        If CustMgmt.FindSet() then
            repeat
                ConsComAmt := 0;
                custMgmt2.Reset();
                custMgmt2.SetRange("Application No.", CustMgmt."Application No.");
                custMgmt2.SetFilter("Serial no.", '<=%1', CustMgmt."Serial no.");
                custMgmt2.SetRange("Comm. Milest. Considered", true);
                IF custMgmt2.FindSeT() THEN
                    REPEAT
                        ConsComAmt += CustMgmt2."Incident Amount" + CustMgmt2."GST Amount";
                    until CustMgmt2.Next() = 0;
                CustMgmt."Comm. Amt. Considered" := ConsComAmt;
                CustMgmt.Modify();
            UNTIL CustMgmt.Next() = 0;
    end;

    /// <summary>
    /// Incidentdataupdate.
    /// To update the Incident data in the table.
    /// </summary>
    procedure Incidentdataupdate()
    var
        CustMgmt: Record "ADV Customer Management";
        Incident: Record "ADV Billing Incident";
    begin
        CustMgmt.Reset();
        CustMgmt.SetRange("Application No.", Rec."Application No.");
        If CustMgmt.FindSet() then
            repeat
                Incident.Reset();
                Incident.SetRange("Incident Code", Rec."Incident Code");
                if Incident.FindSet() then
                    repeat
                        Rec."Incident Name" := Incident."Incident Name";
                        Rec."Comm. Milest. Considered" := Incident."Comm. Milest. Considered";
                        Rec.Modify();
                    until Incident.Next() = 0;
            UNTIL CustMgmt.Next() = 0;
    end;

    /// <summary>
    /// CalculatePriorandTobeInv.
    /// To calculate the Prior commission amount in the table and als to be invoiced
    /// </summary>
    procedure CalculatePriorandTobeInv()
    var
        CustMgmt: Record "ADV Customer Management";
        custMgmt2: Record "ADV Customer Management";
        PriorCommAmt: Decimal;
        Commamt: Decimal;
        ToBeInvAmt: Decimal;
    begin
        //Prior Commission calculation
        CustMgmt.Reset();
        CustMgmt.SetRange("Application No.", Rec."Application No.");
        CustMgmt.SetRange("Comm. Milest. Considered", true);
        If CustMgmt.FindSet() then
            repeat
                PriorCommAmt := 0;
                custMgmt2.Reset();
                custMgmt2.SetRange("Application No.", CustMgmt."Application No.");
                custMgmt2.SetFilter("Serial no.", '<%1', CustMgmt."Serial no.");
                CustMgmt2.SetRange("Comm. Milest. Considered", true);
                if custMgmt2.FindLast() then begin
                    PriorCommAmt := custMgmt2."Commission Amount";
                end;
                CustMgmt."Prior Commission Amount" := PriorCommAmt;
                CustMgmt.Modify();
            until CustMgmt.Next() = 0;

        //To be Invoiced Calculation

        CustMgmt.Reset();
        CustMgmt.SetRange("Application No.", Rec."Application No.");
        CustMgmt.SetRange("Comm. Milest. Considered", true);
        If CustMgmt.FindSet() then
            repeat
                ToBeInvAmt := 0;
                custMgmt2.Reset();
                custMgmt2.SetRange("Application No.", CustMgmt."Application No.");
                custMgmt2.SetFilter("Serial no.", '<%1', CustMgmt."Serial no.");
                CustMgmt2.SetRange("Comm. Milest. Considered", true);
                if custMgmt2.FindLast() then begin
                    ToBeInvAmt := custMgmt2."Invoice Amount";
                end;
                custMgmt2.Reset();
                custMgmt2.SetRange("Application No.", CustMgmt."Application No.");
                custMgmt2.SetRange("Serial no.", CustMgmt."Serial no.");
                CustMgmt2.SetRange("Comm. Milest. Considered", true);
                if custMgmt2.FindFirst() then begin
                    Commamt := custMgmt2."Commission Amount";
                end;
                CustMgmt."To be Invoiced" := Commamt - ToBeInvAmt;
                CustMgmt.Modify();
            until CustMgmt.Next() = 0;
    end;

    /// <summary>
    /// CreateSalesInvoice.
    /// To Create the sales invoice header and lines for respective line
    /// </summary>
    /// <param name="ContractID">Code[50]. /// Paramter to get the contrator ID</param>
    /// <param name="CustMgmtSerial">Integer. //. paramter to get the serial no. of customer managment table</param>
    procedure CreateSalesInvoice(ContractID: Code[50]; CustMgmtSerial: Integer)
    var
        SalesHead: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        Contrhead: Record "ADV Contract Header";
        SalesRecSetup: Record "Sales & Receivables Setup";
        CustMgmt: Record "ADV Customer Management";
        NoSeries: Codeunit NoSeriesManagement;
        DocNo: Code[50];
        Price: Decimal;
    begin

        //for Inserting data in Sales header table
        SalesRecSetup.Get();
        DocNo := Noseries.GetNextNo(SalesRecSetup."Invoice Nos.", 0D, true);
        SalesHead.Init();
        SalesHead."No." := DocNo;
        Contrhead.Reset();
        Contrhead.SetRange("Contract No.", ContractID);
        if Contrhead.FindFirst() then begin
            SalesHead.Validate("Sell-to Customer No.", Contrhead."Customer No.");
            SalesHead.Validate("Sell-to Customer Name", Contrhead."Customer Name");
        end;
        SalesHead.Validate("Document Type", SalesHead."Document Type"::Invoice);
        SalesHead."Document Date" := WorkDate();
        SalesHead."Contract ID" := ContractID;
        SalesHead."Cust. Mgmt. SerialNo." := CustMgmtSerial;
        SalesHead.Insert();

        //for Inserting data in Sales Line table
        salesLine.Init();
        salesLine."Document No." := DocNo;
        salesLine."Line No." := 10000;
        salesLine.Validate("Document Type", salesLine."Document Type"::Invoice);
        salesLine.Validate(Type, salesLine.Type::"G/L Account");
        GLSetup.Get();
        GLSetup.TestField("Billing GL Acc.");
        salesLine.Validate("No.", GLSetup."Billing GL Acc.");
        salesLine.Validate(Quantity, 1);
        CustMgmt.Reset();
        CustMgmt.SetRange("Serial no.", CustMgmtSerial);
        if CustMgmt.FindFirst() then
            Price := CustMgmt."To be Invoiced";
        salesLine.Validate("Unit Price", Price);
        salesLine.Insert();
        Message('Invoice has been Created Successfully. Invoice No. %1', DocNo);

        CustMgmt.Reset();
        CustMgmt.SetRange("Serial no.", CustMgmtSerial);
        if CustMgmt.FindFirst() then begin
            CustMgmt."Invoice No." := DocNo;
            CustMgmt.Modify();
        end;

    end;
}