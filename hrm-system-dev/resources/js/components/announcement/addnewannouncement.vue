<template>
  <div class="table-wrapper ">
    <div class="p-5 rounded-2 " style="background-color: #F3F3F3;">
      <div class=" bg-secondary  text-white  p-3 rounded-start-3 rounded-end-3 d-flex justify-content-between  ">
        <h4 class="pb-2">Add New Announcement</h4>
        <div class="">
          <button type="button" @click="confirmAddAnnouncement" class="btn px-4 mx-2 text-white  "
            style="background-color: #0C53D8;">Save</button>
          <button type="button" @click="closeForm" class="btn btn-danger" style="margin-right: 5px;">Cancel</button>
        </div>
      </div>

      <div class="form-container bg-white rounded-bottom-3 pb-4  ">
        <form class="row g-3 pt-4">
          <div class="row justify-content-center ">
            <div class="col-md-10">
              <label for="title" class="form-label">Title</label>
              <input v-model="newAnnouncement.title" class="form-control" placeholder=" " id="title" required></input>
              <div v-if="errors.title" class="text-danger">
                {{ errors.title }}
              </div>
            </div>
            <div class="col-md-10">
              <label for="description" class="form-label">Description</label>
              <textarea data-height="200px" v-model="newAnnouncement.description" class="form-control" placeholder=""
                rows="6" required></textarea>
              <div v-if="errors.description" class="text-danger">
                {{ errors.description }}
              </div>
            </div>
            <div class="pt-3 col-md-10">
              <label class="pb-2">Upload file (optional)</label>
              <input class="form-control" type="file" id="formFile">
            </div>
            <div class="form-check form-switch pt-3 col-md-10" style="margin-left: 30px;">
              <input class="form-check-input" style=" width: 60px; height:35px" type="checkbox"
                id="flexSwitchCheckDefault" v-model="newAnnouncement.is_publish">
              <label class="form-check-label pt-2 px-2" for="flexSwitchCheckDefault">Publish Now?</label>
            </div>

            <div v-if="newAnnouncement.is_publish" class="pt-3 col-md-10 pb-4">
              <VueDatePicker v-model="newAnnouncement.publish_date"></VueDatePicker>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import Swal from 'sweetalert2';

export default {
  components: { VueDatePicker },
  data() {
    return {
      showPopup1: false,
      showDatePicker: false,
      date: null,
      newAnnouncement: {
        empId: '',
        title: '',
        description: '',
        is_publish: false,
        publish_date: '',
      },
      errors: {
        title: '',
        description: '',
      },
    }
  },
  methods: {
    closeForm() {
      this.$router.go(-1);
    },
    formatDate(date) {
      if (date instanceof Date) {
        const year = date.getFullYear();
        const month = (date.getMonth() + 1).toString().padStart(2, '0');
        const day = date.getDate().toString().padStart(2, '0');
        return `${year}-${month}-${day}`;
      } else {
        return '';
      }
    },
    async addnewannouncement() {
      try {
        const token = localStorage.getItem('token');
        const empId = localStorage.getItem('id');
        const publishDate = this.newAnnouncement.publish_date instanceof Date ? this.formatDate(this.newAnnouncement.publish_date) : null;

        const payload = {
          empId: empId,
          title: this.newAnnouncement.title,
          description: this.newAnnouncement.description,
          is_publish: this.newAnnouncement.is_publish,
        };

        if (publishDate !== null) {
          payload.publish_date = publishDate;
        }

        const response = await axios.post('https://hrm-system-test.up.railway.app/api/announcement', payload, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });

        const addedAnnouncement = response.data; // Newly added announcement
        console.log(addedAnnouncement);// Add it to the local announcements list

        // Reset the form fields
        this.newAnnouncement.title = '';
        this.newAnnouncement.description = '';
        this.newAnnouncement.is_publish = false;
        this.newAnnouncement.publish_date = null;

        // Reload the page to reflect the newly added announcement
      } catch (error) {
        console.error(error);
      }
    },
    async confirmAddAnnouncement() {
      console.log('errors.publish_date:', this.errors.publish_date);
      try {
        if (!this.newAnnouncement.title) {
          this.errors.title = 'Title is required!';
        }
        if (!this.newAnnouncement.description) {
          this.errors.description = 'Description are required';
        }
        if (this.errors.title || this.errors.description) {
          return;
        }

        const result = await Swal.fire({
          title: 'Are you sure?',
          text: 'Do you want add new Announcement?',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Yes, I do!',
          reverseButtons: true
        });
        if (result.isConfirmed) {
          await this.addnewannouncement().then(() => {
            this.closeForm();
            Swal.fire({
              title: 'Approved!',
              text: 'Overtime has been Approved.',
              icon: 'success'
            });
          });
        }
      } catch (error) {
        console.error(error);
      }
    },
  },
  mounted() {
    // ClassicEditor
    //   .create(document.querySelector('#description'))
    //   .then(editor => {
    //     editor.ui.view.editable.element.style.height = '200px';
    //     editor.editing.view.change(writer => {
    //       writer.setStyle('min-height', '200px', editor.editing.view.document.getRoot());
    //     });
    //     editor.on('change', () => {
    //       this.newAnnouncement.description = editor.getData();
    //     });
    //     console.log('Editor was initialized', editor);
    //   })
    //   .catch(error => {
    //     console.error('There was an error initializing the editor', error);
    //   });
  }
};
</script>


<style scoped>
.table-wrapper {
  padding: 20px;
}

.cardHeader h4 {
  text-align: center;
  font-weight: 600;
  color: rgb(0, 108, 81);
  margin-top: 10px;
}

.col-12 {
  text-align: center;
  padding-top: 10px;
}

.ck-editor__editable_inline {
  min-height: 200px;
}
</style>