package telem;

import java.awt.Color;

public class Tools {
    public static final char[] hexDigits = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

    public static String c2hex(Color color) {
        int n = color.getRGB();
        char[] arrc = new char[7];
        arrc[0] = 35;
        for (int i = 6; i >= 1; --i) {
            arrc[i] = hexDigits[n & 0xF];
            n >>>= 4;
        }
        return new String(arrc);
    }

    public static String f2hex(float f) {
        int n = Float.floatToIntBits(f);
        char[] arrc = new char[9];
        arrc[0] = 35;
        for (int i = 8; i >= 1; --i) {
            arrc[i] = hexDigits[n & 0xF];
            n >>>= 4;
        }
        return new String(arrc);
    }

    public static double[] getMinMax(double[] arrd) {
        double d = Double.MAX_VALUE;
        double d2 = -1.7976931348623157E308;
        for (int i = 0; i < arrd.length; ++i) {
            double d3 = arrd[i];
            if (d3 < d) {
                d = d3;
            }
            if (!(d3 > d2)) continue;
            d2 = d3;
        }
        double[] arrd2 = new double[]{d, d2};
        return arrd2;
    }

    public static double[] getMinMax(float[] arrf) {
        double d = Double.MAX_VALUE;
        double d2 = -1.7976931348623157E308;
        for (int i = 0; i < arrf.length; ++i) {
            double d3 = arrf[i];
            if (d3 < d) {
                d = d3;
            }
            if (!(d3 > d2)) continue;
            d2 = d3;
        }
        double[] arrd = new double[]{d, d2};
        return arrd;
    }

    public static double[] toDouble(float[] arrf) {
        int n = arrf.length;
        double[] arrd = new double[n];
        for (int i = 0; i < n; ++i) {
            arrd[i] = arrf[i];
        }
        return arrd;
    }

    public static float[] toFloat(double[] arrd) {
        int n = arrd.length;
        float[] arrf = new float[n];
        for (int i = 0; i < n; ++i) {
            arrf[i] = (float)arrd[i];
        }
        return arrf;
    }

    public static String fixNewLines(String string) {
        char[] arrc = string.toCharArray();
        for (int i = 0; i < arrc.length; ++i) {
            if (arrc[i] != '\r') continue;
            arrc[i] = 10;
        }
        return new String(arrc);
    }

    public static double parseDouble(String string) throws NumberFormatException {
        Double d = new Double(string);
        return d;
    }
}