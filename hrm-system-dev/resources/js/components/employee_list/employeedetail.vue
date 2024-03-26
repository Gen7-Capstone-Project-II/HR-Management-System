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

.profile-container {
  overflow-x: hidden;
}

.card {
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  /* Adjust the shadow properties as needed */
  border-radius: 5px;
}

.cardHeader h4 {

  color: rgb(0, 108, 81);
}

.cardHeader i {

  color: rgb(0, 108, 81);
}

.other-infor {
  background-color: rgb(0, 108, 81);
  color: white;
}

.table-wrapper {
  padding: 20px;
}

.link-class {
  text-decoration: none;
}

/* emergency contact */
.title-1 {
  display: block !important;
  width: 100%;
}

.title-2 {
  display: block !important;
  width: 100%;
}

.decription-1 {
  display: block !important;
  width: 100%;
}

.decription-2 {
  display: block !important;
  width: 100%;
}

.card-title {
  color: rgb(0, 108, 81);
  border-bottom: 3px solid rgb(0, 108, 81);
  /* You can adjust the color and thickness of the line as needed */
  padding-bottom: 5px;
  /* Optional: Add some space between the text and the line */
}
</style>

<template>
  <div v-if="loading" class="d-flex justify-content-center align-items-center text-center" style="height: 80vh;">
    <div class="spinner-border text-secondary " style="width: 3.5rem; height: 3.5rem;" role="status">
      <span class="visually-hidden">Loading...</span>
    </div>
  </div>
  <div v-else class="table-wrapper">
    <div v-if="employee">
      <!-- Profile Section -->
      <div class="card border-0">
        <div class="cardHeader pt-3 ">
          <div class=" row g-0">
            <div class="col-auto">
              <div @click="closeScreen" class="link-class">
                <button class="btn border-0 d-flex justify-content-center align-items-center"><i
                    class="fa-solid fa-arrow-left"></i></button>
              </div>
            </div>
            <div class="col">
              <h4>Employee Information</h4>
            </div>
          </div>
        </div>
        <div class="card-body">
          <router-link :to="{ name: 'EditEmployeeDetail', params: { id: employee.userId } }">
            <button class="btn position-absolute border-0 top-0 end-0"><i class="far fa-edit"></i></button>
          </router-link>
          <div class="row col-md-12 ps-5 d-flex justify-content-center align-items-center">
            <div class="col-md-3 justify-content-center align-items-center">
              <avatar :size="180" :name="`${employee.firstName} ${employee.lastName}`"></avatar>
              <button class="btn btn-primary" @click="openDialogQr(employee)" style="margin-left: 40px;">Scan To Login</button>
              
              <!-- <img :src="getEmployeeImageUrl(employee)" alt="Profile Picture" class="img-fluid rounded-circle"> -->
            </div>
            <div class="col-md-9">
              <div class="row d-flex justify-content-center align-items-center">
                <div class="col-md-5">
                  <p class="card-text border-bottom pb-1 mb-0"><strong>User ID</strong>
                  <p>{{ employee.user?.idEmp }}</p>
                  </p>
                  <p class="card-text border-bottom pb-1 mb-0"><strong>User Name</strong>
                  <p>{{ employee.firstName }} {{ employee.lastName }}</p>
                  </p>
                  <p class="card-text"><strong>Khmer Name</strong>
                  <p>{{ employee.firstNameKH }} {{ employee.lastNameKH }}</p>
                  </p>
                </div>
                <div class="col-md-4">
                  <p class="card-text border-bottom pb-1 mb-0"><strong>Gender</strong>
                  <p>{{ employee.gender }}</p>
                  </p>
                  <p class="card-text border-bottom pb-1 mb-0"><strong>Birth Date</strong>
                  <p>{{ employee.birthDate }}</p>
                  </p>
                  <p class="card-text"><strong>Phone Number</strong>
                  <p>{{ employee.phoneNum1 }}</p>
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div class="other pt-4">
            <div class="other-infor p-2">
              <div class="info-title fw-bold">Other Information</div>
            </div>
          </div>
          <div class="col-md-12 ps-5 pt-3 other-infor-center">
            <div class="row d-flex justify-content-center align-items-center">
              <div class="col-md-4">
                <p class="card-text border-bottom pb-1 mb-0"><strong>Position</strong>
                <p>{{ employee.position?.positionName }} </p>
                </p>
                <p class="card-text"><strong>Department</strong>
                <p>{{ employee.department?.deptName }} </p>
                </p>
              </div>
              <div class="col-md-4">
                <p class="card-text border-bottom pb-1 mb-0"><strong>Address</strong>
                <p>{{ employee.address }}</p>
                </p>
                <p class="card-text"><strong>Telegram</strong>
                <p>{{ employee.telegram }}</p>
                </p>
              </div>
              <div class="col-md-4">
                <p class="card-text border-bottom pb-1 mb-0"><strong>Employee Date</strong>
                <p>{{ employee.employeeDate }}</p>
                </p>
                <p class="card-text"><strong>Active</strong>
                <p><i class="fa-solid fa-check" style="color:rgb(0, 108, 81);"></i></p>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- User's Posts Section -->
      <div class="card mt-3 border-0">
        <div class="card-body">
          <h4 class="card-title pb-3" style="color: rgb(0, 108, 81);">My Emergency Contacts</h4>
          <div v-for="(emergencyContact, index) in emergencyContacts" :key="emergencyContact.id" class="pt-4">
            <div class="d-flex align-items-center justify-content-between ">
              <div style="color: rgb(0, 108, 81);">
                <h5 class="mr-auto">Emergency Contact #{{ index + 1 }}</h5>
              </div>
              <div>
                <router-link :to="{ name: 'EditEmergencyContact', params: { id: emergencyContact.id } }"
                  class="link-class">
                  <button class="btn border-0"><i class="far fa-edit"></i></button>
                </router-link>
              </div>
            </div>
            <div>
              <div class="border-bottom d-flex justify-content-around">
                <div class="title d-flex justify-content-around w-100">
                  <div class="title-1">
                    <strong>Name:</strong>
                  </div>
                  <div class="decription-1">
                    <p>{{ emergencyContact.firstname }} {{ emergencyContact.lastname }}</p>
                  </div>
                </div>
                <div class="title d-flex justify-content-around w-100">
                  <div class="title-2">
                    <strong>Name(KH):</strong>
                  </div>
                  <div class="decription-2">
                    <p>{{ emergencyContact.firstnameKM }} {{ emergencyContact.lastnameKM }}</p>
                  </div>
                </div>
              </div>
              <div class="border-bottom d-flex justify-content-around pt-2 ">
                <div class="title d-flex justify-content-around w-100">
                  <div class="title-1">
                    <strong>Gender:</strong>
                  </div>
                  <div class="decription-1">
                    <p>
                    <p>{{ emergencyContact.gender }}</p>
                    </p>
                  </div>
                </div>
                <div class="title d-flex justify-content-around w-100">
                  <div class="title-2">
                    <strong>Relative:</strong>
                  </div>
                  <div class="decription-2">
                    <p>{{ emergencyContact.relative.relativeName }}</p>
                  </div>
                </div>
              </div>
              <div class="border-bottom d-flex justify-content-around pt-2 ">
                <div class="title d-flex justify-content-around w-100">
                  <div class="title-2">
                    <strong>Phone Number 1:</strong>
                  </div>
                  <div class="decription-2">
                    <p>{{ emergencyContact.phoneNum1 }}</p>
                  </div>
                </div>
                <div class="title d-flex justify-content-around w-100">
                  <div class="title-2">
                    <strong>Phone Number 2:</strong>
                  </div>
                  <div class="decription-2">
                    <p>{{ emergencyContact.phoneNum2 }}</p>
                  </div>
                </div>
              </div>
              <div class="border-bottom d-flex justify-content-around pt-2 ">
                <div class="title d-flex justify-content-around w-100">
                  <div class="title-1">
                    <strong>Email:</strong>
                  </div>
                  <div class="decription-1">
                    <p>{{ emergencyContact.email }}</p>
                  </div>
                </div>
                <div class="title d-flex justify-content-around w-100">
                  <div class="title-2">
                    <strong>Telegram Contact:</strong>
                  </div>
                  <div class="decription-2">
                    <p>{{ emergencyContact.telegram }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
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
            <h5 class="px-2">{{ employeeQr.firstName }} {{ employeeQr.lastName }}</h5>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import axios from 'axios';
import Avatar from "vue3-avatar";
import QrcodeVue from "vue-qrcode";

export default {
  components: {
    Avatar,
    QrcodeVue,
  },
  data() {
    return {
      employee: null,
      loading: false,
      emergencyContacts: [],

      showQr: false,
      loadingQr: false,
      employeeQr: [],
      qrCodeValue: "",
    };
  },
  mounted() {
    console.log("Component mounted");
    this.getEmployee();
    this.getEmergencyContact();
  },
  methods: {
    openDialogQr(employeeList) {
      this.showQr = true;
      this.employeeQr = employeeList;
      this.generateQRCode(this.employeeQr.user_id);
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
    async getEmployee() {
      this.loading = true;
      try {
        // Get the employee ID from the query parameters
        const userId = this.$route.params.id;
        console.log(userId);
        const token = localStorage.getItem('token');

        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/employee_detail/${userId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.employee = response.data.data; // Assign the user data to the component's data property
        console.log(response.data.data);
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async getEmergencyContact() {
      this.loading = true;
      try {
        // Get the employee ID from the query parameters
        const userId = this.$route.params.id;
        console.log(userId);
        const token = localStorage.getItem('token');

        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/emergencycontact/${userId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.emergencyContacts = response.data.data; // Assign the user data to the component's data property
        console.log(response.data.data);
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    closeScreen() {
      this.$router.go(-1);
    },
    getEmployeeImageUrl(employee) {
      return `https://hrm-system-test.up.railway.app/${employee.attachment}`;
    },
  }
};

</script>



<!-- Add your Bootstrap imports here -->
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';