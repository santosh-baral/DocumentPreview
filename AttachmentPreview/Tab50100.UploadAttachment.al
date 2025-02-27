table 50500 Attachments
{
    Caption = 'Attachments';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            Caption = 'EntryNo';
        }
        field(2; FileName; Text[20])
        {
            Caption = 'FileName';
        }
        field(3; Extension; Text[10])
        {
            Caption = 'Extension';
        }
        field(4; "Attachment Storage Location"; Text[250])
        {
            Caption = 'Attachment Storage Location';
        }

    }
    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
    }
}
