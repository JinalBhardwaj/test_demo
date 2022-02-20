/// <summary>
/// Table ADV Milestone Table (ID 50001).
/// contain details of the milestone
/// </summary>
table 50001 "ADV Milestone Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Milestone Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Milestone Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Milestone Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Time Based","Amount Based","Percentage Based";
        }
        field(4; "Milestone Criteria"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "SDR Due Calculation"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Milestone Code")
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