<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Department;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class DepartmentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $departments = Department::paginate(15);
        return response()->json($departments, Response::HTTP_OK);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'deptName'=>'required|string',
            'deptDescription'=>'string'
        ]);

        $department = Department::create($request->all());

        return response()->json([
            'status'=>'success',
            'message'=>'Department is created Successfully.',
            'department'=>$department,
        ],Response::HTTP_CREATED);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $department = Department::findOrFail($id);

        if(!$department){
            return response()->json([
                'message'=>'Cannot Found!'
            ], Response::HTTP_NOT_FOUND);
        }
        return response()->json([
            'status'=>'success',
            'data'=>$department
        ], Response::HTTP_OK);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'deptName' => 'required|string',
            'deptDescription' => 'sometimes|string'
        ]);
        $department = Department::findOrFail($id);
        $department->update($request->all());

        return response()->json([
            'status' => 'success',
            'message' => 'Department is updated Successfully.',
            'department' => $department,
        ], Response::HTTP_OK);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $department = Department::findOrFail($id);
        $department->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Department is deleted Successfully.',
        ], Response::HTTP_OK);
    }
}
