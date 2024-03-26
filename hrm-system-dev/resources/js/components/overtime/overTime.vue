<style scoped>
.table-wrapper {
  padding: 20px;
}

.imgBx img {
  position: relative;
  width: 40px;
  /* height: 30px; */
  border-radius: 50%;
  overflow: hidden;
  cursor: pointer;
}

/* .table-list {
  background-color: white;
  border-radius: 10px;
  border-collapse: separate;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
} */

.cardHeader h5 {
  padding-left: 15px;
  padding-top: 20px;
  color: rgb(0, 108, 81);
}

/* Default color for h4 */
.nav-link h5 {
  color: white;
  border: 0;
}

/* Color for h4 when its parent is active */
.nav-link.active h5 {
  color: rgb(0, 108, 81);
}

.nav-tabs .nav-item:hover .nav-link {
  border-color: transparent !important;
}

.line-space {
  height: 20px;

}


.no-placeholder::before {
  content: none !important;
}

.loading {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100px;
}

.spinner-border {
  width: 3rem;
  height: 3rem;
}
</style>

<template>
  <div class="table-wrapper">
    <div class="text-success h4 pb-4 ">
      Overtimes
    </div>
    <div class=" rounded-3 pb-3" style="background-color: #F3F3F3;">
      <div class="mt-3 mb-3 ps-5">
        <form class="row g-3">
          <div class="col-md-4">
            <label for="dateFilter" class="form-label">Date</label>
            <input type="date" class="form-control" placeholder=" " id="date-filter" @change="handleDateChange">
          </div>
        </form>
      </div>
      <div class="d-flex justify-content-evenly ">
        <div class="card m-2" style="background-color: #FFFFFF;">

          <div class="card-body">
            <h5 class="card-title" style="color:rgb(0, 108, 81);">Total Overtimes Request</h5>
            <p  class="card-text h6 text-secondary text-end ">{{ total_request.total_request }} Requests</p>
          </div>
        </div>
        <div class="card m-2" style="background-color: #FFFFFF;">

          <div class="card-body">
            <h5 class="card-title" style="color:rgb(0, 108, 81);">Total Times Overtime Request</h5>
            <p class="card-text h6 text-secondary text-end">{{ timeToHoursMinutes(total_request.total_times) }}</p>
          </div>
        </div>
        <div class="card m-2" style="background-color: #FFFFFF;">

          <div class="card-body">
            <h5 class="card-title" style="color:rgb(0, 108, 81);">Total Times Overtime Approved</h5>
            <p class="card-text h6 text-secondary text-end">{{ timeToHoursMinutes(total_request.total_approved) }}</p>
          </div>
        </div>
      </div>

    </div>
    <div class="pt-3">
      <ul class="nav nav-tabs rounded-top" style="background-color: rgb(0, 108, 81);">
        <li class="nav-item ps-2">
          <a class="nav-link active mt-3 " data-bs-toggle="tab" href="#AllOvertime" @click="fetchOvertimes()">
            <div class="cardHeader-tab active  px-5 ">
              <h5>All</h5>
            </div>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link mt-3" data-bs-toggle="tab" href="#Overtime" @click="fetchfilterOvertimes(null)">
            <div class="cardHeader-tab active px-5">
              <h5>Overtime</h5>
            </div>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link mt-3" data-bs-toggle="tab" href="#approve" @click="fetchfilterOvertimes(1)">
            <div class="cardHeader-tab active px-5">
              <h5>Approved</h5>
            </div>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link mt-3" data-bs-toggle="tab" href="#reject" @click="fetchfilterOvertimes(0)">
            <div class="cardHeader-tab active px-5">
              <h5>Rejected</h5>
            </div>
          </a>
        </li>
      </ul>
    </div>

    <div class="tab-content pt-3">
      <!-- Overtime Tab -->
      <div class="tab-pane active" id="AllOvertime">
        <div class="row">
          <div v-if="loading" class="d-flex  justify-content-center w-100 ">
            <div class="spinner-border text-secondary " style="width: 3rem; height: 3rem;" role="status">
              <span class="visually-hidden  ">Loading...</span>
            </div>
          </div>
          <div v-else class="col-md-4" v-for="(overtime, index) in overtimes" :key="overtime.id">
            <router-link :to="{ name: 'OvertimeDetail', params: { id: overtime.id } }" class="text-decoration-none ">
              <div class="card m-1">
                <div class="card-header text-white  d-flex justify-content-between "
                  style="background-color: rgb(0, 108, 81);">
                  <div class="" style="padding-top: 10px;">
                    <div v-if="overtime.isApproved === null">Pending</div>
                    <div v-else-if="overtime.isApproved === 1">Approved</div>
                    <div v-else-if="overtime.isApproved === 0">Rejected</div>
                  </div>
                  <div class="d-flex ">
                    <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor"
                      class="bi bi-clock mx-2" style="margin-top: 10px;" viewBox="0 0 16 16">
                      <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z" />
                      <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0" />
                    </svg>
                    <div>
                      <div>
                        {{ formatDate(overtime.createDate) }}
                      </div>
                      <div>
                        {{ timeFormat(overtime.createDate) }}
                      </div>
                    </div>
                  </div>
                </div>
                <div class="card-body">
                  <div class="border border-2 border-success rounded-3 p-3">
                    <div class="d-flex justify-content-between ">
                      <div class="d-flex">
                        <div>
                          <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                            class="bi bi-calendar-week" viewBox="0 0 16 16">
                            <path
                              d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm-3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm-5 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5z" />
                            <path
                              d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5M1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4z" />
                          </svg>
                        </div>
                        <div class="pt-1 px-2">
                          {{ formatDate(overtime.dateOT) }}
                        </div>
                      </div>
                      <div class="d-flex ">
                        <div>
                          <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                            class="bi bi-clock" viewBox="0 0 16 16">
                            <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z" />
                            <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0" />
                          </svg>
                        </div>
                        <div class="pt-1 px-2">
                          {{ timeOvertime(overtime.time_from) }} - {{ timeOvertime(overtime.time_to) }}
                        </div>
                      </div>
                    </div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-stopwatch" viewBox="0 0 16 16">
                          <path d="M8.5 5.6a.5.5 0 1 0-1 0v2.9h-3a.5.5 0 0 0 0 1H8a.5.5 0 0 0 .5-.5z" />
                          <path
                            d="M6.5 1A.5.5 0 0 1 7 .5h2a.5.5 0 0 1 0 1v.57c1.36.196 2.594.78 3.584 1.64l.012-.013.354-.354-.354-.353a.5.5 0 0 1 .707-.708l1.414 1.415a.5.5 0 1 1-.707.707l-.353-.354-.354.354-.013.012A7 7 0 1 1 7 2.071V1.5a.5.5 0 0 1-.5-.5M8 3a6 6 0 1 0 .001 12A6 6 0 0 0 8 3" />
                        </svg>
                      </div>
                      <div class="pt-1 px-2">
                        {{ timeToHoursMinutes(overtime.total_time) }}
                      </div>
                    </div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-chat-right-text" viewBox="0 0 16 16">
                          <path
                            d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z" />
                          <path
                            d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5M3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6m0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5" />
                        </svg>
                      </div>
                      <div class=" px-2">
                        {{ overtime.title }}
                      </div>
                    </div>
                    <div class="card border-3 border-success mt-2 "></div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-person-circle" viewBox="0 0 16 16">
                          <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
                          <path fill-rule="evenodd"
                            d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1" />
                        </svg>
                      </div>
                      <div class=" px-2" style="padding-top: 2px;">
                        {{ overtime.employee.name }}
                      </div>
                    </div>
                  </div>

                </div>
              </div>
            </router-link>
          </div>
        </div>
      </div>

      <!-- Overtime Request tab -->
      <div class="tab-pane fade" id="Overtime">
        <div class="row">
          <div v-if="loading" class="d-flex  justify-content-center w-100 ">
            <div class="spinner-border text-secondary " style="width: 3rem; height: 3rem;" role="status">
              <span class="visually-hidden  ">Loading...</span>
            </div>
          </div>
          <div v-else class="col-md-4" v-for="(overtime, index) in overtimes" :key="overtime.id">
            <router-link :to="{ name: 'OvertimeDetail', params: { id: overtime.id } }" class="text-decoration-none ">
              <div class="card m-1">
                <div class="card-header text-white  d-flex justify-content-between "
                  style="background-color: rgb(0, 108, 81);">
                  <div class="" style="padding-top: 10px;">
                    <div v-if="overtime.isApproved === null">Pending</div>
                    <div v-else-if="overtime.isApproved === 1">Approved</div>
                    <div v-else-if="overtime.isApproved === 0">Rejected</div>
                  </div>
                  <div class="d-flex ">
                    <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor"
                      class="bi bi-clock mx-2" style="margin-top: 10px;" viewBox="0 0 16 16">
                      <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z" />
                      <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0" />
                    </svg>
                    <div>
                      <div>
                        {{ formatDate(overtime.createDate) }}
                      </div>
                      <div>
                        {{ timeFormat(overtime.createDate) }}
                      </div>
                    </div>
                  </div>
                </div>
                <div class="card-body">
                  <div class="border border-2 border-success rounded-3 p-3">
                    <div class="d-flex justify-content-between ">
                      <div class="d-flex">
                        <div>
                          <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                            class="bi bi-calendar-week" viewBox="0 0 16 16">
                            <path
                              d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm-3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm-5 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5z" />
                            <path
                              d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5M1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4z" />
                          </svg>
                        </div>
                        <div class="pt-1 px-2">
                          {{ formatDate(overtime.dateOT) }}
                        </div>
                      </div>
                      <div class="d-flex ">
                        <div>
                          <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                            class="bi bi-clock" viewBox="0 0 16 16">
                            <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z" />
                            <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0" />
                          </svg>
                        </div>
                        <div class="pt-1 px-2">
                          {{ timeOvertime(overtime.time_from) }} - {{ timeOvertime(overtime.time_to) }}
                        </div>
                      </div>
                    </div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-stopwatch" viewBox="0 0 16 16">
                          <path d="M8.5 5.6a.5.5 0 1 0-1 0v2.9h-3a.5.5 0 0 0 0 1H8a.5.5 0 0 0 .5-.5z" />
                          <path
                            d="M6.5 1A.5.5 0 0 1 7 .5h2a.5.5 0 0 1 0 1v.57c1.36.196 2.594.78 3.584 1.64l.012-.013.354-.354-.354-.353a.5.5 0 0 1 .707-.708l1.414 1.415a.5.5 0 1 1-.707.707l-.353-.354-.354.354-.013.012A7 7 0 1 1 7 2.071V1.5a.5.5 0 0 1-.5-.5M8 3a6 6 0 1 0 .001 12A6 6 0 0 0 8 3" />
                        </svg>
                      </div>
                      <div class="pt-1 px-2">
                        {{ timeToHoursMinutes(overtime.total_time) }}
                      </div>
                    </div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-chat-right-text" viewBox="0 0 16 16">
                          <path
                            d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z" />
                          <path
                            d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5M3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6m0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5" />
                        </svg>
                      </div>
                      <div class=" px-2">
                        {{ overtime.title }}
                      </div>
                    </div>
                    <div class="card border-3 border-success mt-2 "></div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-person-circle" viewBox="0 0 16 16">
                          <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
                          <path fill-rule="evenodd"
                            d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1" />
                        </svg>
                      </div>
                      <div class=" px-2" style="padding-top: 2px;">
                        {{ overtime.employee.name }}
                      </div>
                    </div>
                  </div>

                </div>
              </div>
            </router-link>
          </div>
        </div>
      </div>

      <!-- Approve Tab -->
      <div class="tab-pane fade" id="approve">
        <div class="row">
          <div v-if="loading" class="d-flex  justify-content-center w-100 ">
            <div class="spinner-border text-secondary " style="width: 3rem; height: 3rem;" role="status">
              <span class="visually-hidden  ">Loading...</span>
            </div>
          </div>
          <div v-else class="col-md-4" v-for="(overtime, index) in overtimes" :key="overtime.id">
            <router-link :to="{ name: 'OvertimeDetail', params: { id: overtime.id } }" class="text-decoration-none ">
              <div class="card m-1">
                <div class="card-header text-white  d-flex justify-content-between "
                  style="background-color: rgb(0, 108, 81);">
                  <div class="" style="padding-top: 10px;">
                    <div v-if="overtime.isApproved === null">Pending</div>
                    <div v-else-if="overtime.isApproved === 1">Approved</div>
                    <div v-else-if="overtime.isApproved === 0">Rejected</div>
                  </div>
                  <div class="d-flex ">
                    <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor"
                      class="bi bi-clock mx-2" style="margin-top: 10px;" viewBox="0 0 16 16">
                      <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z" />
                      <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0" />
                    </svg>
                    <div>
                      <div>
                        {{ formatDate(overtime.createDate) }}
                      </div>
                      <div>
                        {{ timeFormat(overtime.createDate) }}
                      </div>
                    </div>
                  </div>
                </div>
                <div class="card-body">
                  <div class="border border-2 border-success rounded-3 p-3">
                    <div class="d-flex justify-content-between ">
                      <div class="d-flex">
                        <div>
                          <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                            class="bi bi-calendar-week" viewBox="0 0 16 16">
                            <path
                              d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm-3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm-5 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5z" />
                            <path
                              d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5M1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4z" />
                          </svg>
                        </div>
                        <div class="pt-1 px-2">
                          {{ formatDate(overtime.dateOT) }}
                        </div>
                      </div>
                      <div class="d-flex ">
                        <div>
                          <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                            class="bi bi-clock" viewBox="0 0 16 16">
                            <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z" />
                            <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0" />
                          </svg>
                        </div>
                        <div class="pt-1 px-2">
                          {{ timeOvertime(overtime.time_from) }} - {{ timeOvertime(overtime.time_to) }}
                        </div>
                      </div>
                    </div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-stopwatch" viewBox="0 0 16 16">
                          <path d="M8.5 5.6a.5.5 0 1 0-1 0v2.9h-3a.5.5 0 0 0 0 1H8a.5.5 0 0 0 .5-.5z" />
                          <path
                            d="M6.5 1A.5.5 0 0 1 7 .5h2a.5.5 0 0 1 0 1v.57c1.36.196 2.594.78 3.584 1.64l.012-.013.354-.354-.354-.353a.5.5 0 0 1 .707-.708l1.414 1.415a.5.5 0 1 1-.707.707l-.353-.354-.354.354-.013.012A7 7 0 1 1 7 2.071V1.5a.5.5 0 0 1-.5-.5M8 3a6 6 0 1 0 .001 12A6 6 0 0 0 8 3" />
                        </svg>
                      </div>
                      <div class="pt-1 px-2">
                        {{ timeToHoursMinutes(overtime.total_time) }}
                      </div>
                    </div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-chat-right-text" viewBox="0 0 16 16">
                          <path
                            d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z" />
                          <path
                            d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5M3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6m0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5" />
                        </svg>
                      </div>
                      <div class=" px-2">
                        {{ overtime.title }}
                      </div>
                    </div>
                    <div class="card border-3 border-success mt-2 "></div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-person-circle" viewBox="0 0 16 16">
                          <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
                          <path fill-rule="evenodd"
                            d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1" />
                        </svg>
                      </div>
                      <div class=" px-2" style="padding-top: 2px;">
                        {{ overtime.employee.name }}
                      </div>
                    </div>
                  </div>

                </div>
              </div>
            </router-link>
          </div>
        </div>
      </div>

      <!-- Reject Tab -->
      <div class="tab-pane fade" id="reject">
        <div class="row">
          <div v-if="loading" class="d-flex  justify-content-center w-100 ">
            <div class="spinner-border text-secondary " style="width: 3rem; height: 3rem;" role="status">
              <span class="visually-hidden  ">Loading...</span>
            </div>
          </div>
          <div v-else class="col-md-4" v-for="(overtime, index) in overtimes" :key="overtime.id">
            <router-link :to="{ name: 'OvertimeDetail', params: { id: overtime.id } }" class="text-decoration-none ">
              <div class="card m-1">
                <div class="card-header text-white  d-flex justify-content-between "
                  style="background-color: rgb(0, 108, 81);">
                  <div class="" style="padding-top: 10px;">
                    <div v-if="overtime.isApproved === null">Pending</div>
                    <div v-else-if="overtime.isApproved === 1">Approved</div>
                    <div v-else-if="overtime.isApproved === 0">Rejected</div>
                  </div>
                  <div class="d-flex ">
                    <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor"
                      class="bi bi-clock mx-2" style="margin-top: 10px;" viewBox="0 0 16 16">
                      <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z" />
                      <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0" />
                    </svg>
                    <div>
                      <div>
                        {{ formatDate(overtime.createDate) }}
                      </div>
                      <div>
                        {{ timeFormat(overtime.createDate) }}
                      </div>
                    </div>
                  </div>
                </div>
                <div class="card-body">
                  <div class="border border-2 border-success rounded-3 p-3">
                    <div class="d-flex justify-content-between ">
                      <div class="d-flex">
                        <div>
                          <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                            class="bi bi-calendar-week" viewBox="0 0 16 16">
                            <path
                              d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm-3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm-5 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5z" />
                            <path
                              d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5M1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4z" />
                          </svg>
                        </div>
                        <div class="pt-1 px-2">
                          {{ formatDate(overtime.dateOT) }}
                        </div>
                      </div>
                      <div class="d-flex ">
                        <div>
                          <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                            class="bi bi-clock" viewBox="0 0 16 16">
                            <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z" />
                            <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0" />
                          </svg>
                        </div>
                        <div class="pt-1 px-2">
                          {{ timeOvertime(overtime.time_from) }} - {{ timeOvertime(overtime.time_to) }}
                        </div>
                      </div>
                    </div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-stopwatch" viewBox="0 0 16 16">
                          <path d="M8.5 5.6a.5.5 0 1 0-1 0v2.9h-3a.5.5 0 0 0 0 1H8a.5.5 0 0 0 .5-.5z" />
                          <path
                            d="M6.5 1A.5.5 0 0 1 7 .5h2a.5.5 0 0 1 0 1v.57c1.36.196 2.594.78 3.584 1.64l.012-.013.354-.354-.354-.353a.5.5 0 0 1 .707-.708l1.414 1.415a.5.5 0 1 1-.707.707l-.353-.354-.354.354-.013.012A7 7 0 1 1 7 2.071V1.5a.5.5 0 0 1-.5-.5M8 3a6 6 0 1 0 .001 12A6 6 0 0 0 8 3" />
                        </svg>
                      </div>
                      <div class="pt-1 px-2">
                        {{ timeToHoursMinutes(overtime.total_time) }}
                      </div>
                    </div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-chat-right-text" viewBox="0 0 16 16">
                          <path
                            d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z" />
                          <path
                            d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5M3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6m0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5" />
                        </svg>
                      </div>
                      <div class=" px-2">
                        {{ overtime.title }}
                      </div>
                    </div>
                    <div class="card border-3 border-success mt-2 "></div>
                    <div class="d-flex pt-3">
                      <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                          class="bi bi-person-circle" viewBox="0 0 16 16">
                          <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
                          <path fill-rule="evenodd"
                            d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1" />
                        </svg>
                      </div>
                      <div class=" px-2" style="padding-top: 2px;">
                        {{ overtime.employee.name }}
                      </div>
                    </div>
                  </div>

                </div>
              </div>
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
import axios from 'axios';
import PopupModel1 from '../components/reject_repuest.vue';
import { formatDate } from '@fullcalendar/core';

export default {
  components: {

    PopupModel1,

  },
  data() {
    return {
      showPopup1: false,
      overtimes: [],
      currentPage: 1,
      loading: false,
      currentTab: 'all',
      selectedDate: null,
      total_request: [],
    };
  },
  created() {
    this.$nextTick(() => {
      const dateFilterInput = document.getElementById('date-filter');
      const today = new Date();
      const year = today.getFullYear();
      const month = String(today.getMonth() + 1).padStart(2, '0');
      const day = String(today.getDate()).padStart(2, '0');
      const formattedDate = `${year}-${month}-${day}`;
      dateFilterInput.value = formattedDate;
    });
  },
  mounted() {
    console.log("Integrate Overtime")
    this.fetchOvertimes();
    this.fetchOvertimeCount('');
    this.currentTab = 'all';
  },
  methods: {
    async fetchOvertimes() {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');
        const response = await axios.get('https://hrm-system-test.up.railway.app/api/overtime', {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.overtimes = response.data.data; // Assign the user data to the component's data property
        console.log(response.data.data);
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async fetchfilterOvertimes(type) {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');
        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/overtime?isApproved=${type}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.overtimes = response.data.data; // Assign the user data to the component's data property
        console.log(this.overtimes)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    handleDateChange(event) {
      this.selectedDate = event.target.value;
      this.fetchfilterCreateDateOvertimes(this.selectedDate);
      this.fetchOvertimeCount(this.selectedDate);
    },
    async fetchfilterCreateDateOvertimes(date) {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');
        const formattedDate = date.split('-').join(''); // convert yyyy-mm-dd to yyyymmdd
        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/overtime?createDate=${formattedDate}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        this.overtimes = response.data.data; // Assign the user data to the component's data property
        console.log(this.overtimes)
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    async fetchOvertimeCount(date) {
      this.loading = true;
      try {
        const token = localStorage.getItem('token');
        const formattedDate = date.split('-').join(''); // convert yyyy-mm-dd to yyyymmdd
        const response = await axios.get(`https://hrm-system-test.up.railway.app/api/count_overtime?date=${formattedDate}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        if (response.data.data.length > 0) {
          this.total_request = response.data.data[0]; // Assign the user data to the component's data property
        } else {
          this.total_request = { total_request: 0, total_times: 0, total_approved: 0 }; // Set default values for empty data array
        }
        console.log(this.total_request);
      } catch (error) {
        console.error(error);
      }
      this.loading = false;
    },
    formatDate(dateString) {
      const date = new Date(dateString);
      const day = String(date.getDate()).padStart(2, '0');
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const year = date.getFullYear();
      const formattedDate = `${day}-${month}-${year}`;
      return formattedDate;
    },
    timeFormat(date) {
      const formattedDate = new Date(date);
      const hours = formattedDate.getHours() % 12 || 12;
      const minutes = String(formattedDate.getMinutes()).padStart(2, '0');
      const period = formattedDate.getHours() < 12 ? 'AM' : 'PM';

      return `${hours}:${minutes} ${period}`;
    },
    timeOvertime(date) {
      const [hours, minutes] = date.split(':');
      return `${hours}:${minutes.padStart(2, '0')}`;
    },
    timeToHoursMinutes(total_time) {
      if (!total_time) {
        return "00 hr 00 mins";
      }

      const hours = Math.floor(total_time);
      const minutes = Math.round((total_time - hours) * 60);

      return `${hours.toString().padStart(2, '0')} hr ${minutes.toString().padStart(2, '0')} mins`;
    },
    calculateTotalDays(startDate, endDate) {
      const start = new Date(startDate);
      const end = new Date(endDate);
      const timeDifference = Math.abs(end.getTime() - start.getTime());
      const totalDays = Math.ceil(timeDifference / (1000 * 60 * 60 * 24));

      if (totalDays === 0) {
        return 1;
      }

      return totalDays;
    },
    async rejectAction(overtimeId) {
      const token = localStorage.getItem('token');
      const empId = localStorage.getItem('id');
      const requestData = {
        isApproved: false,
        approvedById: empId
      };
      console.log(requestData);
      console.log(overtimeId);

      axios.put(`https://hrm-system-test.up.railway.app/api/overtime/approveOT/${leaveId}`, requestData, {
        headers: {
          Authorization: `Bearer ${token}`,
        }
      })
        .then(response => {
          console.log('Request rejected successfully');
          this.refreshPage();
        })
        .catch(error => {
          console.error('Error rejecting request:', error);
        });
    },
    async approveAction(overtimeId) {
      const token = localStorage.getItem('token');
      const empId = localStorage.getItem('id');
      const requestData = {
        isApproved: true,
        approvedById: empId,
        total_approve: 1,
      };
      console.log(requestData);
      console.log(overtimeId);

      axios.put(`https://hrm-system-test.up.railway.app/api/leave/approve/${leaveId}`, requestData, {
        headers: {
          Authorization: `Bearer ${token}`,
        }
      })
        .then(response => {
          console.log('Request approved successfully');
          this.refreshPage();
        })
        .catch(error => {
          console.error('Error approving request:', error);
        });
    },
    refreshPage() {
      window.location.reload();
    }
  }
};

</script>



<!-- Add your Bootstrap imports here -->
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';