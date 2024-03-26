<?php

namespace App\Http\Controllers;

use App\Models\UserActivity;
use Illuminate\Http\Request;

class UserActivityController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $userActivities = UserActivity::all();

        return response()->json($userActivities);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $ip = $request->ip();
        $wifiIp = $request->header('X-Forwarded-For') ?? $request->header('X-Real-IP') ?? $request->ip();

        // Store the user activity in the database
        UserActivity::create([
            'ip_address' => $ip,
            'wifi_ip_address' => $wifiIp,
            'activity' => 'User tracked',
        ]);

        return response()->json(['message' => 'User tracked successfully']);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
