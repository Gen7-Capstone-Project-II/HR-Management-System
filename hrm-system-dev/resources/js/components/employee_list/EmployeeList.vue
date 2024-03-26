<style scoped>
.table-wrapper {
  border-radius: 15px;
  overflow: hidden;
  /* Ensures the border radius is applied */
}

.table-list {
  background-color: white;
  border-collapse: separate;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  border-spacing: 0;
}

.table-wrapper .table-list {
  border-radius: 15px;
  /* Apply the same border radius as the wrapper */
}

.pagination {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: flex-end;
  margin-bottom: 5px;
}

.table-list .cardHeader {
  padding-top: 30px;
}

.cardHeader h2 {
  font-weight: 600;
  color: green;
  margin-top: 10px;
}

.imgBx {
  width: 35px;
  /* Adjust the width and height as needed */
  height: 35px;
  border-radius: 50%;
  /* Makes the image circular */
  overflow: hidden;
  /* Ensures content beyond the border-radius is hidden */
  display: flex;
  justify-content: center;
  /* Center horizontally */
  align-items: center;
  /* Center vertically */
}

.imgBx img {
  width: 100%;
  /* Ensure the image fills the container */
  height: auto;
  /* Maintain aspect ratio */
  object-fit: cover;
  /* Scale the image as large as possible */
}

button {
  display: flex;
  justify-content: center;
  align-items: center;
}

.small-button {
  padding: 0.25rem 0.5rem;
  /* You can adjust the padding values to make it smaller */
  font-size: 0.75rem;
  /* You can adjust the font size to make it smaller */
}

.small-text {
  font-size: 0.9rem;
  /* Adjust the font size as needed */
}

.dialog {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: white;
  padding: 20px;
  border: 1px solid #ccc;
}

.dialog-content {
  text-align: center;
}
</style>

<template>
  <div class="table-wrapper">
    <div class="table-list ps-3 pe-3">
      <dev class="cardHeader">
        <h2>Employee List</h2>
      </dev>
      <table class="table mt-2 table-borderless">
        <thead>
          <tr>
            <th scope="col">ID</th>
            <th scope="col">profile</th>
            <th scope="col">Name</th>
            <th scope="col">Department</th>
            <th scope="col">Position</th>
            <th scope="col">Phone Number</th>
            <th scope="col">Active</th>
            <th scope="col">QR</th>
            <th scope="col">Status</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="employee in employeelists"  :key="employee.id">
            <th scope="row" class="small-text">
              {{ employee.user.idEmp }}
            </th>
            <td>
              <div class="imgBx"><img :src="getEmployeeImageUrl(employee)" alt=""></div>
            </td>
            <td class="small-text">{{ employee.firstName }} {{ employee.lastName }}</td>
            <td class="small-text">{{ employee.department.deptName }}</td>
            <td class="small-text">{{ employee.position.positionName }}</td>
            <td class="small-text">{{  employee.phoneNum1}}</td>
            <td class="small-text">
              <span v-if="employee.status === 1">Active</span>
              <span v-else>Inactive</span></td>
            <td>
              <router-link to="/qrCode">
                <button type="button" class="btn btn-success btn-sm small-button">Qr code</button>
              </router-link>
            </td>
            <td class="small-text">....</td>
          </tr>
          
          <!-- Add more rows here -->
        </tbody>
      </table>
      <nav aria-label="Page navigation example">
        <ul class="pagination">
          <li class="page-item">
            <a class="page-link" href="#" aria-label="Previous">
              <span aria-hidden="true">&laquo;</span>
            </a>
          </li>
          <li class="page-item"><a class="page-link" href="#">1</a></li>
          <li class="page-item"><a class="page-link" href="#">2</a></li>
          <li class="page-item"><a class="page-link" href="#">3</a></li>
          <li class="page-item">
            <a class="page-link" href="#" aria-label="Next">
              <span aria-hidden="true">&raquo;</span>
            </a>
          </li>
        </ul>
      </nav>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      showDialog: false ,
      employeelists: [],// Initially dialog is not shown
      loading:false,
    };
  },
  mounted(){
    console.log("Component mounted");
    this.fetchEmployeeLists();
  },
  methods: {
    openDialog() {
      this.showDialog = true; // Show the dialog
    },
    closeDialog() {
      this.showDialog = false; // Close the dialog
    },
    async fetchEmployeeLists() {
      this.loading=true;
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
      this.loading=false;
    },
    getEmployeeImageUrl(employee) {
      return `https://hrm-system-test.up.railway.app/${employee.attachment}`;
    }
  }
};

</script>


  
  <!-- Add your Bootstrap imports here -->
  import 'bootstrap/dist/css/bootstrap.min.css';
  import 'bootstrap/dist/js/bootstrap.bundle.min.js';