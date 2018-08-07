" Vim syntax file
" Language:     PacScript
" Maintainer:   Felipe V Alves
" Last Change:  2016 Apr 29
" Filenames:    *.pcs

" 2. Lexical Grammar
syn case ignore
syn sync linebreaks=2
" 2.1.4 Comments
syn keyword pcsTodo contained    TODO FIXME XXX NOTE
syn region  pacscriptComment start="\<Rem\>" end="$" contains=pacscriptTodo
syn region  pacscriptComment start="'" end="$" contains=pacscriptTodo
syn cluster pacscriptComments contains=pacscriptComment,pacscriptXmlComment
" 2.3 Keywords
" Every possible keyword
syn keyword pacscriptKeywordError   Abs Accel AccMode ACos AddHandler AddPathPoint All And Approach ArchMove Area AreaPos AreaSize Arm Array Arrive As Asc ASin ATn ATn2 AVec Base BasePos Bin Bit BusyState Buzzer ByRef Byte ByVal Call CallByName Cao Case ChangeTool ChangeWork Chr Chuck ClearAreaDetected ClearEvents ClearLog ClearServoLog ClearUserMessage ClrErr ClrPathPoint ClrSplinePoint CollisionDetection Comm Component ContinueAll ContinueRun Cos CpMode CreateArray CreateMutex CreateObject Cross CrtMotionAllow CurAcc CurCPMode CurDec CurDHMode CurDHOffset CurDHParam CurErr CurExJ CurExtAcc CurExtDec CurExtSpd CurFig CurForceSensorPayLoad CurJAcc CurJDec CurJnt CurJSpd CurLmt CurOptMode CurPathPoint CurPayLoad CurPos CurSpd CurSpeedMode CurTool CurTrn CurWork D Date DeadmanState Debug Decel Declare DefDbl DefFlt Define DefInt DefIO DefJnt DefObj DefPos DefSng DefStr DefTrn DefVec DegRad Delay DeleteMutex Depart DestExJ DestJnt DestPos DestTrn DetectOff DetectOn Dev DevH DHMode Dim Dist Do Dot Double Dps Draw Drive DriveA ElIf Else ElseIf EmgState EncMotionAllow EncMotionAllowJnt Encrypt Encryption End EndIf ErAlw Err ErrLvl ErrMsg Error Ex ExA ExeCal Exit Exp ExtAccel ExtDecel ExtSpeed F False Fig FireUserMessage Fix Float For ForceChangeTable ForceCtrl ForceParam ForceSensor ForceSensorPayload ForceValue ForceWaitCondition Format Freeze Function gCao GetAreaDetected GetCollisionStatus GetConfig GetHandIO GetLanguage GetPathPoint GetPathPointCount GetPoint GetPriority GetPublicValue GetSplinePoint GetSrvData GetSrvJntData GetUserMessage GiveArm GiveMutex GoSub GoTo GrvCtrl GrvOffset Halt Hand Hex HighPathAccuracy Hold HoldState I If Ifdef Ifndef Import In Include InposState InStr InStrRev Int Integer Interrupt InvDev IO Is IsArray J J2P J2T JAccel JDecel Join Joint JSpeed Keep Kill KillAll KillByName LBound LCase Left Len LenB Let LetA LetF LetJ LetO LetP LetR LetRx LetRy LetRz LetT LetX LetY LetZ LoadPathPoint LockState Log Log10 Long Loop LTrim Magnitude Max Mid Min Mod Mode MotionComplete MotionContinue MotionDone MotionMode MotionSkip MotionTime MotionTimeout Motor MotorState Move MoveA MoveAh MoveH MoveP MoveR MoveRh MoveZh Mps MsgBox MutexID MutexState Namespace Next NormTrn NormalVector Not Nothing Now NoWait Object Off On Optimize Or Org OrgState Out OutRange OVec P P2J P2T Page_Change PageChange PageChangeByName Pallet PanelInfo Pause PayLoad PI PosClr Pose Position PosRx PosRy PosRz Post PosX PosY PosZ Pow Pragma PrintDbg PrintMsg Private Program Public PVec PWMCtrl RadDeg Randomize ReadByteArray RealPath Rem RemoveHandler Reset ResetArea ResetDHOffset ResetMutex Result Resume Return Right Rnd RobInfo Robot Robot0 Robot1 Robot2 Robot3 Rotate RotateH Rpm RTrim Run RunByName RVec S SaveLog Select Set SetArea SetCollisionDetection SetConfig SetDHOffset SetErr SetHandIO SetPriority SetPublicValue SetSplinePoint SetSrvData SetSrvJntData Sgn Short Sim Sin Single SingularAvoid Speed SpeedMode Split Sprintf Sqr SrvUnLock contained
syn keyword pacscriptKeywordError   StartLog StartServoLog Static Status StatusByName Step Stop StopLog StopServoLog Str String Sub Suspend SuspendAll SuspendByName SyncTime SysDiag SysInfo SysLog SysState T T2J T2P TakeArm TakeArmState TakeMutex Tan Tar_Exjnt Tar_Posture Tar_Time TaskInfo Then Time Timer TInv TMul TNorm To Tool ToolPos TrackApproach TrackArrivalTime TrackBufferDelete TrackBufferIndexes TrackBufferRead TrackConveyorSpd TrackCount TrackCurPos TrackDepart TrackEncoder TrackInitialize TrackInRange TrackMinimumIntervalLength TrackMove TrackOffsetMargin TrackSetMargin TrackSetRange TrackSetSensor TrackSetVision TrackStandbyPos TrackStart TrackStartArea TrackStop TrackTargetOffset TrackTargetPos TrackTargetRelease Trans Trim True UBound UCase Unchuck Undef Until UpdateWork V Val VarChangeType VarCreateArray Variant Vars VarType VCMode Vector Ver Vis Void Wait Wend While Word Work WorkAttribute WorkPos WriteByteArray Xor XY XYH XZ XZH YX YXH YZ YZH ZForce ZonState ZX ZXH ZY ZYH contained
syn match   pacscriptIdentifier     "\[\h\w*\]"
syn cluster pacscriptStrict         contains=pacscriptIdentifier,pacscriptKeywordError
" 2.4 Literals
syn keyword pacscriptConstant       True False Off Pi Nothing
syn match   pacscriptConstant       "\<On\>"
syn match   pacscriptConstant       "\(@\|@\(P\|E\|C\)\)"
syn match   pacscriptNumber         "[+-]\=\(&O[0-7]*\|&H\x\+\|\<\d\+\)[SIL]\=\>"
syn match   pacscriptNumber         "[+-]\=\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[FRD]\=\>"
syn match   pacscriptNumber         "[+-]\=\<\d\+[eE][-+]\=\d\+[FRD]\=\>"
syn match   pacscriptNumber         "[+-]\=\<\d\+\([eE][-+]\=\d\+\)\=[FRD]\>"
syn region  pacscriptString         start=+"+ end=+"+ end=+$+ skip=+""+
syn cluster pacscriptLiterals       contains=pacscriptConstant,pacscriptNumber,pacscriptString

" 3. Preprocessing Directives
syn region  pacscriptPreCondit
\ start="^\s*#\s*\(If\|Ifdef\|Ifndef\|Elif\|Else\|Endif\)\>" skip="\<_$"
\ end="$" contains=@pacscriptComments keepend
syn region  pacscriptPreProError start="^\s*#\s*\(Error\|Warning\)\>" skip="\<_$" end="$"
\ contains=@pacscriptComments,@pacscriptLiterals keepend
syn region  pacscriptPragma    start="^\s*#\s*Pragma\s\+\(Encrypt\|Optimize\)\>" skip="\<_$" end="$"
\ contains=@pacscriptComments,@pacscriptLiterals keepend
syn region  pacscriptDefine     start="^\s*#\s*\(Define\|Undef\)\>" skip="\<_$" end="$"
            \ contains=@pacscriptComments,@pacscriptLiterals keepend
syn region  pacscriptInclude keepend contains=pacscriptString,pacscriptComment
            \ start="^\s*#\s*Include\>"
            \ skip="\<_$" end="$"
syn cluster pacscriptPreProc contains=pacscriptPreCondit,pacscriptDefine,pacscriptInclude,pacscriptPreProError,pacscriptPragma

" 4. General Concepts
syn match   pacscriptModifier       "\<Static\>"

" 5. Attributes
syn match   pacscriptAttribute "<\s*\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\%(\s*([^()]*)\)\=\(\s*,\s*\%(_\n\s*\)\=\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\%(\s*([^()]*)\)\=\)\{-}\s*>"

" 7. Types
" 7.3 Primitive Types
syn keyword pacscriptBuiltinType    Integer Single Double Object String S Trans T Position P Joint J Vector V Variant skipwhite nextgroup=pacscriptGeneric
syn cluster pacscriptType           contains=pacscriptBuiltinType
syn cluster pacscriptAnyType        contains=@pacscriptType

" 9. Type Members
" 9.2 Methods
syn keyword pacscriptSubWords       Sub contained
syn keyword pacscriptAsError        As contained
syn cluster pacscriptSub            contains=pacscriptSubWords,pacscriptParameter
syn keyword pacscriptFunctionWords  Function contained
syn cluster pacscriptFunction       contains=pacscriptFunctionWords,pacscriptParameter
syn region  pacscriptSubArguments   start="(" skip="([^)]*)\|\<_$" end=")" end="$" contains=pacscriptParameter,pacscriptAsClause,@pacscriptLiterals,@pacscriptStrict keepend skipwhite nextgroup=@pacscriptAsError contained
syn match   pacscriptSubDeclaration "\<\(\w\+\s\+\)*\(\<\(End\|Exit\)\>.*\)\@<!\<Sub\>\s\+\%(\h\w*\>\|\[\h\w*\]\)" contains=@pacscriptSub,@pacscriptStrict containedin=pacscriptSubBlock skipwhite nextgroup=pacscriptSubArguments
syn match   pacscriptProcedureEnd "\<End\s\+Sub\>" containedin=pacscriptSubBlock
syn region  pacscriptFunctionArguments  start="(" skip="([^)]*)\|\<_$" end=")" end="$" contains=pacscriptParameter,pacscriptAsClause,@pacscriptLiterals,@pacscriptStrict keepend skipwhite nextgroup=pacscriptFunctionReturn contained
syn match   pacscriptFunctionReturn     "\<As\s\+[][(){}A-Za-z0-9_.]\+" contains=pacscriptAsClause,@pacscriptStrict skipwhite contained
syn match   pacscriptFunctionDeclaration "\<\(\w\+\s\+\)*\(\<\(End\|Exit\)\>.*\)\@<!\<Function\>\s\+\%(\h\w*\>\|\[\h\w*\]\)" contains=@pacscriptFunction,@pacscriptStrict containedin=pacscriptFunctionBlock skipwhite nextgroup=pacscriptFunctionArguments,pacscriptFunctionReturn
syn match   pacscriptProcedureEnd "\<End\s\+Function\>" containedin=pacscriptFunctionBlock
" 9.2.5 Method Parameters
syn keyword pacscriptParameter      ByVal ByRef Optional contained
" 9.6 Instance and Shared Variables
syn keyword pacscriptStatement      Dim Static Public
syn keyword pacscriptAsClause       As skipwhite nextgroup=@pacscriptAnyType,@pacscriptStrict contained
syn keyword pacscriptAsNewClause    As skipwhite nextgroup=pacscriptNewClause,@pacscriptAnyType,@pacscriptStrict

" 10. Statements
" 10.1 Blocks
syn match   pacscriptLabel          "^\h\w*:"me=e-1
" 10.3 With Statement
syn match   pacscriptStatement      "\<\(End\s\+\)\=With\>"
" 10.8 Conditional Statements
syn keyword pacscriptConditional    Then ElseIf Else
syn match   pacscriptConditional    "\<\(End\s\+\)\=If\>"
syn match   pacscriptConditional    "\<\(Select\(\s\+Case\)\|\(End\|Exit\)\s\+Select\)\>"
syn keyword pacscriptLabel          Case
" 10.9 Loop Statements
syn keyword pacscriptRepeat         To Step Each In Next Loop Until
syn match   pacscriptRepeat         "\<\(End\s\+\|Exit\s\+\)\=While\>"
syn match   pacscriptRepeat         "\<\(Exit\s\+\)\=\(Do\|For\)\>"
" 10.10 Exception-Handling Statements
syn keyword pacscriptException      Catch When Finally Resume Throw
syn match   pacscriptException      "\<\(On\s\+Error\|\(End\s\+\|Exit\s\+\)\=Try\)\>"
" 10.11 Branch Statements
syn keyword pacscriptBranch         GoTo Stop Return
syn match   pacscriptBranch         "\<Exit\s\+\(Sub\|Function\|Property\)\>"
" Flow Statements
syn keyword pacscriptFlow           Call CallByName Delay Wait

" 11. Expressions
syn keyword pacscriptOperator       And Or Not Xor Mod
" 11.12 Robotic Functions
syn keyword pacscriptRobotic Approach ArchMove Depart Draw Drive DriveA Rotate RotateH Accel CurAcc CurDec CurExtAcc CurExtDec CurExtSpd CurSpd CurSpeedMove Decel ExtSpeed SpeedMode ChangeTool ChangeWork CurTool CurWork Tool ToolPos Work WorkAttribute WorkPos Area AreaPos AreaSize ClearAreaDetected GetAreaDetected ResetArea SetArea CurLmt ZForce CurForceSensorPayLoad ForceChangeTable ForceCtrl ForceParam ForceSensor ForceSensorPayLoad ForceValue ForceWaitCondition TrackApproach TrackArrivalTime TrackBufferDelete TrackBufferIndexes TrackBufferRoad TrackConveyorSpd TrackCount TrackCurPos TrackDepart TrackEncoder TrackInitialize TrackInRange TrackMinimumIntervalLength TrackMove TrackOffsetMargin TrackSetSensor TrackSetVision TrackStandByPos TrackStart TrackStartArea TrackStop TrackTargetOffset TrackTargetPos TrackTargetRelease CrtMotionAllow EncMotionAllow EncMotionAllowJnt HighPathAccuracy AddPathPoint ClrPathPoint CurPathPoint GetPathPoint GetPathPointCount LoadPathPoint S CollisionDetection GetCollisionStatus SetCollisionDetection Base ClearServoLog GetHandIO SetHandIO StartServoLog StopServoLog SyncTime Arrive MotionSkip WaitMotion Motor MotorState SrvUnLock CurExJ CurFig CurJnt CurPos CurTrn DestJnt DestPos DestTrn GetSrvData GetSrvJntData MotionComplete RobInfo AngularTrigger DetectOff DetectOn Interrupt CPMode CurCPMode CurPayload Eralw GrvCtrl GrvOffset MotionTimeout Payload Posclr SingularAvoid
syn match pacscriptRobotic "\<Pallet\.CalcPos\>"
syn match pacscriptRobotic "\<Move\s\(P\|PTP\|L\|C\|S\)\>"

" Math Functions
syn keyword pacscriptArithmetic Acos Asin Atn Atn2 Cos Sin Tan Sqr Pow Exp Log Log10 Abs Sgn Max Min Randomize Rnd DegRad RadDeg Fix Int Dps Mps Rpm

" String Functions
syn keyword pacscriptStringFunctions LCase UCase Left LTrim Mid Right RTrim Len LenB Str Val Join Split InStr InStrRev Format Sprintf Bin Hex Asc Chr RealPath

" IO Functions
syn keyword pacscriptIO DefIO Reset Set
syn match pacscriptIO "\<Comm\.\(Clear\|Close\|Count\|Input\|Open\|Output\|State\)\>"

" Visual Functions
syn match pacscriptVisual "\<Vis\.\(CalTrans\|GetCalData\|GetCalPos\|SetCalData\|Trans\)\>"

" Gripper Functions
syn match pacscriptGripper "\<Hand\[[0-9]+\]\.\(Chuck\|Motor\|MoveA\|MoveAH\|MoveH\|MoveP\|MoveR\|MoveRH\|MoveZH\|Org\|Stop\|UnChuck\|BusyState\|CurPos\|EmgState\|Error\|GetPoint\|HoldState\|InposState\|MotorState\|OrgState\|ZonState\)\>"

" Provider Functions
syn keyword pacscriptProvider AddHandler RemoveHandler

" Coordinates Functions
syn keyword pacscriptCoordinates J2P J2T P2J P2T T2J T2P Cross Dev DevH Dist Dot Magnitude NormalVector OutRange TInv TMul TNorm LetA LetF LetJ LetO LetP LetR LetRx LetRy LetRz LetX LetY LetZ AVec Fig Joint OVec PosRx PosRy PosRz PosX PosY PosZ PVec RVec

" Teach pendant
syn keyword pacscriptPendant MsgBox PageChange PageChangeByName PrintDbg PrintMsg Buzzer

" System Information
syn keyword pacscriptSysInfo CurOptMode Date DeadManState GetLanguage LockState Now SysInfo SysState Time Timer Ver

" Multitask
syn keyword pacscriptMultitask ContinueAll Run RunByName Halt Hold Kill KillAll KillByName Suspend SuspendAll SuspendByName CreateMutex DeleteMutex GiveArm GiveMutex MutexID MutexState ResetMutex TakeArm TakeArmState TakeMutex GetPriority SetPriority Status StatusByName

" Error Handling
syn keyword pacscriptErrorHandling ClrErr CurrErr ErrLvl ErrMsg Resume
syn match pacscriptErrorHandling "\<Err\.\(Raise\|Description\|Level\|Number\|OriginalNumber\)\>"

" Log Functions
syn match pacscriptLog "\<SysLog\.\(\(Ctrl\|Trace\|Servo\)\.\(Clear\|Start\|Stop\)\|Ctrl\.UserData\)\>"

command -nargs=+ HiLink hi link <args>

" 2. Lexical Grammar
HiLink pacscriptTodo                    Todo
HiLink pacscriptComment                 Comment
HiLink pacscriptKeywordError            pacscriptError
HiLink pacscriptAsError                 pacscriptError
HiLink pacscriptError                   Error
HiLink pacscriptBoolean                 Boolean
HiLink pacscriptNumber                  Number
HiLink pacscriptCharacter               Character
HiLink pacscriptString                  String
HiLink pacscriptDate                    Constant
HiLink pacscriptConstant                Constant

" 3. Preprocessing Directives
HiLink pacscriptPreCondit               PreCondit
HiLink pacscriptDefine                  Define
HiLink pacscriptInclude                 Include
HiLink pacscriptPreProError             PreProc
HiLink pacscriptPragma                  PreProc
HiLink pacscriptPreProc                 PreProc

" 4. General Concepts
HiLink pacscriptTypeAccess              pacscriptType
HiLink pacscriptAccessModifier          pacscriptModifier

" 5. Attributes
HiLink pacscriptAttribute               Special

" 6. Source Files and Namespaces
HiLink pacscriptStorage                 pacscriptStorageClass
HiLink pacscriptOption                  pacscriptPreProc
HiLink pacscriptImports                 pacscriptInclude

" 7. Types
HiLink pacscriptTypeSpecifier           pacscriptType
HiLink pacscriptBuiltinType             pacscriptType
HiLink pacscriptSystemType              pacscriptType
HiLink pacscriptType                    Type
HiLink pacscriptClassModifier           pacscriptStorageClass
HiLink pacscriptEnumWords               pacscriptStorageClass
HiLink pacscriptModuleWords             pacscriptStorageClass
HiLink pacscriptClassWords              pacscriptStorageClass
HiLink pacscriptStructureWords          pacscriptStorageClass
HiLink pacscriptInterfaceWords          pacscriptStorageClass
HiLink pacscriptTypeImplementsKeyword   pacscriptStorageClass
HiLink pacscriptInheritsKeyword         pacscriptStorageClass
HiLink pacscriptTypeEnd                 pacscriptStorageClass
HiLink pacscriptStorageClass            StorageClass

" 9. Type Members
HiLink pacscriptAsNewClause             pacscriptAsClause
HiLink pacscriptAsClause                pacscriptStorageClass
HiLink pacscriptOfClause                pacscriptStorageClass
HiLink pacscriptFlow                    Statement
HiLink pacscriptFunctionWords           Statement
HiLink pacscriptSubWords                Statement
HiLink pacscriptProcedureEnd            Statement
HiLink pacscriptProcedure               Statement

" 10. Statements
HiLink pacscriptStatement               Statement
HiLink pacscriptLabel                   Label
HiLink pacscriptParameter               Keyword
HiLink pacscriptEvent                   pacscriptStatement
HiLink pacscriptConditional             Conditional
HiLink pacscriptRepeat                  Repeat
HiLink pacscriptException               Exception
HiLink pacscriptBranch                  Keyword
HiLink pacscriptArrayHandler            Statement

" 11. Expressions
HiLink pacscriptCast                    pacscriptType
HiLink pacscriptOperator                Operator
HiLink pacscriptNewClause               Keyword

" Functions
HiLink pacscriptRobotic                 Function
HiLink pacscriptArithmetic              Function
HiLink pacscriptStringFunctions         Function
HiLink pacscriptIO                      Function
HiLink pacscriptVisual                  Function
HiLink pacscriptGripper                 Function
HiLink pacscriptProvider                Function
HiLink pacscriptCoordinates             Function
HiLink pacscriptPendant                 Function
HiLink pacscriptSysInfo                 Function
HiLink pacscriptMultitask               Function
HiLink pacscriptErrorHandling           Function
HiLink pacscriptLog                     Function

delcommand HiLink

let b:current_syntax = "pacscript"
