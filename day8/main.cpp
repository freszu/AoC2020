#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <map>
#include <set>

std::vector<std::string> split(const std::string &str, char delimiter) {
    std::vector<std::string> result;
    std::istringstream stringStream{str};
    std::string token;
    while (std::getline(stringStream, token, delimiter)) {
        if (!token.empty()) result.push_back(token);
    }
    return result;
}

struct Command {
    enum class Type {
        jmp, acc, nop
    };

    Type type;
    int number;

    void execute(int &pointer, int &acc) const {
        switch (type) {
            case Type::acc:
                pointer++;
                acc += number;
                break;
            case Type::jmp:
                pointer += number;
                break;
            case Type::nop:
                pointer++;
                break;
        }
    }
};

static std::map<std::string, Command::Type> stringToCommand{
        {"jmp", Command::Type::jmp},
        {"nop", Command::Type::nop},
        {"acc", Command::Type::acc}
};

struct ProgramRunResult {
    bool wasCycle;
    int accValue;
};

std::vector<Command> getCommandsVector() {
    std::ifstream infile("../input.txt");
    std::string line;
    std::__1::vector<Command> commands;
    while (std::getline(infile, line)) {
        std::vector<std::string> commandVector = split(line, ' ');
        auto cmd = Command{stringToCommand[commandVector[0]], std::stoi(commandVector[1])};
        commands.push_back(cmd);
    }
    return commands;
}

ProgramRunResult runProgram(const std::vector<Command> &commands) {
    std::set<int> seenPc;
    int pc = 0;
    int acc = 0;
    bool cycleFound = true;
    while (!seenPc.contains(pc)) {
        seenPc.insert(pc);
        commands[pc].execute(pc, acc);
        if (pc == commands.size()) {
            cycleFound = false;
            break;
        }
    }
    return ProgramRunResult{cycleFound, acc};
}

int findProgramWithoutLoopAcc(std::vector<Command> commands) {
    int index = 0;
    for (auto &command: commands) {
        auto commandCopy = command;
        switch (command.type) {
            case Command::Type::jmp:
                commands[index] = Command{Command::Type::nop, command.number};
                break;
            case Command::Type::acc:
                break;
            case Command::Type::nop:
                commands[index] = Command{Command::Type::jmp, command.number};
                break;
        }
        auto result = runProgram(commands);
        if (!result.wasCycle) return result.accValue;
        // cleanup
        commands[index] = commandCopy;
        index++;
    }
    return -1;
}

int main() {
    std::vector<Command> commands = getCommandsVector();

    std::cout << "acc:" << runProgram(commands).accValue << "\n";

    std::cout << "acc:" << findProgramWithoutLoopAcc(commands) << "\n";
}
