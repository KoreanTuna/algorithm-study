import 'dart:io';
import 'stack.dart';

void main() {
  const commandsMap = {
    'push': _handlePush,
    'pop': _handlePop,
    'size': _handleSize,
    'empty': _handleEmpty,
    'top': _handleTop,
  };

  final stack = Stack<int>();
  final commands = _readCommands();

  final DateTime startTime = DateTime.now();
  if (commands.isEmpty) {
    stdout.writeln('No commands provided');
    return;
  }

  final processCount = int.tryParse(commands[0]) ?? 0;
  if (processCount < 1 || processCount > 10000) {
    stdout.writeln('Invalid number of commands');
    return;
  }

  final buffer = StringBuffer();
  for (var i = 1; i <= processCount; i++) {
    final commandParts = commands[i].split(' ');
    final command = commandParts[0];
    final handler = commandsMap[command];

    if (handler != null) {
      handler(stack, commandParts, buffer);
    } else {
      buffer.writeln('Unknown command: $command');
    }
  }

  stdout.write(buffer.toString());

  final DateTime endTime = DateTime.now();
  final Duration duration = endTime.difference(startTime);
  stdout.writeln('Execution time: ${duration.inMilliseconds} ms');
}

List<String> _readCommands() {
  final commands = <String>[];
  while (true) {
    final line = stdin.readLineSync();
    if (line == null || line.trim().isEmpty) break;
    commands.add(line);
  }
  return commands;
}

void _handlePush(
    Stack<int> stack, List<String> commandParts, StringBuffer buffer) {
  final value = int.tryParse(commandParts[1]);
  if (value != null) {
    stack.push(value);
  } else {
    buffer.writeln('Invalid push command');
  }
}

void _handlePop(
    Stack<int> stack, List<String> commandParts, StringBuffer buffer) {
  buffer.writeln(stack.isEmpty ? -1 : stack.pop());
}

void _handleSize(
    Stack<int> stack, List<String> commandParts, StringBuffer buffer) {
  buffer.writeln(stack.size);
}

void _handleEmpty(
    Stack<int> stack, List<String> commandParts, StringBuffer buffer) {
  buffer.writeln(stack.isEmpty ? 1 : 0);
}

void _handleTop(
    Stack<int> stack, List<String> commandParts, StringBuffer buffer) {
  buffer.writeln(stack.isEmpty ? -1 : stack.peek());
}
