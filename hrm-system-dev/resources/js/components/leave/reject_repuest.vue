<template>
    <div class="popup">
      <div class="popup-content">
        <div class="form-container">
          <form class="row g-3">
            <dev class="cardHeader">
          <h2>Rejest leave Request</h2>
        </dev>
        <div class="row" style="margin-left: 35px;">
            <div class="col-md-5">
              <label for="inputDepartment" class="form-label">The Reason:</label>
              <textarea class="form-control" placeholder=" " id="floatingTextarea2"
                style="height: 100px; width: 400px;"></textarea>
            </div>
          </div>
              <div class="col-12">
                <button type="button" @click="closePopup1" class="btn btn-danger" style="margin-right: 5px;">Cancel</button>
                <button type="button" class="btn btn-success">Confirm</button>
                
              </div>
            </form>
          </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    methods: {
      closePopup1() {
        this.$emit('closePopup1'); // Emitting an event to notify the parent component to close the popup
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
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
    width: 40%;
    display: flex;
    justify-content: center; /* Center the form horizontally */
    align-items: center; /* Center the form vertically */
    z-index: 10000;
  }
  .cardHeader h2 {
    text-align: center;
    font-weight: 600;
    color: rgb(0, 108, 81);
    margin-top: 10px;
  }
  
  .col-12 {
    text-align: center;
    padding-top: 10px;
  }
  </style>
  