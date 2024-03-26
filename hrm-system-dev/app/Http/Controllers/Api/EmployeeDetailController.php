<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\EmployeeDetail;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class EmployeeDetailController extends Controller
{
    public function index(Request $request)
    {
        $positionId = $request->input('position_id');
        $departmentId = $request->input('department_id');

        $query = EmployeeDetail::select(
            'employee_details.*',
            'users.attachment as user_attachment'
        )
            ->with(['user', 'position', 'department'])
            ->leftJoin('users', 'employee_details.user_id', '=', 'users.id')
            ->orderBy('users.idEmp');

        if ($positionId) {
            $query->where('position_id', $positionId);
        }

        if ($departmentId) {
            $query->where('dept_id', $departmentId);
        }

        $perPage = $request->query('per_page', 10);

        $employeeDetails = $query->paginate($perPage);

        return response()->json($employeeDetails, Response::HTTP_OK);
    }

    public function count_Employee()
    {

        $query = EmployeeDetail::select('employee_details.*');

        $totalEmployeeDetails = $query->count();

        return response()->json([
            "message" =>  "successfully",
            "data" => [
                'total_employee' => $totalEmployeeDetails
            ]
        ], Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $request->validate([
            'user_id' => 'required',
            'position_id' => 'required',
            'dept_id' => 'required',
            'firstName' => 'required|string|max:255',
            'lastName' => 'required|string|max:255',
            'firstNameKH' => 'required|string|max:255',
            'lastNameKH' => 'required|string|max:255',
            'birthDate' => 'required',
            'age' => 'sometimes',
            'gender' => 'required|string|max:7',
            'address' => 'required|string',
            'personalEmail' => 'sometimes|string',
            'phoneNum1' => 'required|string|max:11',
            'phoneNume2' => 'sometimes|string|max:11',
            'telegram' => 'required|string|max:11',
            'attachment' => 'file|sometimes',
            'nationality' => 'sometimes|string',
            'materialStatus' => 'sometimes|string',
            'numberOfChild' => 'sometimes',
            'employeeDate' => 'required',
            'status' => 'required',
        ]);

        $employeeDetail = new EmployeeDetail([
            'user_id' => $request->input('user_id'),
            'position_id' => $request->input('position_id'),
            'dept_id' => $request->input('dept_id'),
            'firstName' => $request->input('firstName'),
            'lastName' => $request->input('lastName'),
            'firstNameKH' => $request->input('firstNameKH'),
            'lastNameKH' => $request->input('lastNameKH'),
            'birthDate' => $request->input('birthDate'),
            'age' => $request->input('age'),
            'gender' => $request->input('gender'),
            'address' => $request->input('address'),
            'personalEmail' => $request->input('personalEmail'),
            'phoneNum1' => $request->input('phoneNum1'),
            'phoneNume2' => $request->input('phoneNume2'),
            'telegram' => $request->input('telegram'),
            'attachment' => $request->hasFile('attachment') ? Storage::url($request->file('attachment')->store('employee_detail', 'public')) : null,
            'nationality' => $request->input('nationality'),
            'materialStatus' => $request->input('materialStatus'),
            'numberOfChild' => $request->input('numberOfChild'),
            'employeeDate' => $request->input('employeeDate'),
            'status' => $request->input('status'),
        ]);

        $employeeDetail->save();

        return response()->json([
            "message" => "Employee Detail is Successfully Created",
        ], Response::HTTP_CREATED);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $employeeDetail = EmployeeDetail::with(['user', 'position', 'department'])->where('user_id', $id)
            ->firstOrFail();

        return response()->json(
            [
                'message' => 'Sucessfully',
                'data' => $employeeDetail
            ],
            Response::HTTP_OK
        );
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'user_id' => 'required',
            'position_id' => 'required',
            'dept_id' => 'required',
            'firstName' => 'sometimes|string|max:255',
            'lastName' => 'sometimes|string|max:255',
            'firstNameKH' => 'sometimes|string|max:255',
            'lastNameKH' => 'sometimes|string|max:255',
            'birthDate' => 'sometimes',
            'age' => 'sometimes',
            'gender' => 'sometimes|string|max:7',
            'address' => 'sometimes|string',
            'personalEmail' => 'sometimes|string',
            'phoneNum1' => 'sometimes|string|max:11',
            'phoneNume2' => 'sometimes|string|max:11',
            'telegram' => 'sometimes|string|max:11',
            'attachment' => 'file|sometimes',
            'nationality' => 'sometimes|string',
            'materialStatus' => 'sometimes|string',
            'numberOfChild' => 'sometimes',
            'employeeDate' => 'sometimes',
            'status' => 'sometimes',
        ]);

        $employeeDetail = EmployeeDetail::findOrFail($id);

        $employeeDetail->update($request->all());

        if ($request->file('attachment')) {
            Storage::delete(Str::after($employeeDetail->attachment, 'storage/'));
            $employeeDetail->attachment = Storage::url($request->file('attachment')->store('employee_detail', 'public'));
        }

        $employeeDetail->save();

        return response()->json([
            "message" => "Employee Detail is Successfully Updated",
            "employee" => $employeeDetail
        ], Response::HTTP_OK);
    }

    public function destroy($id)
    {
        $employeeDetail = EmployeeDetail::findOrFail($id);
        Storage::delete(Str::after($employeeDetail->attachment, 'storage/'));
        $employeeDetail->delete();

        return response()->json([
            "message" => "Record Deleted Successfully!"
        ], Response::HTTP_OK);
    }
}
