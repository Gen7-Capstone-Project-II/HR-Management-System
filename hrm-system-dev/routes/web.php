<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\QrCodeLoginController
;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

// Route::get('/', function () {
//     return view('welcome');
// });

Route::get('{path}', function(){
    return view('welcome');
})->where('path', '(.*)');

// Route::get('/generate-qrcode', [QrCodeLoginController::class, 'show'])->name('show');