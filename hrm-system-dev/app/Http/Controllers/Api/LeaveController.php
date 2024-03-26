<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Leave;
use App\Models\Mission;
use App\Models\User;
use Carbon\Carbon;
use GPBMetadata\Google\Type\Datetime;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Support\Str;

class LeaveController extends Controller
{
    public function index(Request $request)
    {
        $isApproved = $request->query('isApproved');
        $createdDate = $request->query('createdDate');
        $leaveTypeId = $request->query('leaveTypeId');

        $query = Leave::with('employee', 'leaveType', 'approvedBy');

        if ($isApproved === 'null') {
            $query->whereNull('isApproved');
        } elseif (in_array($isApproved, ['0', '1'])) {
            $query->where('isApproved', $isApproved);
        }

        if ($createdDate !== null) {
            $query->whereDate('createdDate', $createdDate);
        }

        if ($leaveTypeId !== null) {
            $query->where('leaveTypeId', $leaveTypeId);
        }

        $leaves = $query->paginate(15);

        return response()->json($leaves, Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $request->validate([
            'empId' => 'required',
            'leaveTypeId' => 'required',
            'reason' => 'required|string',
            'attachment' => 'sometimes|file',
        ]);
        $startDate = $request->input('startDate');
        $endDate = $request->input('endDate');

        if (Carbon::parse($startDate)->gt(Carbon::parse($endDate))) {
            return response()->json([
                "message" => "Start date must be earlier than the end date.",
            ], Response::HTTP_BAD_REQUEST);
        }

        $existingMission = Mission::where('empId', $request->input('empId'))
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

        if ($existingMission) {
            return response()->json([
                "message" => "A mission already exists within the specified date range.",
            ], Response::HTTP_CONFLICT);
        }

        $existingLeave = Leave::where('empId', $request->input('empId'))
            ->where('startDate', '<=', $endDate)
            ->where('endDate', '>=', $startDate)
            ->first();

        if ($existingLeave) {
            return response()->json([
                "message" => "Leave request with overlapping dates already exists.",
            ], Response::HTTP_CONFLICT);
        }


        $leave = new Leave([
            'empId' => $request->input('empId'),
            'leaveTypeId' => $request->input('leaveTypeId'),
            'startDate' => $startDate,
            'endDate' => $endDate,
            'reason' => $request->input('reason'),
            'attachment' => $request->hasFile('attachment') ? Storage::url($request->file('attachment')->store('employee_leave', 'public')) : null,
            'createdDate' => date('Y-m-d H:i:s'),
            'isApproved' => null,
            'approvedById' => null,
        ]);

        $leave->save();

        return response()->json([
            "message" => "Leave Request created successfully!",
            "data" => $leave
        ], Response::HTTP_CREATED);
    }
    public function countLeaveByCurrentCreateDate()
    {
        $currentDate = Carbon::now();

        $leaveRequests = Leave::whereNull('isApproved')->get();

        $total_request = $leaveRequests->count();

        return response()->json([
            "message" => "Successfully",
            "data" => [
                "total_leave_request" => $total_request
            ]
        ], Response::HTTP_OK);
    }

    public function show(string $id, Request $request)
    {
        $isApproved = $request->query('isApproved');
        $user = User::findOrFail($id);
        $query = $user->leaves()->with(['employee', 'leaveType', 'approvedBy']);

        if ($isApproved === 'null') {
            $query->whereNull('isApproved');
        } elseif (in_array($isApproved, ['0', '1'])) {
            $query->where('isApproved', $isApproved);
        }

        $leave = $query->paginate(15);

        return response()->json($leave, Response::HTTP_OK);
    }

    public function showDetail(string $id)
    {
        $leave = Leave::with(['employee', 'leaveType', 'approvedBy'])->findOrFail($id);

        return response()->json([
            "message" => "Successfully",
            "data" => $leave
        ], Response::HTTP_OK);
    }

    public function approve(Request $request, string $id)
    {
        $request->validate([
            'isApproved' => 'required|boolean',
            'approvedById' => 'required',
            'leave_comment' => 'required|string'
        ]);

        try {
            $leave = Leave::findOrFail($id);
            if ($leave->isApproved !== null) {
                return response()->json([
                    "message" => "Leave Request has already been approved or rejected.",
                ], Response::HTTP_BAD_REQUEST);
            }

            $leave->isApproved = $request->input('isApproved');
            $leave->approvedById = $request->input('approvedById');
            $leave->leave_comment = $request->input('leave_comment');
            $leave->save();

            return response()->json([
                "message" => "Leave Request approved successfully!",
                "data" => $leave
            ], Response::HTTP_OK);
        } catch (ModelNotFoundException $exception) {
            return response()->json([
                "message" => "Leave Request not found.",
            ], Response::HTTP_NOT_FOUND);
        }
    }

    public function destroy(string $id)
    {
        try {
            $leave = Leave::findOrFail($id);
            Storage::delete(Str::after($leave->attachment, 'storage/'));
            $leave->delete();

            return response()->json([
                "message" => "Leave Deleted successfully!",
            ], Response::HTTP_OK);
        } catch (ModelNotFoundException $exception) {
            return response()->json([
                "message" => "Leave Request not found.",
            ], Response::HTTP_NOT_FOUND);
        }
    }
}
