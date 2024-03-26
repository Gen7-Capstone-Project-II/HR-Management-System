<p align="center"><a href="" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="HRM System"></a></p>

## About HRM System

‘Human Resource Management System’ is a software system which is used to manage and track employee attendance. Employees can view their attendance, request for leave or overtime, check new announcements, and especially scan QR code to track theirs when they are in or out of the organization.

## Problematic

Old ways of keeping track of attendance, like using paper sheets or manual time clocks, are not very efficient. They can easily make mistakes, and it's hard to get the information easily. This might cause problems with following rules and make administrative tasks more difficult.

## Use Case

<p align="center"><img src="https://github.com/phallyn-chean/hrm-system/blob/api_dev/assets/images/web_usecase.jpg" width=600></p>

## Folder Structure

-   app/
    -   Http/
        -   Controllers/
            -   Api/
                -   AnnouncementController.php
                -   AttendanceController.php
                -   AttendanceTypeController.php
                -   ContractController.php
                -   DepartmentController.php
                -   PositionController.php
                -   RelativeController.php
                -   RoleController.php
                -   UserController.php
                -   EmergencyContactController.php
                -   EmployeeDetailController.php
                -   LeaveController.php
                -   LeaveTypeController.php
                -   MissionController.php
                -   MissionTypeController.php
                -   OvertimeController.php
                -   QrCodeLoginController.php
                -   UserActivityController.php
                -   UserAuthController.php
                -   UploadController.php
    -   Models/
        -   Announcement.php
        -   Attendance.php
        -   AttendanceType.php
        -   Contract.php
        -   Department.php
        -   Position.php
        -   Relative.php
        -   Role.php
        -   User.php
        -   EmergencyContact.php
        -   EmployeeDetail.php
        -   Leave.php
        -   LeaveType.php
        -   Mission.php
        -   MissionType.php
        -   Overtime.php
-   database/
    -   migrations/
        -   add_employee_detail_to_users.php
        -   create_announcements_table.php
        -   create_attendances_table.php
        -   create_attendance_types_table.php
        -   create_contracts_table.php
        -   create_departments_table.php
        -   create_emergency_contacts_table.php
        -   create_employee_details_table.php
        -   create_leave_requests_table.php
        -   create_leave_types_table.php
        -   create_missions_table.php
        -   create_mission_types_table.php
        -   create_overtime_requests_table.php
        -   create_positions_table.php
        -   create_relatives_table.php
        -   create_roles_table.php
        -   create_users_table.php
-   routes/
    -   api.php
-   tests/
    -   Feature/
        -   ExampleTest.php
    -   Unit/
        -   ExampleTest.php
-   storage/
-   vendor/
-   .env
-   .gitignore
-   artisan
-   composer.json
-   composer.lock
-   package.json
-   phpunit.xml
-   readme.md
