<style scoped>
/* =========== Google Fonts ============ */
@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');

/* =============== Globals ============== */
* {
  font-family: 'Roboto', sans-serif;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}


body {
  min-height: 100vh;
  overflow-x: hidden;
}

.container {
  /* position: relative; */
  position: static;
  width: 100%;
}

/* =============== Navigation ================ */
.navigation {
  position: fixed;
  width: 230px;
  height: 100%;
  background: rgb(0, 108, 81);
  border-left: 10px solid rgb(0, 108, 81);
  transition: 0.5s;
  overflow: hidden;
}

.navigation.active {
  width: 75px;
}

.navigation ul {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
}

.navigation ul li {
  position: relative;
  width: 100%;
  list-style: none;
  border-top-left-radius: 5px;
  border-bottom-left-radius: 5px;
}

/* .navigation ul li:hover,
.navigation ul li.hovered {
  background-color: white;
} */

.navigation ul li.active {
  background-color: white;
}

.navigation ul li:nth-child(1) {
  margin-bottom: 5px;
  pointer-events: none;
}

.navigation ul li a {
  position: relative;
  display: block;
  width: 100%;
  display: flex;
  text-decoration: none;
  color: white;
}


.navigation ul li.active a {
  color: rgb(0, 108, 81);
}

.navigation ul li a .icon {
  position: relative;
  display: block;
  min-width: 60px;
  height: 60px;
  line-height: 60px;
  text-align: center;
}

.navigation ul li a .icon i {
  font-size: 1rem;
}

.navigation ul li a .icon img {
  width: 80px;
  /* Set the width of the image */
  height: 80px;
  /* Set the height of the image */
  margin-top: -24px;
}

.navigation ul li a .title {
  position: relative;
  display: block;
  padding: 0 5px;
  height: 60px;
  line-height: 60px;
  text-align: start;
  white-space: nowrap;
}

/* --------- curve outside ---------- */

.navigation ul li.active a::before {
  content: "";
  position: absolute;
  right: 0;
  top: -50px;
  width: 30px;
  height: 50px;
  background-color: transparent;
  border-radius: 18%;
  box-shadow: 35px 35px 0 10px white;
  pointer-events: none;
}


.navigation ul li.active a::after {
  content: "";
  position: absolute;
  right: 0;
  bottom: -50px;
  width: 30px;
  height: 50px;
  background-color: transparent;
  border-radius: 18%;
  box-shadow: 35px -35px 0 10px white;
  pointer-events: none;
}

/* ===================== Main ===================== */
.main {
  position: absolute;
  width: calc(100% - 230px);
  left: 230px;
  min-height: 100vh;
  background: white;
  transition: 0.5s;
}

.main.active {
  width: calc(100% - 75px);
  left: 75px;
}

.topbar {
  width: 100%;
  height: 45px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  position: sticky;
  top: 0;
  z-index: 1;
  background-color: white;
  font-size: 0.9rem;
  z-index: 1000;
}

.toggle {
  position: relative;
  width: 50px;
  height: 50px;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 1.5rem;
  cursor: pointer;
}


.user {
  position: relative;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  overflow: hidden;
  cursor: pointer;
  margin-right: 15px;
}

.user img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.link-class {
  text-decoration: none;
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

.dropdown-toggle .caret {
  display: inline-block;
  vertical-align: middle;
  margin-left: 5px;
  margin-top: 3px;
  border-top: 4px solid;
  border-right: 4px solid transparent;
  border-left: 4px solid transparent;
  border-radius: 0;
  transition: transform .2s;
}

.dropdown-menu {
  margin-top: 0;
  border-radius: 0;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
}

.dropdown-menu li {
  padding: 5px 10px;
}

.dropdown-menu li:hover {
  background-color: #f5f5f5;
}

.user-singout {
  display: flex;
}
</style>

<template>
  <!-- =============== Navigation ================ -->
  <div class="container">
    <div class="navigation">
      <ul>
        <li>
          <a href="#">
            <span class="icon">
              <img src="../../../public/images/logoV2.png" alt="logo Image" class="logo-img">
            </span>
            <!-- <span class="title">System</span> -->
          </a>
        </li>

        <li>
          <a href="#">
            <router-link to="/dashboardV2">
              <span class="icon">
                <i class="fa-solid fa-house"></i>
              </span>
              <span class="title">Dashboard</span>
            </router-link>
          </a>
        </li>

        <li>
          <a href="#">
            <router-link to="/EmployeeV2">
              <span class="icon">
                <i class="fa-solid fa-user"></i>
              </span>
              <span class="title">Employee</span>
            </router-link>
          </a>
        </li>

        <li>
          <a href="#">
            <router-link to="/attendance_list">
              <span class="icon">
                <i class="fa-solid fa-clipboard-user"></i>
              </span>
              <span class="title">Attendance</span>
            </router-link>
          </a>
        </li>

        <li>
          <a href="#">
            <router-link to="/leaveRequestV2">
              <span class="icon">
                <i class="fa-solid fa-code-pull-request"></i>
              </span>
              <span class="title">Leave Request</span>
            </router-link>
          </a>
        </li>

        <li>
          <a href="#">
            <router-link to="/overtime">
              <span class="icon">
                <i class="fa-regular fa-clock"></i>
              </span>
              <span class="title">Overtime</span>
            </router-link>
          </a>
        </li>
        <li>
          <a href="#">
            <router-link to="/mission">
              <span class="icon">
                <i class="fa-solid fa-bullseye"></i>
              </span>
              <span class="title">Mission</span>
            </router-link>
          </a>
        </li>

        <li>
          <a href="#">
            <router-link to="/announcement">
              <span class="icon">
                <i class="fa-solid fa-bullhorn"></i>
              </span>
              <span class="title">Announcement</span>
            </router-link>
          </a>
        </li>
        <li>
          <a href="#">
            <router-link to="/setting">
              <span class="icon">
                <i class="fa-solid fa-gear"></i>
              </span>
              <span class="title">Setting</span>
            </router-link>
          </a>
        </li>
      </ul>
    </div>
    <!-- ========================= Main ==================== -->
    <div class="main">
      <div class="topbar" style="background-color: white">
        <div class="toggle">
          <i class="fa-solid fa-bars "></i>
        </div>
        <div class="user-singout">
          <div v-if="employee" class="btn-group">
            <button type="button" class="btn border-0" data-bs-toggle="dropdown" aria-expanded="false">
              <avatar :size="45" :name="`${employee.name}`"></avatar>
            </button>
            <ul class="dropdown-menu rounded" style="width: 20px;">

              <li><a class="dropdown-item" @click="navigateToEmployeeDetail">Profile</a></li>

              <li>
                <hr class="dropdown-divider">
              </li>
              <li><a class="dropdown-item" @click="logout">Sign Out</a></li>
            </ul>
          </div>
        </div>
      </div>


      <!-- ======================= Cards ================== -->
      <router-view></router-view>

    </div>
  </div>

</template>


<script>
import axios from 'axios';
import Avatar from "vue3-avatar";
export default {
  components: { Avatar },
  data(){
    return {
      employee: null
    }
  },
  mounted() {
    this.getEmployee();
    this.checkRoute();

    const list = document.querySelectorAll(".navigation li");

    const activeLink = () => {
      list.forEach((item) => {
        item.classList.remove("hovered");
      });
      this.classList.add("hovered");
    };

    list.forEach((item) => item.addEventListener("mouseover", activeLink));

    const toggle = document.querySelector(".toggle");
    const navigation = document.querySelector(".navigation");
    const main = document.querySelector(".main");

    toggle.onclick = function () {
      navigation.classList.toggle("active");
      main.classList.toggle("active");
    };

    // Add event listener to each menu item
    list.forEach(item => {
      item.addEventListener('click', () => {
        // Remove 'active' class from all menu items
        list.forEach(li => li.classList.remove('active'));
        // Add 'active' class to the clicked menu item
        item.classList.add('active');
      });
    });
  },
  methods: {
    async getEmployee() {
      
      try {
        // Get the employee ID from the query parameters
        const empId = localStorage.getItem('id');
        console.log(empId);
        const token = localStorage.getItem('token');

        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/users/${empId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.employee = response.data; // Assign the user data to the component's data property
        console.log(this.employee);
      } catch (error) {
        console.error(error);
      }
    },
    logout() {
      localStorage.removeItem('token');
      this.$router.push('/');
    },
    checkRoute() {
      if (localStorage.getItem('token') == null) {
        this.$router.push('/');
      } else {
        console.log('User logged in');
      }
    },
    navigateToEmployeeDetail() {
      const employeeId = localStorage.getItem('id');
      this.$router.push({ path: `/employeedetail/${employeeId}`, });
      console.log(employeeId);
    }
  }
};
</script>
