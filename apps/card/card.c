#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <openssl/aes.h>
#include <openssl/evp.h>

// Function to calculate CVC from card number
int calculateCVC(char* cardNumber) {
    // Use AES encryption with card number as the key
    unsigned char key[16];

    int j = 0;
    for(int i = 0; i< strlen(cardNumber) && j < 16; i++){
        if(cardNumber[i] != '-'){
            key[j] = cardNumber[i];
            j++;
        }
    }
    // Encrypt a constant value to get CVC
    unsigned char plaintext[16] = "I wanna CVC Code";
    unsigned char ciphertext[16];
    unsigned char iv[16] = {0};

    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
    EVP_EncryptInit_ex(ctx, EVP_aes_128_cbc(), NULL, key, iv);
    int len;
    EVP_EncryptUpdate(ctx, ciphertext, &len, plaintext, 16);
    EVP_EncryptFinal_ex(ctx, ciphertext + len, &len);
    EVP_CIPHER_CTX_free(ctx);

    // Convert the first 3 bytes of ciphertext to an integer
    char cvc_str[4];
    sprintf(cvc_str, "%d%d%d", (ciphertext[0]%9)+1, (ciphertext[1]%10), (ciphertext[2]%10));
    int cvc_int = atoi(cvc_str);
    return cvc_int;
}

// Luhn algorithm for credit card number generation
char* generateCardNumber() {
    srand((unsigned)time(0));
    char* cardNumber = malloc(20);  // Increased size to accommodate '-' characters
    cardNumber[0] = '4'; // Visa card numbers start with 4
    for(int i = 1; i < 19; i++) {
        if(i % 5 == 4) {  // Add '-' after every 4 digits
            cardNumber[i] = '-';
        } else {
            cardNumber[i] = '0' + rand() % 10;
        }
    }
    cardNumber[19] = '\0';

    int digits[16];
    for(int i = 0, j = 0; i < 16; i++, j++) {
        if(cardNumber[j] == '-') j++;
        digits[i] = cardNumber[j] - '0';
    }

    for(int i = 14; i >= 0; i -= 2) {
        digits[i] *= 2;
        if(digits[i] > 9) {
            digits[i] -= 9;
        }
    }

    int sum = 0;
    for(int i = 0; i < 15; i++) {
        sum += digits[i];
    }

    int checkDigit = (sum * 9) % 10;
    cardNumber[18] = '0' + checkDigit;

    return cardNumber;
}

// Function to check CVC
int verifyCVC(char* cardNumber, int inputCVC) {
    int calculatedCVC = calculateCVC(cardNumber);
    return calculatedCVC == inputCVC;
}

void insertName(){
    char name[20];  // Buffer for storing the name
    write(1, "Enter your name: ", 17);
    read(0, name, 1024);  // Use gets to introduce BOF vulnerability
}

int main() {
    setvbuf(stdin, 0,2,0);
    setvbuf(stdout, 0,2,0);
    char* cardNumber = generateCardNumber();
    write(1, "Generated card number: ", 23);
    write(1, cardNumber, strlen(cardNumber));
    write(1, "\n", 1);

    int cvc = calculateCVC(cardNumber);

    int inputCVC;  // Set to an arbitrarily large size to introduce BOF vulnerability
    write(1, "Enter CVC for verification: ", 28);
    scanf("%d", &inputCVC);  // Use scanf to read integer
    if(verifyCVC(cardNumber, inputCVC)) {
        write(1, "Verification successful!\n", 25);
    } else {
        write(1, "Verification failed!\n", 21);
        exit(0);
    }
    free(cardNumber);
    insertName();

    return 0;
}
