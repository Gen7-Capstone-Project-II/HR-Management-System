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
        Schema::create('emergency_contacts', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('user_id');
            $table->uuid('relative_id');
            $table->string('firstname');
            $table->string('lastname');
            $table->string('firstnameKM')->nullable();
            $table->string('lastnameKM')->nullable();
            $table->string('gender');
            $table->string('phoneNum1');
            $table->string('phoneNum2')->nullable();
            $table->string('telegram')->nullable();
            $table->string('email')->nullable();
            $table->foreign('user_id')->references('id')->on('users');
            $table->foreign('relative_id')->references('id')->on('relatives')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('emergency_contacts');
    }
};
