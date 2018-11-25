From: Michael =?ISO-8859-1?Q?La=DF?= <bevan@bi-co.net>
Subject: fsck: reset i_gc_failures from 0x1 to 0x00
Date: Mon, 26 Nov 2018 00:09:57 +0100
Message-ID: <2dbe74e040f9061f298c45016aa37881ea6f879d.camel@bi-co.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bevan@bi-co.net>) id 1gR3nc-00089t-1H
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 25 Nov 2018 23:26:48 +0000
Received: from voltaic.bi-co.net ([134.119.3.22])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gR3nZ-00Etd4-VX
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 25 Nov 2018 23:26:47 +0000
Received: from bevan-thinkpad (aftr-95-222-30-39.unity-media.net
 [95.222.30.39])
 by voltaic.bi-co.net (Postfix) with ESMTPSA id 8E9BC20888
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Nov 2018 00:09:57 +0100 (CET)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi,

after updating to f2fs-tools 1.12.0, a routine fsck of my file systems
took quite a while and output ten-thousands instances of the following
line:

> [FIX] (fsck_chk_inode_blk: 954)  --> Regular: 0xXYZ reset i_gc_failures from 0x1 to 0x00

where XYZ varied from line to line. I assume this is related to
91bb7b21f740d61cde2bb27da3dccb0afdd5a15b but I'm not sure about the
implications. Is this something to worry about or some deliberate
change of the on-disk format which was now braught up to date by fsck?

Best regards,
Michael
