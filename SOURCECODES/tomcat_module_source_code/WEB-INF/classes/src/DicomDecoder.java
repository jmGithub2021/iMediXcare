package telem;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.channels.FileChannel;
import java.util.Properties;
import telem.DicomDictionary;
import telem.FileInfo;
import telem.Tools;
import telem.createbmp;

public class DicomDecoder {
    private static final int PIXEL_REPRESENTATION = 2621699;
    private static final int TRANSFER_SYNTAX_UID = 131088;
    private static final int SLICE_SPACING = 0x180088;
    private static final int NUMBER_OF_FRAMES = 0x280008;
    private static final int ROWS = 2621456;
    private static final int COLUMNS = 2621457;
    private static final int PIXEL_SPACING = 2621488;
    private static final int BITS_ALLOCATED = 2621696;
    private static final int RED_PALETTE = 2626049;
    private static final int GREEN_PALETTE = 2626050;
    private static final int BLUE_PALETTE = 2626051;
    private static final int PIXEL_DATA = 2145386512;
    private static final int AE = 16709;
    private static final int AS = 16723;
    private static final int AT = 16724;
    private static final int CS = 17235;
    private static final int DA = 17473;
    private static final int DS = 17491;
    private static final int DT = 17492;
    private static final int FD = 17988;
    private static final int FL = 17996;
    private static final int IS = 18771;
    private static final int LO = 19535;
    private static final int LT = 19540;
    private static final int PN = 20558;
    private static final int SH = 21320;
    private static final int SL = 21324;
    private static final int SS = 21331;
    private static final int ST = 21332;
    private static final int TM = 21581;
    private static final int UI = 21833;
    private static final int UL = 21836;
    private static final int US = 21843;
    private static final int UT = 21844;
    private static final int OB = 20290;
    private static final int OW = 20311;
    private static final int SQ = 21329;
    private static final int UN = 21838;
    private static final int QQ = 16191;
    private static Properties dictionary;
    private String directory;
    private String fileName;
    private static final int ID_OFFSET = 128;
    private static final String DICM = "DICM";
    private BufferedInputStream f;
    private int location = 0;
    private boolean littleEndian = true;
    private int elementLength;
    private int vr;
    private static final int IMPLICIT_VR = 11565;
    private byte[] vrLetters = new byte[2];
    private int previousGroup;
    private StringBuffer dicomInfo = new StringBuffer(1000);
    private boolean prefixFound;
    RandomAccessFile dhead;
    String str = "";
    int bitsAllocated = 16;
    int bitStored;
    int windowWidth;
    int windowCenter;
    int samplePerPixel;
    int ht;
    int wd;
    int[][] arr;
    int[][] arr1;
    int[] pix;
    boolean compress = false;
    byte[] buf = new byte[4];
    byte[] ab = new byte[1];
    static char[] buf8;
    char[] buf10;

    public DicomDecoder(String string, String string2) {
        DicomDictionary dicomDictionary;
        this.directory = string;
        this.fileName = string2;
        if (dictionary == null) {
            dicomDictionary = new DicomDictionary();
            dictionary = dicomDictionary.getDictionary();
        }
        dicomDictionary = null;
        try {
            this.dhead = new RandomAccessFile(string + "DicomHeader.txt", "rw");
            FileInfo fileInfo = this.getFileInfo();
            byte[] arrby = this.str.getBytes();
            this.dhead.write(arrby);
            this.dhead.close();
            if (this.compress) {
                this.makjpg();
            } else {
                this.makbmp();
            }
        }
        catch (IOException iOException) {
            String string3 = iOException.getMessage();
            System.out.println("msg :" + string3);
        }
    }

    public void makjpg() {
        try {
            this.f.close();
            FileChannel fileChannel = new FileInputStream(this.directory + this.fileName).getChannel();
            FileChannel fileChannel2 = new FileOutputStream(this.directory + this.fileName.substring(0, this.fileName.lastIndexOf(".")) + ".jpg").getChannel();
            long l = fileChannel.size();
            System.out.println("Size : " + l);
            l -= 626L;
            fileChannel.transferTo(this.location - 4, fileChannel.size(), fileChannel2);
            fileChannel.close();
            fileChannel2.close();
        }
        catch (Exception exception) {
            System.out.println("Error in updating Movie file : " + exception);
        }
    }

    public void makbmp() {
        boolean bl = false;
        boolean bl2 = false;
        boolean bl3 = false;
        this.arr = new int[this.ht][this.wd];
        this.arr1 = new int[this.ht][this.wd];
        this.pix = new int[this.ht * this.wd];
        try {
            int n;
            int n2;
            int n3;
            int n4;
            int n5 = 0;
            for (int i = 0; i < this.ht; ++i) {
                for (n4 = 0; n4 < this.wd; ++n4) {
                    int n6;
                    int n7;
                    int n8;
                    if (this.bitsAllocated == 8 && this.samplePerPixel == 1) {
                        this.f.read(this.ab, 0, 1);
                        this.arr[i][n4] = 0xFF000000 | (this.ab[0] & 0xFF) << 16 | (this.ab[0] & 0xFF) << 8 | this.ab[0] & 0xFF;
                        this.pix[n5] = this.arr[i][n4];
                        ++n5;
                    } else if (this.bitsAllocated == 8 && this.samplePerPixel == 2) {
                        this.f.read(this.buf, 0, 2);
                        n8 = this.buf[0];
                        n7 = this.buf[1];
                        n8 = n8 * 11 / 100;
                        n7 = n7 * 59 / 100;
                        this.pix[n5] = n6 = n8 + n7;
                        ++n5;
                    } else if (this.bitsAllocated == 8 && this.samplePerPixel == 3) {
                        this.f.read(this.buf, 0, 3);
                        n8 = this.buf[0];
                        n7 = this.buf[1];
                        int n9 = this.buf[2];
                        n8 = n8 * 11 / 100;
                        n7 = n7 * 59 / 100;
                        n9 = n9 * 30 / 100;
                        this.pix[n5] = n6 = n8 + n7 + n9;
                        ++n5;
                    }
                    if (this.bitsAllocated == 16) {
                        this.f.read(this.buf, 0, 2);
                        this.arr[i][n4] = n3 = (int)((short)((0xFF & this.buf[1]) << 8 | 0xFF & this.buf[0]));
                    }
                    if (this.bitsAllocated != 24) continue;
                    this.f.read(this.buf, 0, 3);
                    this.arr[i][n4] = 0xFF000000 | (this.buf[2] & 0xFF) << 16 | (this.buf[1] & 0xFF) << 8 | this.buf[0] & 0xFF;
                }
            }
            n4 = 0;
            n3 = 0;
            if (this.bitsAllocated == 16) {
                n4 = this.arr[0][0];
                n3 = this.arr[0][0];
                for (n2 = 0; n2 < this.ht; ++n2) {
                    for (n = 0; n < this.wd; ++n) {
                        if (n4 > this.arr[n2][n]) {
                            n4 = this.arr[n2][n];
                        }
                        if (n3 >= this.arr[n2][n]) continue;
                        n3 = this.arr[n2][n];
                    }
                }
                if (this.windowWidth < 100) {
                    n3 = this.windowWidth + 300;
                    n4 = 10;
                }
                if (this.bitStored == 12) {
                    for (n2 = 0; n2 < this.ht; ++n2) {
                        for (n = 0; n < this.wd; ++n) {
                            if (this.arr[n2][n] <= this.windowWidth) continue;
                            this.arr[n2][n] = this.windowWidth;
                        }
                    }
                    n3 = this.windowWidth;
                }
                System.out.println("min:" + n4);
                System.out.println("max:" + n3);
                System.out.println("after scaling");
                if (n3 > 255 | n4 < 0 && n3 != n4) {
                    for (n2 = 0; n2 < this.ht; ++n2) {
                        for (n = 0; n < this.wd; ++n) {
                            this.arr[n2][n] = 255 * (this.arr[n2][n] - n4) / (n3 - n4);
                            this.arr[n2][n] = 0xFF000000 | (this.arr[n2][n] & 0xFF) << 16 | (this.arr[n2][n] & 0xFF) << 8 | this.arr[n2][n] & 0xFF;
                            this.pix[n5] = this.arr[n2][n];
                            ++n5;
                        }
                    }
                }
            }
            if (this.bitsAllocated == 24) {
                int n10;
                n2 = 0;
                n = this.ht - 1;
                while (n >= 0) {
                    for (n10 = 0; n10 < this.wd; ++n10) {
                        this.arr1[n2][n10] = this.arr[n][n10];
                    }
                    --n;
                    ++n2;
                }
                for (n = 0; n < this.ht; ++n) {
                    for (n10 = 0; n10 < this.wd; ++n10) {
                        this.pix[n5] = this.arr1[n][n10];
                        ++n5;
                    }
                }
            }
            this.f.close();
            createbmp createbmp2 = new createbmp();
            createbmp2.saveBitmap(this.directory + this.fileName.substring(0, this.fileName.lastIndexOf(".")) + ".bmp", this.pix, this.wd, this.ht);
            System.out.println("pix is :" + this.pix.length);
        }
        catch (IOException iOException) {
            System.out.println("error in reading file" + iOException.toString());
        }
    }

    String getString(int n) throws IOException {
        int n2;
        byte[] arrby = new byte[n];
        for (int i = 0; i < n; i += n2) {
            n2 = this.f.read(arrby, i, n - i);
        }
        this.location += n;
        return new String(arrby);
    }

    int getByte() throws IOException {
        int n = this.f.read();
        if (n == -1) {
            throw new IOException("unexpected EOF");
        }
        ++this.location;
        return n;
    }

    int getShort() throws IOException {
        int n = this.getByte();
        int n2 = this.getByte();
        if (this.littleEndian) {
            return (n2 << 8) + n;
        }
        return (n << 8) + n2;
    }

    final int getInt() throws IOException {
        int n = this.getByte();
        int n2 = this.getByte();
        int n3 = this.getByte();
        int n4 = this.getByte();
        if (this.littleEndian) {
            return (n4 << 24) + (n3 << 16) + (n2 << 8) + n;
        }
        return (n << 24) + (n2 << 16) + (n3 << 8) + n4;
    }

    byte[] getLut(int n) throws IOException {
        if ((n & 1) != 0) {
            String string = this.getString(n);
            return null;
        }
        byte[] arrby = new byte[n /= 2];
        for (int i = 0; i < n; ++i) {
            arrby[i] = (byte)(this.getShort() >>> 8);
        }
        return arrby;
    }

    int getLength() throws IOException {
        int n = this.getByte();
        int n2 = this.getByte();
        int n3 = this.getByte();
        int n4 = this.getByte();
        this.vr = (n << 8) + n2;
        String string = this.i2hex(this.vr);
        switch (this.vr) {
            case 20290: 
            case 20311: 
            case 21329: 
            case 21838: {
                if (n3 == 0 || n4 == 0) {
                    return this.getInt();
                }
                this.vr = 11565;
                if (this.littleEndian) {
                    return (n4 << 24) + (n3 << 16) + (n2 << 8) + n;
                }
                return (n << 24) + (n2 << 16) + (n3 << 8) + n4;
            }
            case 16191: 
            case 16709: 
            case 16723: 
            case 16724: 
            case 17235: 
            case 17473: 
            case 17491: 
            case 17492: 
            case 17988: 
            case 17996: 
            case 18771: 
            case 19535: 
            case 19540: 
            case 20558: 
            case 21320: 
            case 21324: 
            case 21331: 
            case 21332: 
            case 21581: 
            case 21833: 
            case 21836: 
            case 21843: 
            case 21844: {
                if (this.littleEndian) {
                    return (n4 << 8) + n3;
                }
                return (n3 << 8) + n4;
            }
        }
        this.vr = 11565;
        if (this.littleEndian) {
            return (n4 << 24) + (n3 << 16) + (n2 << 8) + n;
        }
        return (n << 24) + (n2 << 16) + (n3 << 8) + n4;
    }

    int getNextTag() throws IOException {
        int n = this.getShort();
        String string = Integer.toHexString(n).toUpperCase();
        int n2 = this.getShort();
        String string2 = Integer.toHexString(n2).toUpperCase();
        int n3 = n << 16 | n2;
        this.elementLength = this.getLength();
        if (this.elementLength == 13) {
            this.elementLength = 10;
        }
        if (this.elementLength == -1) {
            this.elementLength = 0;
        }
        return n3;
    }

    FileInfo getFileInfo() throws IOException {
        FileInfo fileInfo;
        FileInfo fileInfo2 = fileInfo = new FileInfo();
        fileInfo.fileFormat = 1;
        fileInfo.fileName = this.fileName;
        fileInfo.directory = this.directory;
        fileInfo.width = 0;
        fileInfo.height = 0;
        fileInfo.offset = 0;
        fileInfo.intelByteOrder = true;
        fileInfo.fileType = 2;
        this.f = new BufferedInputStream(new FileInputStream(this.directory + this.fileName));
        for (long i = 128L; i > 0L; i -= this.f.skip(i)) {
        }
        this.location += 128;
        if (!this.getString(4).equals(DICM)) {
            this.f.close();
            this.f = new BufferedInputStream(new FileInputStream(this.directory + this.fileName));
            this.location = 0;
        }
        boolean bl = true;
        while (true) {
            int n = this.getNextTag();
            if ((this.location & 1) != 0) break;
            if (n == 131088) {
                String string = this.getString(this.elementLength);
                this.addInfo(n, string);
                if (string.indexOf("1.2.4") <= -1 && string.indexOf("1.2.5") <= -1) continue;
                this.compress = true;
                continue;
            }
            if (n == 0x280002) {
                this.samplePerPixel = this.getShort();
                continue;
            }
            if (n == 0x280008) {
                String string = this.getString(this.elementLength);
                this.addInfo(n, string);
                double d = this.s2d(string);
                if (!(d > 1.0)) continue;
                fileInfo.nImages = (int)d;
                continue;
            }
            if (n == 2621456) {
                fileInfo.height = this.ht = this.getShort();
                this.addInfo(n, Integer.toString(fileInfo.height));
                continue;
            }
            if (n == 2621457) {
                fileInfo.width = this.wd = this.getShort();
                this.addInfo(n, Integer.toString(fileInfo.width));
                continue;
            }
            if (n == 2621488) {
                String string = this.getString(this.elementLength);
                this.getSpatialScale(fileInfo, string);
                this.addInfo(n, string);
                continue;
            }
            if (n == 0x180088) {
                String string = this.getString(this.elementLength);
                fileInfo.pixelDepth = this.s2d(string);
                this.addInfo(n, string);
                continue;
            }
            if (n == 2621696) {
                this.bitsAllocated = this.getShort();
                if (this.bitsAllocated == 8) {
                    fileInfo.fileType = 0;
                }
                this.addInfo(n, Integer.toString(this.bitsAllocated));
                continue;
            }
            if (n == 2621697) {
                this.bitStored = this.getShort();
                System.out.printf(" In bitStored : " + this.bitStored, new Object[0]);
                continue;
            }
            if (n == 2621699) {
                int n2 = this.getShort();
                if (n2 == 1) {
                    fileInfo.fileType = 1;
                }
                this.addInfo(n, Integer.toString(n2));
                continue;
            }
            if (n == 2625616) {
                this.windowCenter = Integer.parseInt(this.getString(this.elementLength).trim());
                System.out.printf(" In windowCenter : " + this.windowCenter, new Object[0]);
                continue;
            }
            if (n == 2625617) {
                this.windowWidth = Integer.parseInt(this.getString(this.elementLength).trim());
                System.out.printf(" In WindowWidth : " + this.windowWidth, new Object[0]);
                continue;
            }
            if (n == 2626049) {
                fileInfo.reds = this.getLut(this.elementLength);
                this.addInfo(n, Integer.toString(this.elementLength / 2));
                continue;
            }
            if (n == 2626050) {
                fileInfo.greens = this.getLut(this.elementLength);
                this.addInfo(n, Integer.toString(this.elementLength / 2));
                continue;
            }
            if (n == 2626051) {
                fileInfo.blues = this.getLut(this.elementLength);
                this.addInfo(n, Integer.toString(this.elementLength / 2));
                continue;
            }
            if (n == 2145386512 && this.elementLength != 0) {
                fileInfo.offset = this.location;
                System.out.println("location :" + this.location);
                this.addInfo(n, Integer.toString(this.location));
                break;
            }
            if (n == 2139619344 && this.elementLength != 0) {
                System.out.println("dsadasdalocation :" + this.location);
                fileInfo.offset = this.location + 4;
                break;
            }
            this.addInfo(n, null);
        }
        if (fileInfo.fileType == 0) {
            System.out.println("working1..............");
            if (fileInfo.reds != null && fileInfo.greens != null && fileInfo.blues != null && fileInfo.reds.length == fileInfo.greens.length && fileInfo.reds.length == fileInfo.blues.length) {
                fileInfo.fileType = 5;
                fileInfo.lutSize = fileInfo.reds.length;
                System.out.println("working2..............");
            }
        }
        return fileInfo;
    }

    String getDicomInfo() {
        return new String(this.dicomInfo);
    }

    void addInfo(int n, String string) throws IOException {
        String string2 = this.getHeaderInfo(n, string);
        if (string2 != null && !string2.equals("null")) {
            this.str = this.str + string2.trim() + "\n";
        }
        if (string2 != null) {
            int n2 = n >>> 16;
            if (n2 != this.previousGroup) {
                this.dicomInfo.append("\n");
            }
            this.previousGroup = n2;
            this.dicomInfo.append(this.tag2hex(n) + string2 + "\n");
        }
    }

    String getHeaderInfo(int n, String string) throws IOException {
        String string2 = this.i2hex(n);
        String string3 = (String)dictionary.get(string2);
        if (string3 != null) {
            if (this.vr == 11565 && string3 != null) {
                this.vr = (string3.charAt(0) << 8) + string3.charAt(1);
            }
            string3 = string3.substring(2);
        }
        if (string != null) {
            return string3 + ": " + string;
        }
        switch (this.vr) {
            case 16709: 
            case 16723: 
            case 16724: 
            case 17235: 
            case 17473: 
            case 17491: 
            case 17492: 
            case 18771: 
            case 19535: 
            case 19540: 
            case 20558: 
            case 21320: 
            case 21332: 
            case 21581: 
            case 21833: {
                string = this.getString(this.elementLength);
                break;
            }
            case 21843: {
                if (this.elementLength == 2) {
                    string = Integer.toString(this.getShort());
                    break;
                }
                string = "";
                int n2 = this.elementLength / 2;
                for (int i = 0; i < n2; ++i) {
                    string = string + Integer.toString(this.getShort()) + " ";
                }
                break;
            }
            default: {
                for (long i = (long)this.elementLength; i > 0L; i -= this.f.skip(i)) {
                }
                this.location += this.elementLength;
                string = "";
            }
        }
        if (string3 == null) {
            return null;
        }
        return string3 + ": " + string;
    }

    String i2hex(int n) {
        for (int i = 7; i >= 0; --i) {
            DicomDecoder.buf8[i] = Tools.hexDigits[n & 0xF];
            n >>>= 4;
        }
        return new String(buf8);
    }

    String tag2hex(int n) {
        if (this.buf10 == null) {
            this.buf10 = new char[11];
            this.buf10[4] = 44;
            this.buf10[9] = 32;
        }
        int n2 = 8;
        while (n2 >= 0) {
            this.buf10[n2] = Tools.hexDigits[n & 0xF];
            n >>>= 4;
            if (--n2 != 4) continue;
            --n2;
        }
        return new String(this.buf10);
    }

    double s2d(String string) {
        Double d;
        try {
            d = new Double(string);
        }
        catch (NumberFormatException numberFormatException) {
            d = null;
        }
        if (d != null) {
            return d;
        }
        return 0.0;
    }

    void getSpatialScale(FileInfo fileInfo, String string) {
        double d = 0.0;
        double d2 = 0.0;
        int n = string.indexOf(92);
        if (n > 0) {
            d = this.s2d(string.substring(0, n));
            d2 = this.s2d(string.substring(n + 1));
        }
        if (d != 0.0 && d2 != 0.0) {
            fileInfo.pixelWidth = d;
            fileInfo.pixelHeight = d2;
            fileInfo.unit = "mm";
        }
    }

    boolean prefixFound() {
        return this.prefixFound;
    }

   /* public static void main(String[] arrstring) {
        DicomDecoder dicomDecoder = new DicomDecoder("/usr/java/javafiles/bmpimages/teledicom/", "nod2712200500114022006dcm0008.dcm");
    }*/

    static {
        buf8 = new char[8];
    }
}