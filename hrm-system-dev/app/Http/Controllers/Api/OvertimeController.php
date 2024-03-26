<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Overtime;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Carbon\Carbon;
use Illuminate\Support\Facades\Validator;

class OvertimeController extends Controller
{

    public function index(Request $request)
    {
        $isApproved = $request->query('isApproved');
        $createDate = $request->query('createDate');

        $query = Overtime::with('employee', 'approvedBy');

        if ($isApproved === 'null') {
            $query->whereNull('isApproved');
        } elseif (in_array($isApproved, ['0', '1'])) {
            $query->where('isApproved', $isApproved);
        }

        if ($createDate) {
            $query->whereDate('createDate', $createDate);
        }

        $overtimes = $query->paginate(15);

        return response()->json($overtimes, Response::HTTP_OK);
    }

    public function countOvertimeByCurrentCreateDate()
    {
        $currentDate = Carbon::now();

        $overtimeRequests = Overtime::whereNull('isApproved')->get();

        $total_request = $overtimeRequests->count();

        return response()->json([
            "message" => "Successfully",
            "data" => [
                "total_overtime_request" => $total_request
            ]
        ], Response::HTTP_OK);
    }

    public function countOvertimeByEmployeeAndDate(Request $request)
    {
        $date = $request->query('date');

        if ($date) {
            $overtimes = Overtime::whereDate('createDate', $date)
                ->get()
                ->groupBy('employee_id');
        } else {
            $overtimes = Overtime::all()
                ->groupBy('employee_id');
        }

        $counts = [];

        foreach ($overtimes as $employeeId => $group) {
            $totalTime = $group->sum('total_time');
            $totalApprove = $group->sum('total_approve');
            $totalrequest = count($group);
            $counts[] = [
                'total_times' => $totalTime,
                'total_approved' => $totalApprove,
                'total_request' => $totalrequest,
            ];
        }

        return response()->json([
            "message" => "Successfully",
            "data" => $counts
        ], Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $request->validate([
            'empId' => 'required',
            'title' => 'required|string',
            'reason' => 'required|string',
            'dateOT' => 'required|date_format:Y-m-d',
            'time_from' => 'required|date_format:H:i',
            'time_to' => 'required|date_format:H:i',
            'total_time' => 'sometimes',
            'isApproved' => 'sometimes',
            'total_approve' => 'sometimes',
            'createDate' => 'sometimes',
        ]);

        $validator = Validator::make($request->all(), [
            'dateOT' => [
                function ($attribute, $value, $fail) use ($request) {
                    $existingRecord = Overtime::where('dateOT', $value)
                        ->where('empId', $request->input('empId'))
                        ->first();

                    if ($existingRecord) {
                        $fail("An overtime record already exists for the specified date.");
                    }
                }
            ],
            'time_to' => [
                function ($attribute, $value, $fail) use ($request) {
                    $timeFrom = $request->input('time_from');

                    if ($value <= $timeFrom) {
                        $fail("The 'time_to' must be greater than 'time_from'.");
                    }
                }
            ],
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        $overtime = new Overtime();
        $overtime->empId = $request->input('empId');
        $overtime->title = $request->input('title');
        $overtime->reason = $request->input('reason');
        $overtime->dateOT = $request->input('dateOT');
        $overtime->time_from = $request->input('time_from');
        $overtime->time_to = $request->input('time_to');
        $overtime->total_time = $request->input('total_time');
        $overtime->isApproved = $request->input('isApproved');
        $overtime->total_approve = $request->input('total_approve');
        $overtime->createDate = Carbon::now();

        // Save the new overtime record
        $overtime->save();

        return response()->json([
            'message' => 'Overtime request was successfully submitted.',
            'data' => $overtime
        ], Response::HTTP_CREATED);
    }


    public function show(string $id, Request $request)
    {
        $isApproved = $request->query('isApproved');

        $user = User::findOrFail($id);
        $query = $user->overtimes()->with(['employee', 'approvedBy']);

        if ($isApproved === 'null') {
            $query->whereNull('isApproved');
        } elseif (in_array($isApproved, ['0', '1'])) {
            $query->where('isApproved', $isApproved);
        }

        $overtimes = $query->paginate(15);

        return response()->json($overtimes, Response::HTTP_OK);
    }

    public function overtimeShow(string $otId)
    {
        $overtime = Overtime::with(['employee', 'approvedBy'])->where('id', $otId)
            ->firstOrFail();

        return response()->json(
            [
                'message' => 'Sucessfully',
                'data' => $overtime
            ],
            Response::HTTP_OK
        );
    }

    public function update(Request $request, string $id)
    {
        $request->validate([
            'empId' => 'required',
            'title' => 'sometimes|string',
            'reason' => 'sometimes|string',
            'dateOT' => 'sometimes|date_format:Y-m-d',
            'time_from' => 'sometimes|date_format:H:i',
            'time_to' => 'sometimes|date_format:H:i',
            'total_time' => 'sometimes',
            'isApproved' => 'sometimes',
            'total_approve' => 'sometimes',
            'createDate' => 'sometimes',
        ]);

        $validator = Validator::make($request->all(), [
            'dateOT' => [
                function ($attribute, $value, $fail) use ($request, $id) {
                    $existingRecord = Overtime::where('dateOT', $value)
                        ->where('empId', $request->input('empId'))
                        ->where('id', '!=', $id)
                        ->first();

                    if ($existingRecord) {
                        $fail("An overtime record already exists for the specified date.");
                    }
                }
            ],
            'time_to' => [
                function ($attribute, $value, $fail) use ($request) {
                    $timeFrom = $request->input('time_from');

                    if ($value <= $timeFrom) {
                        $fail("The 'time_to' must be greater than 'time_from'.");
                    }
                }
            ],
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        $overtime = Overtime::findOrFail($id);
        $overtime->empId = $request->input('empId');
        $overtime->title = $request->input('title');
        $overtime->reason = $request->input('reason');
        $overtime->dateOT = $request->input('dateOT');
        $overtime->time_from = $request->input('time_from');
        $overtime->time_to = $request->input('time_to');
        $overtime->total_time = $request->input('total_time');
        $overtime->isApproved = $request->input('isApproved');
        $overtime->total_approve = $request->input('total_approve');
        $overtime->createDate = Carbon::now();

        // Save the updated overtime record
        $overtime->save();

        return response()->json([
            'message' => 'Overtime record was successfully updated.',
            'data' => $overtime
        ], Response::HTTP_OK);
    }

    public function approveOvertime(Request $request, string $id)
    {
        $request->validate([
            'approvedById' => 'required',
            'isApproved' => 'required|boolean',
            'total_approve' => 'sometimes|numeric',
            'overtime_comment' => 'sometimes|string',
        ]);

        $overtime = Overtime::findOrFail($id);
        if ($overtime->isApproved === null) {
            $overtime->approvedById = $request->input('approvedById');
            $overtime->isApproved = $request->input('isApproved');
            $overtime->total_approve = $request->input('total_approve');
            $overtime->overtime_comment = $request->input('overtime_comment');

            // Save the updated overtime record
            $overtime->save();

            return response()->json([
                'message' => 'Overtime record was successfully approved.',
                'data' => $overtime
            ], Response::HTTP_OK);
        } else {
            return response()->json([
                'message' => 'Overtime record has already been approved.',
                'data' => $overtime
            ], Response::HTTP_CONFLICT);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $overtime = Overtime::findOrFail($id);

        // Delete the overtime record
        $overtime->delete();

        return response()->json([
            'message' => 'Overtime record was successfully deleted.'
        ], Response::HTTP_OK);
    }
}
