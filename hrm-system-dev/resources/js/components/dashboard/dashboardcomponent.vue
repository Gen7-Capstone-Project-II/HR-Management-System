<style scoped>
.cardBox {
  position: relative;
  width: 100%;
  padding: 20px;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-gap: 30px;
}

/* .cardBox .card-first {
  position: relative;
  background:#F6B523;
  padding: 30px;
  border-radius: 20px;
  display: flex;
  justify-content: space-between;
  cursor: pointer;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
}
.cardBox .card-second {
  position: relative;
  background:#13A641;
  padding: 30px;
  border-radius: 20px;
  display: flex;
  justify-content: space-between;
  cursor: pointer;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
}
.cardBox .card-third {
  position: relative;
  background:#E83449;
  padding: 30px;
  border-radius: 20px;
  display: flex;
  justify-content: space-between;
  cursor: pointer;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
}
.cardBox .card-four {
  position: relative;
  background:#25ADE4;
  padding: 30px;
  border-radius: 20px;
  display: flex;
  justify-content: space-between;
  cursor: pointer;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
} */
.cardBox .card {
  position: relative;
  background: rgb(0, 108, 81);
  padding: 30px;
  border-radius: 5px;
  display: flex;
  justify-content: space-between;
  cursor: pointer;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
}

.cardBox .numbers {
  position: relative;
  font-weight: 500;
  font-size: 2rem;
  color: white;
  text-decoration: none;
}

.cardBox .cardName {
  color: white;
  font-size: 1.1rem;
  margin-top: 5px;
  text-decoration: none;
}

.link-class {
  text-decoration: none;
}

.cardBox .card .iconBx {
  font-size: 2rem;
  color: rgb(53, 51, 51);
}

/* .cardBox .card-first:hover,
.cardBox .card-second:hover,
.cardBox .card-third:hover,
.cardBox .card-four:hover {
  background: rgb(0, 108, 81);
} */

.cardBox .card:hover {
  background: white;
}

.cardBox .card:hover .numbers,
.cardBox .card:hover .cardName,
.cardBox .card:hover .iconBx {
  color: rgb(0, 108, 81);
}

/* ================== Order Details List ============== */
.details {
  position: relative;
  width: 100%;
  padding: 20px;
  display: grid;
  height: 400px;
  /* grid-template-columns: 2fr 1fr;
  grid-gap: 30px; */
  /* margin-top: 10px; */
}

.details .recentOrders {
  position: relative;
  /* display: grid; */
  min-height: 200px;
  /* padding: 20px; */
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border-radius: 5px;
}

.details .recentOrders .class-table {
  position: relative;
  /* display: grid; */
  min-height: 200px;
}

.details .cardHeader {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.cardHeader h4 {
  color: rgb(0, 108, 81);
}

.cardHeader .btn {
  position: relative;
  padding: 5px 10px;
  background: rgb(0, 108, 81);
  text-decoration: none;
  color: white;
  border-radius: 5px;
}

.details table {
  width: 100%;
  /* border-collapse: collapse; */
  margin-top: 10px;
}

.imgBx img {
  position: relative;
  width: 40px;
  /* height: 30px; */
  border-radius: 50%;
  overflow: hidden;
  cursor: pointer;
}

.details table thead td {
  font-weight: 600;
}

.details .recentOrders table tr {
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.details .recentOrders table tr:last-child {
  border-bottom: none;
}


.details .recentOrders table tr td {
  padding: 10px;
}

/* .details .recentOrders table tr td:last-child {
  text-align: end;
}
.details .recentOrders table tr td:nth-child(2) {
  text-align: end;
}
.details .recentOrders table tr td:nth-child(3) {
  text-align: center;
} */
.status.delivered {
  padding: 2px 4px;
  background: rgb(0, 108, 81);
  color: white;
  border-radius: 5px;
  font-size: 14px;
  font-weight: 500;
}

.recentCustomers {
  position: relative;
  display: grid;
  min-height: 200px;
  padding: 20px;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border-radius: 5px;
}

.recentCustomers .imgBx {
  position: relative;
  width: 40px;
  height: 40px;
  border-radius: 50px;
  overflow: hidden;
}

.recentCustomers .imgBx img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.recentCustomers table tr td {
  padding: 12px 10px;
}

.recentCustomers table tr td h4 {
  font-size: 16px;
  font-weight: 500;
  line-height: 1.2rem;
}

.recentCustomers table tr td h4 span {
  font-size: 14px;
  color: var(--black2);
}

.recentCustomers table tr:hover {
  background: var(--blue);
  color: var(--white);
}

.recentCustomers table tr:hover td h4 span {
  color: var(--white);
}

/* ====================== Responsive Design ========================== */
@media (max-width: 991px) {
  .navigation {
    left: -300px;
  }

  .navigation.active {
    width: 300px;
    left: 0;
  }

  .main {
    width: 100%;
    left: 0;
  }

  .main.active {
    left: 300px;
  }

  .cardBox {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 768px) {
  .details {
    grid-template-columns: 1fr;
  }

  .recentOrders {
    overflow-x: auto;
  }

  .status.inProgress {
    white-space: nowrap;
  }
}

@media (max-width: 480px) {
  .cardBox {
    grid-template-columns: repeat(1, 1fr);
  }

  .cardHeader h2 {
    font-size: 20px;
  }

  .user {
    min-width: 40px;
  }

  .navigation {
    width: 100%;
    left: -100%;
    z-index: 1000;
  }

  .navigation.active {
    width: 100%;
    left: 0;
  }

  .toggle {
    z-index: 10001;
  }

  .main.active .toggle {
    color: #fff;
    position: fixed;
    right: 0;
    left: initial;
  }
}
</style>

<template>
  <div class="cardBox">

    <div class="card">
      <router-link to="/EmployeeV2" class="link-class">
        <div>
          <div v-if="total_employees" class="numbers">{{ total_employees.total_employee }}</div>
          <div class="cardName">Employees</div>
        </div>

        <div class="iconBx">
          <ion-icon name="cart-outline"></ion-icon>
        </div>
      </router-link>
    </div>

    <div class="card">
      <router-link to="   " class="link-class">
        <div>
          <div v-if="total_attendances" class="numbers">{{ total_attendances.presentCount }}</div>
          <div class="cardName">Attendances</div>
        </div>

        <div class="iconBx">
          <ion-icon name="cart-outline"></ion-icon>
        </div>
      </router-link>
    </div>

    <div class="card">
      <router-link to="/leaveRequestV2" class="link-class">
        <div>
          <div v-if="total_leaves" class="numbers">{{ total_leaves.total_leave_request }}</div>
          <div class="cardName">Leave Requests</div>
        </div>

        <div class="iconBx">
          <ion-icon name="chatbubbles-outline"></ion-icon>
        </div>
      </router-link>
    </div>

    <div class="card">
      <router-link to="   " class="link-class">
        <div>
          <div v-if="total_overtimes" class="numbers">{{ total_overtimes.total_overtime_request }}</div>
          <div class="cardName">Overtimes</div>
        </div>

        <div class="iconBx">
          <ion-icon name="cash-outline"></ion-icon>
        </div>
      </router-link>
    </div>
  </div>

  <!-- ================ Order Details List ================= -->
  <div class="details">
    <div class="recentOrders" style="overflow-y: auto;">
      <div class="cardHeader p-2" style="position: sticky; top: 0; z-index: 1; background-color: white;">
        <h4>Leave Requests</h4>
        <router-link to="/leaveRequestV2">
          <a href="#" class="btn">View All</a>
        </router-link>
      </div>
      <div class="class-table">
        <table class="p-4">
          <thead style="position: sticky; top: 0; z-index: 1; background-color: white;">
            <tr>
              <td>#</td>
              <td>Employee</td>
              <td>Leave Type</td>
              <td>Start Date</td>
              <td>End Date</td>
              <td>Total</td>
            </tr>
          </thead>
          <tbody v-if="loading">
                <tr>
                  <td colspan="8" class="bg-white" style="text-align:center;">
                    <div class="spinner-border text-secondary" style="width: 3rem; height: 3rem;" role="status">
                      <span class="visually-hidden">Loading...</span>
                    </div>
                  </td>
                </tr>
              </tbody>
          <tbody v-else>
            <tr v-for="(item, index) in leave_requests" :key="item.id">
              <td>{{ index + 1 }}</td>
              <td>
                <div class="d-flex m-0">
                  <avatar :size="45" :name="`${item.employee.name}`"></avatar>
                  <div class="infor col-9">
                    <h6 class="small-text">{{ item.employee.name }}<br><span class="small-text text-muted"
                        style="font-size: 0.8rem">{{ item.employee.idEmp }}</span></h6>
                  </div>
                </div>
              </td>
              <td>{{ item.leave_type.leaveType }}</td>
              <td>{{ formatDate(item.startDate) }}</td>
              <td>{{ formatDate(item.endDate) }}</td>
              <td v-if="item.totalDays === null"><span class="status delivered">{{ calculateTotalDays(item.startDate,item.endDate) }} Day(s)</span></td>
              <td v-else><span class="status delivered">{{ item.totalDays }}</span></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="details">
    <div class="recentOrders" style="overflow-y: auto;">
      <div class="cardHeader p-2" style="position: sticky; top: 0; z-index: 1; background-color: white;">
        <h4>Overtimes</h4>
        <router-link to="/leaveRequestV2">
          <a href="#" class="btn">View All</a>
        </router-link>
      </div>
      <div class="class-table">
        <table class="p-4">
          <thead style="position: sticky; top: 0; z-index: 1; background-color: white;">
            <tr>
              <td>#</td>
              <td>Employee</td>
              <td>Title</td>
              <td>OT Date</td>
              <td>Time From</td>
              <td>Time To</td>
              <td>Total times</td>
            </tr>
          </thead>
          <tbody v-if="loading">
                <tr>
                  <td colspan="8" class="bg-white" style="text-align:center;">
                    <div class="spinner-border text-secondary" style="width: 3rem; height: 3rem;" role="status">
                      <span class="visually-hidden">Loading...</span>
                    </div>
                  </td>
                </tr>
              </tbody>
          <tbody v-else>
            <tr v-for="(item, index) in overtime_requests" :key="item.id">
              <td>{{ index + 1 }}</td>
              <td>
                <div class="d-flex m-0">
                  <avatar :size="45" :name="`${item.employee.name}`"></avatar>
                  <div class="infor col-9">
                    <h6 class="small-text">{{ item.employee.name }}<br><span class="small-text text-muted"
                        style="font-size: 0.8rem">{{ item.employee.idEmp }}</span></h6>
                  </div>
                </div>
              </td>
              <td>{{ item.title }}</td>
              <td>{{ formatDate(item.dateOT) }}</td>
              <td>{{ timeOvertime(item.time_from) }}</td>
              <td>{{ timeOvertime(item.time_to) }}</td>
              <td><span class="status delivered">{{ timeToHoursMinutes(item.total_time) }}</span></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Avatar from "vue3-avatar";

export default {
  components: {
    Avatar,
  },
  data() {
    return {
      total_leaves: null,
      total_employees: null,
      total_attendances: null,
      total_overtimes: null,
      leave_requests: [],
      loading: false,
      overtime_requests: [],
    }
  },
  mounted() {
    this.fetchTotalEmployee();
    this.fetchTotalAttendances();
    this.fetchTotalLeave();
    this.fetchTotalOvertime();
    this.fetchLeaveRequests(null);
    this.fetchOvertimeRequests(null);
  },
  methods: {
    async fetchTotalLeave() {
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get('https://hrm-system-test.up.railway.app/api/leave_totalrequest', {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.total_leaves = response.data.data; // Assign the user data to the component's data property
        console.log(this.total_leaves);
      } catch (error) {
        console.error(error);
      }
    },
    async fetchTotalAttendances() {
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get('https://hrm-system-test.up.railway.app/api/employee_list_attendancecount', {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.total_attendances = response.data.data;
        console.log(response.total_attendances);
      } catch (error) {
        console.error(error);
      }
    },
    async fetchTotalOvertime() {
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get('https://hrm-system-test.up.railway.app/api/overtime_totalrequest', {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.total_overtimes = response.data.data; // Assign the user data to the component's data property
        console.log(this.total_overtimes);
      } catch (error) {
        console.error(error);
      }
    },
    async fetchTotalEmployee() {
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get('https://hrm-system-test.up.railway.app/api/total_employeedetail', {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.total_employees = response.data.data; // Assign the user data to the component's data property
        console.log(this.total_employees);
      } catch (error) {
        console.error(error);
      }
    },
    async fetchLeaveRequests(type) {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');
        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/leave?isApproved=${type}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.leave_requests = response.data.data; // Assign the user data to the component's data property
        console.log(this.leave_requests)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async fetchOvertimeRequests(type) {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');
        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/overtime?isApproved=${type}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.overtime_requests = response.data.data; // Assign the user data to the component's data property
        console.log(this.overtime_requests)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    formatDate(dateString) {
      const date = new Date(dateString);
      const day = String(date.getDate()).padStart(2, '0');
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const year = date.getFullYear();
      const formattedDate = `${day}-${month}-${year}`;
      return formattedDate;
    },
    timeOvertime(date) {
      const [hours, minutes] = date.split(':');
      return `${hours}:${minutes.padStart(2, '0')}`;
    },
    timeToHoursMinutes(total_time) {
      if (!total_time) {
        return "00 hr 00 mins";
      }

      const hours = Math.floor(total_time);
      const minutes = Math.round((total_time - hours) * 60);

      return `${hours.toString().padStart(2, '0')} hr ${minutes.toString().padStart(2, '0')} mins`;
    },
    calculateTotalDays(startDate, endDate) {
      const start = new Date(startDate);
      const end = new Date(endDate);
      const timeDifference = Math.abs(end.getTime() - start.getTime());
      const totalDays = Math.ceil(timeDifference / (1000 * 60 * 60 * 24));

      if (totalDays === 0) {
        return 1;
      }

      return totalDays;
    },
  }
};

</script>