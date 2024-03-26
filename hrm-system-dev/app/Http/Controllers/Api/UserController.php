<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\EmployeeDetail;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function index(Request $request)
    {
        $perPage = $request->query('per_page', 10); // Default to 10 items per page
        $users = User::with(['roles', 'employeeDetails' => function ($query) {
            $query->with('position', 'department');
        }])->orderBy('idEmp')->paginate($perPage);

        return response()->json($users, Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|max:255',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6|confirmed',
            'roles' => 'required|array',
        ]);

        $currentYear = date('Y');
        $lastUser = User::where('idEmp', 'like', 'HR' . $currentYear . '%')
            ->orderBy('idEmp', 'desc')
            ->first();

        if ($lastUser) {
            $lastEmpId = $lastUser->idEmp;
            $lastId = (int) substr($lastEmpId, -3);
            $newId = $lastId + 1;
        } else {
            $newId = 1;
        }

        $empId = 'HR' . $currentYear . str_pad($newId, 3, '0', STR_PAD_LEFT);

        $validatedData['idEmp'] = $empId;


        $user = User::create($validatedData);

        $user->roles()->attach($validatedData['roles']);

        return response()->json($user, Response::HTTP_CREATED);
    }

    public function show($id)
    {
        $user = User::with('roles')->find($id);
        if (!$user) {
            return response()->json($user, Response::HTTP_FOUND);
        }
        return response()->json($user, Response::HTTP_OK);
    }

    public function update(Request $request, User $user)
    {
        $validatedData = $request->validate([
            'name' => 'required|max:255',
            'email' => 'required|email|unique:users,email,' . $user->id,
            'password' => 'required|min:8',
            'roles' => 'required|array',
        ]);

        $user->update($validatedData);

        $user->roles()->sync($validatedData['roles']);

        return response()->json($user, Response::HTTP_OK);
    }

    public function destroy($id)
    {
        $user = User::findOrFail($id);

        // Delete the user
        $user->delete();

        return response()->json(['message' => 'User deleted successfully'], Response::HTTP_OK);
    }
}
