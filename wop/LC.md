RA - regenerative amplifier
TEM - timing electronics module
PP - Pulse Picker
CW - Continuous wave

## Unused
Some APIs are unused and if needed would require a bit more investigation to see how each works and what effects each has.
Pharos: TurnOn, TurnOff, Burst, Oscillator
Carbide: Burst (review again !!!)
Older Pharos: Oscillator (used in old implementation, prob. need here as well !!!)

## TODO
- [ ] Ar kažkas naudoja "Set power using external power meter" PHAROS komandoje?
    - Jeigu not sure, siūlymas kol kas nedėti, kol sutiksim kam reikia. Čia turėtų būti 

## HAL driver
Driver should handle the full use case of performing an operation. 
This usually involves sending a request to set the target value,
then querying actual value and waiting for it to reach the target value.
Sometimes the driver might also need to observe device status (ex. when preset changes).
Handle edge cases like time outs or errors.

TODO: have a high-level request for get/set laser power, where driver chooses how to achieve the output power
TODO: then have lower-level requests to adjust individual components RA, PP, attenuator, etc.

## HAL driver-level requests

// Gets a combined laser output power 
// taking into account all internal devices like pulsepicker, attenuator, etc.
GetLaserOutputPower(DeviceName: string): Power
Pharos: GET /Basic/ActualOutputPower 
Carbide: GET /Basic/ActualOutputPower
Older Pharos: ?

// Note that we need a new unit type Energy measured in variants of joules.
GetLaserOutputEnergy(DeviceName: string): Energy
Pharos: GET /Basic/ActualOutputEnergy
Carbide: GET /Basic/ActualOutputEnergy
Older Pharos: ?

GetLaserOutputFrequency(DeviceName: string): Frequency
Pharos: GET /Basic/ActualOutputFrequency
Carbide: GET /Basic/ActualOutputFrequency
Older Pharos: ?

GetLaserRegenerativeAmplifierPower(DeviceName: string): Power
Pharos: GET /Basic/ActualRaPower
Carbide: -
Older Pharos: PHAROS_API_RA_Get_UpdatedState -> .Output_Power

SetLaserRegenerativeAmplifierPower(DeviceName: string, Power): void
Pharos: -
Carbide: -
Older Pharos: PHAROS_API_RA_Set_Power_Setpoint_mW

// Gets raw frequency not taking into account pulse picker divider.
GetLaserRegenerativeAmplifierFrequency(DeviceName: string): Frequency
Pharos: GET /Basic/ActualRaFrequency
Carbide: GET /Advanced/ActualRaFrequency
Older Pharos: PHAROS_API_Sync_Get_State -> .AmpInternalFrequency

SetLaserRegenerativeAmplifierFrequency(DeviceName: string, Frequency): void
Pharos: -
Carbide: PUT /Advanced/TargetRaFrequency
Older Pharos: PHAROS_API_Sync_Set_Internal_Frequency

GetLaserRegenerativeAmplifierCurrent(DeviceName: string): Current
Pharos: -
Carbide: -
Older Pharos: PHAROS_API_Driver_Get_State -> DRIVER_TYPE_RA -> I_measured

SetLaserRegenerativeAmplifierCurrent(DeviceName: string, Current): void
Pharos: -
Carbide: -
Older Pharos: PHAROS_API_Driver_Set_I -> DRIVER_TYPE_RA

IsLaserPulsePickerEnabled(DeviceName: string): bool
Pharos: GET /Advanced/IsPpEnabled
Carbide: GET /Advanced/IsPpEnabled
Older Pharos: ?

EnableLaserPulsePicker(DeviceName: string): void
Pharos: POST /Advanced/EnablePp
Carbide: POST /Advanced/EnablePp
Older Pharos: PHAROS_API_Sync_Set_PP_Enable

DisableLaserPulsePicker(DeviceName: string): void
Pharos: POST /Advanced/DisablePp
Carbide: POST /Advanced/DisablePp
Older Pharos: PHAROS_API_Sync_Set_PP_Enable

GetLaserPulsePickerDivider(DeviceName: string): int
Pharos: GET /Basic/ActualPpDivider
Carbide: GET /Basic/ActualPpDivider
Older Pharos: ?

SetLaserPulsePickerDivider(DeviceName: string, divider: int): void
Pharos: PUT /Basic/TargetPpDivider
Carbide: PUT /Basic/TargetPpDivider
Older Pharos: ?

SetLaserBurstPulseCount(DeviceName: string, count: int): void
Pharos: PUT /Advanced/TargetPulseCount
Carbide: PUT /Basic/TargetBurstPulseCount
Older Pharos: ?

GetLaserBurstPulseCount(DeviceName: string): int
Pharos: GET /Advanced/ActualPulseCount 
Carbide: GET /Basic/ActualBurstPulseCount
Older Pharos: ?

GetLaserPulseDuration(DeviceName: string): Duration
Pharos: -
Carbide: GET /Basic/ActualPulseDuration
Older Pharos: ?

SetLaserPulseDuration(DeviceName: string, Duration)
Pharos: - 
Carbide: PUT /Basic/TargetPulseDuration
Older Pharos: ?

SetLaserStretcherCompressorPosition(DeviceName: string, steps: int): void
Pharos: PUT /StretcherCompressor/TargetPosition
Carbide: PUT /StretcherCompressor/TargetPosition, GET /StretcherCompressor/PositionRange
Older Pharos: PHAROS_API_Motor_Move_To_Pos, PHAROS_API_Motor_Get_Max_Position

GetLaserStretcherCompressorPosition(DeviceName: string): int
Pharos: GET /StretcherCompressor/ActualPosition
Carbide: GET /StretcherCompressor/ActualPosition
Older Pharos: PHAROS_API_Motor_Get_UpdatedState -> .MotorPosition

// (?) Should we have a strongly-typed Harmonic type, which would hold wave length values?
GetLaserHarmonic(DeviceName: string): int
Pharos: GET /Basic/ActualHarmonic
Carbide: GET /Basic/ActualHarmoni 
Older Pharos: PHAROS_API_HG_Get_State 

IsLaserOutputEnabled(DeviceName: string): bool
Pharos: GET /Basic/IsOutputEnabled, (?) or this GET /Basic/IsOutputOpen
Carbide: GET /Basic/IsOutputEnabled
Older Pharos: --------------------------------------------------------

EnableLaserOutput(DeviceName: string): void
Pharos: POST /Basic/EnableOutput
Carbide: POST /Basic/EnableOutput
Older Pharos: --------------------------------------------------------

DisableLaserOutput(DeviceName: string): void
Pharos: POST /Basic/CloseOutput
Carbide: POST /Basic/CloseOutput
Older Pharos: --------------------------------------------------------

GetLaserPresets(DeviceName: string): LaserPreset[]
Pharos: GET /Advanced/Presets
Carbide: GET /Advanced/Presets
Older Pharos: -

GetLaserPreset(DeviceName: string): int
Pharos: GET /Basic/SelectedPresetIndex
Carbide: GET /Basic/SelectedPresetIndex 
Older Pharos: -

SetLaserPreset(DeviceName: string, index: int): void
Pharos: PUT /Basic/SelectedPresetIndex, POST /Basic/ApplySelectedPreset
Cardide: PUT /Basic/SelectedPresetIndex, POST /Basic/ApplySelectedPreset
Older Pharos: -

StandbyLaser(DeviceName: string): boid
Pharos: POST /Basic/GoToStandby
Carbide: POST /Basic/GoToStandby
Older Pharos: ?

// A common HAL request.
GetDeviceStatus(DeviceName: string)
Pharos: GET /Basic/Warnings, GET /Basic/Errors, GET /Basic/ActualStateName2 or GET /Advanced/ActualStateId
Carbide: GET /Basic/Warnings, GET /Basic/Errors, GET /Basic/ActualStateName or GET /Advanced/ActualStateId
Older Pharos: ? (there are quite a few different ones)

// A common HAL request.
// Use for states that are needed for reporting/UI.
GetDeviceState(DeviceName: string): DeviceState
Pharos: <On demand>
Carbide: <On deman>
Old Pharos: <On demand>

SetLaserAttenuatorPower(DeviceName: string, percent: Percent): void
Pharos: PUT /Basic/TargetAttenuatorPercentage
Carbide: PUT /Basic/TargetAttenuatorPercentage 
Older Pharos: ?

GetLaserAttenuatorPower(DeviceName: string): Percent
Pharos: GET /Basic/ActualAttenuatorPercentage
Carbide: GET /Basic/ActualAttenuatorPercentage
Older Pharos: ?

TurnLaserChillerOn(DeviceName: string): void
Pharos: POST /Chiller/TurnOn
Carbide: POST /Chiller/TurnOn
Older Pharos: PHAROS_API_Chiller_Set_ChillerState

TurnLaserChillerOff(DeviceName: string): void
Pharos: POST /Chiller/TurnOff
Carbide: POST /Chiller/TurnOff
Older Pharos: PHAROS_API_Chiller_Set_ChillerState

IsLaserChillerOn(DeviceName: string): void
Pharos: GET /Chiller/IsOn
Carbide: GET /Chiller/IsOn
Older Pharos: PHAROS_API_Chiller_Get_UpdatedState, ChillerState

GetLaserChillerActualTemperature(DeviceName: string): Temperature
Pharos: GET /Chiller/ActualTemperature
Carbide: GET /Chiller/ActualTemperature
Older Pharos: PHAROS_API_Chiller_Get_UpdatedState, ChillerWaterTemperature

SetLaserChillerTargetTemperature(DeviceName: string, Temperature): void
Pharos: PUT /Chiller/TargetTemperature
Carbide: PUT /Chiller/TargetTemperature
Older Pharos: PHAROS_API_Chiller_Set_WaterSetPoint

GetLaserChillerTargetTemperature(DeviceName: string): Temperature
Pharos: GET /Chiller/TargetTemperature
Carbide: GET /Chiller/TargetTemperature
Older Pharos: PHAROS_API_Chiller_Get_UpdatedState, ChillerWaterSetPoint


## HAL device-client-level requests

Just map 1:1 to required HTTP methods and endpoints, ex.:
from `PUT /Basic/SelectedPresetIndex`
to `PutBasicSelectedPresetIndex(index: int): void` etc.

