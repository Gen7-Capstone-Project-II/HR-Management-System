<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\MissionType;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class MissionTypeController extends Controller
{
    public function index()
    {
        $missionTypes = MissionType::paginate(15);

        return  response()->json($missionTypes, Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $request->validate([
            'mission_type'=>'required|string',
            'description'=>'sometimes|string'
        ]);

        $missionType = MissionType::create($request->all());

        return  response()->json([
            'message'=>"Mission Type Created Successfully.", 
            "data"=>$missionType
        ], Response::HTTP_CREATED);
    }

    public function show(string $id)
    {
        //
    }

    public function update(Request $request, string $id)
    {
        $request->validate([
            'mission_type'=>'sometimes|string',
            'description'=>'sometimes|string'
        ]);

        try{
            $missionType = MissionType::findOrFail($id);
            $missionType->update($request->all());

            return   response()->json([
                "message"=>"Mission Type Updated Successfully",
                "data"=>$missionType
            ],Response::HTTP_OK);
        }catch(ModelNotFoundException $exception){
            return response()->json([
                "message"=>"Mission Type Not Found.!"
            ],Response::HTTP_NOT_FOUND);
        }  
    }

    public function destroy(string $id)
    {
        try{
            $missionType = MissionType::findOrFail($id);
            $missionType->delete();

            return response()->json([
                "message"=>"Mission Type Deleted Successfully."
            ],Response::HTTP_OK);
        }catch(ModelNotFoundException $exception){
            return response()->json([
                "message"=>"Mission Type Not Found.!"
            ],Response::HTTP_NOT_FOUND);
        }
    }
}
