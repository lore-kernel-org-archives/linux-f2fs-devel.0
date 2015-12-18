From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] libf2fs: fix incorrect type define of declaration
Date: Fri, 18 Dec 2015 15:57:10 +0800
Message-ID: <00c901d13969$c85fb5c0$591f2140$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a9pvI-0006Os-CK
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Dec 2015 07:57:56 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a9pvG-0003Xv-Dr
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Dec 2015 07:57:56 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZJ002WDNGAOS20@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Dec 2015 16:57:46 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

When compiling f2fs toolset in 32-bits machine, following error was
reported:

libf2fs.c:342:5: error: conflicting types for 'find_next_bit_le'
../include/f2fs_fs.h:864:22: note: previous declaration of 'find_next_bit_le' was here
libf2fs.c:348:5: error: conflicting types for 'find_next_zero_bit_le'
../include/f2fs_fs.h:865:22: note: previous declaration of 'find_next_zero_bit_le' was here

This is because our type of return value(u64 in define) and (unsigned long
in declaration) of find_next_{,zero_}bit_le were not same in non-64-bits
machine:

extern unsigned long find_next_bit_le(const u8 *, u64, u64);
u64 find_next_bit_le(const u8 *addr, u64 size, u64 offset)

Fix it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 include/f2fs_fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index f9060f2..e1eeb6e 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -861,8 +861,8 @@ extern int test_bit_le(u32, const u8 *);
 extern int f2fs_test_bit(unsigned int, const char *);
 extern int f2fs_set_bit(unsigned int, char *);
 extern int f2fs_clear_bit(unsigned int, char *);
-extern unsigned long find_next_bit_le(const u8 *, u64, u64);
-extern unsigned long find_next_zero_bit_le(const u8 *, u64, u64);
+extern u64 find_next_bit_le(const u8 *, u64, u64);
+extern u64 find_next_zero_bit_le(const u8 *, u64, u64);
 
 extern u_int32_t f2fs_cal_crc32(u_int32_t, void *, int);
 extern int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len);
-- 
2.6.3



------------------------------------------------------------------------------
