/// <summary>
/// Codeunit ADV Sales Event Handler (ID 50000).
/// To handle all the action related to Sales
/// </summary>
codeunit 50001 "ADV Sale Event Handler"
{
    Permissions = tabledata "Sales Invoice Header" = rmi;
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteSalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    var
        CustMgmt: Record "ADV Customer Management";
    begin
        if (Rec.IsTemporary()) or (not RunTrigger) then
            exit;

        if Rec."Document Type" <> Rec."Document Type"::Invoice then
            exit;
        CustMgmt.Reset();
        CustMgmt.SetRange("Invoice No.", Rec."No.");
        CustMgmt.ModifyAll("Invoice No.", '');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLines', '', false, false)]
    local procedure Onaftersalespost(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        CustMgmt: Record "ADV Customer Management";
        salesinvline: Record "Sales Invoice Line";
        salesinvhead: Record "Sales Invoice Header";
        Invamt: Decimal;
    begin

        CustMgmt.Reset();
        CustMgmt.SetRange("Serial no.", SalesHeader."Cust. Mgmt. SerialNo.");
        if CustMgmt.FindFirst() then begin
            salesinvhead.Reset();
            salesinvhead.SetRange("No.", SalesInvoiceHeader."No.");
            if salesinvhead.FindFirst() then begin
                salesinvhead."Contract ID" := SalesHeader."Contract ID";
                salesinvhead."Cust. Mgmt. SerialNo." := SalesHeader."Cust. Mgmt. SerialNo.";
                salesinvhead.Modify();
            end;
            CustMgmt."Invoice Date" := SalesHeader."Posting Date";
            salesinvline.Reset();
            salesinvline.SetRange("Document No.", SalesInvoiceHeader."No.");
            if salesinvline.FindSet() then
                repeat
                    salesinvline.CalcSums("Amount Including VAT");
                    Invamt += salesinvline."Amount Including VAT";
                until salesinvline.Next() = 0;
            CustMgmt."Invoice Amount" := Invamt;
            CustMgmt.Modify();
        end;
    end;

}