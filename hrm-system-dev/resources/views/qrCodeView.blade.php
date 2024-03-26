<!DOCTYPE html>
<html>
<head>
    <title>QR Code Example</title>
</head>
<body>
    <div>
        <h1>Hello</h1>
        <h2>{{ $token }}</h2>
        <h2>{{ $expirationTime }}</h2>
        <h2>{{ $user }}</h2>
    </div>

    {{-- <img src="data:image/png;base64,{{ base64_encode($qrCodeImage) }}" alt="QR Code"> --}}
    <img src="{{ $qrCodeDataUri }}" alt="QR Code">


    
</body>
</html>