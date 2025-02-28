page 50501 "Preview Attachment"
{
    ApplicationArea = All;
    Caption = 'Preview Attachment';
    PageType = Worksheet;
    SourceTable = Attachments;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            usercontrol(MyChartControl; MyControlAddIn)
            {
                ApplicationArea = All;
            }
        }

    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        CurrPage.MyChartControl.GetAttachment(returnAttachmentBase64());
    end;

    procedure returnAttachmentBase64(): Text
    var
        FilePath: Text;
        FileName: text;
        File: File;
        FileMgt: Codeunit "File Management";
        Base64: Codeunit "Base64 Convert";
        instream: InStream;
        Extension: text;

    begin
        FilePath := rec."FileName"; // Ensure this stores the server file path
        if FilePath = '' then
            Error('File path not specified for this document.');
        // Open the file and read it into an InStream
        File.OPEN(FilePath);
        File.CREATEINSTREAM(InStream);
        exit(Base64.ToBase64(instream, false));
    end;
}
