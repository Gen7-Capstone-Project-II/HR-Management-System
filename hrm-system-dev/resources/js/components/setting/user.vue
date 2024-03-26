<style scoped>
.popup {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}

.popup-content {
  background-color: white;
  padding: 20px;
  border-radius: 15px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
  width: 40%;
  display: flex;
  justify-content: center;
  /* Center the form horizontally */
  align-items: center;
  /* Center the form vertically */
  z-index: 10000;
}

.table-wrapper {
  padding: 20px;
}

.table-list {
  background-color: white;
  border-radius: 10px;
  border-collapse: separate;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.pagination {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: flex-end;
  margin-bottom: 5px;
}

.container {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 1px;
}

h3 {
  margin-top: 5px;
}

.button-addnew {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-left: 120vh;
  /* margin-top: 5px; */
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

.table-list .cardHeader {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding-right: 20px;
  padding-top: 10px;
}

.cardHeader .btn {
  color: rgb(0, 108, 81);
}

.cardHeader h4 {
  /* padding-left: 15px;
  padding-top: 20px; */
  color: rgb(0, 108, 81);
}

.link-class {
  text-decoration: none;
}

.cardHeader .btn-create {
  position: relative;
  padding: 5px 10px;
  background: rgb(0, 108, 81);
  text-decoration: none;
  color: white;
  border-radius: 6px;
}

.spinner-border {
  width: 3rem;
  height: 3rem;
}
</style>

<template>
  <div class="table-wrapper">
    <div class="table-list ps-3 pe-3">
      <div class="cardHeader ">
        <div class="row g-0">
          <div class="col-auto">
            <div @click="closePage" class="link-class">
              <button class="btn border-0 d-flex justify-content-center align-items-center"><i
                  class="fa-solid fa-arrow-left"></i></button>
            </div>
          </div>
          <div class="col">
            <h4>Employee Information</h4>
          </div>
        </div>
        <div>
          <a href="#" class="btn-create" @click="addEmployee">Create User</a>
          <!-- <PopupModel2 v-if="showPopup2" @closePopup2="showPopup2 = false"></PopupModel2> -->
        </div>
      </div>
      <table class="table mt-2 table-borderless">
        <thead>
          <tr>
            <th scope="col">ID</th>
            <th scope="col">Name</th>
            <th scope="col">Email</th>
            <th scope="col">Role</th>
            <!-- <th scope="col">Password</th> -->
            <th scope="col">QR Code</th>
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
          <tr v-for="user in users" :key="user.id">
            <th scope="row" class="small-text">{{ user.idEmp }}</th>
            <td class="small-text">{{ user.name }}</td>
            <td class="small-text">{{ user.email }}</td>
            <td class="small-text">
              <template v-for="role in user.roles" :key="role.uuid">
                {{ role.name }}
              </template>
            </td>
            <!-- <td class="small-text">.......</td> -->
            <td>
              <button type="button" class="btn btn-success btn-sm small-button" @click="openDialogQr(user)">QR
                Code</button>
            </td>
            <td v-if="user.employee_details !== null">
              <button type="button" class="btn btn-secondary btn-sm small-button px-3" style="margin-right: 5px;">Added
                To
                Employee</button>
              <button type="button" class="btn btn-danger btn-sm small-button"
                @click="confirmDelete(user.id)">Delete</button>
            </td>
            <td v-else>
              <router-link :to="{ name: 'AddNewEmplyeeList', params: { id: user.id } }">
                <button type="button" class="btn text- btn-success btn-sm small-button px-4"
                  style="margin-right: 5px;">Add To
                  Employee</button>
              </router-link>
              <button type="button" class="btn btn-danger btn-sm small-button"
                @click="confirmDelete(user.id)">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <div class="popup" v-if="showQr">
    <div class="" style="width: 40%;">
      <div class="bg-white rounded-top-3 ">
        <div class="card-header rounded-top-3  pt-2" style="background-color: rgb(0, 108, 81);">
          <div class="text-end ">
            <button type="button" @click="closeDialogQr" class="btn btn-danger mb-2 px-4 me-4">Close</button>
          </div>
        </div>
        <div class="row">
          <div class="text-center pt-4">
            <h2>Scan Qr Code To Login</h2>
          </div>
          <div>
            <div v-if="loadingQr" class="text-center">
              <div class="spinner-border" role="status">
                <span class="visually-hidden">Loading...</span>
              </div>
            </div>
            <div v-else class="text-center">
              <qrcode-vue v-if="qrCodeValue" :value="qrCodeValue" :errorCorrectionLevel="'M'" :size="400"
                :bgColor="'#FFFFFF'" :fgColor="'#000000'"></qrcode-vue>
            </div>
          </div>
          <div class="d-flex justify-content-center mt-3 mb-4">
            <h5 class="text-secondary ">Employee Name:</h5>
            <h5 class="px-2">{{ employeeQr.name }}</h5>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
import Swal from 'sweetalert2';
import QrcodeVue from "vue-qrcode";

export default {
  components: {
    QrcodeVue,
  },
  data() {
    return {
      users: [], // Store the user data
      showPopup1: false,
      showPopup2: false,
      loading: false,
      // showPopup3: false
      showQr: false,
      loadingQr: false,
      employeeQr: [],
      qrCodeValue: "",
    };
  },
  mounted() {
    console.log("Component mounted");
    this.fetchUsers(); // Fetch the user data when the component is mounted
  },
  methods: {
    addEmployee() {
      this.$router.push({ path: '/add_employee' });
    },
    openDialogQr(employeeList) {
      this.showQr = true;
      this.employeeQr = employeeList;
      this.generateQRCode(this.employeeQr.id);
      console.log(this.employeeQr);
    },
    closeDialogQr() {
      this.showQr = false;
      this.qrCodeValue = "";
    },
    async generateQRCode(id) {
      this.loadingQr = true;
      try {
        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/show/${this.employeeQr.user_id}`);// Assuming this is the correct API endpoint to generate QR code based on user ID
        this.qrCodeValue = JSON.stringify(response.data);
        console.log(this.qrCodeValue);
      } catch (error) {
        console.error("Error fetching QR code data:", error);
      }
      this.loadingQr = false;
    },
    async fetchUsers() {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get('https://hrm-system-test.up.railway.app/api/users', {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.users = response.data.data; // Assign the user data to the component's data property
        console.log(response.data)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async removeUser(userId) {
      try {
        const token = localStorage.getItem('token');

        await axios.delete(`https://hrm-system-test.up.railway.app/api/users/${userId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
      } catch (error) {
        console.error(error);
      }
    },
    async confirmDelete(userId) {
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
          await this.removeUser(userId).then(() => {
            this.fetchUsers();
            Swal.fire({
              title: 'Deleted!',
              text: 'Employee has been Deleted.',
              icon: 'success'
            });
          });
        }
      } catch (error) {
        console.error(error);
      }
    },
    // openQrCodePopup(userId) {
    //   this.showPopup1 = true;
    //   this.userId = userId;
    // },
    navigateToEmployeeDetail(employeeId) {
      this.$router.push({ path: '/addnew_employeelist', query: { id: employeeId } });
      console.log(employeeId);
    },
    closePage() {
      this.$router.go(-1);
    }
  },
};
</script>
