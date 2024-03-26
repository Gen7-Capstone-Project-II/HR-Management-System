<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Announcement;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class AnnouncementController extends Controller
{
    public function index(Request $request)
    {
        $query = Announcement::with('user');

        if ($request->has('is_publish')) {
            $query->where('is_publish', $request->input('is_publish'));
        }

        $announcements = $query->paginate(15);

        return response()->json($announcements, 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'empId' => 'required',
            'title' => 'required',
            'description' => 'required',
            'attachment' => 'file|sometimes',
            'create_date' => 'sometimes|date',
            'is_publish' => 'boolean',
            'publish_date' => 'sometimes|date',
        ]);

        $announcement = new Announcement([
            'empId' => $request->input('empId'),
            'title' => $request->input('title'),
            'description' => $request->input('description'),
            'attachment' => $request->hasFile('attachment') ? Storage::url($request->file('attachment')->store('announcement', 'public')) : null,
            'create_date' => Carbon::now()->format('Y-m-d H:i:s'),
            'is_publish' => $request->input('is_publish', false),
            'publish_date' => $request->input('publish_date'),
        ]);

        // Exclude the `publish_date` field if it is not provided in the request
        if (!$request->has('publish_date')) {
            $announcement->publish_date = null;
        }

        $announcement->save();

        return response()->json([
            "message" => "Successfully created announcement!",
        ], Response::HTTP_CREATED);
    }

    public function show($id)
    {
        $announcement = Announcement::with('user')->findOrFail($id);

        return response()->json($announcement, Response::HTTP_OK);
    }

    public function update(Request $request, $id)
    {
        $announcement = Announcement::findOrFail($id);

        $request->validate([
            'empId' => 'required',
            'title' => 'required',
            'description' => 'required',
            'attachment' => 'file|sometimes',
            'create_date' => 'sometimes|date',
            'is_publish' => 'boolean',
            'publish_date' => 'date|nullable',
        ]);

        $updatedFields = $request->only([
            'empId',
            'title',
            'description',
            'attachment',
            'is_publish',
            'publish_date'
        ]);

        // Exclude the `create_date` field from the updated fields
        unset($updatedFields['create_date']);

        if (!$request->has('publish_date')) {
            // Exclude the `publish_date` field from the updated fields if it is not provided in the request
            unset($updatedFields['publish_date']);
        } else {
            // If the `publish_date` field is provided in the request, set it as a Carbon instance
            $updatedFields['publish_date'] = Carbon::parse($request->input('publish_date'));
        }

        $announcement->update($updatedFields);

        if ($request->file('attachment')) {
            Storage::delete(Str::after($announcement->attachment, 'storage/'));
            $announcement->attachment = Storage::url($request->file('attachment')->store('announcement', 'public'));
        }

        $announcement->save();

        return response()->json([
            "message" => "Announcement Updated Successfully!"
        ], Response::HTTP_OK);
    }
    public function destroy($id)
    {
        $announcement = Announcement::findOrFail($id);
        Storage::delete(Str::after($announcement->attachment, 'storage/'));
        $announcement->delete();

        return response()->json([
            "message" => "Record Deleted Successfully!"
        ], Response::HTTP_OK);
    }
}
