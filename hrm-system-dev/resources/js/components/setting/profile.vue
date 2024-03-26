<style scoped>
.profile-container {
  overflow-x: hidden;
}

.card {
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  /* Adjust the shadow properties as needed */
  border-radius: 20px;
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
.link-class{
  text-decoration: none;
}
</style>

<template>
  <div class="table-wrapper">
    <div>
      <!-- Profile Section -->
      <div class="card border-0">
        <div class="cardHeader pt-3 ">
          <div class="row g-0">
            <div class="col-auto">
              <router-link to="/setting" class="link-class">
                <button class="btn border-0 d-flex justify-content-center align-items-center"><i class="fa-solid fa-arrow-left"></i></button>
              </router-link>
            </div>
            <div class="col">
              <h4>Employee Information</h4>
            </div>
          </div>
        </div>
        <div class="card-body">
          <router-link to="">
            <button class="btn position-absolute border-0 top-0 end-0"><i class="far fa-edit"></i></button>
          </router-link>
          <div class="row col-md-12 ps-5 d-flex justify-content-center align-items-center">
            <div class="col-md-3 d-flex justify-content-center align-items-center">
              <img src="../../../public/images/profile.jpg" alt="Profile Picture" class="img-fluid rounded-circle">
            </div>
            <div class="col-md-9">
              <div class="row d-flex justify-content-center align-items-center">
                <div class="col-md-5">
                  <p class="card-text border-bottom pb-1 mb-0"><strong>User ID</strong><p></p></p>
                  <p class="card-text border-bottom pb-1 mb-0"><strong>User Name</strong><p></p></p>
                  <p class="card-text"><strong>Khmer Name</strong><p></p></p>
                </div>
                  <div class="col-md-4">
                  <p class="card-text border-bottom pb-1 mb-0"><strong>Gender</strong><p></p></p>
                  <p class="card-text border-bottom pb-1 mb-0"><strong>Birth Date</strong><p></p></p>
                  <p class="card-text"><strong>Phone Number</strong><p></p></p>
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
                <p class="card-text border-bottom pb-1 mb-0"><strong>Position</strong> <p> </p></p>
                <p class="card-text"><strong>Department</strong> <p></p></p>
              </div>
              <div class="col-md-4" >
                <p class="card-text border-bottom pb-1 mb-0"><strong>Address</strong><p></p></p>
                <p class="card-text"><strong>Telegram</strong><p></p></p>
              </div>
              <div class="col-md-4" >
                <p class="card-text border-bottom pb-1 mb-0"><strong>Employee Date</strong><p></p></p>
                <p class="card-text"><strong>Active</strong><p><i class="fa-solid fa-check" style="color:rgb(0, 108, 81);"></i></p></p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- User's Posts Section -->
      <div class="card mt-3">
        <div class="card-body">
          <h5 class="card-title">Attendance</h5>
          <div class="list-group">
            <a href="#" class="list-group-item list-group-item-action">
              <div class="d-flex w-100 justify-content-between">
                <h6 class="mb-1">Post Title</h6>
                <small>Post Date</small>
              </div>
              <p class="mb-1">Post content goes here.</p>
              <small>Posted by User Name</small>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import axios from 'axios';

export default {
  methods: {
    
  }
};

</script>



<!-- Add your Bootstrap imports here -->
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';