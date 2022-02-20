/* <summary>
/// Table ADV Billing Incident (ID 50000).
/// Define all the Incident Type in this table
/// </summary>*/
table 50000 "ADV Billing Incident"
{
    DataClassification = ToBeClassified;
    Caption = 'Billing Incident';

    fields
    {
        field(1; "Incident Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Incident Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Comm. Milest. Considered"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Commission Milestone Considered';
        }
    }

    keys
    {
        key(PK; "Incident Code")
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