<template>
    <div class="popup">
        <div class="popup-content">
            <div class="container mt-5">
                <form class="row g-3">
                    <div class="cardHeader">
                        <h2>Update User</h2>
                    </div>
                    <div class="col-md-6">
                        <label for="inputUserName4" class="form-label">User Name</label>
                        <input type="text" class="form-control" id="inputUserName4">
                    </div>
                    <div class="col-md-6">
                        <label for="inputEmail4" class="form-label">Email</label>
                        <input type="email" class="form-control" id="inputEmail4">
                    </div>
                    <div class="col-md-6">
                        <label for="inputpassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="inputpassword4">
                    </div>
                    <div class="col-md-6">
                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                        <input type="password" class="form-control"
                            id="confirmPassword" required>
                        <p class="text-danger">Passwords do not match.</p>
                    </div>
                    <div class="col-md-4">
                        <label for="inputrole" class="form-label">Role</label>
                        <select id="inputrole" class="form-select">
                            <option selected disabled>Choose...</option>
                            <option>...</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <button type="button" class="btn btn-danger" @click="closePopup3" style="margin-right: 5px;">Cancel</button>
                        <button type="submit" class="btn btn-success">Update</button>
                        
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
  
<script>
import axios from 'axios';

export default {
    methods: {
      closePopup3() {
        this.$emit('closePopup3'); // Emitting an event to notify the parent component to close the popup
      }
    }
};
</script>
  
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
    z-index: 9999;
}

.popup-content {
    background-color: white;
    /* padding: 10px; */
    border-radius: 15px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
    width: 70%;
    height: 80%;
    z-index: 10000;
}

.title {
    width: 100%;
    padding: 20px;
    /* Add padding to top and bottom for spacing */
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    padding-right: 20px;
    padding-top: 10px;
}

.cardHeader h2 {
    text-align: center;
    font-weight: 600;
    color: rgb(0, 108, 81);
}

.col-12 {
    text-align: right;
    padding-top: 10px;
}
</style>
  