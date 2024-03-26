<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class EmergencyContact extends Model
{
    use HasFactory;

    protected $primaryKey = 'id';
    public $incrementing = false;

    protected $fillable = [
        'user_id',
        'relative_id',
        'firstname',
        'lastname',
        'firstnameKM',
        'lastnameKM',
        'gender',
        'phoneNum1',
        'phoneNum2',
        'telegram',
        'email',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function relative()
    {
        return $this->belongsTo(Relative::class);
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->{$model->getKeyName()} = (string) Str::uuid();
        });
    }
}
