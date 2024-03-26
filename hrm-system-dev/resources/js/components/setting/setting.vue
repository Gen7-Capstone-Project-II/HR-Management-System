<style scoped>
.cardBox {
  position: relative;
  width: 100%;
  padding: 20px;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-gap: 30px;
}

.cardBox .card {
  position: relative;
  background: white;
  padding: 30px;
  border-radius: 20px;
  display: flex;
  justify-content: space-between;
  cursor: pointer;
  box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
  border: none;
  text-decoration: none;
}

.cardBox .card .numbers {
  position: relative;
  font-weight: 500;
  font-size: 2.5rem;
  color: rgb(0, 108, 81);
  text-decoration: none;
}

.cardBox .card .cardName {
  color: rgb(53, 51, 51);
  font-size: 1.1rem;
  margin-top: 5px;
  text-decoration: none;
}

.cardBox .card .iconBx {
  font-size: 2rem;
  color: rgb(53, 51, 51);
}

.cardBox .card:hover {
  background: rgb(0, 108, 81);
}

.cardBox .card:hover .numbers,
.cardBox .card:hover .cardName,
.cardBox .card:hover .iconBx {
  color: white;
}

.link-class {
  text-decoration: none;
}
</style>

<template>
  <div class="cardBox">

    <div class="card">
      <div @click="navigateToEmployeeDetail" class="link-class">
        <div>
          <div class="numbers">Profile</div>
          <div class="cardName">admin</div>
        </div>

        <div class="iconBx">
          <ion-icon name="cart-outline"></ion-icon>
        </div>
      </div>
    </div>


    <!-- <div class="card">
      <router-link to="/user" class="link-class">
        <div>
          <div class="numbers">User</div>
          <div class="cardName">Employee</div>
        </div>

        <div class="iconBx">
          <ion-icon name="cart-outline"></ion-icon>
        </div>
      </router-link>
    </div> -->

    <div class="card">
      <router-link to="/department" class="link-class">
        <div>
          <div class="numbers">Department</div>
          <div class="cardName"> </div>
        </div>

        <div class="iconBx">
          <ion-icon name="chatbubbles-outline"></ion-icon>
        </div>
      </router-link>
    </div>

    <div class="card">
      <router-link to="position" class="link-class">
        <div>
          <div class="numbers">Position</div>
          <div class="cardName"> </div>
        </div>

        <div class="iconBx">
          <ion-icon name="cash-outline"></ion-icon>
        </div>
      </router-link>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  methods: {
    navigateToEmployeeDetail() {
      const employeeId = localStorage.getItem('id');
      this.$router.push({ path: `/employeedetail/${employeeId}`, });
      console.log(employeeId);
    }
  }
};

</script>



<!-- Add your Bootstrap imports here -->
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';