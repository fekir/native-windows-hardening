#include <stdio.h>
#include <string.h>
#include <windows.h>

void help(const char* argv0) {
    puts("Usage:\n %s -operation <op> -parameters <param> -directory <dir> <file>\n\nAll parameters are optional\n", argv0);
}

int main(int argc, const char* const* argv) {
    if (argc % 2 != 0){
        puts("Wrong number of parameters!\n\n");
        help(argv[0]);
        return 1;
    }
    const char* operation = NULL;
    const char* const file = argv[argc-1];
    const char* parameters = NULL;
    const char* directory = NULL;
    for(int i = 1; i != argc-1; i+=2) {
        if        (strcmp(argv[i], "-operation") == 0) {
            operation = argv[i+1];
        } else if (strcmp(argv[i], "-parameters") == 0) {
            parameters = argv[i+1];
        } else if (strcmp(argv[i], "-directory") == 0) {
            directory = argv[i+1];
        } else  {
            printf("Unknown parameter: %s\n\n", argv[i]);
            help(argv[0]);
            return 1;
        }
    }
    int res = (int) ShellExecuteA(NULL, operation, file, parameters, directory, SW_SHOWNORMAL);
    return res >= 32 ? 0 : res;
}
