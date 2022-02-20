/// <summary>
/// Table ADV Contract Header (ID 50002).
/// </summary>
table 50002 "ADV Contract Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Contract No." <> xRec."Contract No." then begin
                    GenLedSet.Get();
                    NoseriesMgt.TestManual(GenLedSet."Contract No's");

                end;
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
            NotBlank = true;

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                if Cust.Get("Customer No.") then
                    "Customer Name" := Cust.Name
                else
                    if "Customer No." = '' then
                        Clear("Customer Name");

            end;
        }
        field(3; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            Editable = false;
        }
        field(4; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Contract No.")
        {
            Clustered = true;
        }
    }

    var

        GenLedSet: Record "General Ledger Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Code[20];

    trigger OnInsert()
    begin
        if "Contract No." = '' then begin
            GenLedSet.Get();
            GenLedSet.TestField("Contract No's");
            NoseriesMgt.InitSeries(GenLedSet."Contract No's", NoSeries, 0D, "Contract No.", NoSeries);

        end;
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