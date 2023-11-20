import java.io.*;
import java.util.*;

public class FiniteAutomata {

    public static void main(String[] args) {
        Set<String> states = new HashSet<>();
        Set<String> alphabet = new HashSet<>();
        Set<String> finalStates = new HashSet<>();
        Set<String> transitions = new HashSet<>();
        String initialState = "";
        try (Scanner scanner = new Scanner(new File("D:\\Facultate\\LimbajeFormale\\lab3\\untitled\\src\\FA.in"))) {
            String[] stateTokens = scanner.nextLine().split(",");
            states.addAll(Arrays.asList(stateTokens));
            String[] alphabetTokens = scanner.nextLine().split(",");
            alphabet.addAll(Arrays.asList(alphabetTokens));
            initialState = scanner.nextLine();
            String[] finalStatesTokens = scanner.nextLine().split(",");
            finalStates.addAll(Arrays.asList(finalStatesTokens));

            while (scanner.hasNextLine()) {
                String[] transitionTokens = scanner.nextLine().split("=");
                String[] transitionParts = transitionTokens[0].split(",");
                String fromState = transitionParts[0];
                String inputSymbol = transitionParts[1];
                String toState = transitionTokens[1];
                if (!states.contains(fromState) || !states.contains(toState) || !alphabet.contains(inputSymbol)) {
                    System.out.println("Error: The finite automata is not valid.");
                    return;
                }
                transitions.add(fromState + " " + inputSymbol + " " + toState);
            }
        } catch (FileNotFoundException e) {
            System.out.println("Error: FA.in file not found.");
            return;
        }

        System.out.println("Set of States: " + states);
        System.out.println("Alphabet: " + alphabet);
        System.out.println("Transitions: " + transitions);
        System.out.println("Initial State: " + initialState);
        System.out.println("Set of Final States: " + finalStates);

        boolean isValid = states.containsAll(finalStates);

        if (isValid) {
            System.out.println("The finite automata is valid.");
        } else {
            System.out.println("The finite automata is not valid.");
        }

        Scanner inputScanner = new Scanner(System.in);
        while (true) {
            System.out.println("\nMenu:");
            System.out.println("1. Initial State");
            System.out.println("2. Final States");
            System.out.println("3. All states");
            System.out.println("4. Transitions");
            System.out.println("5. Input");
            System.out.println("6. Exit");

            System.out.print("Enter your choice (1/2/3/4/5/6): ");
            int choice = inputScanner.nextInt();

            switch (choice) {
                case 1:
                    System.out.println("Initial State: " + initialState);
                    break;
                case 2:
                    System.out.println("Final States: " + finalStates);
                    break;
                case 3:
                    System.out.println("States: " + states);
                    break;
                case 4:
                    System.out.println("Transitions: " + transitions);
                    break;
                case 5:
                    String inputString = inputScanner.next();

                    char[] charArray = inputString.toCharArray();

                    String currentState = initialState;

                    for (char c : charArray) {
                        boolean foundTransition = false;
                        for (String transition : transitions) {
                            String[] parts = transition.split(" ");
                            String fromState = parts[0];
                            String inputSymbol = parts[1];
                            String toState = parts[2];
                            if (fromState.equals(currentState) && inputSymbol.equals(String.valueOf(c))) {
                                currentState = toState;
                                foundTransition = true;
                                break;
                            }
                        }
                        if (!foundTransition) {
                            System.out.println("Invalid transition for '" + c + "' in state '" + currentState + "'.");
                            break;
                        }
                    }
                    if (finalStates.contains(currentState)) {
                        System.out.println("The input string is accepted.");
                    } else {
                        System.out.println("The input string is not accepted.");
                    }
                    break;

                case 6:
                    inputScanner.close();
                    return;
                default:
                    System.out.println("Invalid input.");
            }
        }
    }
}
