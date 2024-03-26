<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('attendances', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('empId');
            // $table->uuid('attendance_id')->nullable();
            $table->dateTime('attendance_date');
            $table->dateTime('time_in')->nullable();
            $table->dateTime('time_out')->nullable();
            $table->string('location')->nullable(); 
            $table->timestamps();

            $table->foreign('empId')->references('id')->on('users');
            // $table->foreign('attendance_id')->references('id')->on('attendance_types');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendances');
    }
};
