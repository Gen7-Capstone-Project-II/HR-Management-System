<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class MissionType extends Model
{
    protected $primaryKey = 'id';
    public $incrementing = false;
    use HasFactory;

    protected $fillable = [
        'mission_type',
        'description'
    ];

    public function missionType()
    {
        return $this->belongsTo(MissionType::class, 'typeId');
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->{$model->getKeyName()} = (string) Str::uuid();
        });
    }
}
