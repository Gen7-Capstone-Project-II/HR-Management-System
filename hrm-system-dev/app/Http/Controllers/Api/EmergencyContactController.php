<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\EmergencyContact;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class EmergencyContactController extends Controller
{
    public function index()
    {
        $emergencyContacts = EmergencyContact::with(['relative', 'user'])->paginate(15);
        
        return response()->json($emergencyContacts, Response::HTTP_OK);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'user_id' => 'required',
            'relative_id' => 'required',
            'firstname' => 'required|string|max:255',
            'lastname' => 'required|string|max:255',
            'firstnameKM' => 'sometimes|string|max:255',
            'lastnameKM' => 'sometimes|string|max:255',
            'gender' => 'required|string|max:6',
            'phoneNum1' => 'required|string|max:11',
            'phoneNum2' => 'sometimes|string|max:11',
            'telegram' => 'sometimes|string|max:11',
            'email' => 'sometimes|string|email|max:255',
        ]);
        $user = User::findOrFail($request->user_id);
        $emergencyContact = $user->emergencyContacts()->create($request->all());

        return response()->json([
            'status' => 'success',
            'message' => 'Emergency Contact is created Successfully.',
            'department' => $emergencyContact,
        ],Response::HTTP_OK);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $user = User::findOrFail($id);
        $emergencyContacts = $user->emergencyContacts()->with(['relative', 'user'])->paginate(15);

        return response()->json($emergencyContacts, Response::HTTP_OK);
    }

    public function showEmergency(string $id){
        $emergencyContact = EmergencyContact::with(['relative', 'user'])->findOrFail($id);

        return response()->json([
            "message"=>"Successfully",
            "data" => $emergencyContact,
        ], Response::HTTP_OK);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'user_id' => 'required|string',
            'relative_id' => 'required|string',
            'firstname' => 'sometimes',
            'lastname' => 'sometimes',
            'firstnameKM' => 'sometimes',
            'lastnameKM' => 'sometimes',
            'gender' => 'sometimes',
            'phoneNum1' => 'sometimes',
            'phoneNum2' => 'sometimes',
            'telegram' => 'sometimes',
            'email' => 'sometimes',
        ]);
        $emergencyContact = EmergencyContact::findOrFail($id);
        $emergencyContact->update($request->all());
        return response()->json([
            'status' => 'success',
            'message' => 'Emergency Contact is updated Successfully.',
            'data' => $emergencyContact
        ],Response::HTTP_OK);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $emergencyContact = EmergencyContact::findOrFail($id);
        $emergencyContact->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Emergency Contact deleted successfully.',
        ], Response::HTTP_OK);
    }
}
