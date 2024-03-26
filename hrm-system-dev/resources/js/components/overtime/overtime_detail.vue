<template>
    <div>
        <div v-if="loading" class="vh-100 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-secondary " style="width: 3rem; height: 3rem;" role="status">
                <span class="visually-hidden  ">Loading...</span>
            </div>
        </div>
        <div v-else class="card m-5 rounded-top-4 rounded-bottom ">
            <div class="d-flex justify-content-end   card-header pt-3 rounded-top-4"
                style="background-color: rgb(0, 108, 81);">
                <div class="btn px-4 btn-secondary" @click="closeOvertimeDetail">
                    Close
                </div>
            </div>
            <div v-if="overtime" class="card-body rounded-bottom " style="background-color: #FFFFFF;">
                <div class="d-flex justify-content-between ">
                    <div class="h2"> Overtime</div>
                    <div class="" style="margin-top: 10px;">{{ formatDate(overtime.createDate) }}</div>
                </div>
                <div class="pt-1 rounded-2" style="background-color: rgb(0, 108, 81);"></div>
                <div class="mt-4">
                    <div class="d-flex mt-3 justify-content-between   ">
                        <div class="d-flex align-items-center justify-content-between" style="width: 40%;">
                            <div class="title-1 text-secondary mx-3 fw-bolder">
                                Overtime Title:
                            </div>
                            <div class="description-1 fw-bolder">
                                {{ overtime.title }}
                            </div>
                        </div>
                        <div class="d-flex align-items-center justify-content-around " style="width: 50%;">
                            <!-- <div class="text-secondary mx-3 fw-bolder ">
                                Total Reason:
                            </div>
                            <div class="">
                                {{ overtime.reason }}
                            </div> -->
                            <div class="title-2 text-secondary mx-3 fw-bolder">
                                Request By:
                            </div>
                            <div class="description-2 fw-bolder">
                                {{ overtime.employee.name }}
                            </div>
                        </div>
                    </div>
                    <div class=" bg-secondary me-5 mt-4 " style="padding-top: 1px;"></div>
                    <div class="d-flex mt-3 justify-content-between   ">
                        <div class="d-flex align-items-center justify-content-between" style="width: 40%;">

                            <div v-if="overtime.isApproved === null" class="title-1 text-secondary mx-3 fw-bolder">
                                Approved Overtime By:
                            </div>
                            <div v-else-if="overtime.isApproved === 0" class="title-1 text-secondary mx-3 fw-bolder">
                                Rejected Overtime By:
                            </div>
                            <div v-else-if="overtime.isApproved === 1" class="title-1 text-secondary mx-3 fw-bolder">
                                Approved Overtime By:
                            </div>
                            <div v-if="overtime.approved_by === null" class="fw-bolder">
                            </div>
                            <div v-else class="description-1 fw-bolder">
                                {{ overtime.approved_by.name }}
                            </div>
                        
                        </div>
                        <div class="d-flex align-items-center justify-content-around " style="width: 50%;">
                            <div class="title-2 text-secondary mx-3 fw-bolder ">
                                Phone (Mobile):
                            </div>
                            <div class="description-2 fw-bolder">
                                096 605 1816
                            </div>
                        </div>
                    </div>
                    <div class=" bg-secondary me-5 mt-4 " style="padding-top: 1px;"></div>
                    <div class="d-flex mt-4 justify-content-between   ">
                        <div class="d-flex align-items-center justify-content-between" style="width: 40%;">
                            <div class="title-1 text-secondary mx-3 fw-bolder">
                                Overtime Date:
                            </div>
                            <div class="description-1 fw-bolder">
                                {{ formatDate(overtime.dateOT) }}
                            </div>
                        </div>
                        <div class="d-flex align-items-center justify-content-around " style="width: 50%;">
                            <div class="title-2 text-secondary mx-3 fw-bolder ">
                                Time (From-To):
                            </div>
                            <div class="description-2 fw-bolder">
                                {{ timeOvertime(overtime.time_from) }} - {{ timeOvertime(overtime.time_to) }}
                            </div>
                        </div>
                    </div>
                    <div class=" bg-secondary me-5 mt-4 " style="padding-top: 1px;"></div>
                    <div class="d-flex mt-4 justify-content-between">
                        <div class="d-flex align-items-center justify-content-between" style="width: 40%;">
                            <div class="title-1 text-secondary mx-3 fw-bolder">
                                Total Overtime Request:
                            </div>
                            <div class="description-1 fw-bolder">
                                {{ timeToHoursMinutes(overtime.total_time) }}
                            </div>
                        </div>
                        <div class="d-flex align-items-center justify-content-around " style="width: 50%;">
                            <div class="title-2 text-secondary mx-3 fw-bolder ">
                                Total Overtime Approved:
                            </div>
                            <div class="description-2 fw-bolder">
                                {{ timeToHoursMinutes(overtime.total_approve) }}
                            </div>
                        </div>
                    </div>
                    <div class=" bg-secondary me-5 mt-3 " style="padding-top: 1px;"></div>
                    <!-- <div class="d-flex mt-4 justify-content-between">
                        <div class="d-flex align-items-center justify-content-between" style="width: 40%;">
                            <div v-if="overtime.isApproved === null" class="text-secondary mx-3 fw-bolder">
                                Approved Overtime By:
                            </div>
                            <div v-else-if="overtime.isApproved === 0" class="text-secondary mx-3 fw-bolder">
                                Rejected Overtime By:
                            </div>
                            <div v-else-if="overtime.isApproved === 1" class="text-secondary mx-3 fw-bolder">
                                Approved Overtime By:
                            </div>
                            <div v-if="overtime.approved_by === null" class="fw-bolder">
                            </div>
                            <div v-else class="fw-bolder">
                                {{ overtime.approved_by.name }}
                            </div>
                        </div>
                    </div> -->
                    <fieldset disabled class="me-5 mt-3">
                        <div class="mb-3">
                            <label for="inputOvertime" class="form-label">Reason</label>
                            <textarea class="form-control" placeholder=" " id="floatingTextarea2"
                                style="height: auto">{{ overtime.reason }}</textarea>
                        </div>
                    </fieldset>
                    
                    <fieldset disabled class="me-5">
                        <div class="mb-3">
                            <label for="inputOvertime" class="form-label">Comment</label>
                            <textarea class="form-control" placeholder=" " id="floatingTextarea2"
                                style="height: 100px">{{ overtime.overtime_comment }}</textarea>
                        </div>
                    </fieldset>
                </div>
                <div v-if="overtime.isApproved === null" class="d-flex mt-5">
                    <div @click="openReject(overtime)" class="btn p-2 btn-danger"
                        style="width: 50%; border-radius: 1rem 0 0 1rem;">
                        Reject Overtime
                    </div>
                    <div @click="openApprove(overtime)" class="btn p-2 btn-success"
                        style="width: 50%; border-radius: 0 1rem 1rem 0;">
                        Approve Overtime
                    </div>
                </div>
                <div v-else-if="overtime.isApproved === 1" class="d-flex mt-5">
                    <div class="btn p-2 btn-success disabled  " style="width: 100%;border-radius: 1rem 1rem 1rem 1rem;">
                        Approved
                    </div>
                </div>
                <div v-else-if="overtime.isApproved === 0" class="d-flex mt-5">
                    <div class="btn p-2 btn-danger disabled  " style="width: 100%;border-radius: 1rem 1rem 1rem 1rem;">
                        Rejected
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Approve OT-->
    <div class="popup" v-if="showApproveDialog">
        <div class="popup-content" style="width: 65%;">
            <div class="form-container" style="height: 600px; overflow-y: auto;">
                <form class="row g-4">
                    <dev class="cardHeader">
                        <h2>Approve Overtime</h2>
                    </dev>
                    <div class="row justify-content-center align-content-center">
                        <fieldset disabled>
                            <div class="mb-3">
                                <label for="inputOvertime" class="form-label">Title</label>
                                <input class="form-control" placeholder=" " id="floatingTextarea2"
                                    v-model="overtimeApprove.title"></input>
                            </div>
                            <div class="mb-3">
                                <label for="inputOvertime" class="form-label">Reason</label>
                                <textarea class="form-control" placeholder=" " id="floatingTextarea2"
                                    style="height: 100px" v-model="overtimeApprove.reason"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="inputOvertime" class="form-label">Overtime Date</label>
                                <input class="form-control" placeholder=" " id="floatingTextarea2"
                                    v-model="formattedDateOT"></input>
                            </div>
                            <div class="d-flex justify-content-between">
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputOvertime" class="form-label">Time From</label>
                                    <input class="form-control" placeholder=" " id="floatingTextarea2"
                                        v-model="formattedTimeFrom"></input>
                                </div>
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputOvertime" class="form-label">Time To</label>
                                    <input class="form-control" placeholder=" " id="floatingTextarea2"
                                        v-model="formattedTimeTo"></input>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="inputOvertime" class="form-label">Total Overtime Request</label>
                                <input class="form-control" placeholder=" " id="floatingTextarea2"
                                    v-model="formattedTotalOT"></input>
                            </div>
                        </fieldset>
                        <div class="mb-3">
                            <label for="totalApprove" class="form-label">Time Approve(e.g. 1 = 1h)</label>
                            <input class="form-control" placeholder=" " id="totalApprove"
                                v-model.number="overtimeApprove.total_approve" required></input>
                            <div v-if="errors.total_approve" class="text-danger">
                                {{ errors.total_approve }}
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="inputOvertime" class="form-label">Comments</label>
                            <textarea class="form-control" placeholder=" " id="floatingTextarea2" style="height: 100px"
                                v-model="overtimeApprove.overtime_comment" required></textarea>
                            <div v-if="errors.overtime_comment" class="text-danger">
                                {{ errors.overtime_comment }}
                            </div>
                        </div>
                    </div>
                    <div class="d-flex mt-3 mb-3 ">
                        <div @click="closeApprove" class="btn p-2 btn-danger"
                            style="width: 50%; border-radius: 1rem 0 0 1rem;">
                            Cancel
                        </div>
                        <div @click="confirmApproved(overtimeApprove.id)" class="btn p-2 btn-success"
                            style="width: 50%; border-radius: 0 1rem 1rem 0;">
                            Approve
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Reject OT-->
    <div class="popup" v-if="showRejectDialog">
        <div class="popup-content" style="width: 65%;">
            <div class="form-container" style="height: 600px; overflow-y: auto;">
                <form class="row g-4">
                    <dev class="cardHeader">
                        <h2>Reject Overtime</h2>
                    </dev>
                    <div class="row justify-content-center align-content-center">
                        <fieldset disabled>
                            <div class="mb-3">
                                <label for="inputOvertime" class="form-label">Title</label>
                                <input class="form-control" placeholder=" " id="floatingTextarea2"
                                    v-model="overtimeApprove.title"></input>
                            </div>
                            <div class="mb-3">
                                <label for="inputOvertime" class="form-label">Reason</label>
                                <textarea class="form-control" placeholder=" " id="floatingTextarea2"
                                    style="height: 100px" v-model="overtimeApprove.reason"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="inputOvertime" class="form-label">Overtime Date</label>
                                <input class="form-control" placeholder=" " id="floatingTextarea2"
                                    v-model="formattedDateOT"></input>
                            </div>
                            <div class="d-flex justify-content-between">
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputOvertime" class="form-label">Time From</label>
                                    <input class="form-control" placeholder=" " id="floatingTextarea2"
                                        v-model="formattedTimeFrom"></input>
                                </div>
                                <div class="mb-3" style="width: 45%;">
                                    <label for="inputOvertime" class="form-label">Time To</label>
                                    <input class="form-control" placeholder=" " id="floatingTextarea2"
                                        v-model="formattedTimeTo"></input>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="inputOvertime" class="form-label">Total Overtime Request</label>
                                <input class="form-control" placeholder=" " id="floatingTextarea2"
                                    v-model="formattedTotalOT"></input>
                            </div>
                        </fieldset>
                        <div class="mb-3">
                            <label for="inputOvertime" class="form-label">Comments</label>
                            <textarea class="form-control" placeholder=" " id="floatingTextarea2" style="height: 100px"
                                v-model="overtimeApprove.overtime_comment" required></textarea>
                            <div v-if="errors.overtime_comment" class="text-danger">
                                {{ errors.overtime_comment }}
                            </div>
                        </div>
                    </div>
                    <div class="d-flex mt-3 mb-3 ">
                        <div @click="closeReject" class="btn p-2 btn-danger"
                            style="width: 50%; border-radius: 1rem 0 0 1rem;">
                            Cancel
                        </div>
                        <div @click="confirmRejected(overtimeApprove.id)" class="btn p-2 btn-success"
                            style="width: 50%; border-radius: 0 1rem 1rem 0;">
                            Reject
                        </div>
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
            overtime: null,
            loading: false,
            showApproveDialog: false,
            showRejectDialog: false,
            overtimeApprove: [],
            errors: {
                total_approve: '',
                overtime_comment: ''
            }
        };
    },
    mounted() {
        console.log("Component mounted");
        this.getOvertime();
    },
    computed: {
        formattedDateOT() {
            if (this.overtimeApprove && this.overtimeApprove.dateOT) {
                return this.formatDate(this.overtimeApprove.dateOT);
            } else {
                return '';
            }
        },
        formattedTimeFrom() {
            if (this.overtimeApprove && this.overtimeApprove.time_from) {
                return this.timeFormat(this.overtimeApprove.time_from);
            } else {
                return '';
            }
        },
        formattedTimeTo() {
            if (this.overtimeApprove && this.overtimeApprove.time_to) {
                return this.timeFormat(this.overtimeApprove.time_to);
            } else {
                return '';
            }
        },
        formattedTotalOT() {
            if (this.overtimeApprove && this.overtimeApprove.total_time) {
                return this.timeToHoursMinutes(this.overtimeApprove.total_time)
            } else {
                return "00 hr 00 min";
            }
        }

    },
    methods: {
        openApprove(overtime) {
            this.showApproveDialog = true;
            this.overtimeApprove = overtime;
            console.log(this.overtimeApprove);
        },
        closeApprove() {
            this.showApproveDialog = false;
            this.overtimeApprove.total_approve = '';
            this.overtimeApprove.overtime_comment = '';
        },
        openReject(overtime) {
            this.showRejectDialog = true;
            this.overtimeApprove = overtime;
            console.log(this.overtimeApprove);
        },
        closeReject() {
            this.showRejectDialog = false
            this.overtimeApprove.overtime_comment = '';
        },
        async getOvertime() {
            this.loading = true;
            try {
                // Get the employee ID from the query parameters
                const overtimeId = this.$route.params.id;
                console.log(overtimeId);
                const token = localStorage.getItem('token');

                const response = await axios.get(`https://hrm-system-test.up.railway.app/api/overtime_detail/${overtimeId}`, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    }
                });
                this.overtime = response.data.data; // Assign the user data to the component's data property
                console.log(this.overtime);
            } catch (error) {
                console.error(error);
            }
            this.loading = false;
        },
        async approveOvertime(id) {
            try {
                const empId = localStorage.getItem('id');
                const token = localStorage.getItem('token');
                const response = await axios.put(`https://hrm-system-test.up.railway.app/api/overtime/approveOT/${this.overtimeApprove.id}`, {
                    approvedById: empId,
                    isApproved: true,
                    total_approve: this.overtimeApprove.total_approve,
                    overtime_comment: this.overtimeApprove.overtime_comment
                }, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                console.log(response.data.data);
                // this.showApproveDialog = false;
                // window.location.reload();
            } catch (error) {
                console.error(error);
            }
        },
        async rejectOvertime(id) {
            try {
                const empId = localStorage.getItem('id');
                const token = localStorage.getItem('token');
                const response = await axios.put(`https://hrm-system-test.up.railway.app/api/overtime/approveOT/${this.overtimeApprove.id}`, {
                    approvedById: empId,
                    isApproved: false,
                    overtime_comment: this.overtimeApprove.overtime_comment
                }, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                console.log(response.data.data);
            } catch (error) {
                console.error(error);
            }
        },
        formatDate(dateString) {
            const date = new Date(dateString);
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const formatter = new Intl.DateTimeFormat('en-US', options);
            const parts = formatter.formatToParts(date);
            const formattedDate = `${parts[0].value}, ${parts[4].value} ${parts[2].value} ${parts[3].value} ${parts[6].value}`;
            return formattedDate;
        },
        timeOvertime(date) {
            const [hours, minutes] = date.split(':');
            return `${hours}:${minutes.padStart(2, '0')}`;
        },
        timeFormat(date) {
            const [hours, minutes] = date.split(':');
            const formattedDate = new Date(0, 0, 0, hours, minutes, 0);
            const formattedHours = formattedDate.getHours() % 12 || 12;
            const minutesFormatted = String(formattedDate.getMinutes()).padStart(2, '0');
            const period = formattedDate.getHours() < 12 ? 'AM' : 'PM';

            return `${formattedHours}:${minutesFormatted} ${period}`;
        },
        timeToHoursMinutes(total_time) {
            if (!total_time) {
                return "00 hr 00 mins";
            }

            const hours = Math.floor(total_time);
            const minutes = Math.round((total_time - hours) * 60);

            return `${hours.toString().padStart(2, '0')} hr ${minutes.toString().padStart(2, '0')} mins`;
        },
        closeOvertimeDetail() {
            this.$router.go(-1);
        },
        async confirmApproved(id) {
            try {
                if (!this.overtimeApprove.total_approve || !/^-?\d*\.?\d+$/.test(this.overtimeApprove.total_approve)) {
                    this.errors.total_approve = 'Total approve is required and must be numeric';
                }
                if (!this.overtimeApprove.overtime_comment) {
                    this.errors.overtime_comment = 'Comments are required';
                }
                if (this.errors.total_approve || this.errors.overtime_comment) {
                    return;
                }
                this.showApproveDialog = false;

                const result = await Swal.fire({
                    title: 'Are you sure?',
                    text: 'You won\'t be able to change it again!',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Approve it!',
                    reverseButtons: true
                });
                if (result.isConfirmed) {
                    await this.approveOvertime(id).then(() => {
                        this.getOvertime();
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
        async confirmRejected(id) {
            try {
                if (!this.overtimeApprove.overtime_comment) {
                    this.errors.overtime_comment = 'Comments are required';
                }
                if (this.errors.overtime_comment) {
                    return;
                }
                this.showRejectDialog = false;

                const result = await Swal.fire({
                    title: 'Are you sure?',
                    text: 'You won\'t be able to change it again!',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Reject it!',
                    reverseButtons: true
                });
                if (result.isConfirmed) {
                    await this.rejectOvertime(id).then(() => {
                        this.getOvertime();
                        Swal.fire({
                            title: 'Rejected!',
                            text: 'Overtime has been Rejected.',
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
.title-1 {
    display: block !important;
    width: 100%;
}

.title-2 {
    display: block !important;
    width: 100%;
}

.description-1 {
    display: block !important;
    width: 100%;
}

.description-2 {
    display: block !important;
    width: 100%;
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
</style>

<!-- Add your Bootstrap imports here -->
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';