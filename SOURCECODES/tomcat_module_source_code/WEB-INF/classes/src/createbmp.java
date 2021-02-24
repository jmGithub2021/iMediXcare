package telem;

import java.awt.Component;
import java.io.FileOutputStream;

public class createbmp
extends Component {
    private static final int BITMAPFILEHEADER_SIZE = 14;
    private static final int BITMAPINFOHEADER_SIZE = 40;
    private byte[] bitmapFileHeader;
    private byte[] bfType = new byte[]{66, 77};
    private int bfSize = 0;
    private int bfReserved1 = 0;
    private int bfReserved2 = 0;
    private int bfOffBits = 54;
    private byte[] bitmapInfoHeader;
    private int biSize = 40;
    private int biWidth = 0;
    private int biHeight = 0;
    private int biPlanes = 1;
    private int biBitCount = 24;
    private int biCompression = 0;
    private int biSizeImage = 196608;
    private int biXPelsPerMeter = 0;
    private int biYPelsPerMeter = 0;
    private int biClrUsed = 0;
    private int biClrImportant = 0;
    private int[] bitmap;
    private FileOutputStream fo;

    public createbmp() {
        this.bitmapFileHeader = new byte[14];
        this.bitmapInfoHeader = new byte[40];
    }

    public void saveBitmap(String string, int[] arrn, int n, int n2) {
        try {
            this.fo = new FileOutputStream(string);
            this.save(arrn, n, n2);
            this.fo.flush();
            this.fo.close();
        }
        catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    private void save(int[] arrn, int n, int n2) {
        try {
            this.convertImage(arrn, n, n2);
            this.writeBitmapFileHeader();
            this.writeBitmapInfoHeader();
            this.writeBitmap();
        }
        catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    private boolean convertImage(int[] arrn, int n, int n2) {
        this.bitmap = new int[n * n2];
        this.bitmap = arrn;
        int n3 = (4 - n * 3 % 4) * n2;
        this.biSizeImage = n * n2 * 3 + n3;
        this.bfSize = this.biSizeImage + 14 + 40;
        this.biWidth = n;
        this.biHeight = n2;
        return true;
    }

    private void writeBitmap() {
        int n;
        byte[] arrby = new byte[3];
        int n2 = this.biWidth * this.biHeight;
        int n3 = 4 - this.biWidth * 3 % 4;
        if (n3 == 4) {
            n3 = 0;
        }
        int n4 = 1;
        int n5 = 0;
        int n6 = n = n2 - this.biWidth;
        try {
            for (int i = 0; i < n2; ++i) {
                int n7 = this.bitmap[n];
                arrby[0] = (byte)(n7 & 0xFF);
                arrby[1] = (byte)(n7 >> 8 & 0xFF);
                arrby[2] = (byte)(n7 >> 16 & 0xFF);
                this.fo.write(arrby);
                if (n4 == this.biWidth) {
                    n5 += n3;
                    for (int j = 1; j <= n3; ++j) {
                        this.fo.write(0);
                    }
                    n4 = 1;
                    n6 = n = n6 - this.biWidth;
                } else {
                    ++n4;
                }
                ++n;
            }
            this.bfSize += n5 - n3;
            this.biSizeImage += n5 - n3;
        }
        catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    private void writeBitmapFileHeader() {
        try {
            this.fo.write(this.bfType);
            this.fo.write(this.intToDWord(this.bfSize));
            this.fo.write(this.intToWord(this.bfReserved1));
            this.fo.write(this.intToWord(this.bfReserved2));
            this.fo.write(this.intToDWord(this.bfOffBits));
        }
        catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    private void writeBitmapInfoHeader() {
        try {
            this.fo.write(this.intToDWord(this.biSize));
            this.fo.write(this.intToDWord(this.biWidth));
            this.fo.write(this.intToDWord(this.biHeight));
            this.fo.write(this.intToWord(this.biPlanes));
            this.fo.write(this.intToWord(this.biBitCount));
            this.fo.write(this.intToDWord(this.biCompression));
            this.fo.write(this.intToDWord(this.biSizeImage));
            this.fo.write(this.intToDWord(this.biXPelsPerMeter));
            this.fo.write(this.intToDWord(this.biYPelsPerMeter));
            this.fo.write(this.intToDWord(this.biClrUsed));
            this.fo.write(this.intToDWord(this.biClrImportant));
        }
        catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    private byte[] intToWord(int n) {
        byte[] arrby = new byte[]{(byte)(n & 0xFF), (byte)(n >> 8 & 0xFF)};
        return arrby;
    }

    private byte[] intToDWord(int n) {
        byte[] arrby = new byte[]{(byte)(n & 0xFF), (byte)(n >> 8 & 0xFF), (byte)(n >> 16 & 0xFF), (byte)(n >> 24 & 0xFF)};
        return arrby;
    }
}