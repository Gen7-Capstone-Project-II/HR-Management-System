<style scoped>
.container {
  width: 73%;
  background-color: white;
  padding: 20px;
  border-radius: 15px;
  position: absolute;
  left: 61%;
  top: 40%;
  transform: translate(-50%, -50%);
  box-shadow: black;
}

.cardHeader-addnew {
  text-align: center;
  font-weight: 600;
  color: green;
  margin-top: 10px;
}

.form-control {
  border-radius: 0;
  border: none;
  border-bottom: 1px solid #555;
}

.form-select {
  border-radius: 0;
  border: none;
  border-bottom: 1px solid #555;
}

.col-12 {
  text-align: center;
  padding-top: 10px;
}

/* .btn-success {
    
    background-color: #e74c3c;
    border: none;
    text-align: center;
} */

@media only screen and (max-width:600px) {
  .container {
    width: 90%;
    margin-top: 30px;
    position: absolute;
    left: 50%;
    top: 50%;
    padding-bottom: 30px;


  }
}
</style>

<template>
  <div class="container mt-5">
    <form class="row g-3" @submit.prevent="submitForm">
      <div class="cardHeader-addnew">
        <h2>Register</h2>
      </div>
      <div class="col-md-6">
        <label for="inputUserName4" class="form-label">User Name</label>
        <input v-model="formData.name" type="text" class="form-control" id="inputUserName4">
      </div>
      <div class="col-md-6">
        <label for="inputEmail4" class="form-label">Email</label>
        <input v-model="formData.email" type="email" class="form-control" id="inputEmail4">
      </div>
      <div class="col-md-6">
        <label for="inputpassword" class="form-label">Password</label>
        <input v-model="formData.password" type="password" class="form-control" id="inputpassword4">
      </div>
      <div class="col-md-6">
        <label for="confirmPassword" class="form-label">Confirm Password</label>
        <input v-model="formData.password_confirmation" type="password" class="form-control" id="confirmPassword"
          required>
        <p v-if="formData.password !== formData.password_confirmation" class="text-danger">Passwords do not match.</p>
      </div>
      <div class="col-md-4">
        <label for="inputrole" class="form-label">Role</label>
        <select v-model="formData.roles" id="inputrole" class="form-select">
          <option selected disabled>Choose...</option>
          <option v-for="role in roles" :key="role.uuid" :value="role.uuid">{{ role.name }}</option>
        </select>
      </div>
      <div class="col-12">
        <button type="submit" class="btn btn-success">Submit</button>
        <!-- <button type="button" class="btn btn-secondary">Cancel</button> -->
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      formData: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        roles: [], // TODO: make this an array of uuids, not names
      },
      roles: [], 
    };
  },
  mounted() {
    this.fetchRoles(); // Fetch roles when the component is mounted
  },
  methods: {
    fetchRoles() {
      const token = localStorage.getItem('token');
      axios.get('https://hrm-system-test.up.railway.app/api/role_user', {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      })
        .then(response => {
          this.roles = response.data;
          console.log(this.roles);
        })
        .catch(error => {
          console.error('Error fetching roles:', error);
        });
    },

    submitForm() {
      this.formData.roles = [this.formData.roles];

      const token = localStorage.getItem('token');
      axios.post('https://hrm-system-test.up.railway.app/api/users', this.formData, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      })
        .then(response => {
          console.log('Data saved successfully:', response.data);
          this.resetForm();
        })
        .catch(error => {
          console.error('Error saving data:', error);
        })
        .finally(()=>{
          console.log('Form submitted:', this.formData);
        });
    },
    resetForm() {
      this.formData.name = '';
      this.formData.email = '';
      this.formData.password = '';
      this.formData.password_confirmation = '';
      this.formData.roles = [];
    }
  }
};
</script>

