📂 Business Central Attachment Preview

🚀 Overview

Microsoft Dynamics 365 Business Central requires users to download attachments before viewing them, which adds extra steps and potential security risks.

This solution introduces a custom Control Add-in that enables direct file preview within Business Central—without downloading the file.

🔹 Supports PDF, PNG, JPG (easily extendable).

🔹 Uses Base64 encoding to send files from AL to JavaScript.

🔹 Detects file format using MIME type identification.

🔹 Provides a secure, seamless, and faster user experience.

🏗️ How It Works

1️⃣ The AL page retrieves the attachment from the server and converts it into Base64 format.

2️⃣ The Control Add-in sends the Base64 string to JavaScript for interpretation.

3️⃣ JavaScript detects the file type and dynamically renders it in the Business Central UI.


The project consists of:

📂 AL Components

A Preview Attachment Page that fetches attachments from the server.

A Control Add-in to pass the Base64 data to JavaScript.

📂 JavaScript & HTML

JavaScript logic to detect file type and display previews.

An HTML structure for rendering the attachment preview.

🎯 Key Features & Benefits

✅ No Downloads Required – View attachments instantly within Business Central.

✅ Better Security – Files remain on the server, reducing risks.

✅ Faster Workflow – Eliminates unnecessary steps for users.

✅ Extensibility – Can support additional file formats like Word and Excel.

📸 Demo

![New-Attachment-Work-MicrosoftEdge2025-03-0114-25-00-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/460702b3-0cf5-48dd-a99a-47a8aa42caaf)



📌 How to Use

1️⃣ Clone the repository from GitHub.

2️⃣ Deploy the AL extension in Business Central.

3️⃣ Upload JavaScript and HTML to the add-in folder.

4️⃣ Start previewing attachments without downloading!

📬 Connect with me on [LinkedIn](https://www.linkedin.com/in/santoshbaral1)
