<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');
* {
  box-sizing: border-box;
  font-family: 'Ubuntu', sans-serif;
}


/* navigationbar */
.navbar {
  background-color: white;
  height: 7vh;
  width: 100%;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  color: black;
}

.logo-img {
  width: 10%;
}

.profile-img {
  width: 35px;
  /* Adjust the width and height as needed */
  height: 35px;
  border-radius: 50%;
  /* Makes the image circular */
  overflow: hidden;
  /* Ensures content beyond the border-radius is hidden */
}

a {
  cursor: pointer;
  text-decoration: none;
  font-family: 'Poppins', sans-serif;
}

li {
  list-style: none;
}

h4 {
  font-family: 'Poppins', sans-serif;
  font-size: 1.275rem;
  color: black;
}


.sidebar-nav {
  flex-grow: 1;
  list-style: none;
  margin-bottom: 0;
  padding-left: 0;
  margin-left: 0;
}


a.sidebar-link {
  padding: .625rem 1.625rem;
  color: black;
  position: relative;
  display: block;
  font-size: 1rem;
  margin-top: 3px;
}

.sidebar-link[data-bs-toggle="collapse"]::after {
  border: solid;
  border-width: 0 .075rem .075rem 0;
  content: "";
  display: inline-block;
  padding: 2px;
  position: absolute;
  right: 1.5rem;
  top: 1.4rem;
  transform: rotate(-135deg);
  transition: all .2s ease-out;
}

.sidebar-link[data-bs-toggle="collapse"].collapsed::after {
  transform: rotate(45deg);
  transition: all .2s ease-out;
}

.sidebar-link .link-text {
  font-size: 20px;
  /* Adjust the font size as needed */
  font-weight: normal;
  /* Optionally, make the text bold for better visibility */
  color: black;
  /* Adjust the color as needed for better contrast */
}
.sidebar-link[data-bs-toggle="collapse"].collapsed .link-text{
  font-size: 20px;
  /* Adjust the font size as needed */
  font-weight: normal;
  /* Optionally, make the text bold for better visibility */
  color: black;
  /* Adjust the color as needed for better contrast */
}

.wrapper {
  align-items: stretch;
  display: flex;
  width: 100%;
  height: 93vh;
  overflow: hidden;
}

#page-wrapper {
  background-color: rgb(234, 236, 239);
}

#sidebar {
  max-width: 400px;
  min-width: 200px;
  background: white;
  transition: all 0.35s ease-in-out;
  width: 400px;
}

.nav-pills li a:hover {
  background-color: rgb(164, 230, 189);
  border-radius: 15px;
}

.sidebar-block {
  display: flex;
  align-items: center;
}

.icon {
  margin-right: 10px;
  /* Adjust as needed */
  display: block;
}

.icon i {
  font-size: 1.25rem;
}

.link-text {
  position: relative;
  display: block;
  padding: 10px;
  height: 30px;
  line-height: 30px;
  text-align: start;
  white-space: nowrap;
  font-size: 1rem;
}

.hidden {
  transform: translateX(-250px);
}


.main {
  display: flex;
  flex-direction: column;
  height: 92vh;
  /* min-width: 0; */
  overflow: hidden;
  /* transition: all 0.35s ease-in-out; */
  width: 100%;
  margin-top: 10px;
  margin-left: 20px;
  margin-right: 20px;
}

</style>

<template>
  <!-- Navbar -->
  <div class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid ps-3 pe-3">
      <div>
        <i class="fa-solid fa-bars" @click="toggleSidebar"></i>
        <img src="/images/logo.png" alt="Logo Image" class="logo-img">
      </div>
      <!-- <i class="fa-solid fa-search"></i>
        <input class="form-control me-2" type="search" placeholder="Search..." aria-label="Search"> -->
      <div>
        <!-- <i class="fa-regular fa-bell"></i> -->
        <img src="/images/profile.jpg" alt="Profile Image" class="profile-img">
      </div>
    </div>
  </div>
  <!-- Left bar -->
  <div id="page-wrapper" class="wrapper">
    <!-- Sidebar -->
    <aside id="sidebar" class="{ 'hidden': sidebarHidden }">
      <!-- Sidebar Content -->
      <div class="h-100">
        <!-- <div class="sidebar-profile">
          <div class="text-left">
            <img src="/images/profile.jpg" alt="Profile Image" class="profile-img">
          </div>
          <a href="#">Sonai KOY</a>
        </div> -->
        <ul class="sidebar-nav nav-pills flex-column mt-4">
          <li class="sidebar-item">
            <router-link to="/dashboardcomponent" class="sidebar-link">
              <div class="sidebar-block">
                <span class="icon">
                  <i class="fa-solid fa-house"></i>
                </span>
                <span class="link-text ms-3">Dashboard</span>
              </div>
            </router-link>
          </li>
          <li class="sidebar-item">
            <router-link to="/EmployeeList" class="sidebar-link">
              <div class="sidebar-block">
                <span class="icon">
                  <i class="fa-solid fa-user"></i>
                </span>
                <span class="link-text ms-3">Employee List</span>
              </div>
            </router-link>
          </li>
          <li class="sidebar-item">
            <router-link to="/attendance_list" class="sidebar-link">
              <div class="sidebar-block">
                <span class="icon">
                  <i class="fa-solid fa-clipboard-user"></i>
                </span>
                <span class="link-text ms-3">Attendance</span>
              </div>
            </router-link>
          </li>
          <li class="sidebar-item">
            <router-link to="/leaveRequest" class="sidebar-link">
              <div class="sidebar-block">
                <span class="icon">
                  <i class="fa-solid fa-code-pull-request"></i>
                </span>
                <span class="link-text ms-3">Leave Request</span>
              </div>
            </router-link>
          </li>
          <li class="sidebar-item">
            <router-link to="/overtime" class="sidebar-link">
              <div class="sidebar-block">
                <span class="icon">
                  <i class="fa-regular fa-clock"></i>
                </span>
                <span class="link-text ms-3">Overtime</span>
              </div>
            </router-link>
          </li>
          <li class="sidebar-item">
            <router-link to="/announcement" class="sidebar-link">
              <div class="sidebar-block">
                <span class="icon">
                  <i class="fa-solid fa-bullhorn"></i>
                </span>
                <span class="link-text ms-3">Announcement</span>
              </div>
            </router-link>
          </li>

          <li class="sidebar-item">
                        <a href="#" class="sidebar-link collapsed" data-bs-target="#pages" data-bs-toggle="collapse"
                            aria-expanded="false">
                            
                            <span class="link-text ms-3">Setting</span>
                        </a>
                        <ul id="pages" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                            <li class="sidebar-item">
                              <router-link to="/user" class="sidebar-link">
                                <span class="link-text ms-3">User</span>
                              </router-link>
                            </li>
                            <li class="sidebar-item">
                              <router-link to="/department" class="sidebar-link">
                                <span class="link-text ms-3">Department</span>
                              </router-link>
                            </li>
                            <li class="sidebar-item">
                              <router-link to="/position" class="sidebar-link">
                                <span class="link-text ms-3">Position</span>
                              </router-link>
                            </li>
                        </ul>
                    </li>
        </ul>
      </div>
    </aside>

    <!-- Main content -->
    <div class="main">
      <!-- Dashboard content goes here -->
      <router-view></router-view>
      <!-- Add your dashboard components here -->
    </div>
  </div>
</template>

  
<script>
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import '@fortawesome/fontawesome-free/css/all.css';

export default {
  data() {
    return {
      sidebarHidden: false
    };
  },
  methods: {
    toggleSidebar() {
      this.sidebarHidden = !this.sidebarHidden;
    }
  }
};
</script>
 
  