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
        Schema::table('announcements', function (Blueprint $table) {
            $table->dateTime('create_date')->nullable();
            $table->boolean('is_publish')->default(false);
            $table->dateTime('publish_date')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('announcements', function (Blueprint $table) {
            $table->dropColumn('create_date');
            $table->dropColumn('is_publish');
            $table->dropColumn('publish_date');
        });
    }
};
