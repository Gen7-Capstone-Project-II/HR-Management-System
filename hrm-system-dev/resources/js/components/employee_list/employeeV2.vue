<style scoped>
.cardBox {
  position: relative;
  width: 100%;
  padding: 20px;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-gap: 20px;
}

.cardBox .card {
  position: relative;
  background: rgb(255, 255, 255);
  padding: 10px;
  border-radius: 5px;
  display: flex;
  justify-content: space-between;
  cursor: pointer;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
}

.user img {
  position: relative;
  width: 60px;
  height: 60px;
  border-radius: 50%;
  overflow: hidden;
  cursor: pointer;
}

.cardHeader h4 {
  padding-left: 30px;

  color: rgb(0, 108, 81);
}

.link-class {
  text-decoration: none;
}

.nowrap {
  white-space: nowrap;
}

/* ====================== Responsive Design ========================== */
@media (max-width: 991px) {
  .navigation {
    left: -230px;
  }

  .navigation.active {
    width: 230px;
    left: 0;
  }

  .main {
    width: 100%;
    left: 0;
  }

  .main.active {
    left: 230px;
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

  .cardHeader h4 {
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

  <div class="d-flex justify-content-between align-items-center pe-4 pt-5 pb-2">
    <dev class="cardHeader">
      <h4>Employee Lists</h4>
    </dev>
    <div>
      <button type="button" class="btn btn-primary me-3" @click="addEmployee" style="border-radius: 5px;">Add Employee</button>
      <button type="button" class="btn btn-success" @click="exportCSV" style="border-radius: 5px;">Export</button>
    </div>
  </div>
  <div class=" mx-4 rounded-3 " style="height: 100px; background-color: #F5F5F5;">
    <div class="d-flex justify-content-evenly">
      <div class="col-md-4 mt-3">
        <label for="typeFilter" class="form-label">Departments</label>
        <select class="form-select" v-model="selectedDepartment" placeholder=" ">
          <option selected disabled>Choose...</option>
          <option v-for="department in departments" :key="department.id" :value="department.id">
            {{ department.deptName }}
          </option>
        </select>
      </div>
      <div class="col-md-4 m-3">
        <label for="typeFilter" class="form-label">Positions</label>
        <select class="form-select" v-model="selectedPosition" placeholder="">
          <option selected disabled>Choose...</option>
          <option v-for="position in positions" :key="position.id" :value="position.id">
            {{ position.positionName }}
          </option>
        </select>
      </div>
    </div>
  </div>
  <div v-if="loading" class="d-flex justify-content-center align-items-center text-center" style="height: 80vh;">
    <div class="spinner-border text-secondary " style="width: 3.5rem; height: 3.5rem;" role="status">
      <span class="visually-hidden">Loading...</span>
    </div>
  </div>
  <div v-else class="cardBox">
    <div class="card" style="border: none;" v-for="employee in employeelists" :key="employee.id">
      <router-link :to="{ name: 'EmployeeDetail', params: { id: employee.user_id } }" class="link-class">
        <div class="card-body">
          <div class="user">
            <avatar :size="85" :name="`${employee.firstName} ${employee.lastName}`"></avatar>
            <!-- <img :src="getEmployeeImageUrl(employee)" alt=""> -->
          </div>
          <h5 class="card-title" style="padding-top: 5px;color:rgb(0, 108, 81);">{{ employee.firstName }} {{
              employee.lastName }}</h5>
          <h6 class="card-subtitle mb-2 text-muted">{{ employee.position.positionName }}</h6>
          <div class="card small-card" style="background-color: white; border: none; padding: 5px;">
            <div class="card-body">
              <div class="row">
                <div class="d-flex justify-content-between ">
                  <div class="col-md-6">
                    <p class="card-subtitle mb-2" style="color: rgb(0, 108, 81);">Department</p>
                    <p class="card-text">{{ employee.department.deptName }}</p>
                  </div>
                  <div class="col-md-6 mx-5">
                    <p class="card-subtitle mb-2" style="color: rgb(0, 108, 81);">Start Date</p>
                    <p class="card-text">{{ employee.employeeDate }}</p>
                  </div>
                </div>
                <p class="card-text" style="padding-top: 10px;"><i class="fa-solid fa-envelope"></i> <a
                    href="mailto:{{ employee.user.email }}"> {{ employee.user.email }}</a></p>
                <p class="card-text"><i class="fa-solid fa-phone"></i> (+855) {{ employee.phoneNum1 }}</p>
              </div>
            </div>
          </div>
        </div>
      </router-link>
      <div class="dropdown position-absolute top-0 end-0" style="padding-right: 15px; padding-top: 15px;">
        <button class="btn border-0 " type="button" id="dropdownMenuButton" data-bs-toggle="dropdown"
          aria-expanded="false">
          <i class="fa-solid fa-ellipsis"></i>
        </button>
        <ul class="dropdown-menu rounded dropdown-menu-end border-0" aria-labelledby="dropdownMenuButton"
          style="box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);">
          <router-link :to="{ name: 'EditEmployeeDetail', params: { id: employee.user_id } }"
            class="link-class d-flex mx-2">
            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
              class="bi bi-pencil-square text-primary " viewBox="0 0 16 16">
              <path
                d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
              <path fill-rule="evenodd"
                d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
            </svg>
            <p class="mx-2 h5">Edit</p>
          </router-link>
          <div class="pt-1 mt-1 bg-secondary "></div>
          <div @click="confirmDelete(employee.id)" class="d-flex mx-2 mt-2">
            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-trash text-danger "
              viewBox="0 0 16 16">
              <path
                d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z" />
              <path
                d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z" />
            </svg>
            <p class="mx-2 h5">Delete</p>
          </div>
        </ul>
      </div>
    </div>
  </div>
</template>


<script>
import axios from 'axios';
import Avatar from "vue3-avatar";
import Swal from 'sweetalert2';
import Papa from "papaparse";

export default {
  components: {
    Avatar,
  },
  data() {
    return {
      showDialog: false,
      employeelists: [],// Initially dialog is not shown
      loading: false,
      headers: [],
      departments: [],
      positions: [],
      selectedDepartment: '',
      selectedPosition: ''
    };
  },
  mounted() {
    console.log("Component mounted");
    this.fetchEmployeeLists();
    this.fetchDepartments();
    this.fetchPositions();
  },
  watch: {
    selectedDepartment: async function () {
      await this.fetchEmployeeListswithDepartment(this.selectedDepartment);
    },
    selectedPosition: async function () {
      await this.fetchEmployeeListswithPosition(this.selectedPosition);
    }
  },
  methods: {
    addEmployee() {
      this.$router.push({ path: '/add_employee' });
    },
    openDialog() {
      this.showDialog = true; // Show the dialog
    },
    closeDialog() {
      this.showDialog = false; // Close the dialog
    },
    async fetchDepartments() {
      try {
        const token = localStorage.getItem('token');
        const response = await axios.get('https://hrm-system-test.up.railway.app/api/department', {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        });
        this.departments = response.data.data;
        // this.newEmployee.dept_id = '';
        console.log(this.departments);
      } catch (error) {
        console.error('Error fetching roles:', error);
      }

    },
    async fetchPositions() {
      try {
        const token = localStorage.getItem('token');
        const response = await axios.get('https://hrm-system-test.up.railway.app/api/position', {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        });
        this.positions = response.data.data;
        console.log(this.positions);
      } catch (error) {
        console.error('Error fetching roles:', error);
      }
    },
    async fetchEmployeeLists() {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get('https://hrm-system-test.up.railway.app/api/employee_detail', {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.employeelists = response.data.data; // Assign the user data to the component's data property
        console.log(response.data)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async fetchEmployeeListswithDepartment(id) {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/employee_detail?department_id=${id}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.employeelists = response.data.data; // Assign the user data to the component's data property
        console.log(response.data)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async fetchEmployeeListswithPosition(id) {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/employee_detail?position_id=${id}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.employeelists = response.data.data; // Assign the user data to the component's data property
        console.log(response.data)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async deleteEmployee(employeeId) {
      try {
        const token = localStorage.getItem('token');
        await axios.delete(`https://hrm-system-test.up.railway.app/api/employee_detail/${employeeId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });

      } catch (error) {
        console.error(error);
      }
    },
    getEmployeeImageUrl(employee) {
      return `https://hrm-system-test.up.railway.app/${employee.attachment}`;
    },
    navigateToEmployeeDetail(employeeId) {
      this.$router.push({ path: '/employeedetail', query: { id: employeeId } });
      console.log(employeeId);
    },
    async confirmDelete(employeId) {
      try {
        const result = await Swal.fire({
          title: 'Are you sure?',
          text: 'You won\'t be able to revert this!',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#d33',
          cancelButtonColor: '#3085d6',
          confirmButtonText: 'Yes, delete it!',
          reverseButtons: true
        });

        if (result.isConfirmed) {
          await this.deleteEmployee(employeId);
          Swal.fire({
            title: 'Deleted!',
            text: 'Employee has been deleted.',
            icon: 'success'
          }).then(() => {
            this.fetchEmployeeLists();
          });
        }
      } catch (error) {
        console.error(error);
      }
    },
    exportCSV() {
      const employeeData = this.employeelists.map((employee) => ({
        ID:`${employee.user?.idEmp}`,
        Position: employee.position.positionName,
        Department: employee.department.deptName,
        PhoneNumber: employee.phoneNum1,
        Name: employee.firstName + employee.lastName,
        NameKH: `${employee.firstNameKH} ${employee.lastNameKH}`,
        Birtdate: employee.birthDate,
        Age: employee.age,
        Gender: employee.gender,
        Address: employee.address,
        phoneNum1: employee.phoneNum1,
        phoneNum2: employee.phoneNum2,
        Telegram: employee.telegram,
      }));
      // const employeeData = this.employeelists;

      this.employeelists = employeeData;
      const csv = '\uFEFF' + Papa.unparse(employeeData); // Adding BOM
      const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });

      const link = document.createElement("a");
      link.href = URL.createObjectURL(blob);
      link.download = "employee_data.csv";
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);

    },
  }
};

</script>



<!-- Add your Bootstrap imports here -->
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';