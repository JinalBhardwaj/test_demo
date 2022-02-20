/// <summary>
/// Table ADV Customer Management (ID 50003).
/// </summary>
table 50003 "ADV Customer Management"
{
    DataClassification = CustomerContent;
    Caption = 'Customer Management';

    fields
    {
        field(1; "Serial no."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Contract ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ADV Contract Header";
        }
        field(3; "Application No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "CV Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Incident Code"; Code[50])
        {
            TableRelation = "ADV Billing Incident"."Incident Code";
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Incident: Record "ADV Billing Incident";
            begin
                Incident.Reset();
                Incident.SetRange("Incident Code", "Incident Code");
                if Incident.FindFirst() then begin
                    "Incident Name" := Incident."Incident Name";
                    "Comm. Milest. Considered" := Incident."Comm. Milest. Considered";
                end else
                    if "Incident Code" = '' then begin
                        Clear("Incident Name");
                        Clear("Comm. Milest. Considered");
                    end;
            end;
        }
        field(6; "Incident Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Incident Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Incident Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Cumulative Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Incident Status"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "GST Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Prior Commission Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Commission Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Commission Calc. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Commission Computed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Milestone Applied"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ADV Milestone Table";
        }
        field(17; "Customer ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "To be Invoiced"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Invoice Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Comm. Milest. Considered"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Commission Milestone Considered';
        }
        field(22; "Comm. Amt. Considered"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Commission Amount Considered';
        }
        field(23; "Invoice No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Invoice));
        }
    }

    keys
    {
        key(PK; "Serial no.")
        {
            Clustered = true;
        }
    }

    var


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}