<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Attendance extends Model
{
    use HasFactory;

    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $fillable = [
        'empId',
        'attendance_id',
        'attendance_date',
        'time_in',
        'time_out',
        'location',
        'location_timein',
        'location_timeout'
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->{$model->getKeyName()} = (string) Str::uuid();
        });
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'empId');
    }

    // public function attendanceType()
    // {
    //     return $this->belongsTo(AttendanceType::class, 'attendance_id');
    // }
}
