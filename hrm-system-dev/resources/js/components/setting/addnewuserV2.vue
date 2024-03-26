<style scoped>
.profile-container {
    overflow-x: hidden;
}

.card {
    box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
    /* Adjust the shadow properties as needed */
    border-radius: 20px;
    border: none;
}

.cardHeader h2 {
    text-align: center;
    color: rgb(0, 108, 81);
}

.table-wrapper {
    padding: 20px;
}

.other-infor {
    background-color: rgb(0, 108, 81);
    color: white;

}

.other-infor-center {
    display: center;
    padding-top: 20px;
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

<template>
    <div class="table-wrapper">
        <div>
            <div class=" d-flex justify-content-between rounded-top-3 "
                style="height: 55px; background-color: rgb(0, 108, 81);">
                <div class="pt-3 h4 text-white px-5">Personal Information</div>
                <div class="pt-2 pe-3">
                    <button type="button" class="btn btn-danger mx-3 px-4" @click="closeForm">Close</button>
                    <button type="button" class="btn btn-primary px-4" @click="confirmAddInfoEmployee">Save</button>
                    <!-- <button v-else type="button" class="btn btn-primary px-4"
                        @click="confirmAddNewEmployee">Save</button> -->
                </div>
            </div>
            <div class="container rounded-bottom-3 " style="background-color: #F5F5F5;">
                <div class="row">
                    <div class="col-md-14">
                        <!-- Profile Section -->
                        <div class="card mt-2 mb-3">
                            <!-- <div class="card-header"></div> -->
                            <div class="card-body ">
                                <div>
                                    <div class="row">
                                        <div class="col-md-12 ">
                                            <div class="row">
                                                <div class=" d-flex justify-content-around  ">
                                                    <div class="mb-3" style="width: 40%;">
                                                        <label for="firstName" class="form-label">First Name</label>
                                                        <input type="text" class="form-control" id="firstName"
                                                            v-model="newEmployee.firstName" required>
                                                        <div v-if="errorsEmployeeInfo.firstName" class="text-danger">
                                                            {{ errorsEmployeeInfo.firstName }}
                                                        </div>
                                                    </div>
                                                    <div class="mb-3" style="width: 40%;">
                                                        <label for="lastname" class="form-label">Last Name</label>
                                                        <input type="text" class="form-control" id="lastname"
                                                            v-model="newEmployee.lastName" required>
                                                        <div v-if="errorsEmployeeInfo.lastName" class="text-danger">
                                                            {{ errorsEmployeeInfo.lastName }}
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class=" d-flex justify-content-around  ">
                                                    <div class="mb-3" style="width: 40%;">
                                                        <label for="firstNameKH" class="form-label">First Name
                                                            KH</label>
                                                        <input type="text" class="form-control" id="firstNameKH"
                                                            v-model="newEmployee.firstNameKH" required>
                                                        <div v-if="errorsEmployeeInfo.firstNameKH" class="text-danger">
                                                            {{ errorsEmployeeInfo.firstNameKH }}
                                                        </div>
                                                    </div>
                                                    <div class="mb-3" style="width: 40%;">
                                                        <label for="lastNameKH" class="form-label">Last Name KH</label>
                                                        <input type="text" class="form-control" id="lastNameKH"
                                                            v-model="newEmployee.lastNameKH" required>
                                                        <div v-if="errorsEmployeeInfo.lastNameKH" class="text-danger">
                                                            {{ errorsEmployeeInfo.lastNameKH }}
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class=" d-flex justify-content-around">
                                                    <div class="mb-3" style="width: 20%;">
                                                        <label for="gender" class="form-label">Gender</label>
                                                        <select class="form-select" id="gender"
                                                            v-model="newEmployee.gender" required>
                                                            <option value="male">Male</option>
                                                            <option value="female">Female</option>
                                                        </select>
                                                        <div v-if="errorsEmployeeInfo.gender" class="text-danger">
                                                            {{ errorsEmployeeInfo.gender }}
                                                        </div>
                                                    </div>
                                                    <div class="mb-3" style="width: 20%;">
                                                        <label for="birthDate" class="form-label">Birth Date</label>
                                                        <input type="date" class="form-control" id="birthDate"
                                                            v-model="newEmployee.birthDate" required>
                                                        <div v-if="errorsEmployeeInfo.birthDate" class="text-danger">
                                                            {{ errorsEmployeeInfo.birthDate }}
                                                        </div>
                                                    </div>
                                                    <div class="mb-3" style="width: 30%;">
                                                        <label for="phoneNum1" class="form-label">Phone Number</label>
                                                        <input type="text" class="form-control" id="phoneNum1"
                                                            v-model="newEmployee.phoneNum1" required>
                                                        <div v-if="errorsEmployeeInfo.phoneNum1" class="text-danger">
                                                            {{ errorsEmployeeInfo.phoneNum1 }}
                                                        </div>

                                                    </div>

                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="other-infor p-2">
                                        <div class="info-title fw-bold">Other Information</div>
                                    </div>
                                    <div class="col-md-12 other-infor-center">
                                        <div class="row">

                                            <div class="col-md-4">
                                                <div class="mb-3">
                                                    <label for="position_id" class="form-label">Position</label>
                                                    <select class="form-select" id="position_id"
                                                        v-model="newEmployee.position_id" required>
                                                        <option selected disabled>Choose...</option>
                                                        <option v-for="position in positions" :key="position.id"
                                                            :value="position.id">
                                                            {{ position.positionName }}
                                                        </option>
                                                    </select>
                                                    <div v-if="errorsEmployeeInfo.position_id" class="text-danger">
                                                        {{ errorsEmployeeInfo.position_id }}
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Department</label>
                                                    <!-- <label for="dept_id" class="form-label">Department</label> -->
                                                    <select v-model="newEmployee.dept_id" id="dept_id"
                                                        class="form-select" required>
                                                        <option selected disabled>Choose...</option>
                                                        <option v-for="department in departments" :key="department.id"
                                                            :value="department.id">
                                                            {{ department.deptName }}
                                                        </option>
                                                    </select>
                                                    <div v-if="errorsEmployeeInfo.dept_id" class="text-danger">
                                                        {{ errorsEmployeeInfo.dept_id }}
                                                    </div>
                                                </div>

                                                <!-- Add other input fields for first name, last name, etc. -->
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <!-- Add input fields for other profile attributes -->
                                                <div class="mb-3">
                                                    <label for="address" class="form-label">Address</label>
                                                    <input type="text" class="form-control" id="address"
                                                        v-model="newEmployee.address" required>
                                                    <div v-if="errorsEmployeeInfo.address" class="text-danger">
                                                        {{ errorsEmployeeInfo.address }}
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="telegram" class="form-label">Telegram</label>
                                                    <input type="text" class="form-control" id="telegram"
                                                        v-model="newEmployee.telegram" required>
                                                    <div v-if="errorsEmployeeInfo.telegram" class="text-danger">
                                                        {{ errorsEmployeeInfo.telegram }}
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <div class="mb-3">
                                                    <label for="employeeDate" class="form-label">Employee Date</label>
                                                    <input type="date" class="form-control" id="employeeDate"
                                                        v-model="newEmployee.employeeDate" required>
                                                    <div v-if="errorsEmployeeInfo.employeeDate" class="text-danger">
                                                        {{ errorsEmployeeInfo.employeeDate }}
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="address" class="form-label">Status</label>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" id="status"
                                                            v-model="newEmployee.status">
                                                        <label class="form-check-label" for="status">Check if user is
                                                            active</label>
                                                    </div>
                                                </div>
                                                <!-- Add other input fields for first name, last name, etc. -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
            formData: {
                name: '',
                email: '',
                password: 'HR2024!',
                password_confirmation: 'HR2024!',
                roles: [], // TODO: make this an array of uuids, not names
            },
            errorsFormData: {
                name: '',
                email: '',
                roles: '',
            },
            roles: [],
            newEmployee: {
                user_id: '',
                position_id: '',
                dept_id: '',
                firstName: '',
                lastName: '',
                firstNameKH: '',
                lastNameKH: '',
                birthDate: '',
                gender: '',
                phoneNum1: '',
                address: '',
                telegram: '',
                employeeDate: '',
                status: 1
            },
            departments: [],
            positions: [],
            showAddmore: false,
            errorsEmployeeInfo: {
                position_id: '',
                dept_id: '',
                firstName: '',
                lastName: '',
                firstNameKH: '',
                lastNameKH: '',
                birthDate: '',
                gender: '',
                phoneNum1: '',
                address: '',
                telegram: '',
                employeeDate: '',
                status: 1
            },
        }
    },
    mounted() {
        console.log("Component mounted");
        this.fetchRoles();
        this.fetchDepartment();
        this.fetchPositions();
    },
    methods: {
        changeProfilePicture() {
            var input = document.createElement('input');
            input.type = 'file';
            input.accept = 'image/*';
            input.onchange = (event) => {
                var file = event.target.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = () => {
                        var img = document.querySelector('.rounded-circle');
                        img.src = reader.result;
                        // Now you can upload the image using Axios
                        this.uploadProfilePicture(file);
                    };
                    reader.readAsDataURL(file);
                }
            };
            input.click();
        },
        async addEmployee() {
            try {
                const userId = localStorage.getItem('userId');
                console.log(`User Id is ${userId}`);
                const token = localStorage.getItem('token');

                const response = await axios.post('https://hrm-system-test.up.railway.app/api/employee_detail', {
                    user_id: userId,
                    position_id: this.newEmployee.position_id,
                    dept_id: this.newEmployee.dept_id,
                    firstName: this.newEmployee.firstName,
                    lastName: this.newEmployee.lastName,
                    firstNameKH: this.newEmployee.firstNameKH,
                    lastNameKH: this.newEmployee.lastNameKH,
                    birthDate: this.newEmployee.birthDate,
                    gender: this.newEmployee.gender,
                    phoneNum1: this.newEmployee.phoneNum1,
                    address: this.newEmployee.address,
                    telegram: this.newEmployee.telegram,
                    employeeDate: this.newEmployee.employeeDate,
                    status: this.newEmployee.status,
                }, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    }
                });
                // const addEmployee = response.data;
                console.log(response.data);

                // Reset form fill
                this.newEmployee.position_id = '';
                this.newEmployee.dept_id = '';
                this.newEmployee.firstName = '';
                this.newEmployee.lastName = '';
                this.newEmployee.firstNameKH = '';
                this.newEmployee.lastNameKH = '';
                this.newEmployee.birthDate = '';
                this.newEmployee.gender = '';
                this.newEmployee.phoneNum1 = '';
                this.newEmployee.address = '';
                this.newEmployee.telegram = '';
                this.newEmployee.employeeDate = '';
                this.newEmployee.status = '';
            } catch (error) {
                console.error(error);
            }
        },
        async fetchDepartment() {
            const token = localStorage.getItem('token');
            axios.get('https://hrm-system-test.up.railway.app/api/department', {
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            })
                .then(response => {
                    this.departments = response.data.data;
                    // this.newEmployee.dept_id = '';
                    console.log(response.data);
                })
                .catch(error => {
                    console.error('Error fetching roles:', error);
                });
        },
        async fetchPositions() {
            const token = localStorage.getItem('token');
            axios.get('https://hrm-system-test.up.railway.app/api/position', {
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            })
                .then(response => {
                    this.positions = response.data.data;
                    // this.newEmployee.position_id = '';
                    console.log(this.positions);
                })
                .catch(error => {
                    console.error('Error fetching roles:', error);
                });
        },
        fetchRoles() {
            const token = localStorage.getItem('token');
            axios.get('https://hrm-system-test.up.railway.app/api/role_user', {
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            })
                .then(response => {
                    this.roles = response.data;
                    console.log(this.roles);
                })
                .catch(error => {
                    console.error('Error fetching roles:', error);
                });
        },

        async submitMultiForm() {
            if (!this.formData.name) {
                this.errorsFormData.name = 'Username is required';
            }
            if (!this.formData.email) {
                this.errorsFormData.email = 'Email is required';
            }
            if (this.formData.roles == []) {
                this.errorsFormData.roles = 'Roles is required';
            }
            if (this.errorsFormData.name || this.errorsFormData.email || this.errorsFormData.roles) {
                return;
            }
            this.showAddmore = true;
            this.formData.roles = [this.formData.roles];

            const token = localStorage.getItem('token');
            axios.post('https://hrm-system-test.up.railway.app/api/users', this.formData, {
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            })
                .then(response => {
                    console.log('Data saved successfully:', response.data);
                    this.resetForm();

                    // Save the user id
                    const userId = response.data.id;
                    console.log(`User ID: ${userId}`);

                    // Use the user id in the addEmployee method
                    localStorage.setItem('userId', userId);
                })
                .catch(error => {
                    console.error('Error saving data:', error);
                })
                .finally(() => {
                    console.log('Form submitted:', this.formData);
                });
        },
        async submitForm() {

            try {
                // this.formData.roles = [this.formData.roles];

                const token = localStorage.getItem('token');
                axios.post('https://hrm-system-test.up.railway.app/api/users', {
                    name: `${this.newEmployee.firstName} ${this.newEmployee.lastName}`,
                    email: `${this.newEmployee.lastName}@gmail.com`,
                    password: 'HR2024!',
                    password_confirmation: 'HR2024!',
                    roles: ["9b513035-55c5-4b9c-900e-535011f5e874"]
                }, {
                    headers: {
                        'Authorization': `Bearer ${token}`
                    }
                });
                console.log('Data saved successfully:', response.data);
                this.formData.name = '';
                this.formData.email = '';
                this.formData.password = '';
                this.formData.password_confirmation = '';
                this.formData.roles = [];
            } catch (error) {
                console.error('Error saving data:', error);
            }
        },
        resetForm() {
            this.errorsFormData.name = '';
            this.errorsFormData.email = '';
            this.errorsFormData.roles = '';
        },
        closeForm() {
            this.$router.go(-1);

        },
        async confirmAddNewEmployee() {
            // console.log('errors.publish_date:', this.errors.publish_date);
            try {
                if (!this.formData.name) {
                    this.errorsFormData.name = 'Username is required';
                }
                if (!this.formData.email) {
                    this.errorsFormData.email = 'Email is required';
                }
                if (this.formData.roles == []) {
                    this.errorsFormData.roles = 'Roles is required';
                }
                if (this.errorsFormData.name || this.errorsFormData.email || this.errorsFormData.roles) {
                    return;
                }

                const result = await Swal.fire({
                    title: 'Are you sure?',
                    text: 'Do you want add new Employee?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, I do!',
                    reverseButtons: true
                });
                if (result.isConfirmed) {
                    await this.submitForm().then(() => {
                        this.$router.go(-1);
                    });
                    Swal.fire({
                        title: 'Added!',
                        text: 'New Employee has been Added.',
                        icon: 'success'
                    }).then(() => {
                        this.$router.go(-1);
                    });
                }
            } catch (error) {
                console.error(error);
            }
        },
        async confirmAddInfoEmployee() {
            // console.log('errors.publish_date:', this.errors.publish_date);
            try {
                if (!this.newEmployee.position_id) {
                    this.errorsEmployeeInfo.position_id = 'Position is required';
                }
                if (!this.newEmployee.dept_id) {
                    this.errorsEmployeeInfo.dept_id = 'Department is required';
                }
                if (!this.newEmployee.firstName) {
                    this.errorsEmployeeInfo.firstName = 'Firstname is required';
                }
                if (!this.newEmployee.lastName) {
                    this.errorsEmployeeInfo.lastName = 'Lastname is required';
                }
                if (!this.newEmployee.firstNameKH) {
                    this.errorsEmployeeInfo.firstNameKH = 'FirstnameKH is required';
                }
                if (!this.newEmployee.lastNameKH) {
                    this.errorsEmployeeInfo.lastNameKH = 'LastnameKH is required';
                }
                if (!this.newEmployee.birthDate) {
                    this.errorsEmployeeInfo.birthDate = 'Date of Birth is required';
                }
                if (!this.newEmployee.gender) {
                    this.errorsEmployeeInfo.gender = 'Gender is required';
                }
                if (!this.newEmployee.phoneNum1) {
                    this.errorsEmployeeInfo.phoneNum1 = 'Phone Number is required';
                }
                if (!this.newEmployee.address) {
                    this.errorsEmployeeInfo.address = 'Address is required';
                }
                if (!this.newEmployee.telegram) {
                    this.errorsEmployeeInfo.telegram = 'Telegram is required';
                }
                if (!this.newEmployee.employeeDate) {
                    this.errorsEmployeeInfo.employeeDate = 'Date of Employee is required';
                }
                if (this.errorsEmployeeInfo.position_id || this.errorsEmployeeInfo.dept_id) {
                    return;
                }
                await this.submitForm();
                const result = await Swal.fire({
                    title: 'Are you sure?',
                    text: 'Do you want add new Employee?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, I do!',
                    reverseButtons: true
                });
                if (result.isConfirmed) {
                    await this.addEmployee().finally(() => {
                        this.$router.go(-1);
                        Swal.fire({
                            title: 'Added!',
                            text: 'New Employee has been Added.',
                            icon: 'success'
                        });
                    });
                }
            } catch (error) {
                console.error(error);
            }
        },
        closeSubmitForm() {
            this.$router.go(-1);
        },
        resetErrorMessage() {
            this.errorsEmployeeInfo.position_id = '';

            this.errorsEmployeeInfo.dept_id = '';

            this.errorsEmployeeInfo.firstName = '';

            this.errorsEmployeeInfo.lastName = '';

            this.errorsEmployeeInfo.firstNameKH = '';

            this.errorsEmployeeInfo.lastNameKH = '';

            this.errorsEmployeeInfo.birthDate = '';

            this.errorsEmployeeInfo.gender = '';

            this.errorsEmployeeInfo.phoneNum1 = '';

            this.errorsEmployeeInfo.address = '';

            this.errorsEmployeeInfo.telegram = '';

            this.errorsEmployeeInfo.employeeDate = '';

        }
    }
};
</script>

<!-- Add your Bootstrap imports here -->
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';