<style scoped>
.table-wrapper {
  padding: 20px;
}

/* card box style */
.cardBox {
  position: relative;
  width: 100%;
  /* padding: 10px; */
  padding-bottom: 20px;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-gap: 30px;
}

.cardBox .card-first {
  /* position: relative; */
  background: #F6B523;
  padding: 5px;
  border-radius: 5px;
  display: inline;
  justify-content: space-between;
  cursor: pointer;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
  height: 110px;
}

.card-first .card-title {
  background: #F6B523;
  height: 50px;
  width: 50px;
  margin-top: -20px;
  border-radius: 5px;
  justify-content: center;
  align-items: center;
  display: flex;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
  color: white;
}

.cardBox .card-second {
  /* position: relative; */
  background: #13A641;
  padding: 5px;
  border-radius: 5px;
  display: inline;
  justify-content: space-between;
  cursor: pointer;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
  height: 110px;
}

.card-second .card-title {
  background: #13A641;
  height: 50px;
  width: 50px;
  margin-top: -20px;
  border-radius: 5px;
  justify-content: center;
  align-items: center;
  display: flex;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
  color: white;
}

.cardBox .card-third {
  /* position: relative; */
  background: #E83449;
  padding: 5px;
  border-radius: 5px;
  display: inline;
  justify-content: space-between;
  cursor: pointer;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
  height: 110px;
}

.card-third .card-title {
  background: #E83449;
  height: 50px;
  width: 50px;
  margin-top: -20px;
  border-radius: 5px;
  justify-content: center;
  align-items: center;
  display: flex;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
  color: white;
}

.cardBox .card-four {
  /* position: relative; */
  background: #25ADE4;
  padding: 5px;
  border-radius: 5px;
  display: inline;
  justify-content: space-between;
  cursor: pointer;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
  height: 110px;
}

.card-four .card-title {
  background: #25ADE4;
  height: 50px;
  width: 50px;
  margin-top: -20px;
  border-radius: 5px;
  justify-content: center;
  align-items: center;
  display: flex;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
  color: white;
}

.cardBox .numbers {
  position: relative;
  font-weight: 500;
  font-size: 1.5rem;
  color: #000000;
  text-decoration: none;
  text-align: right;
}

.cardBox .cardName {
  color: #000000;
  font-size: o.9rem;
  margin-top: 5px;
  text-decoration: none;
}

.border-line {
  border: 0.1px solid #FFFFFF;
  /* Add your desired border style here */
}

.class-border {
  border-radius: 5px;
}

.date {
  font-size: 14px;
  color: white;
  margin-top: 2px;
}

.row {
  display: flex;
  align-items: center;
  /* Align items vertically */
}


.form-control:hover {
  /* Add your hover styles here */
  border-color: white;
  /* For example: change border color to blue on hover */
}



.link-class {
  text-decoration: none;
}

.cardBox .card .iconBx {
  font-size: 2rem;
  color: rgb(53, 51, 51);
}

.cardBox .card:hover {
  background: rgb(0, 108, 81);
}

.cardBox .card:hover .numbers,
.cardBox .card:hover .cardName,
.cardBox .card:hover .iconBx {
  color: white;
}


/* attendance style */
.cardHeader h4 {
  color: rgb(0, 108, 81);
  display: flex;
}

.table-bordered {
  border-collapse: collapse;
  /* Add this line */
  width: 100%;
  /* Adjust width as needed */
  border-radius: 10px;
}

.table-bordered th.employee-name {
  width: 300px;
  /* Adjust the width as needed */
  height: 40px;
  /* Adjust the height as needed */
  color: rgb(0, 108, 81);
  padding: 0;
  position: sticky;
  top: 0;
  left: 0;
  background-color: rgb(233, 253, 235);
  z-index: 2;
  text-align: center;
}

.date-header {
  position: sticky;
  top: 0;
  z-index: 1;
  background-color: white;
  font-size: 0.9rem;
  z-index: 1000;
}

.table-bordered .p-attendance {
  color: green;
}

.table-bordered .a-attendance {
  color: red;
}

.table-bordered .user-name {
  color: rgb(0, 108, 81);
  font-size: 0.9rem;
  padding-top: 5px;
}

.loading-spinner-container {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}

.fixed-column {
  position: sticky;
  left: 0;
  z-index: 1;
  background-color: white;
}

.form-control {
  border-radius: 5px;
  height: 30px;
}

.form-year {
  border-radius: 5px;
  font-size: 0.7rem;
  width: 100%;
}

.form-month {
  border-radius: 5px;
  font-size: 0.7rem;
}


.attendance-cell {
  position: relative;
  min-width: 30px;
  /* Adjust width as needed */
  height: 35px;
  /* Adjust height as needed */
  background-color: rgb(233, 253, 235);
}

.attendance-cell span {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.table td {
  padding: 2px;
}

.table-bordered td {
  padding: 2px;
  /* Remove default padding */
}

.table-bordered th {
  padding-left: 3px;
  /* Remove default padding */
  padding-right: 3px;
  padding-top: 0;
  padding-bottom: 0;
}

.table-bordered th p {
  margin: 0;
  /* Remove default padding */
}

.imgPf {
  width: 50px;
  /* Adjust width as needed */
  height: 50px;
  /* Adjust height as needed */
  overflow: hidden;
}

.imgBx img {
  position: relative;
  width: 35px;
  /* height: 30px; */
  border-radius: 50%;
  padding: 4px;
}

.profile {
  background-color: rgb(247, 255, 249);
  width: 100%;
}

.loading-spinner {
  border: 4px solid rgba(0, 0, 0, 0.1);
  border-left-color: #000;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  animation: spin 1s linear infinite;
  margin-bottom: 10px;
  z-index: 9999;
}

.class-infor {
  font-size: 1rem;
}

.employee-number {
  z-index: 10000;
}


@keyframes spin {
  0% {
    transform: rotate(0deg);
  }

  100% {
    transform: rotate(360deg);
  }
}

.loading {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100px;
  height: 100px;
  background-color: rgba(255, 255, 255, 0.8);
  border-radius: 50%;
}

.spinner-border {
  width: 3rem;
  height: 3rem;
}

.attendance-popup {

  width: 200px;
  position: absolute;
  background-color: #fff;
  border: 1px solid #ddd;
  z-index: 10000;
  color: white;
  border-radius: 5px;
  font-size: 0.9rem;
  border: none;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
}
</style>

<template>
  <div class="table-wrapper">
    <div class="d-flex justify-content-between align-items-center pe-4 pt-2 pb-2">
      <dev class="cardHeader">
        <h4>Attendances</h4>
      </dev>
    </div>
    <form class="row g-3 pb-2 d-flex  justify-content-between  ">
      <div class="d-flex justify-content-between ">
        <div class="filter-header align-items-center" style="width: 30%;">
          <div class="">
            <input class=" p-2 rounded-1 form-control" type="month" v-model="date"
              @change="fetchAttendanceListWithDate">
          </div>
        </div>
        <div>
          <button type="button" class="btn btn-success" @click="exportCSV" style="border-radius: 5px;">Export</button>
        </div>
      </div>

      <!-- <div class=" w-50   d-flex  justify-content-end align-items-center " style="display: flex;">
        <div style="margin-right: 5px;"><label for="month">EmployeeName</label></div>
        <div><input type="employeename" class="form-control" placeholder=" "></div>
      </div> -->
    </form>

    <div class="cardBox">

      <!-- <div class="card-first">
        <div class="d-inline-flex justify-content-between w-100 ">
          <div class="card-title">
            <div><i class="fa-regular fa-user"></i></div>
          </div>
          <div>
            <div class="class-title">
              <div class="cardName">Total Employees</div>
              <div class="numbers">{{ attendanceCount.totalUsers }}</div>
            </div>
          </div>
        </div>
        <div>
          <div class="border-line"></div>
          <div class="date d-flex justify-content-center align-text-center ">All of the Employee</div>
        </div>
      </div> -->

      <!-- <div class="card-second">
        <div class="d-inline-flex justify-content-between w-100 ">
          <div class="card-title">
            <div><i class="fa-solid fa-calendar-check"></i></div>
          </div>
          <div>
            <div class="class-title">
              <div class="cardName">Present</div>
              <div class="numbers">{{ attendanceCount.presentCount }}</div>
            </div>
          </div>
        </div>
        <div>
          <div class="border-line"></div>
          <div class="date d-flex justify-content-center align-text-center ">{{ currentDate }}</div>
        </div>
      </div> -->

      <!-- <div class="card-third">
        <div class="d-inline-flex justify-content-between w-100 ">
          <div class="card-title">
            <div><i class="fa-regular fa-calendar-xmark "></i></div>
          </div>
          <div>
            <div class="class-title">
              <div class="cardName">Absent</div>
              <div class="numbers">{{ attendanceCount.absentCount }}</div>
            </div>
          </div>
        </div>
        <div>
          <div class="border-line"></div>
          <div class="date d-flex justify-content-center align-text-center ">{{ currentDate }}</div>
        </div>
      </div> -->

      <!-- <div class="card-four">
        <div class="d-inline-flex justify-content-between w-100 ">
          <div class="card-title">
            <div><i class="fa-regular fa-calendar-days"></i></div>
          </div>
          <div>
            <div class="class-title">
              <div class="cardName">On Leave</div>
              <div class="numbers">{{ attendanceCount.leaveCount }}</div>
            </div>
          </div>
        </div>
        <div>
          <div class="border-line"></div>
          <div class="date d-flex justify-content-center align-text-center ">{{ currentDate }}</div>
        </div>
      </div> -->
    </div>
    <div class="list-attendance" style="height: 477px; overflow-y: auto; overflow-x: auto;">
      <tr v-if="isLoading">
        <td colspan="7">
          <div class="loading">
            <div class="spinner-border" role="status">
              <span class="sr-only">Loading...</span>
            </div>
          </div>
        </td>
      </tr>
      <table v-else class="table table-bordered ">
        <thead>
          <tr>
            <th class="employee-name  align-items-center ">
              <div class=" text-center pb-4" style="width: 300px;border-collapse: collapse;">EmployeeName</div>
            </th>
            <th v-if="attendanceListData && attendanceListData[0] && attendanceListData[0].attendanceData"
              v-for="attendance in attendanceListData[0].attendanceData.attendances" :key="attendance.date"
              class="date-header" style="position: sticky; top: 0; z-index: 1; background-color: white;">
              <p>{{ formatDate(attendance.date) }}</p>
            </th>
          </tr>
        </thead>
        <tbody>

          <tr v-for="(employee, index) in (attendanceListData)" :key="index">
            <td class="fixed-column">
              <div class="profile justify-content-around ">
                <!-- Left-aligned content -->
                <div class=" d-flex   " style="width: 70%;">
                  <div class="imgBx">
                    <avatar :size="35" :name="`${employee.user.name}`"></avatar>
                  </div>
                  <div class=" user-name">{{ employee.user.name }}</div>

                </div>

                <!-- Right-aligned content -->
                <!-- <div class="col-3 d-flex justify-content-evenly"
                  style="font-size: 0.7rem; background-color: rgb(233, 253, 235);border-radius: 5px; color: rgb(0, 108, 81);">
                  <div class=""><i class="fa-regular fa-clock"></i></div>
                  <div class="">{{ countattendance.presentCount }}/22</div>
                </div> -->
              </div>

            </td>
            <!-- <td v-for="(attendance, dateIndex) in employee.attendanceData.attendances" :key="dateIndex">
              <div class="attendance-cell">
                <span :class="attendance.attendance ? 'p-attendance' : 'a-attendance'">
                  {{ attendance.attendance ? 'P' : 'A' }}
                </span>
              </div>
            </td> -->
            <td v-for="(attendance, dateIndex) in employee.attendanceData.attendances" :key="dateIndex">
              <div class="attendance-cell" @click="hoveredAttendance = attendance"
                @mouseleave="hoveredAttendance = null">
                <span :class="attendance.attendance ? 'p-attendance' : 'a-attendance'">
                  {{ attendanceDisplay(attendance) }}
                </span>

                <!-- <div v-if="hoveredAttendance === attendance" class="attendance-popup">
                  <p class="date-title d-flex justify-content-center align-content-center rounded-top-2 "
                    style="background-color: rgb(0, 108, 81); border-top: 5px;"><strong>Name: sonai KOY</strong></p>
                  <div class="date-description ps-4" style="color:rgb(0, 108, 81); background-color: white;">
                    <p>Date:3/19/2024
                    <p class="ps-2">Time In - 6:00AM
                    <p>Time Out - 5:00PM</p>
                    </p>
                    </p>
                  </div>


                </div> -->

              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>



  </div>
</template>

<script>
import axios from 'axios';
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css'
import Papa from "papaparse";
import Avatar from "vue3-avatar";




export default {
  components: { VueDatePicker, Avatar },
  computed: {
    // ...
    attendanceDisplay() {
      const currentDate = new Date().toISOString().slice(0, 10);

      return (attendance) => {
        if (attendance.date > currentDate) {
          return '--';
        }

        return this.currentDate === attendance.date ? this.currentDate : attendance.attendance ? 'P' : 'A';
      };
    }
  },
  data() {
    return {
      date: new Date().toISOString().substring(0, 7),
      attendanceListData: [],
      attendanceCount: {},
      selectedYear: new Date().getFullYear(),
      selectedMonth: new Date().getMonth() + 1,
      years: [],
      months: [],
      isLoading: false,
      currentDate: '',
      hoveredAttendance: null,
      headers: [],
      dateList: [],
      countAttendance: [],
    };
  },
  mounted() {
    const currentDate = new Date();
    const currentYear = currentDate.getFullYear();
    const currentMonth = currentDate.getMonth() + 1;
    console.log("Component mounted");
    this.fetchAttendanceList(currentYear, currentMonth);
    this.fetchAttendanceCounts(currentYear, currentMonth);
    this.initializeOptions();
    this.currentDate = this.getCurrentDate();
    this.fetchAttendanceCount();
  },
  methods: {
    formatTime(timestamp) {
      if (!timestamp) {
        return "---";
      }
      const date = new Date(timestamp); // Convert timestamp to Date object
      const hours = String(date.getUTCHours()).padStart(2, '0'); // Get hours and pad with 0 if needed
      const minutes = String(date.getUTCMinutes()).padStart(2, '0'); // Get minutes and pad with 0 if needed
      return `${hours}:${minutes}`; // Combine hours and minutes with a colon
    },
    fetchAttendanceListWithDate() {
      if (!this.date) {
        this.date = new Date().toISOString().substring(0, 7);
      }

      const dateRegex = /^(\d{4})-(\d{2})$/;
      const dateMatch = this.date.match(dateRegex);
      if (dateMatch) {
        const selectedYear = parseInt(dateMatch[1], 10);
        const selectedMonth = parseInt(dateMatch[2], 10);

        // Use selectedYear and selectedMonth in the API request
        this.fetchAttendanceList(selectedYear, selectedMonth);
        this.fetchAttendanceCounts(selectedYear, selectedMonth);
      } else {
        const currentYear = new Date().getFullYear();
        const currentMonth = new Date().getMonth() + 1;
        this.fetchAttendanceList(currentYear, currentMonth);
        this.fetchAttendanceCounts(currentYear, currentMonth);
      }
    },
    async fetchAttendanceList(year, month) {
      this.isLoading = true;
      try {
        // Set isLoading to true before making the API request
        const token = localStorage.getItem('token');

        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/employee_list/attendances?month=${year}-${month.toString().padStart(2, '0')}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.attendanceListData = response.data.data;

        console.log(response.data);
      } catch (error) {
        console.error(error);
        this.isLoading = false; // Set isLoading to false in case of an error
      }
      this.isLoading = false;
    },
    getCurrentDate() {
      const currentDate = new Date();
      const options = {
        weekday: 'long',
        day: '2-digit',
        month: 'short',
        year: 'numeric'
      };
      const formattedDate = currentDate.toLocaleDateString('en-US', options);
      return formattedDate;
    },
    async fetchAttendanceCount() {
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get('https://hrm-system-test.up.railway.app/api/employee_list_attendancecount', {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.attendanceCount = response.data.data;
        console.log(response.data);
      } catch (error) {
        console.error(error);
      }
    },
    async fetchAttendanceCounts(year, month) {
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/employee_attendance_count?month=${year}-${month.toString().padStart(2, '0')}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.countAttendance = response.data.data;
        console.log(this.countAttendance);
      } catch (error) {
        console.error(error);
      }
    },
    formatDate(dateStr) {
      const date = new Date(dateStr);
      const options = { month: 'short', day: '2-digit', weekday: 'short' };
      const formattedDate = date.toLocaleDateString('en-US', options);
      const parts = formattedDate.split(', ');
      const reorderedDate = `${parts[1]} ${parts[0]}`;
      return reorderedDate;
    },
    initializeOptions() {
      const currentYear = new Date().getFullYear();
      const startYear = currentYear - 10; // Change this to set the range of years you want to display

      for (let year = startYear; year <= currentYear; year++) {
        this.years.push(year);
      }

      const monthNames = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];

      for (let month = 1; month <= 12; month++) {
        this.months.push(monthNames[month - 1]);
      }
    },
    exportCSV() {
      // Define an array to store all unique dates
      let allDates = [];

      // Extract all unique dates from attendance data
      this.attendanceListData.forEach(attendanceRecord => {
        attendanceRecord.attendanceData.attendances.forEach(attendance => {
          if (!allDates.includes(attendance.date)) {
            allDates.push(attendance.date);
          }
        });
      });

      // Sort the dates in ascending order
      allDates.sort();

      // Create CSV headers with dates
      const csvHeaders = ['ID', 'Name', ...allDates];

      // Prepare attendance data in CSV format
      const formattedAttendanceData = this.attendanceListData.map((attendanceRecord) => {
        const attendanceStatusByDate = {};

        // Initialize attendance status for all dates as 'A'
        allDates.forEach(date => {
          attendanceStatusByDate[date] = 'A';
        });

        // Update attendance status for the dates present in the attendance record
        attendanceRecord.attendanceData.attendances.forEach(attendance => {
          if (attendance.attendance && attendance.attendance.length > 0 && attendance.attendance[0].attendanceData) {
            // Check if attendance is not null, has elements, and has attendanceData
            const attendanceData = attendance.attendance[0].attendanceData;
            if (attendanceData.time_in) {
              // If time_in is available, assign it to the date
              attendanceStatusByDate[attendance.date] = `${this.formatTime(attendanceData.time_in)} -- ${this.formatTime(attendanceData.time_out)}`;
            } else {
              // If time_in is not available, mark absence ('A')
              attendanceStatusByDate[attendance.date] = 'A';
            }
          } else {
            // If attendance is null or empty, or if attendanceData is missing, mark absence ('A')
            attendanceStatusByDate[attendance.date] = 'A';
          }
        });



        // Format the attendance data object with ID, Name, and attendance status for each date
        const formattedAttendance = {
          ID: attendanceRecord.user?.idEmp,
          Name: attendanceRecord.user.name,
        };

        // Populate attendance status for each date
        allDates.forEach(date => {
          formattedAttendance[date] = attendanceStatusByDate[date];
        });

        return formattedAttendance;
      });

      // Convert attendance data to CSV format using Papa.unparse
      const csvContent = Papa.unparse(formattedAttendanceData, { header: true });

      // Create a Blob object and download the CSV file
      const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });
      const link = document.createElement("a");
      link.href = URL.createObjectURL(blob);
      link.download = "Attendance_data.csv";
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      this.fetchPosts();
    },

  }
};
</script>