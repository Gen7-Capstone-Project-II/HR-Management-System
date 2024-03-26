<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class EmployeeDetail extends Model
{
    use HasFactory;

    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $fillable = [
        'user_id',
        'position_id',
        'dept_id',
        'firstName',
        'lastName',
        'firstNameKH',
        'lastNameKH',
        'birthDate',
        'age',
        'gender',
        'address',
        'personalEmail',
        'phoneNum1',
        'phoneNume2',
        'telegram',
        'attachment',
        'nationality',
        'materialStatus',
        'numberOfChild',
        'employeeDate',
        'status',
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }

    public function position(){
        return $this->belongsTo(Position::class);
    }

    public function department(){
        return $this->belongsTo(Department::class, 'dept_id');
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->{$model->getKeyName()} = (string) Str::uuid();
        });
    }
}
