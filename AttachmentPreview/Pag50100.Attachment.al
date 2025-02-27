page 50500 Attachment
{
    ApplicationArea = All;
    Caption = 'Attachment';
    PageType = List;
    SourceTable = Attachments;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ToolTip = 'Specifies the value of the EntryNo field.', Comment = '%';
                }
                field(FileName; Rec.FileName)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the FileName field.', Comment = '%';
                }
                field(Extension; Rec.Extension)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Extension field.', Comment = '%';
                }
                field("Attachment Storage Location"; Rec."Attachment Storage Location")
                {

                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Upload Attachment")
            {
                ApplicationArea = All;
                Caption = 'Upload Attachment';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Upload;
                ToolTip = 'Upload Attachment';
                trigger OnAction()
                begin
                    UploadAttachment();
                end;
            }
            action(Preview)
            {
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Download action.';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    page.Run(page::"Preview Attachment", Rec);
                end;
            }
            action(Download)
            {
                ApplicationArea = All;
                Caption = 'Download';
                Image = Download;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Download Attachment';
                trigger OnAction()
                begin
                    DownloadAttachment();
                end;
            }
        }
    }
    procedure UploadAttachment()
    var
        InStream: InStream;
        OutStream: OutStream;
        FileName: Text;
        Extension: Text;
        ServerFilePath: Text;
        TargetDirectory: Text;
        File: file;
        ServerFolderPath: text;
        FileMgt: Codeunit "File Management";

    begin
        // Prompt the user to select a file and upload into TempBlob
        if UploadIntoStream('Select a file to upload', '', '', FileName, InStream) then begin
            // Validate File Extension
            Extension := FileMgt.GetExtension(FileName);
            if Extension = '' then
                Error('Invalid file. Please upload a file with a valid extension.');

            // Define the server directory (ensure it is configured in your setup)

            TargetDirectory := rec."Attachment Storage Location";
            ServerFolderPath := TargetDirectory;
            if TargetDirectory = '' then
                Error('Attachment Storage Location is not configured.');

            if not TargetDirectory.EndsWith('\') then
                TargetDirectory := TargetDirectory + '\';

            // Construct server file path with unique name
            ServerFilePath := TargetDirectory + Format(rec.EntryNo) + '.' + Extension;

            File.CREATE(ServerFilePath);       // Create the file on the server
            File.CREATEOUTSTREAM(OutStream);  // Prepare to write to the file

            CopyStream(OutStream, InStream);  // Write the data
            File.CLOSE;                       // Close the file

            Rec.Extension := Extension;
            Rec.FileName := ServerFilePath;
            rec.MODIFY;

            Message('File uploaded successfully to server location: %1', ServerFilePath);
        end else
            Error('File upload canceled.');
    end;

    procedure DownloadAttachment()
    var
        File: File;
        InStream: InStream;
        FilePath: Text;
        FileName: Text;
        FileMgt: Codeunit "File Management";
    begin
        // Construct the file path on the server
        FilePath := Rec."FileName"; // Ensure this stores the server file path
        if FilePath = '' then
            Error('File path not specified for this document.');

        // Open the file and read it into an InStream
        File.OPEN(FilePath);
        File.CREATEINSTREAM(InStream);

        FileName := FileMgt.GetFileName(FilePath);

        // Prompt the user to save the file on their client computer
        DownloadFromStream(InStream, '', '', '', FileName);

        // Close the file
        File.CLOSE;

        Message('File downloaded successfully: %1', FileName);
    end;

}
