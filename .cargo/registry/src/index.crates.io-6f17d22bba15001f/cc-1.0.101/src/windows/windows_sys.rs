// This file is autogenerated.
//
// To add bindings, edit windows_sys.lst then run:
//
// ```
// cd generate-windows-sys/
// cargo run
// ```
// Bindings generated by `windows-bindgen` 0.57.0

#![allow(
    non_snake_case,
    non_upper_case_globals,
    non_camel_case_types,
    dead_code,
    clippy::all
)]
#[link(name = "advapi32")]
extern "system" {
    pub fn RegCloseKey(hkey: HKEY) -> WIN32_ERROR;
}
#[link(name = "advapi32")]
extern "system" {
    pub fn RegEnumKeyExW(
        hkey: HKEY,
        dwindex: u32,
        lpname: PWSTR,
        lpcchname: *mut u32,
        lpreserved: *const u32,
        lpclass: PWSTR,
        lpcchclass: *mut u32,
        lpftlastwritetime: *mut FILETIME,
    ) -> WIN32_ERROR;
}
#[link(name = "advapi32")]
extern "system" {
    pub fn RegOpenKeyExW(
        hkey: HKEY,
        lpsubkey: PCWSTR,
        uloptions: u32,
        samdesired: REG_SAM_FLAGS,
        phkresult: *mut HKEY,
    ) -> WIN32_ERROR;
}
#[link(name = "advapi32")]
extern "system" {
    pub fn RegQueryValueExW(
        hkey: HKEY,
        lpvaluename: PCWSTR,
        lpreserved: *const u32,
        lptype: *mut REG_VALUE_TYPE,
        lpdata: *mut u8,
        lpcbdata: *mut u32,
    ) -> WIN32_ERROR;
}
#[link(name = "kernel32")]
extern "system" {
    pub fn FreeLibrary(hlibmodule: HMODULE) -> BOOL;
}
#[link(name = "kernel32")]
extern "system" {
    pub fn GetMachineTypeAttributes(
        machine: u16,
        machinetypeattributes: *mut MACHINE_ATTRIBUTES,
    ) -> HRESULT;
}
#[link(name = "kernel32")]
extern "system" {
    pub fn GetProcAddress(hmodule: HMODULE, lpprocname: PCSTR) -> FARPROC;
}
#[link(name = "kernel32")]
extern "system" {
    pub fn LoadLibraryA(lplibfilename: PCSTR) -> HMODULE;
}
#[link(name = "kernel32")]
extern "system" {
    pub fn OpenSemaphoreA(dwdesiredaccess: u32, binherithandle: BOOL, lpname: PCSTR) -> HANDLE;
}
#[link(name = "kernel32")]
extern "system" {
    pub fn PeekNamedPipe(
        hnamedpipe: HANDLE,
        lpbuffer: *mut core::ffi::c_void,
        nbuffersize: u32,
        lpbytesread: *mut u32,
        lptotalbytesavail: *mut u32,
        lpbytesleftthismessage: *mut u32,
    ) -> BOOL;
}
#[link(name = "kernel32")]
extern "system" {
    pub fn ReleaseSemaphore(
        hsemaphore: HANDLE,
        lreleasecount: i32,
        lppreviouscount: *mut i32,
    ) -> BOOL;
}
#[link(name = "kernel32")]
extern "system" {
    pub fn WaitForSingleObject(hhandle: HANDLE, dwmilliseconds: u32) -> WAIT_EVENT;
}
#[link(name = "ole32")]
extern "system" {
    pub fn CoCreateInstance(
        rclsid: *const GUID,
        punkouter: *mut core::ffi::c_void,
        dwclscontext: CLSCTX,
        riid: *const GUID,
        ppv: *mut *mut core::ffi::c_void,
    ) -> HRESULT;
}
#[link(name = "ole32")]
extern "system" {
    pub fn CoInitializeEx(pvreserved: *const core::ffi::c_void, dwcoinit: u32) -> HRESULT;
}
#[link(name = "oleaut32")]
extern "system" {
    pub fn SysFreeString(bstrstring: BSTR);
}
#[link(name = "oleaut32")]
extern "system" {
    pub fn SysStringLen(pbstr: BSTR) -> u32;
}
pub type ADVANCED_FEATURE_FLAGS = u16;
pub type BOOL = i32;
pub type BSTR = *const u16;
pub type CLSCTX = u32;
pub const CLSCTX_ALL: CLSCTX = 23u32;
pub type COINIT = i32;
pub const COINIT_MULTITHREADED: COINIT = 0i32;
pub const ERROR_NO_MORE_ITEMS: WIN32_ERROR = 259u32;
pub const ERROR_SUCCESS: WIN32_ERROR = 0u32;
pub const FALSE: BOOL = 0i32;
pub type FARPROC = Option<unsafe extern "system" fn() -> isize>;
#[repr(C)]
#[derive(Clone, Copy)]
pub struct FILETIME {
    pub dwLowDateTime: u32,
    pub dwHighDateTime: u32,
}
pub const FILE_ATTRIBUTE_TEMPORARY: FILE_FLAGS_AND_ATTRIBUTES = 256u32;
pub type FILE_FLAGS_AND_ATTRIBUTES = u32;
#[repr(C)]
#[derive(Clone, Copy)]
pub struct GUID {
    pub data1: u32,
    pub data2: u16,
    pub data3: u16,
    pub data4: [u8; 8],
}
impl GUID {
    pub const fn from_u128(uuid: u128) -> Self {
        Self {
            data1: (uuid >> 96) as u32,
            data2: (uuid >> 80 & 0xffff) as u16,
            data3: (uuid >> 64 & 0xffff) as u16,
            data4: (uuid as u64).to_be_bytes(),
        }
    }
}
pub type HANDLE = *mut core::ffi::c_void;
pub type HKEY = *mut core::ffi::c_void;
pub const HKEY_LOCAL_MACHINE: HKEY = -2147483646i32 as _;
pub type HMODULE = *mut core::ffi::c_void;
pub type HRESULT = i32;
pub type IMAGE_FILE_MACHINE = u16;
pub const IMAGE_FILE_MACHINE_AMD64: IMAGE_FILE_MACHINE = 34404u16;
pub const KEY_READ: REG_SAM_FLAGS = 131097u32;
pub const KEY_WOW64_32KEY: REG_SAM_FLAGS = 512u32;
pub type MACHINE_ATTRIBUTES = i32;
pub type PCSTR = *const u8;
pub type PCWSTR = *const u16;
pub type PWSTR = *mut u16;
pub type REG_SAM_FLAGS = u32;
pub const REG_SZ: REG_VALUE_TYPE = 1u32;
pub type REG_VALUE_TYPE = u32;
#[repr(C)]
#[derive(Clone, Copy)]
pub struct SAFEARRAY {
    pub cDims: u16,
    pub fFeatures: ADVANCED_FEATURE_FLAGS,
    pub cbElements: u32,
    pub cLocks: u32,
    pub pvData: *mut core::ffi::c_void,
    pub rgsabound: [SAFEARRAYBOUND; 1],
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct SAFEARRAYBOUND {
    pub cElements: u32,
    pub lLbound: i32,
}
pub const SEMAPHORE_MODIFY_STATE: SYNCHRONIZATION_ACCESS_RIGHTS = 2u32;
pub type SYNCHRONIZATION_ACCESS_RIGHTS = u32;
pub const S_FALSE: HRESULT = 0x1_u32 as _;
pub const S_OK: HRESULT = 0x0_u32 as _;
pub type THREAD_ACCESS_RIGHTS = u32;
pub const THREAD_SYNCHRONIZE: THREAD_ACCESS_RIGHTS = 1048576u32;
pub const UserEnabled: MACHINE_ATTRIBUTES = 1i32;
pub const WAIT_ABANDONED: WAIT_EVENT = 128u32;
pub type WAIT_EVENT = u32;
pub const WAIT_FAILED: WAIT_EVENT = 4294967295u32;
pub const WAIT_OBJECT_0: WAIT_EVENT = 0u32;
pub const WAIT_TIMEOUT: WAIT_EVENT = 258u32;
pub type WIN32_ERROR = u32;
