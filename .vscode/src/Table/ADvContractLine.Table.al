/// <summary>
/// Table ADv Contract Line (ID 50004).
/// </summary>
table 50004 "ADv Contract Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Milestone Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ADV Milestone Table"."Milestone Name";
            Editable = false;
        }
        field(4; "Milestone Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Time Based","Amount Based","Percentage Based";
        }
        field(5; "Commission %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Absolute/Cumulative"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Absolute","Cumulative";
        }
        field(7; "Milestone Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ADV Milestone Table";
            trigger OnValidate()
            var
                Milestone: Record "ADV Milestone Table";
            begin
                Milestone.Reset();
                Milestone.SetRange("Milestone Code", "Milestone Code");
                if Milestone.FindFirst() then begin
                    "Milestone Type" := Milestone."Milestone Type";
                    "Milestone Name" := Milestone."Milestone Name";
                    "Milestone %" := Milestone."Milestone Criteria";
                end else
                    if "Milestone Code" = '' then begin
                        Clear("Milestone Type");
                        Clear("Milestone Name");
                        Clear("Milestone %");
                    end;
            end;
        }
        field(8; "Milestone %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Document No.", "Line No.")
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