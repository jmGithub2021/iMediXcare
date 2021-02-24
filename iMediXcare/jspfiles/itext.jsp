<%@page import = "java.io.*,com.itextpdf.text.Document,com.itextpdf.tool.xml.css.*,com.itextpdf.text.DocumentException,com.itextpdf.tool.xml.pipeline.html.LinkProvider,com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext,com.itextpdf.tool.xml.pipeline.html.HtmlPipeline,com.itextpdf.tool.xml.pipeline.html.AbstractImageProvider,com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline,com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline,com.itextpdf.tool.xml.pipeline.css.CSSResolver,com.itextpdf.tool.xml.parser.XMLParser,com.itextpdf.tool.xml.net.FileRetrieveImpl,com.itextpdf.tool.xml.net.FileRetrieve,com.itextpdf.tool.xml.html.Tags,com.itextpdf.text.pdf.PdfWriter,com.itextpdf.tool.xml.XMLWorker,com.itextpdf.tool.xml.XMLWorkerHelper" %>

<%
  /*  String HTML = request.getRealPath("/")+"/itxt.html";
    String DEST = request.getRealPath("/")+"/index1.pdf";
    String IMG_PATH = request.getRealPath("/");
    String RELATIVE_PATH = request.getRealPath("/");
    String CSS_DIR = request.getRealPath("/")+"/bootstrap/css/";
    */
    
       Document document = new Document();
        // step 2
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(request.getRealPath("/")+"/pdf.pdf"));
        // step 3
        document.open();
        document.newPage();
        // step 4
       /* ByteArrayInputStream bis =
    new ByteArrayInputStream(new FileInputStream(request.getRealPath("/")+"/itext.html").toString().getBytes()); */
        ByteArrayInputStream cis =
    new ByteArrayInputStream( new FileInputStream(request.getRealPath("/")+"/style.css").toString().getBytes());
//XMLWorkerHelper.getInstance().parseXHtml(writer, document, bis, cis);  
        XMLWorkerHelper.getInstance().parseXHtml(writer, document,
               new FileInputStream("http://10.5.29.88:8080/iMediX/jspfiles/ai0.jsp?id=SCHC0204180000&ty=ai0&dt=20180402204457") ,cis); 


/*                
// CSS
CSSResolver cssResolver = new StyleAttrCSSResolver();
CssFile cssFile = XMLWorkerHelper.getCSS(new ByteArrayInputStream(new FileInputStream(request.getRealPath("/")+"/style.css").getBytes()));
cssResolver.addCss(cssFile);

// HTML
HtmlPipelineContext htmlContext = new HtmlPipelineContext(null);
htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());

// Pipelines
PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);

// XML Worker
XMLWorker worker = new XMLWorker(css, true);
XMLParser p = new XMLParser(worker);
p.parse(new ByteArrayInputStream(new FileInputStream(request.getRealPath("/")+"/itext.html").toString().getBytes()));
    
   */             
        //step 5
         document.close();
 
       out.println( "PDF Created!" );
%>
