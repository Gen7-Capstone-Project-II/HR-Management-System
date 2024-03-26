<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Relative;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class RelativeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $relatives = Relative::paginate(15);
        return response()->json($relatives, Response::HTTP_OK);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'relativeName'=>'required|string',
            'description'=>'sometimes|string'
        ]);

        $relative = Relative::create($request->all());

        return response()->json([
            'status'=>'success',
            'message'=>'Relative is created Successfully.',
            'department'=>$relative,
        ], Response::HTTP_CREATED);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $relative = Relative::find($id);
        if(!$relative){
            return response()->json([
                'message'=>'Cannot Found!'
            ], Response::HTTP_NOT_FOUND);
        }
        return response()->json([
            'status'=>'success',
            'data'=>$relative
        ], Response::HTTP_OK);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'relativeName'=>'required|string',
            'description'=>'sometimes|string'
        ]);

        $relative = Relative::findOrFail($id);
        $relative->update($request->all());

        return response()->json([
            'status' => 'success',
            'message' => 'Relative is updated Successfully.',
            'department' => $relative,
        ], Response::HTTP_OK);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $relative = Relative::find($id);
        if(!$relative){
            return response()->json([
                'message'=>'Cannot Found!'
            ], Response::HTTP_NOT_FOUND);
        }else{
            $relative->delete();

            return response()->json([
                'status' => 'success',
                'message' => 'Relative is deleted Successfully.',
            ], Response::HTTP_OK);
        }
        
    }
}
