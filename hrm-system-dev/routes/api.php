<?php

use App\Http\Controllers\Api\AnnouncementController;
use App\Http\Controllers\Api\AttendanceController;
use App\Http\Controllers\Api\AttendanceTypeController;
use App\Http\Controllers\Api\ContractController;
use App\Http\Controllers\Api\DepartmentController;
use App\Http\Controllers\Api\PositionController;
use App\Http\Controllers\Api\RelativeController;
use App\Http\Controllers\Api\RoleController;
use App\Http\Controllers\Api\UploadController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\EmergencyContactController;
use App\Http\Controllers\Api\EmployeeDetailController;
use App\Http\Controllers\Api\LeaveController;
use App\Http\Controllers\Api\LeaveTypeController;
use App\Http\Controllers\Api\MissionTypeController;
use App\Http\Controllers\Api\MissionController;
use App\Http\Controllers\Api\OvertimeController;
use App\Http\Controllers\QrCodeLoginController;
use App\Http\Controllers\UserActivityController;
use App\Http\Controllers\UserAuthController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/


Route::post('register', [UserAuthController::class, 'register']);
Route::post('login', [UserAuthController::class, 'login']);
Route::post('logout', [UserAuthController::class, 'logout'])
  ->middleware('auth:api');


Route::middleware(['auth:api', 'role:Admin'])->group(function () {
  Route::apiResource('role_user', RoleController::class);
  Route::apiResource('users', UserController::class);

  Route::apiResource('announcement', AnnouncementController::class);
  Route::post('announcement/{id}', [AnnouncementController::class, 'update']);

  Route::apiResource('department', DepartmentController::class);
  Route::apiResource('position', PositionController::class);

  Route::apiResource('relative', RelativeController::class);
  Route::apiResource('emergencycontact', EmergencyContactController::class);
  Route::get('emergencycontact_detail/{id}', [EmergencyContactController::class, 'showEmergency']);

  Route::apiResource('employee_detail', EmployeeDetailController::class);
  Route::get('total_employeedetail', [EmployeeDetailController::class, 'count_Employee']);
  Route::post('employee_detail/{id}', [EmployeeDetailController::class, 'update']);

  Route::apiResource('attendance_type', AttendanceTypeController::class);
  Route::apiResource('attendances', AttendanceController::class);
  Route::get('/employee/attendance', [AttendanceController::class, 'show']);
  Route::get('/employee/attendances', [AttendanceController::class, 'index']);
  Route::get('/employee_list/attendances', [AttendanceController::class, 'showAll']);
  Route::get('employee_list_attendancecount', [AttendanceController::class, 'countAttendance']);
  Route::get('employee_attendance_count', [AttendanceController::class, 'countAttendanceByMonth']);
  Route::put('/attendances/{id}/time-in', [AttendanceController::class, 'updateTimeIn']);
  Route::put('/attendances/{id}/time-out', [AttendanceController::class, 'updateTimeOut']);

  Route::apiResource('leave_type', LeaveTypeController::class);
  Route::apiResource('leave', LeaveController::class);
  Route::get('leave_totalrequest', [LeaveController::class, 'countLeaveByCurrentCreateDate']);
  Route::put('leave/approve/{id}', [LeaveController::class, 'approve']);
  Route::get('leave_detail/{id}',[LeaveController::class, 'showDetail']);

  Route::apiResource('mission_type', MissionTypeController::class);
  Route::apiResource('mission', MissionController::class);
  Route::get('mission_detail/{id}', [MissionController::class, 'showDetail']);
  Route::put('mission/approve/{id}', [MissionController::class, 'approve']);

  Route::apiResource('contract', ContractController::class);
  Route::post('contract/{id}', [ContractController::class, 'update']);
  
  Route::apiResource('overtime', OvertimeController::class);
  Route::put('overtime/approveOT/{id}', [OvertimeController::class, 'approveOvertime']);
  Route::get('overtime_detail/{id}', [OvertimeController::class, 'overtimeShow']);
  Route::get('count_overtime',[OvertimeController::class, 'countOTEmployees']);
  Route::get('overtime_totalrequest', [OvertimeController::class, 'countOvertimeByCurrentCreateDate']);
});

Route::middleware(['auth:api'])->group(function () {
  Route::get('show/{id}', [UserController::class, 'show']);
  Route::get('announcement', [AnnouncementController::class, 'index']);
  
  Route::apiResource('role_user', RoleController::class);
  Route::apiResource('users', UserController::class);
  Route::apiResource('department', DepartmentController::class);
  Route::apiResource('position', PositionController::class);

  Route::apiResource('relative', RelativeController::class);
  Route::apiResource('emergencycontact', EmergencyContactController::class);
  Route::get('emergencycontact_detail/{id}', [EmergencyContactController::class, 'showEmergency']);
  
  Route::apiResource('employee_detail', EmployeeDetailController::class);
  Route::get('total_employeedetail', [EmployeeDetailController::class, 'count_Employee']);
  Route::post('employee_detail/{id}', [EmployeeDetailController::class, 'update']);

  Route::apiResource('attendance_type', AttendanceTypeController::class);
  Route::apiResource('attendances', AttendanceController::class);
  Route::get('/employee/attendance', [AttendanceController::class, 'show']);
  Route::get('/employee/attendances', [AttendanceController::class, 'index']);
  Route::get('/employee_list/attendances', [AttendanceController::class, 'showAll']);
  Route::get('employee_list_attendancecount', [AttendanceController::class, 'countAttendance']);
  Route::get('employee_attendance_count', [AttendanceController::class, 'countAttendanceByMonth']);
  Route::put('/attendances/{id}/time-in', [AttendanceController::class, 'updateTimeIn']);
  Route::put('/attendances/{id}/time-out', [AttendanceController::class, 'updateTimeOut']);

  Route::apiResource('leave_type', LeaveTypeController::class);
  Route::apiResource('leave', LeaveController::class);
  Route::get('leave_totalrequest', [LeaveController::class, 'countLeaveByCurrentCreateDate']);
  Route::put('leave/approve/{id}', [LeaveController::class, 'approve']);
  Route::get('leave_detail/{id}',[LeaveController::class, 'showDetail']);

  Route::apiResource('mission_type', MissionTypeController::class);
  Route::apiResource('mission', MissionController::class);
  Route::get('mission_detail/{id}', [MissionController::class, 'showDetail']);
  Route::put('mission/approve/{id}', [MissionController::class, 'approve']);

  Route::apiResource('contract', ContractController::class);
  Route::post('contract/{id}', [ContractController::class, 'update']);

  Route::apiResource('overtime', OvertimeController::class);
  Route::put('overtime/approveOT/{id}', [OvertimeController::class, 'approveOvertime']);
  Route::get('overtime_detail/{id}', [OvertimeController::class, 'overtimeShow']);
  Route::get('count_overtime',[OvertimeController::class, 'countOvertimeByEmployeeAndDate']);
  Route::get('overtime_totalrequest', [OvertimeController::class, 'countOvertimeByCurrentCreateDate']);
});

Route::post('/track-user', [UserActivityController::class, 'store']);
Route::get('/track-user', [UserActivityController::class, 'index']);


// mobile app
Route::post('/login-token', [QrCodeLoginController::class, 'login']);
Route::get('/index', [QrCodeLoginController::class, 'index']);
Route::get('/show/{id}', [QrCodeLoginController::class, 'show']);

Route::post('/upload', [UploadController::class, 'upload']);
