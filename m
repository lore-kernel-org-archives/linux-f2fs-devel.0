From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] fsck.f2fs: check condition to avoid wrong
	memory allocation
Date: Thu, 13 Oct 2016 17:02:29 -0700
Message-ID: <20161014000230.59232-4-jaegeuk@kernel.org>
References: <20161014000230.59232-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bupxj-0005eR-4L
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 00:02:59 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bupxi-0003PD-CZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 00:02:59 +0000
In-Reply-To: <20161014000230.59232-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch should fix the below bug.

Info: checkpoint state = 4 :  compacted_summary sudden-power-off
[FIX] (is_valid_ssa_data_blk: 301)  --> Set data summary 0x1039 -> [0x3] [0x0] [0x0]
[ASSERT] (fsck_chk_data_blk:1459)  --> SIT bitmap is 0x0. blk_addr[0x20b6d8]
[ASSERT] (__chk_dentries:1255)  --> Bad dentry 0x2 with invalid NID/ino 0x1644b164
[FIX] (__chk_dentries:1258)  --> Clear bad dentry 0x2 with bad ino 0x1644b164
[ASSERT] (__chk_dentries:1269)  --> Bad dentry 0x0 with unexpected ftype 0x2c
[FIX] (__chk_dentries:1272)  --> Clear bad dentry 0x4 with bad ftype 0x2c
[ASSERT] (__chk_dentries:1255)  --> Bad dentry 0x5 with invalid NID/ino 0x49000000
[FIX] (__chk_dentries:1258)  --> Clear bad dentry 0x5 with bad ino 0x49000000
[ASSERT] (__chk_dentries:1255)  --> Bad dentry 0x7 with invalid NID/ino 0x67706a2e
[FIX] (__chk_dentries:1258)  --> Clear bad dentry 0x7 with bad ino 0x67706a2e
[ASSERT] (__chk_dentries:1255)  --> Bad dentry 0x8 with invalid NID/ino 0x4a437044
[FIX] (__chk_dentries:1258)  --> Clear bad dentry 0x8 with bad ino 0x4a437044
[ASSERT] (__chk_dentries:1269)  --> Bad dentry 0x0 with unexpected ftype 0x0
[FIX] (__chk_dentries:1272)  --> Clear bad dentry 0xf with bad ftype 0x0
[ASSERT] (__chk_dentries:1255)  --> Bad dentry 0x20 with invalid NID/ino 0x4a150009
[FIX] (__chk_dentries:1258)  --> Clear bad dentry 0x20 with bad ino 0x4a150009
[ASSERT] (__chk_dentries:1255)  --> Bad dentry 0x21 with invalid NID/ino 0x1800094a
[FIX] (__chk_dentries:1258)  --> Clear bad dentry 0x21 with bad ino 0x1800094a
*** buffer overflow detected ***: fsck.f2fs terminated
======= Backtrace: =========
/lib/x86_64-linux-gnu/libc.so.6(+0x7338f)[0x7fa56b17b38f]
/lib/x86_64-linux-gnu/libc.so.6(__fortify_fail+0x5c)[0x7fa56b212c9c]
/lib/x86_64-linux-gnu/libc.so.6(+0x109b60)[0x7fa56b211b60]
fsck.f2fs[0x4032f6]
fsck.f2fs[0x4063f7]
fsck.f2fs[0x406d09]
fsck.f2fs[0x4046b8]
fsck.f2fs[0x405378]
fsck.f2fs[0x405d86]
fsck.f2fs[0x402071]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf5)[0x7fa56b129ec5]

Reported-by: Mirh <mirh@protonmail.ch>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 4b6628e..636477d 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1281,8 +1281,8 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 
 		name_len = le16_to_cpu(dentry[i].name_len);
 
-		if (name_len == 0) {
-			ASSERT_MSG("Bad dentry 0x%x with zero name_len", i);
+		if (name_len == 0 || name_len > F2FS_NAME_LEN) {
+			ASSERT_MSG("Bad dentry 0x%x with invalid name_len", i);
 			if (c.fix_on) {
 				FIX_MSG("Clear bad dentry 0x%x", i);
 				test_and_clear_bit_le(i, bitmap);
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
