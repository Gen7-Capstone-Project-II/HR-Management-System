<style scoped>
* {
  padding: 0;
  margin: 0;
  box-sizing: border-box;

}

form {
  border-radius: 20px;
  margin-top: 100px !important;
  width: 24% !important;
  background-color: white !important;
  padding: 50px;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
}

.btn-primary {
  padding: 10px;
  width: 100%;
  border: none;
  border-radius: 50px;
  background: linear-gradient(90deg, rgba(0, 108, 81) 0%, rgba(2, 92, 17) 35%, rgba(23, 173, 43) 100%);

}

.form-control {
  color: rgba(0, 0, 0, .87);
  border-bottom-color: rgba(0, 0, 0, .42);
  box-shadow: none !important;
  border: none;
  border-bottom: 1px solid;
  border-radius: 4px 4px 0 0;
}

h4 {
  font-size: 2rem !important;
  font-weight: 700;
}

.form-label {
  font-weight: 800 !important;
}

img {
  margin-top: -70px;
  margin-bottom: -70px;
  width: 100%;
}

@media only screen and (max-width: 600px) {
  form {
    width: 100% !important;
  }
}

.error-message {
  color: red;
}
</style>

<style scoped></style>

<template>
  <div class="container-fluid">
    <form class="mx-auto" id="loginForm" @submit.prevent="login">
      <h4 class="text-center">
        <img src="../../../public/images/logo.png" alt="Logo" />
      </h4>
      <div class="mb-3 mt-5">
        <label for="exampleInputEmail1" class="form-label">Email</label>
        <input type="email" class="form-control" id="exampleInputEmail1" v-model="email" aria-describedby="emailHelp"
          required>
      </div>
      <div class="mb-3">
        <label for="exampleInputPassword1" class="form-label">Password</label>
        <input type="password" class="form-control" id="exampleInputPassword1" v-model="password" required>
        <div id="emailHelp" class="form-text mt-3">Forget password ?</div>
      </div>

      <button type="submit" class="btn btn-primary mt-5">Login</button>
      <div v-if="error" class="error-message">{{ error }}</div>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import '@fortawesome/fontawesome-free/css/all.css';

export default {
  data() {
    return {
      email: '',
      password: '',
      error: null
    };
  },
  mounted() {
    this.checkRoute();
  },
  methods: {
    login() {
      axios.post('https://hrm-system-test.up.railway.app/api/login', {
        email: this.email,
        password: this.password
      })
        .then(response => {
          // Assuming Laravel returns a token upon successful login
          const token = response.data.token;
          const empId = response.data.user.id;
          // Store the token in local storage
          localStorage.setItem('token', token);
          localStorage.setItem('id', empId);

          console.log(token);
          console.log(empId);
          // Redirect to dashboard
          this.$router.push('/dashboardV2');
        })
        .catch(error => {
          console.error('Login failed:', error);
          // Handle login error
          this.error = 'Invalid email or password';
        });
    },
    checkRoute() {
      if (localStorage.getItem('token') !== null) {
        this.$router.push('/dashboardV2');
      } else {
        console.log('Not loggin yet')
      }
    },
  }

}
</script>



<!-- Add your Bootstrap imports here -->



<!-- Add your Bootstrap imports here -->