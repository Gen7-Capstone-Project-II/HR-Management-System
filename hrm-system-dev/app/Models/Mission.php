<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Mission extends Model
{
    protected $primaryKey = 'id';
    public $incrementing = false;

    use HasFactory;

    protected $fillable = [
        'empId',
        'typeId',
        'title',
        'startDate',
        'endDate',
        'budget',
        'note',
        'attachment',
        'createdDate',
        'isApproved',
        'approvedById',
        'mission_comment',
    ];

    public function missionType()
    {
        return $this->belongsTo(MissionType::class, 'typeId');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'empId');
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
