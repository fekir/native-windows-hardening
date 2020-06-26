#include <windows.h>
#include <stdio.h>

int main(int argc, char* const* argv) {
    if (argc != 2) {
        printf("Usage: %s [CommandLine]\n", argv[0]);
        return 1;
    }

    STARTUPINFO si = {};
    PROCESS_INFORMATION pi = {};
    char* cmdline = argv[1];
    if (!CreateProcessA(NULL, cmdline, NULL, NULL, FALSE, 0, NULL, NULL, &si, &pi)) {
        return 1;
    }
    WaitForSingleObject(pi.hProcess, INFINITE);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
}
