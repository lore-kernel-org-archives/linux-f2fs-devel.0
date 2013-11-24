From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: avoid lock debugging overhead
Date: Sun, 24 Nov 2013 13:55:17 +0900
Message-ID: <1385268917-13853-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VkRk7-0006Tq-Ge
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 04:56:23 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VkRk5-0006Qk-6P
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 04:56:23 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWR00G0N4DP6I70@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 13:56:13 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If CONFIG_F2FS_CHECK_FS is unset, we don't need to add any debugging overhead.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 72718ef..417280a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -22,8 +22,10 @@
 
 #ifdef CONFIG_F2FS_CHECK_FS
 #define f2fs_bug_on(condition)	BUG_ON(condition)
+#define f2fs_down_write(x, y)	down_write_nest_lock(x, y)
 #else
 #define f2fs_bug_on(condition)
+#define f2fs_down_write(x, y)	down_write(x)
 #endif
 
 /*
@@ -556,7 +558,7 @@ static inline void f2fs_unlock_op(struct f2fs_sb_info *sbi)
 
 static inline void f2fs_lock_all(struct f2fs_sb_info *sbi)
 {
-	down_write_nest_lock(&sbi->cp_rwsem, &sbi->cp_mutex);
+	f2fs_down_write(&sbi->cp_rwsem, &sbi->cp_mutex);
 }
 
 static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
