<style scoped>
.table-wrapper {
  padding: 20px;
}

.imgBx img {
  position: relative;
  width: 40px;
  /* height: 30px; */
  border-radius: 50%;
  overflow: hidden;
  cursor: pointer;
}


.cardHeader h4 {
  padding-left: 15px;
  padding-top: 20px;
  color: rgb(0, 108, 81);
}

/* Default color for h4 */
.nav-link h5 {
  color: white;
  border: 0;
}

/* Color for h4 when its parent is active */
.nav-link.active h5 {
  color: rgb(0, 108, 81);
}

.line-space {
  height: 20px;

}

.nav-tabs .nav-item .nav-link {
  border: 2px solid transparent;
}

.no-placeholder::before {
  content: none !important;
}

.infor-title {
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
}

.spinner-border {
  width: 3rem;
  height: 3rem;
}
</style>

<template>
  <div class="table-wrapper">
    <!-- Tabs -->
    <div class="h4 pb-4" style="color:rgb(0, 108, 81);">
      Leave Request
    </div>
    <div class="infor-title" style="border-top-left-radius:5px;border-top-right-radius:5px;">
      <ul class="nav nav-tabs border-bottom-0"
        style="border-top-left-radius:7px;border-top-right-radius:7px; background-color:rgb(0, 108, 81);">
        <li class="nav-item pt-3 px-1">
          <a class="nav-link active px-5" data-bs-toggle="tab" href="#AllleaveRequest" @click="fetchLeaveRequests()">
            <div class="cardHeader-tab">
              <h5>All</h5>
            </div>
          </a>
        </li>
        <li class="nav-item pt-3 px-1">
          <a class="nav-link px-5" data-bs-toggle="tab" href="#leaveRequest" @click="fetchfilterLeaveRequests(null)">
            <div class="cardHeader-tab">
              <h5>Leave Request</h5>
            </div>
          </a>
        </li>
        <li class="nav-item pt-3 px-1">
          <a class="nav-link px-5" data-bs-toggle="tab" href="#Approved" @click="fetchfilterLeaveRequests(1)">
            <div class="cardHeader-tab">
              <h5>Approved</h5>
            </div>
          </a>
        </li>
        <li class="nav-item pt-3 px-1">
          <a class="nav-link px-5" data-bs-toggle="tab" href="#Reject" @click="fetchfilterLeaveRequests(0)">
            <div class="cardHeader-tab">
              <h5>Rejected</h5>
            </div>
          </a>
        </li>
      </ul>

      <!-- Filter Inputs -->
      <div class="mt-3 mb-3 ps-5">
        <form class="row g-3">
          <div class="col-md-4">
            <label for="dateFilter" class="form-label">Created Date</label>
            <input type="date" class="form-control" placeholder=" " id="date-filter" @change="handleDateChange">
          </div>
          <div class="col-md-4">
            <label for="typeFilter" class="form-label">Type Filter</label>
            <select class="form-select" v-model="selectedLeaveType" placeholder=" ">
              <option selected disabled>Choose...</option>
              <option v-for="leavetype in leavetypes" :key="leavetype.id" :value="leavetype.id">
                {{ leavetype.leaveType }}
              </option>
            </select>
          </div>
        </form>
      </div>

      <!-- Tab Content -->
      <div class="tab-content pt-3">
        <!-- Leave Request Tab -->
        <div class="tab-pane fade show active" id="AllleaveRequest">
          <div class="table-list ps-3 pe-3">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">Employee</th>
                  <th scope="col">Start Date</th>
                  <th scope="col">End Date</th>
                  <th scope="col">Total</th>
                  <th scope="col">Leave Type</th>
                  <th scope="col">Status</th>
                  <th scope="col">Actions</th>
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
                <tr v-for="(leave, index) in leaveRequests" :key="leave.id">
                  <th scope="row" class="small-text">{{ index + 1 }}</th>
                  <td>
                    <div class="d-flex m-0">
                      <avatar :size="45" :name="`${leave.employee.name}`"></avatar>
                      <div class="infor col-9">
                        <h6 class="small-text">{{ leave.employee.name }}<br><span class="small-text text-muted"
                            style="font-size: 0.8rem">{{ leave.employee.idEmp
                            }}</span></h6>
                      </div>
                    </div>
                  </td>
                  <td class="small-text">{{ formatDate(leave.startDate) }}</td>
                  <td class="small-text">{{ formatDate(leave.endDate) }}</td>
                  <td class="small-text">{{ calculateTotalDays(leave.startDate, leave.endDate) }} day</td>
                  <td class="small-text">{{ leave.leave_type.leaveType }}</td>
                  <td v-if="leave.isApproved === null" class="small-text"><button type="button"
                      class="btn btn-primary  btn-sm small-button disabled ">Pending</button></td>
                  <td v-else-if="leave.isApproved === 1" class="small-text"><button type="button"
                      class="btn btn-success btn-sm small-button disabled ">Approved</button></td>
                  <td v-else-if="leave.isApproved === 0" class="small-text"><button type="button"
                      class="btn btn-danger btn-sm small-button disabled ">Rejected</button></td>
                  <td>
                    <router-link :to="{ name: 'LeaveDetail', params: { id: leave.id } }">
                      <button type="button" class="btn btn-sm border">View</button>
                    </router-link>
                  </td>
                </tr>
                <!-- Add more rows here -->
              </tbody>
            </table>
          </div>
        </div>

        <!-- Leave-repuest tap -->
        <div class="tab-pane fade" id="leaveRequest">
          <div class="table-list ps-3 pe-3">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">Employee</th>
                  <th scope="col">Start Date</th>
                  <th scope="col">End Date</th>
                  <th scope="col">Total</th>
                  <th scope="col">Leave Type</th>
                  <th scope="col">Status</th>
                  <th scope="col">Actions</th>
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
                <tr v-for="(leave, index) in leaveRequests" :key="leave.id">
                  <th scope="row" class="small-text">{{ index + 1 }}</th>
                  <td>
                    <div class="d-flex m-0">
                      <avatar :size="45" :name="`${leave.employee.name}`"></avatar>
                      <div class="infor col-9">
                        <h6 class="small-text">{{ leave.employee.name }}<br><span class="small-text text-muted"
                            style="font-size: 0.8rem">{{ leave.employee.idEmp
                            }}</span></h6>
                      </div>
                    </div>
                  </td>
                  <td class="small-text">{{ formatDate(leave.startDate) }}</td>
                  <td class="small-text">{{ formatDate(leave.endDate) }}</td>
                  <td class="small-text">{{ calculateTotalDays(leave.startDate, leave.endDate) }} day</td>
                  <td class="small-text">{{ leave.leave_type.leaveType }}</td>
                  <td class="small-text"><button type="button"
                      class="btn btn-primary btn-sm small-button disabled ">Pending</button></td>
                  <td>
                    <router-link :to="{ name: 'LeaveDetail', params: { id: leave.id } }">
                      <button type="button" class="btn btn-sm border">View</button>
                    </router-link>
                  </td>
                </tr>
                <!-- Add more rows here -->
              </tbody>
            </table>
          </div>
        </div>

        <!-- Approve Tab -->
        <div class="tab-pane fade" id="Approved">
          <div class="table-list ps-3 pe-3">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">Employee</th>
                  <th scope="col">Start Date</th>
                  <th scope="col">End Date</th>
                  <th scope="col">Total</th>
                  <th scope="col">Leave Type</th>
                  <th scope="col">Status</th>
                  <th scope="col">Actions</th>
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
                <tr v-for="(leave, index) in leaveRequests" :key="leave.id">
                  <th scope="row" class="small-text">{{ index + 1 }}</th>
                  <td>
                    <div class="d-flex m-0">
                      <avatar :size="45" :name="`${leave.employee.name}`"></avatar>
                      <div class="infor col-9">
                        <h6 class="small-text">{{ leave.employee.name }}<br><span class="small-text text-muted"
                            style="font-size: 0.8rem">{{ leave.employee.idEmp
                            }}</span></h6>
                      </div>
                    </div>
                  </td>
                  <td class="small-text">{{ formatDate(leave.startDate) }}</td>
                  <td class="small-text">{{ formatDate(leave.endDate) }}</td>
                  <td class="small-text">{{ calculateTotalDays(leave.startDate, leave.endDate) }} day</td>
                  <td class="small-text">{{ leave.leave_type.leaveType }}</td>
                  <td class="small-text"><button type="button"
                      class="btn btn-success btn-sm small-button disabled ">Approved</button></td>
                  <td>
                    <router-link :to="{ name: 'LeaveDetail', params: { id: leave.id } }">
                      <button type="button" class="btn btn-sm border">View</button>
                    </router-link>
                  </td>
                </tr>
                <!-- Add more rows here -->
              </tbody>
            </table>
          </div>
        </div>

        <!-- Reject Tab -->
        <div class="tab-pane fade" id="Reject">
          <div class="table-list ps-3 pe-3">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">Employee</th>
                  <th scope="col">Start Date</th>
                  <th scope="col">End Date</th>
                  <th scope="col">Total</th>
                  <th scope="col">Leave Type</th>
                  <th scope="col">Status</th>
                  <th scope="col">Actions</th>
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
                <tr v-for="(leave, index) in leaveRequests" :key="leave.id">
                  <th scope="row" class="small-text">{{ index + 1 }}</th>
                  <td>
                    <div class="d-flex m-0">
                      <avatar :size="45" :name="`${leave.employee.name}`"></avatar>
                      <div class="infor col-9">
                        <h6 class="small-text">{{ leave.employee.name }}<br><span class="small-text text-muted"
                            style="font-size: 0.8rem">{{ leave.employee.idEmp
                            }}</span></h6>
                      </div>
                    </div>
                  </td>
                  <td class="small-text">{{ formatDate(leave.startDate) }}</td>
                  <td class="small-text">{{ formatDate(leave.endDate) }}</td>
                  <td class="small-text">{{ calculateTotalDays(leave.startDate, leave.endDate) }} day</td>
                  <td class="small-text">{{ leave.leave_type.leaveType }}</td>
                  <td class="small-text"><button type="button"
                      class="btn btn-danger btn-sm small-button disabled ">Rejected</button></td>
                  <td>
                    <router-link :to="{ name: 'LeaveDetail', params: { id: leave.id } }">
                      <button type="button" class="btn btn-sm border">View</button>
                    </router-link>
                  </td>
                </tr>
                <!-- Add more rows here -->
              </tbody>
            </table>
          </div>
        </div>


      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import PopupModel1 from '../components/reject_repuest.vue';
import Avatar from "vue3-avatar";

export default {
  components: {
    Avatar,
    PopupModel1,

  },
  data() {
    return {
      showPopup1: false,
      leaveRequests: [],
      currentPage: 1,
      loading: false,
      selectedDate: null,
      selectedLeaveType: '',
      leavetypes: [],
    };
  },
  mounted() {
    this.fetchLeaveRequests();
    this.fetchLeaveTypes();
  },
  created() {
    this.$nextTick(() => {
      const dateFilterInput = document.getElementById('date-filter');
      const today = new Date();
      const year = today.getFullYear();
      const month = String(today.getMonth() + 1).padStart(2, '0');
      const day = String(today.getDate()).padStart(2, '0');
      const formattedDate = `${year}-${month}-${day}`;
      dateFilterInput.value = formattedDate;
    });
  },
  watch: {
    selectedLeaveType: async function () {
      await this.fetchLeavesByType(this.selectedLeaveType);
    }
  },
  methods: {
    async fetchLeaveRequests() {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');
        const response = await axios.get('https://hrm-system-test.up.railway.app/api/leave', {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.leaveRequests = response.data.data; // Assign the user data to the component's data property
        console.log(response.data)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    handleDateChange(event) {
      this.selectedDate = event.target.value;
      this.fetchfilterCreateDateLeaves(this.selectedDate);
    },
    async fetchfilterLeaveRequests(type) {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');
        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/leave?isApproved=${type}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.leaveRequests = response.data.data; // Assign the user data to the component's data property
        console.log(this.leaveRequests)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async fetchfilterCreateDateLeaves(date) {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');
        const formattedDate = date.split('-').join(''); // convert yyyy-mm-dd to yyyymmdd
        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/leave?createdDate=${formattedDate}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.leaveRequests = response.data.data; // Assign the user data to the component's data property
        console.log(this.leaveRequests)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async fetchLeavesByType(id) {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/leave?leaveTypeId=${id}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.leaveRequests = response.data.data; // Assign the user data to the component's data property
        console.log(this.leaveRequests)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async fetchLeaveTypes() {
      try {
        const token = localStorage.getItem('token');
        const response = await axios.get('https://hrm-system-test.up.railway.app/api/leave_type', {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        });
        this.leavetypes = response.data.data;
        console.log(this.leavetypes);
      } catch (error) {
        console.error('Error fetching roles:', error);
      }
    },
    formatDate(dateString) {
      const date = new Date(dateString);
      const day = String(date.getDate()).padStart(2, '0');
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const year = date.getFullYear();
      const formattedDate = `${day}-${month}-${year}`;
      return formattedDate;
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
    async rejectAction(leaveId) {
      const token = localStorage.getItem('token');
      const empId = localStorage.getItem('id');
      const requestData = {
        isApproved: false,
        approvedById: empId
      };
      console.log(requestData);
      console.log(leaveId);

      axios.put(`https://hrm-system-test.up.railway.app/api/leave/approve/${leaveId}`, requestData, {
        headers: {
          Authorization: `Bearer ${token}`,
        }
      })
        .then(response => {
          console.log('Request rejected successfully');
          this.refreshPage();
        })
        .catch(error => {
          console.error('Error rejecting request:', error);
        });
    },
    async approveAction(leaveId) {
      const token = localStorage.getItem('token');
      const empId = localStorage.getItem('id');
      const requestData = {
        isApproved: true,
        approvedById: empId
      };
      console.log(requestData);
      console.log(leaveId);

      axios.put(`https://hrm-system-test.up.railway.app/api/leave/approve/${leaveId}`, requestData, {
        headers: {
          Authorization: `Bearer ${token}`,
        }
      })
        .then(response => {
          console.log('Request approved successfully');
          this.refreshPage();
        })
        .catch(error => {
          console.error('Error approving request:', error);
        });
    },
    refreshPage() {
      window.location.reload();
    }
  }
};

</script>



<!-- Add your Bootstrap imports here -->
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';