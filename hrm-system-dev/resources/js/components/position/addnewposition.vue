<template>
  <div class="popup">
    <div class="popup-content" style="width: 60%;">
      <div class="form-container">
        <form class="row g-3">
          <dev class="cardHeader">
            <h2>Add New Position</h2>
          </dev>
          <div class="row justify-content-center align-content-center">
            <div class="col-md-11">
              <label for="positionName" class="form-label">Position</label>
              <input v-model="newPosition.positionName" class="form-control" placeholder=" " id="positionName"
                required></input>
              <div v-if="errors.positionName" class="text-danger">
                {{ errors.positionName }}
              </div>
            </div>
            <div class="col-md-11 pt-3 ">
              <label for="positionDescription" class="form-label">Description</label>
              <textarea v-model="newPosition.positionDescription" class="form-control" placeholder=" "
                id="positionDescription" style="height: 150px" required></textarea>
              <div v-if="errors.positionDescription" class="text-danger">
                {{ errors.positionDescription }}
              </div>
            </div>
          </div>
          <div class="col-12 button-container d-flex">
            <button type="button" @click="closePopup1" class="btn btn-danger"
              style="margin-right: 5px;width: 50%;">Cancel</button>
            <button type="button" @click="confirmDialog" class="btn btn-success" style="width: 50%;">Save</button>

          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Swal from 'sweetalert2';
export default {
  data() {
    return {
      newPosition: {
        positionName: '',
        positionDescription: ''
      },
      errors: {
        positionName: '',
        positionDescription: ''
      },
    }
  },
  methods: {
    closePopup1() {
      this.$emit('closePopup1'); // Emitting an event to notify the parent component to close the popup
    },
    async addPosition() {
      const token = localStorage.getItem('token');
      const response = await axios.post('https://hrm-system-test.up.railway.app/api/position', {
        positionName: this.newPosition.positionName,
        positionDescription: this.newPosition.positionDescription
      }, {
        headers: {
          Authorization: `Bearer ${token}`,
        }
      });

      const addedDepartment = response.data; // Newly added department
      console.log(addedDepartment);// Add it to the local department list

      // Reset the form fields
      this.newPosition.positionName = '';
      this.newPosition.positionDescription = '';

      this.$emit('closePopup1');
    },
    async confirmDialog() {
      try {
        if (!this.newPosition.positionName) {
          this.errors.positionName = 'Name of Position is required!';
        }
        if (!this.newPosition.positionDescription) {
          this.errors.positionDescription = 'Descript of Position is required';
        }
        if (this.errors.positionName || this.errors.positionDescription) {
          return;
        }
        this.closePopup1();
        const result = await Swal.fire({
          title: 'Are you sure?',
          text: 'Do you want to add new Position?',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Yes, I do!',
          reverseButtons: true,
        });
        if (result.isConfirmed) {
          await this.addPosition().then(() => {
            Swal.fire({
              title: 'Created!',
              text: 'Position has been Added.',
              icon: 'success'
            }).then(() => {
              window.location.reload();
            });
          });

        }
      } catch (error) {
        console.error(error);
      }
    },
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
  border-radius: 5px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
  width: 40%;
  display: flex;
  justify-content: center;
  /* Center the form horizontally */
  align-items: center;
  /* Center the form vertically */
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

.button-container button {
  margin-right: 10px;
}
</style>