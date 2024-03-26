<style scoped>
.table-wrapper {
  padding: 20px;
}

.table-list .cardHeader {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding-right: 20px;
  padding-top: 10px;
}

.cardHeader h4 {
  /* padding-left: 15px;
  padding-top: 20px; */
  color: rgb(0, 108, 81);
}

.cardHeader .btn {
  /* padding-left: 15px;
  padding-top: 20px; */
  color: rgb(0, 108, 81);
}

.link-class {
  text-decoration: none;
}

.cardHeader .btn-create {
  position: relative;
  padding: 5px 10px;
  background: rgb(0, 108, 81);
  text-decoration: none;
  color: white;
  border-radius: 6px;
}

.table-list {
  background-color: white;
  border-radius: 10px;
  border-collapse: separate;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100px;
}

.loading-animation {
  border: 6px solid rgba(0, 0, 0, 0.1);
  border-top-color: #333;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  animation: spin 1s linear infinite;
}

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

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}
</style>

<template>
  <div class="table-wrapper">
    <div class="table-list ps-3 pe-3">
      <div class="cardHeader">
        <div class="row g-0">
          <div class="col-auto">
            <router-link to="/setting" class="link-class">
              <button class="btn border-0 d-flex justify-content-center align-items-center"><i
                  class="fa-solid fa-arrow-left"></i></button>
            </router-link>
          </div>
          <div class="col">
            <h4>Position</h4>
          </div>
        </div>
        <div>
          <a href="#" class="btn-create" @click="showPopup1 = true">Create Position</a>
          <PopupModel1 v-if="showPopup1" @closePopup1="showPopup1 = false"></PopupModel1>
        </div>
      </div>
      <div class="padding1">
        <table class="table mt-2 table-borderless">
          <thead>
            <tr>
              <th scope="col" class="left">No</th>
              <th scope="col" class="center">Position</th>
              <th scope="col" class="center">Description</th>
              <th scope="col" class="right">Actions</th>
            </tr>
          </thead>
          <tbody>
            <template v-if="loading">
              <tr>
                <td colspan="4" class="center">
                  <div class="loading-container">
                    <div class="loading-animation"></div>
                  </div>
                </td>
              </tr>
            </template>
            <template v-else>
              <tr v-for="(position, index) in positions" :key="position.id">
                <td class="left small-text"> {{ index + 1 }}.</td>
                <td class="center small-text">{{ position.positionName }}</td>
                <td class="center small-text"> {{ position.positionDescription }}</td>
                <td class="right">
                  <button type="button" class="btn btn-success btn-sm small-button" style="margin-right: 5px;"
                    @click="openEdit(position)">Edit</button>
                  <PopupModel2 v-if="showPopup2" @closePopup2="showPopup2 = false"></PopupModel2>
                  <button type="button" class="btn btn-danger btn-sm small-button"
                    @click="confirmDelete(position.id)">Delete</button>
                </td>
              </tr>
            </template>
            <!-- Add more rows here -->
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- edit position -->
  <div class="popup" v-if="showEdit">
    <div class="popup-content" style="width: 60%;">
      <div class="form-container">
        <form class="row g-3">
          <dev class="cardHeader">
            <h2>Update Position</h2>
          </dev>
          <div class="row justify-content-center align-content-center">
            <div class="col-md-11">
              <label for="positionName" class="form-label">Position</label>
              <input v-model="position.positionName" class="form-control" placeholder=" " id="positionName"></input>
            </div>
            <div class="col-md-11 pt-3">
              <label for="positionDescription" class="form-label">Description</label>
              <textarea v-model="position.positionDescription" class="form-control" placeholder=" "
                id="positionDescription" style="height: 150px"></textarea>
            </div>
          </div>
          <div class="col-12 d-flex button-container">
            <button type="button" @click="closeEdit" class="btn btn-danger"
              style="margin-right: 5px;width: 50%;">Cancel</button>
            <button type="button" class="btn btn-success" @click="confirmEdit(position.id)"
              style="width: 50%;">Update</button>

          </div>
        </form>
      </div>
    </div>
  </div>
</template>



<script>
import PopupModel1 from '../components/addnewposition.vue';
import PopupModel2 from '../components/updateposition.vue';
import axios from 'axios';
import Swal from 'sweetalert2';

export default {
  components: {
    PopupModel1,
    PopupModel2
  },
  data() {
    return {
      showPopup1: false,
      showPopup2: false,
      showEdit: false,
      positions: [],
      position: [],
      loading: false,
      selectedPosition: null
    };
  },
  mounted() {
    console.log("Componenent mounted!");
    this.fetchPositions();
  },
  methods: {
    openEdit(position) {
      this.showEdit = true;
      this.position = position;
      console.log(this.position);
    },
    closeEdit() {
      this.showEdit = false
    },
    async deletePosition(positionId) {
      try {
        const token = localStorage.getItem('token');
        await axios.delete(`https://hrm-system-test.up.railway.app/api/position/${positionId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });

        // Remove the deleted announcement from the array
        this.positions = this.positions.filter(position => position.id !== positionId);
      } catch (error) {
        console.error(error);
      }
    },
    async fetchPositions() {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');

        const response = await axios.get('https://hrm-system-test.up.railway.app/api/position', {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.positions = response.data.data;
        
        console.log(response.data)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async updatePosition(id) {
      try {
        const token = localStorage.getItem('token');
        const response = await axios.put(`https://hrm-system-test.up.railway.app/api/position/${this.position.id}`, {
          positionName: this.position.positionName,
          positionDescription: this.position.positionDescription
        }, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        console.log(response.data);
        this.showEdit = false;
      } catch (error) {
        console.error(error);
      }
    },
    async confirmDelete(positionId) {
      try {
        const result = await Swal.fire({
          title: 'Are you sure?',
          text: 'You won\'t be able to revert this!',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#d33',
          cancelButtonColor: '#3085d6',
          confirmButtonText: 'Yes, delete it!',
          reverseButtons: true
        });

        if (result.isConfirmed) {
          await this.deletePosition(positionId);
          const index = this.positions.findIndex(position => position.id === positionId);
          this.positions.splice(index, 1);

          Swal.fire({
            title: 'Deleted!',
            text: 'Your file has been deleted.',
            icon: 'success'
          }).then(() => {
            window.location.reload();
          });
        }
      } catch (error) {
        console.error(error);
      }
    },
    async confirmEdit(id) {
      try {
        this.closeEdit();
        const result = await Swal.fire({
          title: 'Are you sure?',
          text: 'Do you want to Update this Position?',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Yes, I do!',
          reverseButtons: true,
        });
        if (result.isConfirmed) {
          await this.updatePosition(id).then(() => {
            Swal.fire({
              title: 'Updated!',
              text: 'Position has been Updated.',
              icon: 'success'
            }).then(() => {
              this.fetchPositions();
            });
          });

        }
      } catch (error) {
        console.error(error);
      }
    },
  },
};
</script>



<!-- Add your Bootstrap imports here -->
