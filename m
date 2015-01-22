From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] fibmap.f2fs: fix the wrong stat info
Date: Thu, 22 Jan 2015 11:19:05 +0800
Message-ID: <00c501d035f2$52ea29e0$f8be7da0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YE8Je-0006bW-29
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Jan 2015 03:20:18 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YE8Jb-0003s7-R1
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Jan 2015 03:20:18 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NIK002G56LK4870@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Jan 2015 12:20:08 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

fibmap shows ino, size, blocks with incorrectly decimal number, fix it.

Before:
--------------------------------------------
dev       [8:16]
ino       [0x   238ea : 0]
mode      [0x    81a4 : 33188]
nlink     [0x       1 : 1]
uid       [0x       0 : 0]
gid       [0x       0 : 0]
size      [0x   79e00 : 0]
blksize   [0x    1000 : 4096]
blocks    [0x     268 : 0]
--------------------------------------------

Patched:
--------------------------------------------
dev       [8:16]
ino       [0x   238ea : 145642]
mode      [0x    81a4 : 33188]
nlink     [0x       1 : 1]
uid       [0x       0 : 0]
gid       [0x       0 : 0]
size      [0x   79e00 : 499200]
blksize   [0x    1000 : 4096]
blocks    [0x     268 : 616]
--------------------------------------------

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 tools/fibmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/fibmap.c b/tools/fibmap.c
index a6a112b..2df8094 100644
--- a/tools/fibmap.c
+++ b/tools/fibmap.c
@@ -33,14 +33,14 @@ void print_stat(struct stat64 *st)
 {
 	printf("--------------------------------------------\n");
 	printf("dev       [%d:%d]\n", major(st->st_dev), minor(st->st_dev));
-	printf("ino       [0x%8lx : %ld]\n", st->st_ino, st->st_ino);
+	printf("ino       [0x%8llx : %lld]\n", st->st_ino, st->st_ino);
 	printf("mode      [0x%8x : %d]\n", st->st_mode, st->st_mode);
 	printf("nlink     [0x%8lx : %ld]\n", st->st_nlink, st->st_nlink);
 	printf("uid       [0x%8x : %d]\n", st->st_uid, st->st_uid);
 	printf("gid       [0x%8x : %d]\n", st->st_gid, st->st_gid);
-	printf("size      [0x%8lx : %ld]\n", st->st_size, st->st_size);
+	printf("size      [0x%8llx : %lld]\n", st->st_size, st->st_size);
 	printf("blksize   [0x%8lx : %ld]\n", st->st_blksize, st->st_blksize);
-	printf("blocks    [0x%8lx : %ld]\n", st->st_blocks, st->st_blocks);
+	printf("blocks    [0x%8llx : %lld]\n", st->st_blocks, st->st_blocks);
 	printf("--------------------------------------------\n\n");
 }
 
-- 
2.2.1



------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
