package telem;

import java.io.InputStream;

public class FileInfo {
    public static final int GRAY8 = 0;
    public static final int GRAY16_SIGNED = 1;
    public static final int GRAY16_UNSIGNED = 2;
    public static final int GRAY32_INT = 3;
    public static final int GRAY32_FLOAT = 4;
    public static final int COLOR8 = 5;
    public static final int RGB = 6;
    public static final int RGB_PLANAR = 7;
    public static final int UNKNOWN = 0;
    public static final int RAW = 1;
    public static final int TIFF = 2;
    public static final int GIF_OR_JPG = 3;
    public static final int FITS = 4;
    public int fileFormat = 0;
    public int fileType = 0;
    public String fileName = "Untitled";
    public String directory = "";
    public String url = "";
    public int width;
    public int height;
    public int offset = 0;
    public int nImages = 1;
    public int gapBetweenImages;
    public boolean whiteIsZero;
    public boolean intelByteOrder;
    public int lutSize;
    public byte[] reds;
    public byte[] greens;
    public byte[] blues;
    public Object pixels;
    public String info;
    InputStream inputStream;
    public double pixelWidth = 1.0;
    public double pixelHeight = 1.0;
    public double pixelDepth = 1.0;
    public String unit;
    public int calibrationFunction;
    public double[] coefficients;
    public String valueUnit;

    public int getBytesPerPixel() {
        switch (this.fileType) {
            case 0: 
            case 5: {
                return 1;
            }
            case 1: 
            case 2: {
                return 2;
            }
            case 3: 
            case 4: {
                return 4;
            }
            case 6: 
            case 7: {
                return 3;
            }
        }
        return 0;
    }

    public String toString() {
        return "name=" + this.fileName + ", dir=" + this.directory + ", url=" + this.url + ", width=" + this.width + ", height=" + this.height + ", nImages=" + this.nImages + ", type=" + this.fileType + ", offset=" + this.offset + ", whiteZero=" + (this.whiteIsZero ? "t" : "f") + ", Intel=" + (this.intelByteOrder ? "t" : "f") + ", lutSize=" + this.lutSize;
    }
}