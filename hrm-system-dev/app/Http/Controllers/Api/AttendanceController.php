<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Attendance;
use App\Models\Leave;
use App\Models\Mission;
use App\Models\User;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class AttendanceController extends Controller
{
    public function showAll(Request $request)
    {
        $validatedData = $request->validate([
            'month' => 'required|date_format:Y-m',
        ]);

        $startDate = Carbon::createFromFormat('Y-m-d', $validatedData['month'] . '-01');
        $endDate = Carbon::createFromFormat('Y-m-d', $validatedData['month'] . '-' . $startDate->format('t'));

        $users = User::all();

        $attendanceData = [];

        $leaveData = Leave::whereIn('empId', $users->pluck('id'))
            ->whereBetween('startDate', [$startDate->toDateString(), $endDate->toDateString()])
            ->whereBetween('endDate', [$startDate->toDateString(), $endDate->toDateString()])
            ->get()
            ->groupBy([
                function ($leave) {
                    return $leave->empId;
                },
                function ($leave) {
                    return Carbon::parse($leave->startDate)->format('Y-m-d');
                }
            ]);

        $missionData = Mission::whereIn('empId', $users->pluck('id'))
            ->whereBetween('startDate', [$startDate->toDateString(), $endDate->toDateString()])
            ->whereBetween('endDate', [$startDate->toDateString(), $endDate->toDateString()])
            ->get()
            ->groupBy([
                function ($mission) {
                    return $mission->empId;
                },
                function ($mission) {
                    return Carbon::parse($mission->startDate)->format('Y-m-d');
                }
            ]);

        foreach ($users as $user) {
            $attendances = Attendance::where('empId', $user->id)
                ->whereBetween('attendance_date', [$startDate->toDateString(), $endDate->toDateString()])
                ->get()
                ->groupBy(function ($attendance) {
                    return Carbon::parse($attendance->attendance_date)->format('Y-m-d');
                });

            $daysInMonth = $endDate->format('t');

            $userAttendanceData = [];

            for ($day = 1; $day <= $daysInMonth; $day++) {
                $date = Carbon::createFromFormat('Y-m-d', $validatedData['month'] . '-' . $day);

                $attendanceGroup = $attendances->get($date->format('Y-m-d'));

                $userAttendanceData['attendances'][] = [
                    'date' => $date->format('Y-m-d'),
                    'attendance' => empty($attendanceGroup) ? null : $attendanceGroup->map(function ($attendance) {
                        return [
                            'attendanceData' => $attendance,
                        ];
                    }),
                ];

                $userLeaveData = $leaveData[$user->id][$date->format('Y-m-d')] ?? null;
                $userMissionData = $missionData[$user->id][$date->format('Y-m-d')] ?? null;

                if (empty($userAttendanceData['attendances'][$day - 1]['attendance'])) {
                    if ($userLeaveData && $userLeaveData[0]->isApproved) {
                        $userAttendanceData['attendances'][$day - 1]['attendance'] = 'leave';
                    } elseif ($userMissionData && $userMissionData[0]->isApproved) {
                        $userAttendanceData['attendances'][$day - 1]['attendance'] = 'mission';
                    } else {
                        $userAttendanceData['attendances'][$day - 1]['attendance'] = null;
                    }
                }
            }

            $attendanceData[] = [
                'user' => $user,
                'attendanceData' => $userAttendanceData,
            ];
        }

        return response()->json([
            'message' => 'Successfully',
            'data' => $attendanceData,
        ], Response::HTTP_OK);
    }
    public function index(Request $request)
    {
        $validatedData = $request->validate([
            'empId' => 'required|exists:users,id',
            'month' => 'required|date_format:Y-m',
        ]);

        $startDate = Carbon::createFromFormat('Y-m-d', $validatedData['month'] . '-01');
        $endDate = Carbon::createFromFormat('Y-m-d', $validatedData['month'] . '-' . $startDate->format('t'));

        $attendances = Attendance::with('user')
            ->where('empId', $validatedData['empId'])
            ->whereBetween('attendance_date', [$startDate->toDateString(), $endDate->toDateString()])
            ->get()
            ->groupBy(function ($attendance) {
                return Carbon::parse($attendance->attendance_date)->format('Y-m-d');
            });

        $daysInMonth = $endDate->format('t');

        $attendanceData = [];

        $user = User::find($validatedData['empId']);

        for ($day = 1; $day <= $daysInMonth; $day++) {
            $date = Carbon::createFromFormat('Y-m-d', $validatedData['month'] . '-' . $day);

            // Check if the current date is valid before adding it to the $attendanceData array
            $attendanceGroup = $attendances->get($date->format('Y-m-d'));

            $attendanceDataEntry = [
                'date' => $date->format('Y-m-d'),
                'attendance' => $attendanceGroup ?? null,
            ];

            $leave = Leave::where('empId', $validatedData['empId'])
                ->where('startDate', '<=', $date->toDateString())
                ->where('endDate', '>=', $date->toDateString())
                ->first();

            $mission = Mission::where('empId', $validatedData['empId'])
                ->where('startDate', '<=', $date->toDateString())
                ->where('endDate', '>=', $date->toDateString())
                ->first();

            if ($leave && $leave->isApproved) {
                $attendanceDataEntry['attendance'] = 'leave';
            } elseif ($mission && $mission->isApproved) {
                $attendanceDataEntry['attendance'] = 'mission';
            }

            // Push the entry to the attandanceData array
            if ($attendanceGroup && $attendanceGroup->isNotEmpty()) {
                // If attendance is present, wrap it in the 'attendanceData' key
                $attendanceDataEntry['attendance'] = ['attendanceData' => $attendanceGroup->toArray()];
            }

            $attendanceData[] = $attendanceDataEntry;
        }

        return response()->json([
            "message" => 'Successfully',
            "data" => ['attendances' => $attendanceData],
        ], Response::HTTP_OK);
    }
    public function show(Request $request)
    {
        $validatedData = $request->validate([
            'empId' => 'required|exists:users,id',
            'month' => 'required|date_format:Y-m',
        ]);

        $currentDate = Carbon::now();
        $formattedMonth = $currentDate->format('Y-m');
        $startDate = Carbon::createFromFormat('Y-m-d', $formattedMonth . '-01');
        $endDate = Carbon::createFromFormat('Y-m-d', $formattedMonth . '-' . $startDate->format('t'));

        $attendances = Attendance::with('user')
            ->where('empId', $validatedData['empId'])
            ->whereBetween('attendance_date', [$startDate->toDateString(), $endDate->toDateString()])
            ->get()
            ->groupBy(function ($attendance) {
                return Carbon::parse($attendance->attendance_date)->format('Y-m-d');
            });

        $currentDay = $currentDate->format('Y-m-d');

        $attendanceData = [
            'date' => $currentDate->format('Y-m-d'),
            'attendance' => $attendances->get($currentDay) ? $attendances->get($currentDay)->map(function ($attendance) {
                return [
                    'attendanceData' => $attendance,
                ];
            }) : null,
        ];

        return response()->json([
            "message" => 'Successfully',
            "data" => $attendanceData,
        ], Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'empId' => 'required|exists:users,id',
            'location' => 'nullable|string',
        ]);

        $startDate = $request->input('start_date', date('Y-m-t'));
        $endDate = $request->input('end_date', date('Y-m-t'));

        $startDate = new \DateTime($startDate);
        $endDate = new \DateTime($endDate);

        $months = [];

        for ($date = $startDate; $date <= $endDate; $date->modify('+1 month')) {
            $months[] = $date->format('Y-m-01');
        }

        $currentDay = date('Y-m-d');

        $existingAttendance = Attendance::where('empId', $validatedData['empId'])
            ->where('attendance_date', $currentDay)
            ->exists();

        if (!$existingAttendance) {
            foreach ($months as $month) {
                $validatedData = new Attendance([
                    'empId' => $validatedData['empId'],
                    // 'attendance_id' => $validatedData['attendance_id'],
                    'attendance_date' => $currentDay,
                    'time_in' => null,
                    'time_out' => null,
                    'location' => $validatedData['location'] ?? null,
                ]);

                $validatedData->save();
            }
        }

        return response()->json([
            'message' => $existingAttendance ? 'Attendance record for the current day already exists' : 'Attendance records created successfully',
            'attendance' => $validatedData,
        ], 201);
    }

    public function updateTimeIn(Request $request, $id)
    {
        $validatedData = $request->validate([
            'time_in' => 'nullable|date_format:H:i',
            'location_timein' => 'required|string'
        ]);

        $attendance = Attendance::findOrFail($id);
        if (!empty($attendance->time_in)) {
            return response()->json([
                'message' => 'Time in is already set and cannot be updated',
                'attendance' => $attendance,
            ], Response::HTTP_OK);
        }
        $attendance->time_in = DB::raw("TIME('$validatedData[time_in]')");
        $attendance->location_timein = $validatedData["location_timein"];
        $attendance->save();

        return response()->json([
            'message' => 'Time in updated successfully',
            'attendance' => $attendance,
        ], 200);
    }

    public function updateTimeOut(Request $request, $id)
    {
        $validatedData = $request->validate([
            'time_out' => 'nullable|date_format:H:i',
            'location_timeout' => 'required|string'
        ]);

        $attendance = Attendance::findOrFail($id);
        if (!empty($attendance->time_out)) {
            return response()->json([
                'message' => 'Time out is already set and cannot be updated',
                'attendance' => $attendance,
            ], Response::HTTP_OK);
        }
        $attendance->time_out = DB::raw("TIME('$validatedData[time_out]')");
        $attendance->location_timeout = $validatedData["location_timeout"];
        $attendance->save();

        return response()->json([
            'message' => 'Time in updated successfully',
            'attendance' => $attendance,
        ], 200);
    }


    public function countAttendance(Request $request)
    {
        $currentDate = Carbon::now();
        $currentDay = $currentDate->format('Y-m-d');

        $users = User::all();

        $absentCount = 0;
        $presentCount = 0;
        $leaveCount = 0;

        $totalUsers = $users->count();

        foreach ($users as $user) {
            $attendance = Attendance::where('empId', $user->id)
                ->where('attendance_date', $currentDay)
                ->first();

            if (is_null($attendance)) {
                $absentCount++;
            } else {
                $leave = Leave::where('empId', $user->id)
                    ->where('startDate', '<=', $currentDay)
                    ->where('endDate', '>=', $currentDay)
                    ->first();

                if ($leave && $leave->isApproved) {
                    $leaveCount++;
                } else {
                    $presentCount++;
                }
            }
        }

        return response()->json([
            'message' => 'Attendance count successfully',
            'data' => [
                'totalUsers' => $totalUsers,
                'absentCount' => $absentCount,
                'presentCount' => $presentCount,
                'leaveCount' => $leaveCount,
            ],
        ], Response::HTTP_OK);
    }

    public function countAttendanceByMonth(Request $request)
    {
        $validatedData = $request->validate([
            'month' => 'required|date_format:Y-m',
        ]);

        $users = User::all();

        $month = $validatedData['month'];
        $startDate = Carbon::createFromFormat('Y-m-d', $month . '-01');
        $endDate = Carbon::createFromFormat('Y-m-d', $month . '-' . $startDate->format('t'));

        $absentData = [];

        foreach ($users as $user) {

            $totalDates = $startDate->diffInDays($endDate->endOfMonth())+1;
            $userAttendances = $user->attendances()
                ->whereBetween('attendance_date', [$startDate, $endDate])
                ->pluck('id');

            $presentCount = $userAttendances->count();
            $absentCount = $totalDates-$presentCount;

            $absentData[] = [
                'userId' => $user->id,
                'userName' => $user->name,
                'absentCount' => $absentCount,
                'presentCount' => $presentCount,
            ];
        }

        return response()->json([
            'message' => 'Attendance count for all users in ' . $month . ' successfully',
            'data' => $absentData,
        ], Response::HTTP_OK);
    }
}
