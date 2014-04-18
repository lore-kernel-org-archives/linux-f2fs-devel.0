From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs: BUG_ON() is triggered when mount valid f2fs
	filesystem
Date: Fri, 18 Apr 2014 15:35:04 +0900
Message-ID: <1397802904.4283.1.camel@kjgkr>
References: <52F320FC.50803@ispras.ru> <534BC29B.3020408@ispras.ru>
	<1397559864.7727.5.camel@kjgkr> <534E494C.7050909@ispras.ru>
	<1397691337.7727.18.camel@kjgkr> <534F2A32.9030405@ispras.ru>
	<1397720720.7727.28.camel@kjgkr> <5350C06A.4090807@ispras.ru>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Wb2QI-0008Bu-C3
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Apr 2014 06:37:18 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wb2QE-0008MN-Uc
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Apr 2014 06:37:18 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4700B24RPVCJ40@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Apr 2014 15:37:07 +0900 (KST)
In-reply-to: <5350C06A.4090807@ispras.ru>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Andrey Tsyvarev <tsyvarev@ispras.ru>, linux-kernel <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Thank you for the explanation.
The following patch will resolve the issue.
Thanks,

>From 2048e7458c982f4297da9d3366ab29224ae2e8b0 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Fri, 18 Apr 2014 15:21:04 +0900
Subject: [PATCH] f2fs: avoid BUG_ON when mouting corrupted image having
 garbage blocks

If the disk has some garbage blocks, F2FS is able to face with BUG_ON
when
recovering direct node blocks.
This patch detects the error case and avoids that prior to reaching
BUG_ON.

Alexey Khoroshilov addressed the potential security issues as follows.
"An ability to trigger a BUG_ON assert by mounting a crafted image is
usually considered as a local denial of service [1-3]. As far as I
understand, the reason is that some kernel data may become inconsistent
that can lead to further problems.

[1] http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2011-3353
[2] http://www.openwall.com/lists/oss-security/2011/06/24/4
[3] http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2011-2928
etc."

Reported-by: Andrey Tsyvarev <tsyvarev@ispras.ru>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/node.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6ebdba1..64755f4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1609,6 +1609,11 @@ int recover_inode_page(struct f2fs_sb_info *sbi,
struct page *page)
 	struct node_info old_ni, new_ni;
 	struct page *ipage;
 
+	get_node_info(sbi, ino, &old_ni);
+
+	if (unlikely(old_ni.blk_addr != NULL_ADDR))
+		return -EINVAL;
+
 	ipage = grab_cache_page(NODE_MAPPING(sbi), ino);
 	if (!ipage)
 		return -ENOMEM;
@@ -1616,7 +1621,6 @@ int recover_inode_page(struct f2fs_sb_info *sbi,
struct page *page)
 	/* Should not use this inode  from free nid list */
 	remove_free_nid(NM_I(sbi), ino);
 
-	get_node_info(sbi, ino, &old_ni);
 	SetPageUptodate(ipage);
 	fill_node_footer(ipage, ino, ino, 0, true);
 
-- 
1.8.4.474.g128a96c




-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
