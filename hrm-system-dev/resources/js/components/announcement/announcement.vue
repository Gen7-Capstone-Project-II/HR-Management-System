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

.custom-textarea-height {
  min-height: 150px;
  /* You can adjust this value to change the height */
}

.col-12 {
  text-align: center;
  padding-top: 10px;
}

.table-wrapper {
  padding: 20px;
}

/* .table-list {
  background-color: white;
  border-radius: 10px;
  border-collapse: separate;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
} */

.table-list .cardHeader {
  /* display: flex; */
  /* justify-content: space-between;
  align-items: flex-start; */
  padding-right: 20px;
  padding-top: 10px;
}

.cardHeader h4 {
  padding-left: 15px;
  padding-top: 20px;
  color: rgb(0, 108, 81);
}

.cardHeader .btn {
  /* position: relative; */
  /* padding: 5px 10px; */
  background: rgb(0, 108, 81);
  text-decoration: none;
  color: white;
  border-radius: 6px;
}


/* .table-list {
  background-color: white;
  border-radius: 10px;
  border-collapse: separate;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
} */

.cardHeader h4 {
  padding-left: 15px;
  padding-top: 20px;
  color: rgb(0, 108, 81);
}

.cardHeader-tab h4 {
  /* padding-left: 15px;
  padding-top: 20px; */
  color: rgb(0, 108, 81);
}

.line-space {
  height: 20px;

}

.nav-tabs .nav-item .nav-link.active {
  color: #118143;
  border-bottom: 2px solid #118143;
  /* Color of the line under the active tab */
}

.nav-tabs .nav-item .nav-link {
  border: 2px solid transparent;
  /* Hide the bottom border of all tab links */
}

.nav-link:not(.active) .cardHeader-tab {
  color: #9B9696;
}

.no-placeholder::before {
  content: none !important;
}

.rounded-table {
  border-radius: 10px;
}
</style>

<template>
  <div class="table-wrapper ">
    <div class="px-5 h4" style="color: rgb(0, 108, 81);">
      <p>Announcements</p>
    </div>
    <div class="p-3 rounded-2 " style="background-color: #F3F3F3;">
      <div class=" pb-3">

        <div class="d-flex p-3 justify-content-between border rounded-1 bg-white btn-outline-primary">
          <!-- <h4>Announcement</h4> -->
          <div class="d-flex">
            <div class="col-1 d-flex justify-content-center align-items-center px-4">
              <div class="p-3 border  rounded-circle " style="font-size: 0;background-color: #E8E8E8;">
                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                  class="bi bi-megaphone-fill " style="color: #19469E;" viewBox="0 0 16 16">
                  <path
                    d="M13 2.5a1.5 1.5 0 0 1 3 0v11a1.5 1.5 0 0 1-3 0zm-1 .724c-2.067.95-4.539 1.481-7 1.656v6.237a25 25 0 0 1 1.088.085c2.053.204 4.038.668 5.912 1.56zm-8 7.841V4.934c-.68.027-1.399.043-2.008.053A2.02 2.02 0 0 0 0 7v2c0 1.106.896 1.996 1.994 2.009l.496.008a64 64 0 0 1 1.51.048m1.39 1.081q.428.032.85.078l.253 1.69a1 1 0 0 1-.983 1.187h-.548a1 1 0 0 1-.916-.599l-1.314-2.48a66 66 0 0 1 1.692.064q.491.026.966.06" />
                </svg>
              </div>
            </div>
            <div class="size-3 d-flex flex-column px-2">
              <span class="px-3 pt-1 pb-1 " style="color: #8C8C8C;">Create Announcement</span>
              <span class="px-3 pt-1 ">Notify all employees</span>
            </div>
          </div>
          <div class="rounded-2  m-2 pt-1  ">
            <button class="btn p-2 rounded-2 text-white" style="background-color: #19469E;" @click="addAnnouncement">
              Create Announcement</button>
          </div>

        </div>
      </div>
      <!-- Tabs -->
      <ul class="nav nav-tabs border-bottom-0 ">
        <li class="nav-item">
          <a class="nav-link active" data-bs-toggle="tab" href="#Announcement" @click="fetchAnnouncements(1)">
            <div class="cardHeader-tab active  h5">
              Published Announcements
            </div>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" data-bs-toggle="tab" href="#Draft" @click="fetchAnnouncements(0)">
            <div class="cardHeader-tab active h5">
              Draft Announcements
            </div>
          </a>
        </li>
      </ul>

      <!-- Filter Inputs -->

      <!-- Tab Content -->
      <div class="tab-content pt-3">
        <!-- Leave Request Tab -->
        <div class="tab-pane fade show active" id="Announcement">
          <div class="table-list  pe-3">
            <div v-if="loading" class="d-flex  justify-content-center w-100 ">
              <div class="spinner-border text-secondary " style="width: 3rem; height: 3rem;" role="status">
                <span class="visually-hidden  ">Loading...</span>
              </div>
            </div>
            <div v-else class="border bg-white rounded-2 p-2">
              <table class="table ">
                <thead>
                  <tr>
                    <th class="w-25" scope="col-1">Published Date</th>
                    <th scope="col-8">Announcements</th>
                    <th scope="col-3" style="text-align: right;"></th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(announcement, index) in announcements" :key="announcement.id">      
                    <td class="col-1 small-text">{{ formatDate(announcement.publish_date) }}
                      <br>
                      <span class="small-text text-muted d-inline-block text-truncate"
                        style="font-size: 0.8rem; max-width: 250px;">{{ timeFormat(announcement.publish_date) }}</span>
                    </td>             
                    <td class="col-8 small-text" > {{ announcement.title }} <br><span
                        class="small-text text-muted d-inline-block text-truncate"
                        style="font-size: 0.8rem; max-width: 400px;">{{ announcement.description }}</span>
                      </td>     
                    <td class="col-3" style="text-align: right;">
                      <router-link :to="{ name: 'ViewAnnouncement', params: { id: announcement.id } }">
                      <button type="button" class="btn btn-outline-primary" style="width: 100px; height: 35px;"
                       >Details</button></router-link>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- Draft Announcement tap -->
        <div class="tab-pane fade" id="Draft">
          <div class="table-list ps-3 pe-3 ">
            <div v-if="loading" class="d-flex  justify-content-center w-100 ">
              <div class="spinner-border text-secondary " style="width: 3rem; height: 3rem;" role="status">
                <span class="visually-hidden  ">Loading...</span>
              </div>
            </div>
            <div v-else class="border bg-white rounded-2 p-2">
              <table class="table">
                <thead>
                  <tr>
                    <!-- <th scope="col">#</th> -->
                    <th scope="col">#</th>
                    <th scope="col">Title</th>
                    <th scope="col">Created By</th>
                    <th scope="col">Created At</th>
                    <th scope="col" class="px-lg-5 ">Actions</th>
                    <!-- <th scope="col"></th> -->
                  </tr>
                </thead>
                <tbody>

                  <tr v-for="(announcement, index) in announcements" :key="announcement.id">
                    <th scope="row" class="small-text"> {{ index + 1 }}</th>      
                    <td class="col small-text"> {{ announcement.title }} <br>    
                      <span class="small-text text-muted d-inline-block text-truncate"
                        style="font-size: 0.8rem; max-width: 250px;">{{ announcement.description }}</span>
                    </td>
                    <td class="small-text">{{ announcement.user.name }}</td>
                    <td class="small-text">{{ formatDate(announcement.create_date) }} <br>
                      <span class="small-text text-muted d-inline-block text-truncate"
                        style="font-size: 0.8rem; max-width: 250px;">{{ timeFormat(announcement.create_date) }}</span>
                    </td> 
                    <td>
                      <button type="button" class="btn btn-success btn-sm small-button mx-1 "
                        @click="goToEditPage(announcement.id)">Edit</button>
                      <PopupModel3 v-if="showPopup3" @closePopup3="showPopup3 = false"></PopupModel3>
                      <button type="button" class="btn btn-danger btn-sm small-button mx-1 "
                        @click="confirmDelete(announcement.id)">Delete</button>
                      <button type="button" class="btn btn-primary  btn-sm small-button"
                        @click="openPublish(announcement)">Publish</button>
                    </td>
                    <!-- <td class="col-1" style="text-align: right;">
                      <router-link to="/viewannouncement">
                      <button type="button" class="btn btn-outline-primary" style="width: 100px; height: 35px;"
                       >Details</button></router-link>
                    </td> -->
                  </tr>

                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="popup" v-if="showPublishDialog">
    <div class="popup-content" style="width: 65%;">
      <div class="form-container" style="height: 500px; overflow-y: auto; overflow-x: hidden ">
        <form class="row g-4">
          <dev class="cardHeader">
            <h2>Publish Announcement</h2>
          </dev>
          <div class="row justify-content-start  align-content-center">
            <fieldset disabled>
              <div class="mb-3">
                <label for="inputOvertime" class="form-label">Title</label>
                <input class="form-control" placeholder=" " id="floatingTextarea2"
                  v-model="publishAnnouncement.title"></input>
              </div>
              <div class="mb-3">
                <label for="inputOvertime" class="form-label">Description</label>
                <textarea class="form-control" placeholder=" " id="floatingTextarea2" style="height: 150px"
                  v-model="publishAnnouncement.description"></textarea>
              </div>
            </fieldset>
            <div class="form-check form-switch pt-3  col-md-12" style="margin-left: 20px;">
              <input class="form-check-input" style=" width: 60px; height:35px" type="checkbox"
                id="flexSwitchCheckDefault" v-model="publishAnnouncement.is_publish">
              <label class="form-check-label pt-2 px-2" for="flexSwitchCheckDefault">Publish Now?</label>
            </div>

            <div v-if="publishAnnouncement.is_publish" class="pt-5 col-md-12 pb-4 mx-2 " style="width: 40%;">
              <VueDatePicker v-model="publishAnnouncement.publish_date"></VueDatePicker>
            </div>
            <div class="d-flex mt-3 mb-3 ">
            <div @click="closePublish" class="btn p-2 btn-danger" style="width: 50%; border-radius: 1rem 0 0 1rem;">
              Cancel
            </div>
            <div v-if="!publishAnnouncement.is_publish" @click="" class="btn p-2 btn-success disabled" style="width: 50%; border-radius: 0 1rem 1rem 0;">
              Publish
            </div>
            <div v-else @click="confirmPublishAnnouncement(publishAnnouncement.id)" class="btn p-2 btn-success" style="width: 50%; border-radius: 0 1rem 1rem 0;">
              Publish
            </div>
          </div>
          </div>
        </form>
      </div>
    </div>
  </div>

</template>

<script>
import axios from 'axios';
import PopupModel2 from '../components/viewannouncement.vue';
import PopupModel1 from '../components/addnewannouncement.vue';
import UpdateAnnounecement from '../components/updateannounecement.vue';
import Swal from 'sweetalert2';
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';

export default {
  components: {
    PopupModel1,
    PopupModel2,
    UpdateAnnounecement,
    VueDatePicker
  },
  data() {
    return {
      showPopup1: false,
      showPopup2: false,
      announcements: [],
      publishAnnouncement: [],
      showPopup3: false,
      selectedAnnouncement: null, // New data property to store the selected announcement for editing
      loading: false,
      showPublishDialog: false,
    };
  },
  mounted() {
    console.log("Component mounted");
    this.fetchAnnouncements(1);
  },
  methods: {
    addAnnouncement() {
      this.$router.push({ path: '/AddNewAnnouncement' });
    },
    openPublish(announcement) {
      this.showPublishDialog = true;
      this.publishAnnouncement = announcement;
      console.log(this.publishAnnouncement);
    },
    closePublish() {
      this.showPublishDialog = false;
      this.publishAnnouncement.is_publish=false;
      this.publishAnnouncement.publish_date=null;
    },
    openDialog() {
      this.showDialog = true; // Show the dialog
    },
    closeDialog() {
      this.showDialog = false; // Close the dialog
    },
    async fetchAnnouncements(type) {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');
        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/announcement?is_publish=${type}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.announcements = response.data.data;
        console.log(response.data);
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async publishannouncement(announcementId) {
      try {
        const token = localStorage.getItem('token');
        const empId = localStorage.getItem('id');
        const publishDate = this.publishAnnouncement.publish_date instanceof Date ? this.formatDate(this.publishAnnouncement.publish_date) : null;

        const payload = {
          empId: empId,
          title: this.publishAnnouncement.title,
          description: this.publishAnnouncement.description,
          is_publish: this.publishAnnouncement.is_publish,
        };

        if (publishDate !== null) {
          payload.publish_date = publishDate;
        }

        const response = await axios.post(`https://hrm-system-test.up.railway.app/api/announcement/${announcementId}`, payload, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });

        const publishedAnnouncement = response.data; // Newly added announcement
        console.log(publishedAnnouncement);// Add it to the local announcements list

        // Reload the page to reflect the newly added announcement
      } catch (error) {
        console.error(error);
      }
    },
    formatDate(date) {
      const formattedDate = new Date(date);
      const month = formattedDate.toLocaleString('default', { month: 'long' });
      const day = formattedDate.getDate();
      const year = formattedDate.getFullYear();

      return `${month} ${day}, ${year}`;
    },
    timeFormat(date) {
      const formattedDate = new Date(date);
      const hours = formattedDate.getHours() % 12 || 12;
      const minutes = String(formattedDate.getMinutes()).padStart(2, '0');
      const period = formattedDate.getHours() < 12 ? 'AM' : 'PM';

      return `${hours}:${minutes} ${period}`;
    },
    async deleteAnnouncement(announcementId) {
      try {
        const token = localStorage.getItem('token');
        await axios.delete(`https://hrm-system-test.up.railway.app/api/announcement/${announcementId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });

      } catch (error) {
        console.error(error);
      }
    },
    goToEditPage(id) {
      this.$router.push(`/updateAnnouncement/${id}`);
    },
    async confirmDelete(announcementId) {
      try {
        this.openDialog();
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
          await this.deleteAnnouncement(announcementId);
          Swal.fire({
            title: 'Deleted!',
            text: 'Announcement has been deleted.',
            icon: 'success'
          }).then(() => {
            this.closeDialog()
            this.fetchAnnouncements(0);
          });
        }
      } catch (error) {
        console.error(error);
      }
    },
    async confirmPublishAnnouncement(announcementId) {
      try {
        this.showPublishDialog = false;
        const result = await Swal.fire({
          title: 'Are you sure?',
          text: 'Do you want to Publish Announcement?',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Yes, I do!',
          reverseButtons: true
        });
        if (result.isConfirmed) {
          await this.publishannouncement(announcementId).then(() => {
            this.showPublishDialog = false;
            this.fetchAnnouncements(0);
            Swal.fire({
              title: 'Published!',
              text: 'Announcement has been Published.',
              icon: 'success'
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




<!-- Add your Bootstrap imports here -->
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';