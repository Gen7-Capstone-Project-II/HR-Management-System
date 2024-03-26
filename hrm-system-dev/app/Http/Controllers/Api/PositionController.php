<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Position;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class PositionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $positions = Position::paginate(15);

        return response()->json($positions, Response::HTTP_OK);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'positionName'=>'required|string',
            'positionDescription'=>'string'
        ]);

        $position = Position::create($request->all());

        return response()->json([
            'status'=>'success',
            'message'=>'Position is created Successfully.',
            'department'=>$position,
        ],Response::HTTP_CREATED);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $position = Position::findOrFail($id);

        if(!$position){
            return response()->json([
                'message'=>'Cannot Found!'
            ], Response::HTTP_NOT_FOUND);
        }
        return response()->json([
            'status'=>'success',
            'data'=>$position
        ], Response::HTTP_OK);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'positionName'=>'required|string',
            'positionDescription'=>'sometimes|string'
        ]);

        $position = Position::findOrFail($id);
        $position->update($request->all());

        return response()->json([
            'status' => 'success',
            'message' => 'Position is updated Successfully.',
            'department' => $position,
        ], Response::HTTP_OK);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $position = Position::findOrFail($id);
        $position->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Position is deleted Successfully.',
        ], Response::HTTP_OK);
    }
}
