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
.cardHeader-addnew{
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
.col-12{
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
        <form class="row g-3">
          <dev class="cardHeader-addnew">
        <h2>Rigister</h2>
      </dev>
            <div class="col-md-6">
              <label for="inputFirstName4" class="form-label">First Name</label>
              <input type="firstname" class="form-control" id="inputFisrtName4">
            </div>
            <div class="col-md-6">
              <label for="inputlastName4" class="form-label">last Name</label>
              <input type="lastname" class="form-control" id="inputLastName4">
            </div>
            <div class="col-6">
              <label for="inputEmail4" class="form-label">Email</label>
              <input type="email" class="form-control" id="inputEmail4" >
            </div>
            <div class="col-md-6">
              <label for="inputpassword" class="form-label">Password</label>
              <input type="password" class="form-control" id="inputpassword4">
            </div>
            <div class="col-md-6">
              <label for="inputPhoneNumber4" class="form-label">Phone Number</label>
              <input type="phoneNumber" class="form-control" id="inputPhoneNumber4">
            </div>
            <div class="col-md-6">
              <label for="inputDepartment" class="form-label">Department</label>
              <input type="text" class="form-control" id="inputDepartment">
            </div>
            <div class="col-md-6">
              <label for="inputDepartment" class="form-label">Position</label>
              <input type="text" class="form-control" id="inputDepartment">
            </div>
            <div class="col-md-2">
              <label for="inputGender" class="form-label">Gender</label>
              <select id="inputGender" class="form-select">
                <option selected>Choose...</option>
                <option>Male</option>
                <option>Female</option>
              </select>
            </div>
            <div class="col-12">
              <button type="button" class="btn btn-success">Conceal</button>
              <button type="button" class="btn btn-success">Submit</button>
              
            </div>
          </form>
    </div>
</template>

<script>
import axios from 'axios';

export default {
};

</script>