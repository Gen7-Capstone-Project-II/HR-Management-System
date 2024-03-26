<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AttendanceType;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class AttendanceTypeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $attendanceTypes = AttendanceType::paginate(15);

        return  response()->json($attendanceTypes, Response::HTTP_OK);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'type'=>'required|string',
            'color_type'=>'sometimes|string',
            'description'=>'nullable|string'
        ]);

        $attendanceType = AttendanceType::create($validatedData);

        return  response()->json([
            'message'=>"Attendance type created successfully.", 
            "data"=>$attendanceType
        ],Response::HTTP_CREATED);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $attendanceType = AttendanceType::findOrFail($id);

        return   response()->json($attendanceType, Response::HTTP_OK);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $validatedData = $request->validate([
            'type'=>'required|string',
            'color_type'=>'sometimes|string',
            'description'=>'nullable|string'
        ]);

        $attendanceType = AttendanceType::findOrFail($id);

        // Update the type
        $attendanceType->update($validatedData);

        // Return the updated type
        return response()->json($attendanceType,  Response::HTTP_OK);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
         // Find the attendance type by ID
        $attendanceType = AttendanceType::findOrFail($id);

        // Delete the type
        $attendanceType->delete();

        // Return a success message
        return response()->json(['message' => 'Attendance type deleted successfully'],  Response::HTTP_OK);
    }
}
