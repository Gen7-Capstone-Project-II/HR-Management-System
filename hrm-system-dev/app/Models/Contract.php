<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Contract extends Model
{
    use HasFactory;
    protected $primaryKey = 'id';
    public $incrementing = false;

    protected $fillable = [
        'empId',
        'departmentId',
        'positionId',
        'contract_startdate',
        'contract_enddate',
        'working_schedule',
        'base_salary',
        'attachment_file',
    ];

    public function employee_contract(){
        return $this->belongsTo(User::class, 'empId');
    }

    public function position_contract(){
        return $this->belongsTo(Position::class, 'positionId');
    }

    public function department_contract(){
        return $this->belongsTo(Department::class, 'departmentId');
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->{$model->getKeyName()} = (string) Str::uuid();
        });
    }
}
