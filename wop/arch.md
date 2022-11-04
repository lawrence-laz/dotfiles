 
- IDeviceClient
- IDeviceSerialPortClient
- DeviceClientBuilder <- has access to ServiceProvider
- Validate that DeviceClient has both virtual and real implementation
- Injected and used in driver during initialization
- Standard stuff, like creating DeviceDispatcherBehavior with virtual and real is done out of the box in DeviceClientBuilder
- Logging, SerialPort stuff like actual client, semaphore, retry? monitoring
- Implementation of these scanned with scrutor?
- Scanner validation to see if 
- Device.Client property? Just Pipeline, you have to .Send<TReq, TResp>
- SerialPort stuff with options moved to SerialPortClient and handled in that class




-----------




 - Chain of responsibility to standardize and simplify hardware implementation in Devices module.
    - You need to:
        - Define device api close to real implementation as requests (record structs)
        - Implement real handler as a wrapper around vendor api
        - Implement virtual handler as a thin emulator of real hardware
    - That's it, the stuff like logging is cross-cutting and re-used as behaviors
    - For integration tests, you need to:
        - Cover Devices.Api commands and driver implementations with integration tests
        - Arrange is just condiguration and maybe some commands like initialize (few lines)
        - Act is just sending the command under test
        - Assert is just providing the expected output for the device (logging is already implemented out of the box)
            - This uses snapshot verification
                - There are libraries for this, which we should try to adopt
                - Snapshots are version controlled and reviewed
    - !!! This automatically and in a strongly typed way maps SendDeviceCommand stuff to the user access
    - Semaphore locking
    - retry mechanisms
- Try implementing using https://www.nuget.org/packages/MessagePipe
- Considered alternatives to chain of responsibility with aspect oriented programming, like:
    - postsharp - paid licenses
    - fody - method only decoration, couldn't fully implement decorator pattern with dynamic dispatch between virtual/non-virtual
    - castle.core dynamicproxy - quite difficult to use (but possible, had used it before multiple times), performance is a bit low for our application
    - avatar - dynamic proxy with source generators from the maintainers of castle.core, but not mature, doesn't support new roslyn yet, fallbacks to castle.core
    - raw source generators - probably best out of aop solutions, but the task is not the easiest, proper decorator implementation with ref/out support is quite big
- Just shifting from oop to functional approach with chain of responsibility eliminates this problem, because behavior can be chained with "functional" handlers.


 - ValueObject: Scalar(decimal Value, string Units)
 checking in operations, if you try to multiply values, that have different units, shouldn't allow?
 enforced unit specification?


 - Palengvinti ir pagreitinti naujos įrangos ir naujų vendorių įgyvendinimą SCA.
 
> in/out aerotech readint visą laiką, ne tik execute stepe
> valdiklis atskirai nuo aertotech
> duris, kurios atidarytos, kurioj pusėj ir t. t. custom valdiklis

 - Padidinti SCA stabilumą. sumažinti naujų klaidų tikimybę,
   - Kodo restruktūrizavimas, skirtingų dalių atsiejimas.
   - Padengti funkcionalumą automatiniais testais
 - Supaprastinti naujos įrangos konfiguravimą SCA vartotojams:
   - SCA automatiškai atpažįsta prisjungtą įrenginį.
   - Neatpažinus įrenginio, vartotojas gali pats nurodyti, koks tai įrenginys.
   - Konfigūracijos vedlys, rodantis tik įrenginiui aktualius pasirinkimus.
 - ir bendrai turėti programinį kodą, kuris paruoštas lengvam tolimesniam sca vystymui


> aerotech vykdymas nenutraukiant kodo bloko.
veikti paraleliai su kitais įrenginiais
lazerio komanda

> optimize repeated actions to improve execution times (CMD lygyje)

 - Dabartinio SCA kodo yra daug (šimtai tūkst.) ir jis glaudžiai surištas tarpusavyje. 
   - Tarkim, Nėra >griežtų< (yra šiek tiek) linijų tarp konkretaus vendoriaus funkcionalumo ir bendro SCA funkcionalumo.
 - Dėl to dabar pridėti palaikymą naujam įrenginiui reikia pakoreguoti daug kodo vietų, o visas vietas surasti ir suprasti nėra lengva.
 - Taip pat dažnai pajudinus vieną vietą, kažkas gali sulūžti kitoje vietoje, nes viskas yra glaudžiai susiję.



 - Siekiamybė yra padalinti SCA į aiškiai apibrėžtus modulius su savo atsakomybėmis.
 - Pradedame nuo Hardware abstraction, kur norim atskirti SCA loginį kodą nuo kiekvieno įrenginio implementacijos detalių.
 - Atskyrimą norim pasiekti taikydamo ports and adapters architektūrą, kur kiekvienas modulis aiškiai apibrėžia savo teikiamą funkcionalumą kaip portus, o kiti moduliai gali juos naudoti prisijungdami su adapteriais
 - !!Hardware modulis pateiks abstrakčius portus/funkcionalumus, taip visi kiti SCA moduliai nebus pririšti prie konkrečių įrenginių.
 - Hardware modulio vidus turės panašią architektūrą į Linux kernel, su tokiom esybėm kaip:
   - Device, bendra įrenginio esybė, kuri būtų matoma SCA ir įrenginiams, kurių mes nepalaikom/neatpažįstam
   - ConnectionBus (serial port, usb, etc.), prijungimo mechanizmo esybė, atsakinga už įrenginių prijungimo stebėjimą ir koordinuoja įrenginio atpažinimą
   - Driver, įrenginio funkcionalumo esybė iš SCA pusės, kuri gali būti priskirta atitinkamiems device.
