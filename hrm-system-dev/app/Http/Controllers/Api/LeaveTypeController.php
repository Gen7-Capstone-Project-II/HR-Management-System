<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\LeaveType;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class LeaveTypeController extends Controller
{
    public function index()
    {
        $leavetypes = LeaveType::paginate(15);

        return response()->json($leavetypes, Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $request->validate([
            'leaveType'=>'required|string',
            'defaultDays'=>'required|numeric',
            'description'=>'sometimes|string'
        ]);

        $leavetype = LeaveType::create($request->all());

        return response()->json([
            'status'=>'success',
            'message'=>'Leave Type is created Successfully.',
            'department'=>$leavetype,
        ],Response::HTTP_CREATED);
    }

    public function show(string $id)
    {
        
    }

    public function update(Request $request, string $id)
    {
        $request->validate([
            'leaveType'=>'sometimes|string',
            'defaultDays'=>'sometimes|numeric',
            'description'=>'sometimes|string'
        ]);
        $leavetype = LeaveType::findOrFail($id);
        $leavetype->update($request->all());

        return response()->json([
            'status' => 'success',
            'message' => 'Leave Type is updated Successfully.',
            'department' => $leavetype,
        ], Response::HTTP_OK);
    }

    public function destroy(string $id)
    {
        $leavetype = LeaveType::findOrFail($id);
        $leavetype->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Leave Type is deleted Successfully.',
        ], Response::HTTP_OK);
    }
}
