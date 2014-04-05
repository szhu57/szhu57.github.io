---
layout: post
title: "A basic TCP program using HOPP pattern"
author: Weiwei
tags:
  - tcp
  - socket
  - java
---
> Problem: Sometimes objects must appear in more than one computing context (that is, address space.) How can we make difference one and multiple address spaces (for example, single versus distributed processing) transparent? This post will introduced a FTP program which using the design pattern named HOPP (Half Object Plus Protocol).    

<!--more-->
####soluction:
Divide the object into two interdependent half-objects, one in each address space, with a protocol between them. In each address space, implement whatever functonality is required to interact efficiently with the other obejcts in that adderss space. This may result in duplicated functionality.    

The HOPP pattern deals with the placement and replication of objects in a distributed computing environment.    

####An TFP example using HOPP: 
Client:
    
    public class FileTransferClientUI {
    
      protected BufferedReader console;
      protected FileTransferClientHOPP clientHOPP;
    
      public static void main(String[] args) {
    
        if (args.length != 1) {
          System.err.println("Usage: Client address");
          System.exit(1);
        }
        FileTransferClientUI ui = new FileTransferClientUI(args[0]);
        ui.loop();
      }
    
      public FileTransferClientUI(String server) {
    
        clientHOPP = null;
        try {
          clientHOPP = new FileTransferClientHOPP(server);
        } catch (Exception e) {
          e.printStackTrace();
          System.exit(1);
        }
    
        console = new BufferedReader(new InputStreamReader(System.in));
      }
    
      public void loop() {
        while (true) {
          String line = null;
          try {
            System.out.print("Entre Request (" + FileTransferTextConstants.DIR
                + " | " + FileTransferTextConstants.CD + " | "
                + FileTransferTextConstants.GETDIR + " | "
                + FileTransferTextConstants.QUIT + "): ");
            line = console.readLine();
          } catch (IOException e) {
            clientHOPP.quit();
            e.printStackTrace();
            System.exit(1);
          }
    
          if (line.equalsIgnoreCase(FileTransferTextConstants.DIR)) {
            dir();
          } else if (line.toUpperCase().startsWith(FileTransferTextConstants.CD)) {
            chdir(losePrefix(line, FileTransferTextConstants.CD));
          } else if (line.toUpperCase()
              .startsWith(FileTransferTextConstants.GETDIR)) {
            getdir();
          } else if (line.equalsIgnoreCase(FileTransferTextConstants.QUIT)) {
            clientHOPP.quit();
            System.exit(0);
          } else {
            System.out.println("Unrecognised command");
          }
        }
      }
    
      /**
       * Given that the string starts with the prefix, get rid of the prefix and any
       * whitespace
       */
      public String losePrefix(String str, String prefix) {
        int index = prefix.length();
        String ret = str.substring(index).trim();
        return ret;
      }
    
      protected void dir() {
        String[] dirList = clientHOPP.dir();
        if (dirList.length == 0) {
          System.out.println("No dir list available");
        } else {
          System.out.println("Dir listing is:");
          for (int n = 0; n < dirList.length; n++) {
            System.out.println(dirList[n]);
          }
        }
      }
    
      public void chdir(String dir) {
        if (clientHOPP.chdir(dir)) {
          System.out.println("Chdir okay");
        } else {
          System.out.println("Chdir failed");
        }
      }
    
      public void getdir() {
        String dirName = clientHOPP.getdir();
        System.out.println(dirName);
      }
    } // FileTransferClientUI


Client HOPP:
    
    public class FileTransferClientHOPP {

        protected Socket mySocket;
        protected BufferedReader reader;
        protected PrintStream writer;
    
        public FileTransferClientHOPP(String server) throws UnknownHostException,
          IOException {
    
        InetAddress address = InetAddress.getByName(server);
        mySocket = null;
        InputStream inStream = null;
        OutputStream outStream = null;
    
        mySocket = new Socket(address, FileTransferTextConstants.PORT);
        inStream = mySocket.getInputStream();
        outStream = mySocket.getOutputStream();
    
        reader = new BufferedReader(new InputStreamReader(inStream));
        writer = new PrintStream(outStream);
        }
    
        public void quit() {
            //ignore
          }
    
        public String[] dir() {
            // stub
            writer.print(FileTransferTextConstants.DIR
                + FileTransferTextConstants.CR_LF);
            ArrayList<String> tempList = new ArrayList<String>();
            String line = null;
            while (true) {
              try {
                line = reader.readLine();
              } catch (IOException e) {
                break;
              }
              if (line.equals("")) {
                break;
              }
              tempList.add(line);
            }
            String[] dirList = new String[tempList.size()];
            tempList.toArray(dirList);
            return dirList;
        }
    
        public boolean chdir(String dir) {
            //ignore
        }
    
        public String getdir() {
            //ignore
        }
    }


Server HOPP:

    public class FileTransferServerHOPP {
      File clientDir = new File(".");
    
      public boolean chdir(String dir) {
        File newDir = new File(clientDir, dir);
        if (newDir.isDirectory()) {
          clientDir = newDir;
          return true;
        } else {
          return false;
        }
      }
    
      public String[] dir() {
        String[] fileNames = clientDir.list();
        return fileNames;
      }
    
      public String getdir() {
        try {
          return clientDir.getCanonicalPath();
        } catch (IOException e) {
          return e.getMessage();
        }
      }
    
    }

Server:

    public class FileTransferTextServer {
    
      public static void main(String argv[]) {
        ServerSocket s = null;
        try {
          s = new ServerSocket(FileTransferTextConstants.PORT);
        } catch (IOException e) {
          e.printStackTrace();
          System.exit(1);
        }
        System.out.println("HOPP File Server Running...");
        while (true) {
          Socket incoming = null;
          try {
            incoming = s.accept();
          } catch (IOException e) {
            System.out.println(e);
            continue;
          }
    
          new SocketHandler(incoming).start();
        }
      }
    }
    
    class SocketHandler extends Thread {
    
      Socket incoming;
      FileTransferServerHOPP fileServer = new FileTransferServerHOPP();
    
      BufferedReader reader;
      PrintStream writer;
    
      SocketHandler(Socket incoming) {
        this.incoming = incoming;
      }
    
      public void run() {
        try {
          writer = new PrintStream(incoming.getOutputStream());
          reader = new BufferedReader(new InputStreamReader(
              incoming.getInputStream()));
          while (true) {
            String line = reader.readLine();
            if (line == null) {
              break;
            }
            System.out.println("Received request: " + line);
    
            if (line.startsWith(FileTransferTextConstants.CD)) {
              changeDirRequest(losePrefix(line, FileTransferTextConstants.CD));
            } else if (line.startsWith(FileTransferTextConstants.DIR)) {
              directoryRequest();
            } else if (line.startsWith(FileTransferTextConstants.GETDIR)) {
              getDirectoryName();
            } else if (line.startsWith(FileTransferTextConstants.QUIT)) {
              break;
            } else {
              writer.print(FileTransferTextConstants.ERROR
                  + FileTransferTextConstants.CR_LF);
            }
    
          }
          incoming.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
    
      /**
       * Given that the string starts with the prefix, get rid of the prefix and any
       * following whitespace
       */
      public String losePrefix(String str, String prefix) {
        int index = prefix.length();
        String ret = str.substring(index).trim();
        return ret;
    
      }
    
      public void changeDirRequest(String dir) {
        if (fileServer.chdir(dir)) {
          writer.print(FileTransferTextConstants.SUCCEEDED + " "
              + fileServer.getdir() + FileTransferTextConstants.CR_LF);
        } else {
          writer.print(FileTransferTextConstants.ERROR
              + FileTransferTextConstants.CR_LF);
        }
      }
      
      //here all the unnecessary parts are ignored!
    }