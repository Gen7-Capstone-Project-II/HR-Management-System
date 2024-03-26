// router.js
import { createRouter, createWebHistory } from "vue-router";

import dashboardcomponent from "../js/components/dashboard/dashboardcomponent.vue";
import dashboardV2 from "../js/components/dashboard/dashboardV2.vue";

import login from "../../resources/js/components/authentication/login.vue";

import attendance_list from "../js/components/attendance/attendance_list.vue";

import overtime from "../js/components/overtime/overTime.vue";
import overtimeDetail from "../js/components/overtime_detail.vue";

import announcement from "../js/components/announcement/announcement.vue";
import viewannouncement from "../js/components/announcement/viewannouncement.vue";
import AddNewAnnouncement from "../js/components/announcement/addnewannouncement.vue";
import UpdateAnnouncement from "../js/components/announcement/updateannounecement.vue";

import EmployeeV2 from "../js/components/employee_list/employeeV2.vue";
import employeedetail from "../js/components/employee_list/employeedetail.vue";
import editemployeedetail from "../js/components/employee_list/edite_ployee_detail.vue";
import addnew_employeelist from "../js/components/employee_list/addnew_employee_list.vue";
import update_emergency from "./components/emergency_contact/update_emergency.vue";

import leaveRequestV2 from "../js/components/leave/leaveRequestV2.vue";
import leavRequest_detail from "./components/leave/leavRequest_detail.vue";

import setting from "../js/components/setting/setting.vue";
import profile from "../js/components/setting/profile.vue";
import user from "../js/components/setting/user.vue";
import adduser from "../js/components/setting/addnewuserV2.vue";
import department from "../js/components/department/department.vue";
import position from "../js/components/position/position.vue";

import mission from "../js/components/mission/mission.vue";
import view_mission from "../js/components/mission/view_mission.vue";


const routes = [
    {
        path: "/",
        component: login,
    },
    {
        path: "/dashboardV2",
        component: dashboardV2,
        meta: { requiresAuth: true },
        children: [
            {
                path: "/dashboardV2",
                component: dashboardcomponent,
            },
            {
                path: "/overtime",
                component: overtime,
            },
            {
                path: "/mission",
                component: mission,
            },
            {
                path: "/view_mission/:id",
                name: "ViewMission",
                component: view_mission,
            },
            {
                path: "/overtime_detail/:id",
                name: "OvertimeDetail",
                component: overtimeDetail,
            },
            {
                path: "/announcement",
                component: announcement,
            },
            {
                path: "/AddNewAnnouncement",
                component: AddNewAnnouncement,
            },
            {
                path: "/viewannouncement/:id",
                name: "ViewAnnouncement",
                component: viewannouncement,
            },
            {
                path: "/updateAnnouncement/:id",
                name: "UpdateAnnouncement",
                component: UpdateAnnouncement,
            },
            {
                path: "/EmployeeV2",
                component: EmployeeV2,
            },
            {
                path: "/attendance_list",
                component: attendance_list,
            },
            {
                path: "/leaveRequestV2",
                component: leaveRequestV2,
            },
            {
                path: "/setting",
                component: setting,
            },
            {
                path: "/user",
                component: user,
            },
            {
                path: "/add_employee",
                component: adduser,
            },
            {
                path: "/profile",
                component: profile,
            },
            {
                path: "/department",
                component: department,
            },
            {
                path: "/position",
                component: position,
            },
            {
                path: "/update_emergency/:id",
                name: "EditEmergencyContact",
                component: update_emergency,
            },
            {
                path: "/leave_detail/:id",
                name: "LeaveDetail",
                component: leavRequest_detail,
            },
            {
                path: "/employeedetail/:id",
                name: "EmployeeDetail",
                component: employeedetail,
            },
            {
                path: "/edit_employeedetail/:id",
                name: "EditEmployeeDetail",
                component: editemployeedetail,
            },
            {
                path: "/addnew_employeelist/:id",
                name: "AddNewEmplyeeList",
                component: addnew_employeelist,
            },
        ],
    },
    // Add more routes as needed
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});
// router.beforeEach((to, from, next) => {
//   // Check if the route requires authentication
//   if (to.meta.requiresAuth) {
//     // Check if the user is authenticated
//     const isAuthenticated = localStorage.getItem('token'); // Assuming you are storing a token in localStorage upon successful login
//     if (isAuthenticated) {
//       // If authenticated, proceed to the route
//       next();
//     } else {
//       // If not authenticated, redirect to the login page
//       next('/login'); // Assuming you have a '/login' route
//     }
//   } else {
//     // If the route does not require authentication, proceed as usual
//     next();
//   }
// });

export default router;
