pragma circom 2.1.5;

include "./regex_helpers.circom";

template WalletSubjectRegex (msg_bytes) {
    signal input msg[msg_bytes];
    signal output out;

    var num_bytes = msg_bytes+1;
    signal in[num_bytes];
    in[0] <== 128;      // \x80 (sentinel for first character in string)
    for (var i = 0; i < msg_bytes; i++) {
        in[i+1] <== msg[i];
    }

    component eq[121][num_bytes];
    component lt[58][num_bytes];
    component and[102][num_bytes];
    component multi_or[21][num_bytes];
    signal states[num_bytes+1][50];

    for (var i = 0; i < num_bytes+1; i++) {
        states[i][0] <== 1;
    }
    for (var i = 1; i < 50; i++) {
        states[0][i] <== 0;
    }

    for (var i = 0; i < num_bytes; i++) {
        lt[0][i] = LessThan(8);
        lt[0][i].in[0] <== 47;
        lt[0][i].in[1] <== in[i];
        lt[1][i] = LessThan(8);
        lt[1][i].in[0] <== in[i];
        lt[1][i].in[1] <== 58;
        and[0][i] = AND();
        and[0][i].a <== lt[0][i].out;
        and[0][i].b <== lt[1][i].out;
        and[1][i] = AND();
        and[1][i].a <== states[i][1];
        and[1][i].b <== and[0][i].out;
        lt[2][i] = LessThan(8);
        lt[2][i].in[0] <== 47;
        lt[2][i].in[1] <== in[i];
        lt[3][i] = LessThan(8);
        lt[3][i].in[0] <== in[i];
        lt[3][i].in[1] <== 58;
        and[2][i] = AND();
        and[2][i].a <== lt[2][i].out;
        and[2][i].b <== lt[3][i].out;
        and[3][i] = AND();
        and[3][i].a <== states[i][48];
        and[3][i].b <== and[2][i].out;
        lt[4][i] = LessThan(8);
        lt[4][i].in[0] <== 47;
        lt[4][i].in[1] <== in[i];
        lt[5][i] = LessThan(8);
        lt[5][i].in[0] <== in[i];
        lt[5][i].in[1] <== 58;
        and[4][i] = AND();
        and[4][i].a <== lt[4][i].out;
        and[4][i].b <== lt[5][i].out;
        and[5][i] = AND();
        and[5][i].a <== states[i][49];
        and[5][i].b <== and[4][i].out;
        multi_or[0][i] = MultiOR(3);
        multi_or[0][i].in[0] <== and[1][i].out;
        multi_or[0][i].in[1] <== and[3][i].out;
        multi_or[0][i].in[2] <== and[5][i].out;
        states[i+1][1] <== multi_or[0][i].out;
        eq[0][i] = IsEqual();
        eq[0][i].in[0] <== in[i];
        eq[0][i].in[1] <== 32;
        and[6][i] = AND();
        and[6][i].a <== states[i][1];
        and[6][i].b <== eq[0][i].out;
        eq[1][i] = IsEqual();
        eq[1][i].in[0] <== in[i];
        eq[1][i].in[1] <== 32;
        and[7][i] = AND();
        and[7][i].a <== states[i][10];
        and[7][i].b <== eq[1][i].out;
        multi_or[1][i] = MultiOR(2);
        multi_or[1][i].in[0] <== and[6][i].out;
        multi_or[1][i].in[1] <== and[7][i].out;
        states[i+1][2] <== multi_or[1][i].out;
        eq[2][i] = IsEqual();
        eq[2][i].in[0] <== in[i];
        eq[2][i].in[1] <== 46;
        and[8][i] = AND();
        and[8][i].a <== states[i][1];
        and[8][i].b <== eq[2][i].out;
        states[i+1][3] <== and[8][i].out;
        eq[3][i] = IsEqual();
        eq[3][i].in[0] <== in[i];
        eq[3][i].in[1] <== 68;
        and[9][i] = AND();
        and[9][i].a <== states[i][2];
        and[9][i].b <== eq[3][i].out;
        states[i+1][4] <== and[9][i].out;
        eq[4][i] = IsEqual();
        eq[4][i].in[0] <== in[i];
        eq[4][i].in[1] <== 69;
        and[10][i] = AND();
        and[10][i].a <== states[i][2];
        and[10][i].b <== eq[4][i].out;
        states[i+1][5] <== and[10][i].out;
        eq[5][i] = IsEqual();
        eq[5][i].in[0] <== in[i];
        eq[5][i].in[1] <== 85;
        and[11][i] = AND();
        and[11][i].a <== states[i][2];
        and[11][i].b <== eq[5][i].out;
        states[i+1][6] <== and[11][i].out;
        eq[6][i] = IsEqual();
        eq[6][i].in[0] <== in[i];
        eq[6][i].in[1] <== 100;
        and[12][i] = AND();
        and[12][i].a <== states[i][2];
        and[12][i].b <== eq[6][i].out;
        states[i+1][7] <== and[12][i].out;
        eq[7][i] = IsEqual();
        eq[7][i].in[0] <== in[i];
        eq[7][i].in[1] <== 101;
        and[13][i] = AND();
        and[13][i].a <== states[i][2];
        and[13][i].b <== eq[7][i].out;
        states[i+1][8] <== and[13][i].out;
        eq[8][i] = IsEqual();
        eq[8][i].in[0] <== in[i];
        eq[8][i].in[1] <== 117;
        and[14][i] = AND();
        and[14][i].a <== states[i][2];
        and[14][i].b <== eq[8][i].out;
        states[i+1][9] <== and[14][i].out;
        lt[6][i] = LessThan(8);
        lt[6][i].in[0] <== 47;
        lt[6][i].in[1] <== in[i];
        lt[7][i] = LessThan(8);
        lt[7][i].in[0] <== in[i];
        lt[7][i].in[1] <== 58;
        and[15][i] = AND();
        and[15][i].a <== lt[6][i].out;
        and[15][i].b <== lt[7][i].out;
        and[16][i] = AND();
        and[16][i].a <== states[i][3];
        and[16][i].b <== and[15][i].out;
        states[i+1][10] <== and[16][i].out;
        eq[9][i] = IsEqual();
        eq[9][i].in[0] <== in[i];
        eq[9][i].in[1] <== 13;
        and[17][i] = AND();
        and[17][i].a <== states[i][0];
        and[17][i].b <== eq[9][i].out;
        states[i+1][11] <== and[17][i].out;
        eq[10][i] = IsEqual();
        eq[10][i].in[0] <== in[i];
        eq[10][i].in[1] <== 65;
        and[18][i] = AND();
        and[18][i].a <== states[i][4];
        and[18][i].b <== eq[10][i].out;
        states[i+1][12] <== and[18][i].out;
        eq[11][i] = IsEqual();
        eq[11][i].in[0] <== in[i];
        eq[11][i].in[1] <== 84;
        and[19][i] = AND();
        and[19][i].a <== states[i][5];
        and[19][i].b <== eq[11][i].out;
        states[i+1][13] <== and[19][i].out;
        eq[12][i] = IsEqual();
        eq[12][i].in[0] <== in[i];
        eq[12][i].in[1] <== 83;
        and[20][i] = AND();
        and[20][i].a <== states[i][6];
        and[20][i].b <== eq[12][i].out;
        states[i+1][14] <== and[20][i].out;
        eq[13][i] = IsEqual();
        eq[13][i].in[0] <== in[i];
        eq[13][i].in[1] <== 97;
        and[21][i] = AND();
        and[21][i].a <== states[i][7];
        and[21][i].b <== eq[13][i].out;
        states[i+1][15] <== and[21][i].out;
        eq[14][i] = IsEqual();
        eq[14][i].in[0] <== in[i];
        eq[14][i].in[1] <== 116;
        and[22][i] = AND();
        and[22][i].a <== states[i][8];
        and[22][i].b <== eq[14][i].out;
        states[i+1][16] <== and[22][i].out;
        eq[15][i] = IsEqual();
        eq[15][i].in[0] <== in[i];
        eq[15][i].in[1] <== 115;
        and[23][i] = AND();
        and[23][i].a <== states[i][9];
        and[23][i].b <== eq[15][i].out;
        states[i+1][17] <== and[23][i].out;
        eq[16][i] = IsEqual();
        eq[16][i].in[0] <== in[i];
        eq[16][i].in[1] <== 73;
        and[24][i] = AND();
        and[24][i].a <== states[i][12];
        and[24][i].b <== eq[16][i].out;
        eq[17][i] = IsEqual();
        eq[17][i].in[0] <== in[i];
        eq[17][i].in[1] <== 72;
        and[25][i] = AND();
        and[25][i].a <== states[i][13];
        and[25][i].b <== eq[17][i].out;
        eq[18][i] = IsEqual();
        eq[18][i].in[0] <== in[i];
        eq[18][i].in[1] <== 105;
        and[26][i] = AND();
        and[26][i].a <== states[i][15];
        and[26][i].b <== eq[18][i].out;
        eq[19][i] = IsEqual();
        eq[19][i].in[0] <== in[i];
        eq[19][i].in[1] <== 104;
        and[27][i] = AND();
        and[27][i].a <== states[i][16];
        and[27][i].b <== eq[19][i].out;
        eq[20][i] = IsEqual();
        eq[20][i].in[0] <== in[i];
        eq[20][i].in[1] <== 67;
        and[28][i] = AND();
        and[28][i].a <== states[i][19];
        and[28][i].b <== eq[20][i].out;
        eq[21][i] = IsEqual();
        eq[21][i].in[0] <== in[i];
        eq[21][i].in[1] <== 99;
        and[29][i] = AND();
        and[29][i].a <== states[i][20];
        and[29][i].b <== eq[21][i].out;
        multi_or[2][i] = MultiOR(6);
        multi_or[2][i].in[0] <== and[24][i].out;
        multi_or[2][i].in[1] <== and[25][i].out;
        multi_or[2][i].in[2] <== and[26][i].out;
        multi_or[2][i].in[3] <== and[27][i].out;
        multi_or[2][i].in[4] <== and[28][i].out;
        multi_or[2][i].in[5] <== and[29][i].out;
        states[i+1][18] <== multi_or[2][i].out;
        eq[22][i] = IsEqual();
        eq[22][i].in[0] <== in[i];
        eq[22][i].in[1] <== 68;
        and[30][i] = AND();
        and[30][i].a <== states[i][14];
        and[30][i].b <== eq[22][i].out;
        states[i+1][19] <== and[30][i].out;
        eq[23][i] = IsEqual();
        eq[23][i].in[0] <== in[i];
        eq[23][i].in[1] <== 100;
        and[31][i] = AND();
        and[31][i].a <== states[i][17];
        and[31][i].b <== eq[23][i].out;
        states[i+1][20] <== and[31][i].out;
        eq[24][i] = IsEqual();
        eq[24][i].in[0] <== in[i];
        eq[24][i].in[1] <== 32;
        and[32][i] = AND();
        and[32][i].a <== states[i][18];
        and[32][i].b <== eq[24][i].out;
        states[i+1][21] <== and[32][i].out;
        eq[25][i] = IsEqual();
        eq[25][i].in[0] <== in[i];
        eq[25][i].in[1] <== 116;
        and[33][i] = AND();
        and[33][i].a <== states[i][21];
        and[33][i].b <== eq[25][i].out;
        states[i+1][22] <== and[33][i].out;
        eq[26][i] = IsEqual();
        eq[26][i].in[0] <== in[i];
        eq[26][i].in[1] <== 111;
        and[34][i] = AND();
        and[34][i].a <== states[i][22];
        and[34][i].b <== eq[26][i].out;
        states[i+1][23] <== and[34][i].out;
        eq[27][i] = IsEqual();
        eq[27][i].in[0] <== in[i];
        eq[27][i].in[1] <== 32;
        and[35][i] = AND();
        and[35][i].a <== states[i][23];
        and[35][i].b <== eq[27][i].out;
        states[i+1][24] <== and[35][i].out;
        lt[8][i] = LessThan(8);
        lt[8][i].in[0] <== 64;
        lt[8][i].in[1] <== in[i];
        lt[9][i] = LessThan(8);
        lt[9][i].in[0] <== in[i];
        lt[9][i].in[1] <== 91;
        and[36][i] = AND();
        and[36][i].a <== lt[8][i].out;
        and[36][i].b <== lt[9][i].out;
        lt[10][i] = LessThan(8);
        lt[10][i].in[0] <== 96;
        lt[10][i].in[1] <== in[i];
        lt[11][i] = LessThan(8);
        lt[11][i].in[0] <== in[i];
        lt[11][i].in[1] <== 123;
        and[37][i] = AND();
        and[37][i].a <== lt[10][i].out;
        and[37][i].b <== lt[11][i].out;
        eq[28][i] = IsEqual();
        eq[28][i].in[0] <== in[i];
        eq[28][i].in[1] <== 37;
        eq[29][i] = IsEqual();
        eq[29][i].in[0] <== in[i];
        eq[29][i].in[1] <== 54;
        eq[30][i] = IsEqual();
        eq[30][i].in[0] <== in[i];
        eq[30][i].in[1] <== 49;
        eq[31][i] = IsEqual();
        eq[31][i].in[0] <== in[i];
        eq[31][i].in[1] <== 43;
        eq[32][i] = IsEqual();
        eq[32][i].in[0] <== in[i];
        eq[32][i].in[1] <== 51;
        eq[33][i] = IsEqual();
        eq[33][i].in[0] <== in[i];
        eq[33][i].in[1] <== 95;
        eq[34][i] = IsEqual();
        eq[34][i].in[0] <== in[i];
        eq[34][i].in[1] <== 45;
        eq[35][i] = IsEqual();
        eq[35][i].in[0] <== in[i];
        eq[35][i].in[1] <== 52;
        eq[36][i] = IsEqual();
        eq[36][i].in[0] <== in[i];
        eq[36][i].in[1] <== 56;
        eq[37][i] = IsEqual();
        eq[37][i].in[0] <== in[i];
        eq[37][i].in[1] <== 55;
        eq[38][i] = IsEqual();
        eq[38][i].in[0] <== in[i];
        eq[38][i].in[1] <== 53;
        eq[39][i] = IsEqual();
        eq[39][i].in[0] <== in[i];
        eq[39][i].in[1] <== 57;
        eq[40][i] = IsEqual();
        eq[40][i].in[0] <== in[i];
        eq[40][i].in[1] <== 50;
        eq[41][i] = IsEqual();
        eq[41][i].in[0] <== in[i];
        eq[41][i].in[1] <== 46;
        and[38][i] = AND();
        and[38][i].a <== states[i][24];
        multi_or[3][i] = MultiOR(16);
        multi_or[3][i].in[0] <== and[36][i].out;
        multi_or[3][i].in[1] <== and[37][i].out;
        multi_or[3][i].in[2] <== eq[28][i].out;
        multi_or[3][i].in[3] <== eq[29][i].out;
        multi_or[3][i].in[4] <== eq[30][i].out;
        multi_or[3][i].in[5] <== eq[31][i].out;
        multi_or[3][i].in[6] <== eq[32][i].out;
        multi_or[3][i].in[7] <== eq[33][i].out;
        multi_or[3][i].in[8] <== eq[34][i].out;
        multi_or[3][i].in[9] <== eq[35][i].out;
        multi_or[3][i].in[10] <== eq[36][i].out;
        multi_or[3][i].in[11] <== eq[37][i].out;
        multi_or[3][i].in[12] <== eq[38][i].out;
        multi_or[3][i].in[13] <== eq[39][i].out;
        multi_or[3][i].in[14] <== eq[40][i].out;
        multi_or[3][i].in[15] <== eq[41][i].out;
        and[38][i].b <== multi_or[3][i].out;
        lt[12][i] = LessThan(8);
        lt[12][i].in[0] <== 64;
        lt[12][i].in[1] <== in[i];
        lt[13][i] = LessThan(8);
        lt[13][i].in[0] <== in[i];
        lt[13][i].in[1] <== 91;
        and[39][i] = AND();
        and[39][i].a <== lt[12][i].out;
        and[39][i].b <== lt[13][i].out;
        lt[14][i] = LessThan(8);
        lt[14][i].in[0] <== 96;
        lt[14][i].in[1] <== in[i];
        lt[15][i] = LessThan(8);
        lt[15][i].in[0] <== in[i];
        lt[15][i].in[1] <== 123;
        and[40][i] = AND();
        and[40][i].a <== lt[14][i].out;
        and[40][i].b <== lt[15][i].out;
        lt[16][i] = LessThan(8);
        lt[16][i].in[0] <== 47;
        lt[16][i].in[1] <== in[i];
        lt[17][i] = LessThan(8);
        lt[17][i].in[0] <== in[i];
        lt[17][i].in[1] <== 58;
        and[41][i] = AND();
        and[41][i].a <== lt[16][i].out;
        and[41][i].b <== lt[17][i].out;
        eq[42][i] = IsEqual();
        eq[42][i].in[0] <== in[i];
        eq[42][i].in[1] <== 37;
        eq[43][i] = IsEqual();
        eq[43][i].in[0] <== in[i];
        eq[43][i].in[1] <== 43;
        eq[44][i] = IsEqual();
        eq[44][i].in[0] <== in[i];
        eq[44][i].in[1] <== 95;
        eq[45][i] = IsEqual();
        eq[45][i].in[0] <== in[i];
        eq[45][i].in[1] <== 45;
        eq[46][i] = IsEqual();
        eq[46][i].in[0] <== in[i];
        eq[46][i].in[1] <== 46;
        and[42][i] = AND();
        and[42][i].a <== states[i][25];
        multi_or[4][i] = MultiOR(8);
        multi_or[4][i].in[0] <== and[39][i].out;
        multi_or[4][i].in[1] <== and[40][i].out;
        multi_or[4][i].in[2] <== and[41][i].out;
        multi_or[4][i].in[3] <== eq[42][i].out;
        multi_or[4][i].in[4] <== eq[43][i].out;
        multi_or[4][i].in[5] <== eq[44][i].out;
        multi_or[4][i].in[6] <== eq[45][i].out;
        multi_or[4][i].in[7] <== eq[46][i].out;
        and[42][i].b <== multi_or[4][i].out;
        lt[18][i] = LessThan(8);
        lt[18][i].in[0] <== 64;
        lt[18][i].in[1] <== in[i];
        lt[19][i] = LessThan(8);
        lt[19][i].in[0] <== in[i];
        lt[19][i].in[1] <== 91;
        and[43][i] = AND();
        and[43][i].a <== lt[18][i].out;
        and[43][i].b <== lt[19][i].out;
        lt[20][i] = LessThan(8);
        lt[20][i].in[0] <== 47;
        lt[20][i].in[1] <== in[i];
        lt[21][i] = LessThan(8);
        lt[21][i].in[0] <== in[i];
        lt[21][i].in[1] <== 58;
        and[44][i] = AND();
        and[44][i].a <== lt[20][i].out;
        and[44][i].b <== lt[21][i].out;
        eq[47][i] = IsEqual();
        eq[47][i].in[0] <== in[i];
        eq[47][i].in[1] <== 105;
        eq[48][i] = IsEqual();
        eq[48][i].in[0] <== in[i];
        eq[48][i].in[1] <== 116;
        eq[49][i] = IsEqual();
        eq[49][i].in[0] <== in[i];
        eq[49][i].in[1] <== 112;
        eq[50][i] = IsEqual();
        eq[50][i].in[0] <== in[i];
        eq[50][i].in[1] <== 37;
        eq[51][i] = IsEqual();
        eq[51][i].in[0] <== in[i];
        eq[51][i].in[1] <== 122;
        eq[52][i] = IsEqual();
        eq[52][i].in[0] <== in[i];
        eq[52][i].in[1] <== 97;
        eq[53][i] = IsEqual();
        eq[53][i].in[0] <== in[i];
        eq[53][i].in[1] <== 102;
        eq[54][i] = IsEqual();
        eq[54][i].in[0] <== in[i];
        eq[54][i].in[1] <== 110;
        eq[55][i] = IsEqual();
        eq[55][i].in[0] <== in[i];
        eq[55][i].in[1] <== 113;
        eq[56][i] = IsEqual();
        eq[56][i].in[0] <== in[i];
        eq[56][i].in[1] <== 104;
        eq[57][i] = IsEqual();
        eq[57][i].in[0] <== in[i];
        eq[57][i].in[1] <== 114;
        eq[58][i] = IsEqual();
        eq[58][i].in[0] <== in[i];
        eq[58][i].in[1] <== 45;
        eq[59][i] = IsEqual();
        eq[59][i].in[0] <== in[i];
        eq[59][i].in[1] <== 99;
        eq[60][i] = IsEqual();
        eq[60][i].in[0] <== in[i];
        eq[60][i].in[1] <== 119;
        eq[61][i] = IsEqual();
        eq[61][i].in[0] <== in[i];
        eq[61][i].in[1] <== 46;
        eq[62][i] = IsEqual();
        eq[62][i].in[0] <== in[i];
        eq[62][i].in[1] <== 106;
        eq[63][i] = IsEqual();
        eq[63][i].in[0] <== in[i];
        eq[63][i].in[1] <== 121;
        eq[64][i] = IsEqual();
        eq[64][i].in[0] <== in[i];
        eq[64][i].in[1] <== 118;
        eq[65][i] = IsEqual();
        eq[65][i].in[0] <== in[i];
        eq[65][i].in[1] <== 100;
        eq[66][i] = IsEqual();
        eq[66][i].in[0] <== in[i];
        eq[66][i].in[1] <== 43;
        eq[67][i] = IsEqual();
        eq[67][i].in[0] <== in[i];
        eq[67][i].in[1] <== 98;
        eq[68][i] = IsEqual();
        eq[68][i].in[0] <== in[i];
        eq[68][i].in[1] <== 95;
        eq[69][i] = IsEqual();
        eq[69][i].in[0] <== in[i];
        eq[69][i].in[1] <== 108;
        eq[70][i] = IsEqual();
        eq[70][i].in[0] <== in[i];
        eq[70][i].in[1] <== 111;
        eq[71][i] = IsEqual();
        eq[71][i].in[0] <== in[i];
        eq[71][i].in[1] <== 101;
        eq[72][i] = IsEqual();
        eq[72][i].in[0] <== in[i];
        eq[72][i].in[1] <== 107;
        eq[73][i] = IsEqual();
        eq[73][i].in[0] <== in[i];
        eq[73][i].in[1] <== 117;
        eq[74][i] = IsEqual();
        eq[74][i].in[0] <== in[i];
        eq[74][i].in[1] <== 115;
        eq[75][i] = IsEqual();
        eq[75][i].in[0] <== in[i];
        eq[75][i].in[1] <== 103;
        eq[76][i] = IsEqual();
        eq[76][i].in[0] <== in[i];
        eq[76][i].in[1] <== 109;
        and[45][i] = AND();
        and[45][i].a <== states[i][27];
        multi_or[5][i] = MultiOR(32);
        multi_or[5][i].in[0] <== and[43][i].out;
        multi_or[5][i].in[1] <== and[44][i].out;
        multi_or[5][i].in[2] <== eq[47][i].out;
        multi_or[5][i].in[3] <== eq[48][i].out;
        multi_or[5][i].in[4] <== eq[49][i].out;
        multi_or[5][i].in[5] <== eq[50][i].out;
        multi_or[5][i].in[6] <== eq[51][i].out;
        multi_or[5][i].in[7] <== eq[52][i].out;
        multi_or[5][i].in[8] <== eq[53][i].out;
        multi_or[5][i].in[9] <== eq[54][i].out;
        multi_or[5][i].in[10] <== eq[55][i].out;
        multi_or[5][i].in[11] <== eq[56][i].out;
        multi_or[5][i].in[12] <== eq[57][i].out;
        multi_or[5][i].in[13] <== eq[58][i].out;
        multi_or[5][i].in[14] <== eq[59][i].out;
        multi_or[5][i].in[15] <== eq[60][i].out;
        multi_or[5][i].in[16] <== eq[61][i].out;
        multi_or[5][i].in[17] <== eq[62][i].out;
        multi_or[5][i].in[18] <== eq[63][i].out;
        multi_or[5][i].in[19] <== eq[64][i].out;
        multi_or[5][i].in[20] <== eq[65][i].out;
        multi_or[5][i].in[21] <== eq[66][i].out;
        multi_or[5][i].in[22] <== eq[67][i].out;
        multi_or[5][i].in[23] <== eq[68][i].out;
        multi_or[5][i].in[24] <== eq[69][i].out;
        multi_or[5][i].in[25] <== eq[70][i].out;
        multi_or[5][i].in[26] <== eq[71][i].out;
        multi_or[5][i].in[27] <== eq[72][i].out;
        multi_or[5][i].in[28] <== eq[73][i].out;
        multi_or[5][i].in[29] <== eq[74][i].out;
        multi_or[5][i].in[30] <== eq[75][i].out;
        multi_or[5][i].in[31] <== eq[76][i].out;
        and[45][i].b <== multi_or[5][i].out;
        lt[22][i] = LessThan(8);
        lt[22][i].in[0] <== 64;
        lt[22][i].in[1] <== in[i];
        lt[23][i] = LessThan(8);
        lt[23][i].in[0] <== in[i];
        lt[23][i].in[1] <== 91;
        and[46][i] = AND();
        and[46][i].a <== lt[22][i].out;
        and[46][i].b <== lt[23][i].out;
        lt[24][i] = LessThan(8);
        lt[24][i].in[0] <== 96;
        lt[24][i].in[1] <== in[i];
        lt[25][i] = LessThan(8);
        lt[25][i].in[0] <== in[i];
        lt[25][i].in[1] <== 123;
        and[47][i] = AND();
        and[47][i].a <== lt[24][i].out;
        and[47][i].b <== lt[25][i].out;
        eq[77][i] = IsEqual();
        eq[77][i].in[0] <== in[i];
        eq[77][i].in[1] <== 45;
        eq[78][i] = IsEqual();
        eq[78][i].in[0] <== in[i];
        eq[78][i].in[1] <== 37;
        eq[79][i] = IsEqual();
        eq[79][i].in[0] <== in[i];
        eq[79][i].in[1] <== 43;
        eq[80][i] = IsEqual();
        eq[80][i].in[0] <== in[i];
        eq[80][i].in[1] <== 95;
        eq[81][i] = IsEqual();
        eq[81][i].in[0] <== in[i];
        eq[81][i].in[1] <== 46;
        and[48][i] = AND();
        and[48][i].a <== states[i][33];
        multi_or[6][i] = MultiOR(7);
        multi_or[6][i].in[0] <== and[46][i].out;
        multi_or[6][i].in[1] <== and[47][i].out;
        multi_or[6][i].in[2] <== eq[77][i].out;
        multi_or[6][i].in[3] <== eq[78][i].out;
        multi_or[6][i].in[4] <== eq[79][i].out;
        multi_or[6][i].in[5] <== eq[80][i].out;
        multi_or[6][i].in[6] <== eq[81][i].out;
        and[48][i].b <== multi_or[6][i].out;
        lt[26][i] = LessThan(8);
        lt[26][i].in[0] <== 64;
        lt[26][i].in[1] <== in[i];
        lt[27][i] = LessThan(8);
        lt[27][i].in[0] <== in[i];
        lt[27][i].in[1] <== 91;
        and[49][i] = AND();
        and[49][i].a <== lt[26][i].out;
        and[49][i].b <== lt[27][i].out;
        lt[28][i] = LessThan(8);
        lt[28][i].in[0] <== 96;
        lt[28][i].in[1] <== in[i];
        lt[29][i] = LessThan(8);
        lt[29][i].in[0] <== in[i];
        lt[29][i].in[1] <== 123;
        and[50][i] = AND();
        and[50][i].a <== lt[28][i].out;
        and[50][i].b <== lt[29][i].out;
        eq[82][i] = IsEqual();
        eq[82][i].in[0] <== in[i];
        eq[82][i].in[1] <== 45;
        eq[83][i] = IsEqual();
        eq[83][i].in[0] <== in[i];
        eq[83][i].in[1] <== 37;
        eq[84][i] = IsEqual();
        eq[84][i].in[0] <== in[i];
        eq[84][i].in[1] <== 43;
        eq[85][i] = IsEqual();
        eq[85][i].in[0] <== in[i];
        eq[85][i].in[1] <== 95;
        eq[86][i] = IsEqual();
        eq[86][i].in[0] <== in[i];
        eq[86][i].in[1] <== 46;
        and[51][i] = AND();
        and[51][i].a <== states[i][37];
        multi_or[7][i] = MultiOR(7);
        multi_or[7][i].in[0] <== and[49][i].out;
        multi_or[7][i].in[1] <== and[50][i].out;
        multi_or[7][i].in[2] <== eq[82][i].out;
        multi_or[7][i].in[3] <== eq[83][i].out;
        multi_or[7][i].in[4] <== eq[84][i].out;
        multi_or[7][i].in[5] <== eq[85][i].out;
        multi_or[7][i].in[6] <== eq[86][i].out;
        and[51][i].b <== multi_or[7][i].out;
        multi_or[8][i] = MultiOR(5);
        multi_or[8][i].in[0] <== and[38][i].out;
        multi_or[8][i].in[1] <== and[42][i].out;
        multi_or[8][i].in[2] <== and[45][i].out;
        multi_or[8][i].in[3] <== and[48][i].out;
        multi_or[8][i].in[4] <== and[51][i].out;
        states[i+1][25] <== multi_or[8][i].out;
        eq[87][i] = IsEqual();
        eq[87][i].in[0] <== in[i];
        eq[87][i].in[1] <== 128;
        and[52][i] = AND();
        and[52][i].a <== states[i][0];
        and[52][i].b <== eq[87][i].out;
        eq[88][i] = IsEqual();
        eq[88][i].in[0] <== in[i];
        eq[88][i].in[1] <== 10;
        and[53][i] = AND();
        and[53][i].a <== states[i][11];
        and[53][i].b <== eq[88][i].out;
        multi_or[9][i] = MultiOR(2);
        multi_or[9][i].in[0] <== and[52][i].out;
        multi_or[9][i].in[1] <== and[53][i].out;
        states[i+1][26] <== multi_or[9][i].out;
        eq[89][i] = IsEqual();
        eq[89][i].in[0] <== in[i];
        eq[89][i].in[1] <== 48;
        and[54][i] = AND();
        and[54][i].a <== states[i][24];
        and[54][i].b <== eq[89][i].out;
        states[i+1][27] <== and[54][i].out;
        eq[90][i] = IsEqual();
        eq[90][i].in[0] <== in[i];
        eq[90][i].in[1] <== 115;
        and[55][i] = AND();
        and[55][i].a <== states[i][26];
        and[55][i].b <== eq[90][i].out;
        states[i+1][28] <== and[55][i].out;
        eq[91][i] = IsEqual();
        eq[91][i].in[0] <== in[i];
        eq[91][i].in[1] <== 117;
        and[56][i] = AND();
        and[56][i].a <== states[i][28];
        and[56][i].b <== eq[91][i].out;
        states[i+1][29] <== and[56][i].out;
        eq[92][i] = IsEqual();
        eq[92][i].in[0] <== in[i];
        eq[92][i].in[1] <== 64;
        and[57][i] = AND();
        and[57][i].a <== states[i][25];
        and[57][i].b <== eq[92][i].out;
        eq[93][i] = IsEqual();
        eq[93][i].in[0] <== in[i];
        eq[93][i].in[1] <== 64;
        and[58][i] = AND();
        and[58][i].a <== states[i][27];
        and[58][i].b <== eq[93][i].out;
        eq[94][i] = IsEqual();
        eq[94][i].in[0] <== in[i];
        eq[94][i].in[1] <== 64;
        and[59][i] = AND();
        and[59][i].a <== states[i][33];
        and[59][i].b <== eq[94][i].out;
        eq[95][i] = IsEqual();
        eq[95][i].in[0] <== in[i];
        eq[95][i].in[1] <== 64;
        and[60][i] = AND();
        and[60][i].a <== states[i][37];
        and[60][i].b <== eq[95][i].out;
        multi_or[10][i] = MultiOR(4);
        multi_or[10][i].in[0] <== and[57][i].out;
        multi_or[10][i].in[1] <== and[58][i].out;
        multi_or[10][i].in[2] <== and[59][i].out;
        multi_or[10][i].in[3] <== and[60][i].out;
        states[i+1][30] <== multi_or[10][i].out;
        eq[96][i] = IsEqual();
        eq[96][i].in[0] <== in[i];
        eq[96][i].in[1] <== 98;
        and[61][i] = AND();
        and[61][i].a <== states[i][29];
        and[61][i].b <== eq[96][i].out;
        states[i+1][31] <== and[61][i].out;
        eq[97][i] = IsEqual();
        eq[97][i].in[0] <== in[i];
        eq[97][i].in[1] <== 106;
        and[62][i] = AND();
        and[62][i].a <== states[i][31];
        and[62][i].b <== eq[97][i].out;
        states[i+1][32] <== and[62][i].out;
        eq[98][i] = IsEqual();
        eq[98][i].in[0] <== in[i];
        eq[98][i].in[1] <== 120;
        and[63][i] = AND();
        and[63][i].a <== states[i][27];
        and[63][i].b <== eq[98][i].out;
        states[i+1][33] <== and[63][i].out;
        lt[30][i] = LessThan(8);
        lt[30][i].in[0] <== 64;
        lt[30][i].in[1] <== in[i];
        lt[31][i] = LessThan(8);
        lt[31][i].in[0] <== in[i];
        lt[31][i].in[1] <== 91;
        and[64][i] = AND();
        and[64][i].a <== lt[30][i].out;
        and[64][i].b <== lt[31][i].out;
        lt[32][i] = LessThan(8);
        lt[32][i].in[0] <== 96;
        lt[32][i].in[1] <== in[i];
        lt[33][i] = LessThan(8);
        lt[33][i].in[0] <== in[i];
        lt[33][i].in[1] <== 123;
        and[65][i] = AND();
        and[65][i].a <== lt[32][i].out;
        and[65][i].b <== lt[33][i].out;
        lt[34][i] = LessThan(8);
        lt[34][i].in[0] <== 47;
        lt[34][i].in[1] <== in[i];
        lt[35][i] = LessThan(8);
        lt[35][i].in[0] <== in[i];
        lt[35][i].in[1] <== 58;
        and[66][i] = AND();
        and[66][i].a <== lt[34][i].out;
        and[66][i].b <== lt[35][i].out;
        eq[99][i] = IsEqual();
        eq[99][i].in[0] <== in[i];
        eq[99][i].in[1] <== 45;
        eq[100][i] = IsEqual();
        eq[100][i].in[0] <== in[i];
        eq[100][i].in[1] <== 46;
        and[67][i] = AND();
        and[67][i].a <== states[i][30];
        multi_or[11][i] = MultiOR(5);
        multi_or[11][i].in[0] <== and[64][i].out;
        multi_or[11][i].in[1] <== and[65][i].out;
        multi_or[11][i].in[2] <== and[66][i].out;
        multi_or[11][i].in[3] <== eq[99][i].out;
        multi_or[11][i].in[4] <== eq[100][i].out;
        and[67][i].b <== multi_or[11][i].out;
        lt[36][i] = LessThan(8);
        lt[36][i].in[0] <== 64;
        lt[36][i].in[1] <== in[i];
        lt[37][i] = LessThan(8);
        lt[37][i].in[0] <== in[i];
        lt[37][i].in[1] <== 91;
        and[68][i] = AND();
        and[68][i].a <== lt[36][i].out;
        and[68][i].b <== lt[37][i].out;
        lt[38][i] = LessThan(8);
        lt[38][i].in[0] <== 96;
        lt[38][i].in[1] <== in[i];
        lt[39][i] = LessThan(8);
        lt[39][i].in[0] <== in[i];
        lt[39][i].in[1] <== 123;
        and[69][i] = AND();
        and[69][i].a <== lt[38][i].out;
        and[69][i].b <== lt[39][i].out;
        lt[40][i] = LessThan(8);
        lt[40][i].in[0] <== 47;
        lt[40][i].in[1] <== in[i];
        lt[41][i] = LessThan(8);
        lt[41][i].in[0] <== in[i];
        lt[41][i].in[1] <== 58;
        and[70][i] = AND();
        and[70][i].a <== lt[40][i].out;
        and[70][i].b <== lt[41][i].out;
        eq[101][i] = IsEqual();
        eq[101][i].in[0] <== in[i];
        eq[101][i].in[1] <== 45;
        and[71][i] = AND();
        and[71][i].a <== states[i][34];
        multi_or[12][i] = MultiOR(4);
        multi_or[12][i].in[0] <== and[68][i].out;
        multi_or[12][i].in[1] <== and[69][i].out;
        multi_or[12][i].in[2] <== and[70][i].out;
        multi_or[12][i].in[3] <== eq[101][i].out;
        and[71][i].b <== multi_or[12][i].out;
        eq[102][i] = IsEqual();
        eq[102][i].in[0] <== in[i];
        eq[102][i].in[1] <== 45;
        and[72][i] = AND();
        and[72][i].a <== states[i][39];
        and[72][i].b <== eq[102][i].out;
        eq[103][i] = IsEqual();
        eq[103][i].in[0] <== in[i];
        eq[103][i].in[1] <== 45;
        and[73][i] = AND();
        and[73][i].a <== states[i][43];
        and[73][i].b <== eq[103][i].out;
        multi_or[13][i] = MultiOR(4);
        multi_or[13][i].in[0] <== and[67][i].out;
        multi_or[13][i].in[1] <== and[71][i].out;
        multi_or[13][i].in[2] <== and[72][i].out;
        multi_or[13][i].in[3] <== and[73][i].out;
        states[i+1][34] <== multi_or[13][i].out;
        eq[104][i] = IsEqual();
        eq[104][i].in[0] <== in[i];
        eq[104][i].in[1] <== 101;
        and[74][i] = AND();
        and[74][i].a <== states[i][32];
        and[74][i].b <== eq[104][i].out;
        states[i+1][35] <== and[74][i].out;
        eq[105][i] = IsEqual();
        eq[105][i].in[0] <== in[i];
        eq[105][i].in[1] <== 99;
        and[75][i] = AND();
        and[75][i].a <== states[i][35];
        and[75][i].b <== eq[105][i].out;
        states[i+1][36] <== and[75][i].out;
        lt[42][i] = LessThan(8);
        lt[42][i].in[0] <== 47;
        lt[42][i].in[1] <== in[i];
        lt[43][i] = LessThan(8);
        lt[43][i].in[0] <== in[i];
        lt[43][i].in[1] <== 58;
        and[76][i] = AND();
        and[76][i].a <== lt[42][i].out;
        and[76][i].b <== lt[43][i].out;
        and[77][i] = AND();
        and[77][i].a <== states[i][33];
        and[77][i].b <== and[76][i].out;
        lt[44][i] = LessThan(8);
        lt[44][i].in[0] <== 47;
        lt[44][i].in[1] <== in[i];
        lt[45][i] = LessThan(8);
        lt[45][i].in[0] <== in[i];
        lt[45][i].in[1] <== 58;
        and[78][i] = AND();
        and[78][i].a <== lt[44][i].out;
        and[78][i].b <== lt[45][i].out;
        and[79][i] = AND();
        and[79][i].a <== states[i][37];
        and[79][i].b <== and[78][i].out;
        multi_or[14][i] = MultiOR(2);
        multi_or[14][i].in[0] <== and[77][i].out;
        multi_or[14][i].in[1] <== and[79][i].out;
        states[i+1][37] <== multi_or[14][i].out;
        eq[106][i] = IsEqual();
        eq[106][i].in[0] <== in[i];
        eq[106][i].in[1] <== 116;
        and[80][i] = AND();
        and[80][i].a <== states[i][36];
        and[80][i].b <== eq[106][i].out;
        states[i+1][38] <== and[80][i].out;
        eq[107][i] = IsEqual();
        eq[107][i].in[0] <== in[i];
        eq[107][i].in[1] <== 46;
        and[81][i] = AND();
        and[81][i].a <== states[i][34];
        and[81][i].b <== eq[107][i].out;
        eq[108][i] = IsEqual();
        eq[108][i].in[0] <== in[i];
        eq[108][i].in[1] <== 46;
        and[82][i] = AND();
        and[82][i].a <== states[i][39];
        and[82][i].b <== eq[108][i].out;
        eq[109][i] = IsEqual();
        eq[109][i].in[0] <== in[i];
        eq[109][i].in[1] <== 46;
        and[83][i] = AND();
        and[83][i].a <== states[i][43];
        and[83][i].b <== eq[109][i].out;
        multi_or[15][i] = MultiOR(3);
        multi_or[15][i].in[0] <== and[81][i].out;
        multi_or[15][i].in[1] <== and[82][i].out;
        multi_or[15][i].in[2] <== and[83][i].out;
        states[i+1][39] <== multi_or[15][i].out;
        eq[110][i] = IsEqual();
        eq[110][i].in[0] <== in[i];
        eq[110][i].in[1] <== 58;
        and[84][i] = AND();
        and[84][i].a <== states[i][38];
        and[84][i].b <== eq[110][i].out;
        states[i+1][40] <== and[84][i].out;
        eq[111][i] = IsEqual();
        eq[111][i].in[0] <== in[i];
        eq[111][i].in[1] <== 83;
        eq[112][i] = IsEqual();
        eq[112][i].in[0] <== in[i];
        eq[112][i].in[1] <== 115;
        and[85][i] = AND();
        and[85][i].a <== states[i][40];
        multi_or[16][i] = MultiOR(2);
        multi_or[16][i].in[0] <== eq[111][i].out;
        multi_or[16][i].in[1] <== eq[112][i].out;
        and[85][i].b <== multi_or[16][i].out;
        states[i+1][41] <== and[85][i].out;
        eq[113][i] = IsEqual();
        eq[113][i].in[0] <== in[i];
        eq[113][i].in[1] <== 13;
        and[86][i] = AND();
        and[86][i].a <== states[i][37];
        and[86][i].b <== eq[113][i].out;
        eq[114][i] = IsEqual();
        eq[114][i].in[0] <== in[i];
        eq[114][i].in[1] <== 13;
        and[87][i] = AND();
        and[87][i].a <== states[i][43];
        and[87][i].b <== eq[114][i].out;
        multi_or[17][i] = MultiOR(2);
        multi_or[17][i].in[0] <== and[86][i].out;
        multi_or[17][i].in[1] <== and[87][i].out;
        states[i+1][42] <== multi_or[17][i].out;
        lt[46][i] = LessThan(8);
        lt[46][i].in[0] <== 64;
        lt[46][i].in[1] <== in[i];
        lt[47][i] = LessThan(8);
        lt[47][i].in[0] <== in[i];
        lt[47][i].in[1] <== 91;
        and[88][i] = AND();
        and[88][i].a <== lt[46][i].out;
        and[88][i].b <== lt[47][i].out;
        lt[48][i] = LessThan(8);
        lt[48][i].in[0] <== 96;
        lt[48][i].in[1] <== in[i];
        lt[49][i] = LessThan(8);
        lt[49][i].in[0] <== in[i];
        lt[49][i].in[1] <== 123;
        and[89][i] = AND();
        and[89][i].a <== lt[48][i].out;
        and[89][i].b <== lt[49][i].out;
        lt[50][i] = LessThan(8);
        lt[50][i].in[0] <== 47;
        lt[50][i].in[1] <== in[i];
        lt[51][i] = LessThan(8);
        lt[51][i].in[0] <== in[i];
        lt[51][i].in[1] <== 58;
        and[90][i] = AND();
        and[90][i].a <== lt[50][i].out;
        and[90][i].b <== lt[51][i].out;
        and[91][i] = AND();
        and[91][i].a <== states[i][39];
        multi_or[18][i] = MultiOR(3);
        multi_or[18][i].in[0] <== and[88][i].out;
        multi_or[18][i].in[1] <== and[89][i].out;
        multi_or[18][i].in[2] <== and[90][i].out;
        and[91][i].b <== multi_or[18][i].out;
        lt[52][i] = LessThan(8);
        lt[52][i].in[0] <== 64;
        lt[52][i].in[1] <== in[i];
        lt[53][i] = LessThan(8);
        lt[53][i].in[0] <== in[i];
        lt[53][i].in[1] <== 91;
        and[92][i] = AND();
        and[92][i].a <== lt[52][i].out;
        and[92][i].b <== lt[53][i].out;
        lt[54][i] = LessThan(8);
        lt[54][i].in[0] <== 96;
        lt[54][i].in[1] <== in[i];
        lt[55][i] = LessThan(8);
        lt[55][i].in[0] <== in[i];
        lt[55][i].in[1] <== 123;
        and[93][i] = AND();
        and[93][i].a <== lt[54][i].out;
        and[93][i].b <== lt[55][i].out;
        lt[56][i] = LessThan(8);
        lt[56][i].in[0] <== 47;
        lt[56][i].in[1] <== in[i];
        lt[57][i] = LessThan(8);
        lt[57][i].in[0] <== in[i];
        lt[57][i].in[1] <== 58;
        and[94][i] = AND();
        and[94][i].a <== lt[56][i].out;
        and[94][i].b <== lt[57][i].out;
        and[95][i] = AND();
        and[95][i].a <== states[i][43];
        multi_or[19][i] = MultiOR(3);
        multi_or[19][i].in[0] <== and[92][i].out;
        multi_or[19][i].in[1] <== and[93][i].out;
        multi_or[19][i].in[2] <== and[94][i].out;
        and[95][i].b <== multi_or[19][i].out;
        multi_or[20][i] = MultiOR(2);
        multi_or[20][i].in[0] <== and[91][i].out;
        multi_or[20][i].in[1] <== and[95][i].out;
        states[i+1][43] <== multi_or[20][i].out;
        eq[115][i] = IsEqual();
        eq[115][i].in[0] <== in[i];
        eq[115][i].in[1] <== 101;
        and[96][i] = AND();
        and[96][i].a <== states[i][41];
        and[96][i].b <== eq[115][i].out;
        states[i+1][44] <== and[96][i].out;
        eq[116][i] = IsEqual();
        eq[116][i].in[0] <== in[i];
        eq[116][i].in[1] <== 110;
        and[97][i] = AND();
        and[97][i].a <== states[i][44];
        and[97][i].b <== eq[116][i].out;
        states[i+1][45] <== and[97][i].out;
        eq[117][i] = IsEqual();
        eq[117][i].in[0] <== in[i];
        eq[117][i].in[1] <== 10;
        and[98][i] = AND();
        and[98][i].a <== states[i][42];
        and[98][i].b <== eq[117][i].out;
        states[i+1][46] <== and[98][i].out;
        eq[118][i] = IsEqual();
        eq[118][i].in[0] <== in[i];
        eq[118][i].in[1] <== 100;
        and[99][i] = AND();
        and[99][i].a <== states[i][45];
        and[99][i].b <== eq[118][i].out;
        states[i+1][47] <== and[99][i].out;
        eq[119][i] = IsEqual();
        eq[119][i].in[0] <== in[i];
        eq[119][i].in[1] <== 32;
        and[100][i] = AND();
        and[100][i].a <== states[i][47];
        and[100][i].b <== eq[119][i].out;
        states[i+1][48] <== and[100][i].out;
        eq[120][i] = IsEqual();
        eq[120][i].in[0] <== in[i];
        eq[120][i].in[1] <== 36;
        and[101][i] = AND();
        and[101][i].a <== states[i][48];
        and[101][i].b <== eq[120][i].out;
        states[i+1][49] <== and[101][i].out;
    }

    signal final_state_sum[num_bytes+1];
    final_state_sum[0] <== states[0][46];
    for (var i = 1; i <= num_bytes; i++) {
        final_state_sum[i] <== final_state_sum[i-1] + states[i][46];
    }
    out <== final_state_sum[num_bytes];

    signal output reveal_amount[msg_bytes];
    for (var i = 0; i < msg_bytes; i++) {
        reveal_amount[i] <== in[i+1] * (states[i+2][1] + states[i+2][3] + states[i+2][10]);
    }

    signal output reveal_currency[msg_bytes];
    for (var i = 0; i < msg_bytes; i++) {
        reveal_currency[i] <== in[i+1] * (states[i+2][14] + states[i+2][4] + states[i+2][12] + states[i+2][18] + states[i+2][5] + states[i+2][13] + states[i+2][6] + states[i+2][14] + states[i+2][19] + states[i+2][8] + states[i+2][16] + states[i+2][9] + states[i+2][17] + states[i+2][20] + states[i+2][18]);
    }

    signal output reveal_recipient[msg_bytes];
    for (var i = 0; i < msg_bytes; i++) {
        reveal_recipient[i] <== in[i+1] * (states[i+2][27] + states[i+2][33] + states[i+2][37] + states[i+2][38] + states[i+2][25] + states[i+2][30] + states[i+2][34] + states[i+2][39] + states[i+2][43]);
    }
}
