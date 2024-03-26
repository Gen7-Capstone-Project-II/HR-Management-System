<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Leave;
use App\Models\Mission;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;


class MissionController extends Controller
{
    public function index(Request $request)
    {
        $isApproved = $request->query('isApproved');
        $createdDate = $request->query('createdDate');
        $typeId = $request->query('typeId');
        $query = Mission::with('user', 'missionType','approvedBy');

        if ($isApproved === 'null') {
            $query->whereNull('isApproved');
        } elseif (in_array($isApproved, ['0', '1'])) {
            $query->where('isApproved', $isApproved);
        }

        if($createdDate){
            $query->whereDate('createdDate', $createdDate);
        }

        if($typeId){
            $query->where('typeId', $typeId);
        }
        
        $missions = $query->paginate(15);

        return response()->json($missions, Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $request->validate([
            'empId'=>'required|string',
            'typeId'=>'required|string',
            'title'=>'required|string',
            'budget'=>'nullable|double',
            'note'=>'nullable|string',
            'attachment'=>'nullable|file',
        ]);
        $startDate = $request->input('startDate');
        $endDate = $request->input('endDate');

        if (Carbon::parse($startDate)->gt(Carbon::parse($endDate))) {
            return response()->json([
                "message" => "Start date must be earlier than the end date.",
            ], Response::HTTP_BAD_REQUEST);
        }

        $existingLeave = Leave::where('empId', $request->input('empId'))
            ->where(function ($query) use ($startDate, $endDate) {
                $query->where(function ($query) use ($startDate, $endDate) {
                    $query->where('startDate', '>=', $startDate)
                        ->where('startDate', '<=', $endDate);
                })->orWhere(function ($query) use ($startDate, $endDate) {
                    $query->where('endDate', '>=', $startDate)
                        ->where('endDate', '<=', $endDate);
                });
            })
            ->first();

        if ($existingLeave) {
            return response()->json([
                "message" => "Leave request already exists during the mission dates.",
            ], Response::HTTP_CONFLICT);
        }

        $existingMission = Mission::where('empId', $request->input('empId'))
        ->where('startDate', '<=', $endDate)
        ->where('endDate', '>=', $startDate)
        ->first();

        if ($existingMission) {
            return response()->json([
                "message" => "Mission request with overlapping dates already exists.",
            ], Response::HTTP_CONFLICT);
        }

        $mission = new Mission([
            'empId'=>$request->input('empId'),
            'typeId'=>$request->input('typeId'),
            'title'=>$request->input('title'),
            'startDate'=>$startDate,
            'endDate'=>$endDate,
            'budget'=>$request->input('budget'),
            'note'=>$request->input('note'),
            'attachment' => $request->hasFile('attachment') ? Storage::url($request->file('attachment')->store('mission', 'public')) : null,
            'createdDate' => date('Y-m-d H:i:s'),
            'isApproved' => null,
            'approvedById' => null,
        ]);

        $mission->save();

        return response()->json([
            "message"=>"Mission created successfully",
            "data"=>$mission
        ], Response::HTTP_CREATED);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id, Request $request)
    {
        $isApproved = $request->query('isApproved');
        $user = User::findOrFail($id);
        $query = $user->missions()->with(['user', 'missionType','approvedBy']);

        if ($isApproved === 'null') {
            $query->whereNull('isApproved');
        } elseif (in_array($isApproved, ['0', '1'])) {
            $query->where('isApproved', $isApproved);
        }

        $mission = $query->paginate(15);

        return response()->json($mission, Response::HTTP_OK);
    }

    public function showDetail(string $id){
        $mission = Mission::with(['user', 'missionType','approvedBy'])->findOrFail($id);

        return response()->json([
            "message"=>"Successfully",
            "data"=>$mission
        ], Response::HTTP_OK);
    }

    public function update(Request $request, string $id)
    {
        //
    }

    public function approve(Request $request, string $id){
        $request->validate([
            'isApproved' => 'required|boolean',
            'approvedById' => 'required',
            'mission_comment' => 'sometimes'
        ]);

        try{
            $mission = Mission::findOrFail($id);
            if($mission->isApproved !== null){
                return response()->json([
                    "message" => "Mission Request has already been approved or rejected.",
                ], Response::HTTP_BAD_REQUEST);
            }

            $mission->isApproved = $request->input('isApproved');
            $mission->approvedById = $request->input('approvedById');
            $mission->mission_comment = $request->input('mission_comment');
            $mission->save();

            return response()->json([
                "message" => "Mission request has been ". ($request->input('isApproved') ? "approved." : "rejected.") ,
                "data" => $mission
            ], Response::HTTP_OK);
        }catch(ModelNotFoundException $exception){
            return response()->json([
                "error"=>"Record not found"],Response::HTTP_NOT_FOUND);
        }
    }

    public function destroy(string $id)
    {
        try{
            $mission = Mission::findOrFail($id);
            Storage::delete(Str::after($mission->attachment, 'storage/'));
            $mission->delete();

            return response()->json([
                "message" => "Mission Deleted Successfully.!",
            ], Response::HTTP_OK);
        }catch(ModelNotFoundException $exception){
            return response()->json([
                "error"=>"Record not found"
            ],Response::HTTP_NOT_FOUND);
        }
    }
}
