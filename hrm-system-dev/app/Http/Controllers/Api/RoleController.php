<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Role;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;

class RoleController extends Controller
{
    public function index()
    {
        $roles = Role::all();

        return response()->json($roles, Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|unique:roles,name|max:255',
        ]);

        $role = Role::create([
            'name' => $validatedData['name'],
        ]);

        return response()->json($role, Response::HTTP_CREATED);
    }

    public function update(Request $request, Role $role)
    {
        $validatedData = $request->validate([
            'name' => [
                'required',
                'max:255',
                Rule::unique('roles')->ignore($role->id),
            ],
        ]);

        $role->update([
            'name' => $validatedData['name'],
        ]);

        return response()->json($role, Response::HTTP_OK);
    }
    public function destroy(Role $role)
    {
        $role->delete();

        return response()->json(null, Response::HTTP_NO_CONTENT);
    }
}
