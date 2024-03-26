<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Overtime extends Model
{
    protected $primaryKey = 'id';
    public $incrementing = false;
    use HasFactory;

    protected $fillable = [
        'empId',
        'approvedById',
        'title',
        'reason',
        'dateOT',
        'time_from',
        'time_to',
        'total_time',
        'isApproved',
        'total_approve',
        'paid',
        'createDate',
        'overtime_comment'
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->{$model->getKeyName()} = (string) Str::uuid();
        });
    }

    public function employee()
    {
        return $this->belongsTo(User::class, 'empId');
    }

    public function approvedBy()
    {
        return $this->belongsTo(User::class, 'approvedById');
    }
}
