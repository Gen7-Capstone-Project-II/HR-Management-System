<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Leave extends Model
{
    use HasFactory;
    protected $primaryKey = 'id';
    public $incrementing = false;

    protected $fillable = [
        'empId',
        'leaveTypeId',
        'startDate',
        'endDate',
        'totalDays',
        'reason',
        'createdDate',
        'attachment',
        'isApproved',
        'approvedById',
        'leave_comment',
    ];

    public function employee()
    {
        return $this->belongsTo(User::class, 'empId');
    }

    public function leaveType()
    {
        return $this->belongsTo(LeaveType::class, 'leaveTypeId');
    }

    public function approvedBy()
    {
        return $this->belongsTo(User::class, 'approvedById');
    }
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->{$model->getKeyName()} = (string) Str::uuid();
        });
    }
}
