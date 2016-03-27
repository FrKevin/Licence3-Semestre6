int somme(int n) {
    int i, somme = 0;

    for (i = 0; i < n; i++) {
        somme += i;
    }

    return 0;
}

int sommePairs(int n) {
    int i, somme = 0;

    for (i = 0; i < n; i+=2) {
        somme += i;
    }

    return 0;
}

int sommeImpairs(int n) {
    int i, somme = 0;

    for (i = 1; i < n; i+=2) {
        somme += i;
    }

    return 0;
}

int sommeCarres(int n) {
    int i, somme = 0;

    for (i = 0; i < n; i++) {
        somme += i * i;
    }

    return 0;
}
