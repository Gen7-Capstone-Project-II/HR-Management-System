<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\UploadStoreRequest;
use App\Models\Upload;
use Validator;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class UploadController extends Controller
{
    public function attachmentStore(UploadStoreRequest $request){
        $validatedData = $request->validated();
        $validatedData['attachment'] = $request->file('attachment')->store('images');
        $data = Upload::create($validatedData);
        $publicLink = Storage::url('app/'.$validatedData['attachment']);


        return response()->json([
            'data' => $data, 'public_link' => $publicLink], Response::HTTP_CREATED);
    }

    public function store(Request $request){
        $request->validate([
            'file' => 'required|file', // Validate file presence and type
        ]);

        $file = $request->file('file');
        $filename = Str::uuid()->toString() . '.' . $file->getClientOriginalExtension();

        $path = $file->storeAs('public/files', $filename); // Store file physically

        $file = Upload::create([
            'filename' => $filename,
            'path' => $path, // Store path for local storage
            'disk' => 'public', // Optional for cloud storage
        ]);

        return response()->json([
            'url' => Storage::url($file->path), // Generate public URL
            'file_id' => $file->id,
        ]);
    }

    public function index(){
        $files = Upload::all();

        return response()->json($files, Response::HTTP_OK);
    }
}
