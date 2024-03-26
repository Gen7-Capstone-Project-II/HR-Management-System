<style >
@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');


body {
    background: linear-gradient(90deg, rgba(0, 108, 81) 0%, rgba(2, 92, 17) 35%, rgba(23, 173, 43) 100%);
    font-family: 'Roboto', sans-serif;
}

</style>
<template>
    <div>
        <h1>Scan Qr Code To Login</h1>
        <h2>{{ qrCodeValue }}</h2>
    </div>
    <div>{{ qrCodeValue }}</div>
    <div v-if="loading == true" class="loading-spinner">Loading...</div>
    <div v-else>
        <qrcode-vue
            v-if="qrCodeValue"
            :value="qrCodeValue"
            :errorCorrectionLevel="'M'"
            :size="400"
            :bgColor="'#FFFFFF'"
            :fgColor="'#000000'"
        ></qrcode-vue>
    </div>
</template>

<script>
import QrcodeVue from "vue-qrcode";
import axios from "axios";

export default {
    components: {
        QrcodeVue,
    },
    data() {
        return {
            qrCodeValue: "", 
            loading: true,
        };
    },
    mounted() {
        axios
            .get("/api/show")
            .then((response) => {
                this.qrCodeValue = JSON.stringify(response.data); 
            })
            .catch((error) => {
                console.error("Error fetching QR code data:", error);
            })
            .finally(() => {
                this.loading = false; 
            });
    },
};
</script>