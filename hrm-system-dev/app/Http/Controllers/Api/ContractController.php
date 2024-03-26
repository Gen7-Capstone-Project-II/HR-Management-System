<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Contract;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class ContractController extends Controller
{
    public function index()
    {
        $contracts = Contract::with(['employee_contract', 'department_contract', 'position_contract'])->paginate(15);

        return response()->json($contracts, Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $request->validate([
            'empId' => 'required',
            'departmentId' => 'required',
            'positionId' => 'required',
            'working_schedule' => 'required|string',
            'base_salary' => 'required',
            'attachment_file' => 'sometimes|file',
        ]);
        $startDate = $request->input('contract_startdate');
        $endDate = $request->input('contract_enddate');

        if (Carbon::parse($startDate)->gt(Carbon::parse($endDate))) {
            return response()->json([
                "message" => "Start date must be earlier than the end date.",
            ], Response::HTTP_BAD_REQUEST);
        }

        $contract = new Contract([
            'empId' => $request->input('empId'),
            'departmentId' => $request->input('departmentId'),
            'positionId' => $request->input('positionId'),
            'contract_startdate' => $startDate,
            'contract_enddate' => $endDate,
            'working_schedule' => $request->input('working_schedule'),
            'base_salary' => $request->input('base_salary'),
            'attachment_file' => $request->hasFile('attachment_file') ? Storage::url($request->file('attachment_file')->store('contract', 'public')) : null,
        ]);

        $contract->save();

        return Response()->json([
            "message" => "Contract has been created",
            "data" => $contract,
        ], Response::HTTP_CREATED);
    }

    public function show(string $id)
    {
        $user = User::findOrFail($id);
        $contract = $user->contracts()->with(['employee_contract', 'department_contract', 'position_contract'])->paginate();

        return response()->json($contract, Response::HTTP_OK);
    }

    public function  update(Request $request, string $id)
    {
        $request->validate([
            'empId' => 'required',
            'departmentId' => 'required',
            'positionId' => 'required',
            'working_schedule' => 'required|string',
            'base_salary' => 'required',
            'attachment_file' => 'sometimes|file',
        ]);

        $contract = Contract::find($id);

        if (!$contract) {
            return response()->json([
                "message" => "Contract not found",
            ], Response::HTTP_NOT_FOUND);
        }

        $startDate = $request->input('contract_startdate');
        $endDate = $request->input('contract_enddate');

        if (Carbon::parse($startDate)->gt(Carbon::parse($endDate))) {
            return response()->json([
                "message" => "Start date must be earlier than the end date.",
            ], Response::HTTP_BAD_REQUEST);
        }

        $contract->empId = $request->input('empId');
        $contract->departmentId = $request->input('departmentId');
        $contract->positionId = $request->input('positionId');
        $contract->contract_startdate = $startDate;
        $contract->contract_enddate = $endDate;
        $contract->working_schedule = $request->input('working_schedule');
        $contract->base_salary = $request->input('base_salary');

        if ($request->hasFile('attachment_file')) {
            $contract->attachment_file = Storage::url($request->file('attachment_file')->store('contract', 'public'));
        }

        $contract->save();

        return response()->json([
            "message" => "Contract has been updated",
            "data" => $contract,
        ], Response::HTTP_OK);
    }

    public function destroy($id)
{
    $contract = Contract::find($id);

    if (!$contract) {
        return response()->json([
            "message" => "Contract not found",
        ], Response::HTTP_NOT_FOUND);
    }
    Storage::delete(Str::after($contract->attachment_file, 'storage/'));
    $contract->delete();

    return response()->json([
        "message" => "Contract has been deleted",
    ], Response::HTTP_OK);
}
}
