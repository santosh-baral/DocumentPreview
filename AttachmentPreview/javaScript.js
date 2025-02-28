
// Detect file type by checking the MIME type from the Base64 data
function GetAttachment(base64data) {
    var previewElement = document.querySelector(".previewArea");  
    if (!previewElement) {
        console.error('Preview area element not found.');
        return;
    }
    // First, determine the MIME type of the file
    var mimeType = getMimeType(base64data);

    // Depending on the file type, display the preview
    if (mimeType.startsWith('image/')) {
        var img = document.createElement('img');
        img.src = 'data:' + mimeType + ';base64,' + base64data;
        img.style.width = '100%';
        previewElement.appendChild(img);
    } else if (mimeType === 'application/pdf') {
        var iframe = document.createElement('iframe');
        iframe.src = 'data:' + mimeType + ';base64,' + base64data;
        iframe.style.width = '100%';
        iframe.style.height = '600px';  
        previewElement.appendChild(iframe);
    } else {
        previewElement.innerHTML = 'Unsupported file type';
    }
}

//Function to detect MIME type based on Base64 signature
function getMimeType(base64) {
    if (base64.startsWith('iVBOR')) return 'image/png';  
    if (base64.startsWith('/9j/')) return 'image/jpeg'; 
    if (base64.startsWith('JVBER')) return 'application/pdf';  
    return 'application/octet-stream'; 
}

