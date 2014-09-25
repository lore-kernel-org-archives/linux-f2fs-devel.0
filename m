From: joerg jungermann <jj@borkum.net>
Subject: possible endianes bug in mkfs.f2fs roll-forward speed
Date: Thu, 25 Sep 2014 18:05:51 +0200
Message-ID: <20140925160551.GA30960@borkum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <abra@onno.borkum.net>) id 1XXBYP-0001jL-Bu
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Sep 2014 16:06:01 +0000
Received: from onno.borkum.net ([178.63.1.125])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XXBYM-00019B-UO
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Sep 2014 16:06:01 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi,

I might found a bug in mkfs.f2fs. while experimenting with f2fs on my big
endian MIPS32 device (platform lantiq, 14.07-rc3, uclibc).

I ran into an issue that mkfs.f2fs, was not able to format block devices if i did not
specify the sector count manually.

I hunted it down to lib/libf2fs.c.
After I found that the detected sector count equals to the wanted sector count shifted left (32+9) times.

I found two issues:
Firstly it uses ioctl BLKGETSIZE, which writes to an uint32_t the size of the device.
As c->total_sectors is of type uint64_t, the value is written in to the first 4 bytes.
That explained the left shift of 32 bits.

Secondly BLKGETSIZE determines the size of the device in bytes (AFAIK, learned by observation).
In the first branch of the if-block patched below, the c->total_sectors is calculated by
  c->total_sectors = stat_buf.st_size / c->sector_size;
The else branch omits the devision. sector_sice is mostly 512, that explained the left shift by 9 bytes.

I prepared patch against 1.4.0, not HEAD, sorry.
 * fixes sector count calculation
 * uses BLKGETSIZE64 if avail

best regards


--- lib/libf2fs.c.orig  2014-09-25 17:41:56.433763287 +0200
+++ lib/libf2fs.c       2014-09-25 17:45:04.944604490 +0200
@@ -453,11 +453,21 @@
                                c->sectors_per_blk = PAGE_SIZE / sector_size;
                        }
                }
-
-               if (ioctl(fd, BLKGETSIZE, &c->total_sectors) < 0) {
+#ifdef BLKGETSIZE64
+               if (ioctl(fd, BLKGETSIZE64, &c->total_sectors) < 0) {
+                       MSG(0, "\tError: Cannot get the device size\n");
+                       return -1;
+               }
+    c->total_sectors /= c->sector_size;
+#else
+         uint32_t total_sectors;
+               if (ioctl(fd, BLKGETSIZE, &total_sectors) < 0) {
                        MSG(0, "\tError: Cannot get the device size\n");
                        return -1;
                }
+    total_sectors /= c->sector_size;
+    c->total_sectors = total_sectors;
+#endif
 
                if (ioctl(fd, HDIO_GETGEO, &geom) < 0)
                        c->start_sector = 0;


-- 
Joerg Jungermann

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
