<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\LoginToken;
use Illuminate\Http\Response;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Facades\JWTAuth;

class QrCodeLoginController extends Controller
{
    public function index()
    {
       return response()->json([
           'status' => 'success',
           'message' => 'Welcome to the QrCodeLoginController',
           'data' => LoginToken::all()
       ], Response::HTTP_OK);
    }

    public function show($id)
    {
        $user = User::find($id);
        if (!$user) {
            return response()->json($user, Response::HTTP_FOUND);
        }

        $token = Str::random(32);

        // Save the token to the login_tokens table with a 3-minute expiration time
        $expirationTime = now()->addMinutes(3);

        $existingToken = LoginToken::where('user_id', $user->id)->first();
        if ($existingToken && $existingToken->expires < $expirationTime) {
            // Update the existing record
            $existingToken->update([
                'token' => $token,
                'expires_at' => $expirationTime,
            ]);
        } else {
            // Create a new record if one doesn't exist
            $loginToken = LoginToken::create([
                'token' => $token,
                'user_id' => $user->id,
                'expires_at' => $expirationTime,
            ]);
        }
        $data = [
            'token' => $token,
            'user_id' => $user->id,
        ];
        return response()->json($data, Response::HTTP_OK);
    }

    public function login(Request $request)
    {
        $request->validate([
            'token' => 'required|string',
            'user_id' => 'required|string',
        ]);

        $loginToken = LoginToken::where('token', $request->token)
            ->where('user_id', $request->user_id)
            ->where('expires_at', '>=', now())
            ->first();

        if (!$loginToken) {
            return response()->json([
                'token' => LoginToken::where('token', $request->token)->where('expires_at', '>=', now())->first(),
                'status' => 'error',
                'message' => 'Invalid token or token expired. Please try again.',
            ], Response::HTTP_UNAUTHORIZED);
        }

        $user = User::find($loginToken->user_id);

        // Attempt to generate a token using JWTAuth
        $token = JWTAuth::fromUser($user);
        // If you want to delete the token after successful validation, uncomment the following line
        $loginToken->delete();

        return response()->json([
            'status' => 'success',
                'user' => $user,
                'token' => $token,
                'type' => 'bearer',
        ], Response::HTTP_OK);
    }
}
