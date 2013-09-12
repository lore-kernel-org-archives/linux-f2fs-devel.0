From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH V2] f2fs: optimize fs_lock for better performance
Date: Thu, 12 Sep 2013 11:17:51 +0800
Message-ID: <5231325F.3090700@cn.fujitsu.com>
References: <88.C4.11914.9D4A9225@epcpsbge6.samsung.com>
	<1378774324.2354.103.camel@kjgkr> <523001B6.3080506@cn.fujitsu.com>
	<001001ceaf61$a4ea9a90$eebfcfb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1VJxUY-0000Vi-O0
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Sep 2013 03:22:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VJxUX-000532-13 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Sep 2013 03:22:50 +0000
In-Reply-To: <001001ceaf61$a4ea9a90$eebfcfb0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, shu.tan@samsung.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Yu Chao <chao2.yu@samsung.com>

There is a performance problem: when all sbi->fs_lock are holded, then
all the following threads may get the same next_lock value from sbi->next_lock_num
in function mutex_lock_op, and wait for the same lock(fs_lock[next_lock]),
it may cause performance reduce.
So we move the sbi->next_lock_num++ before getting lock, this will average the
following threads if all sbi->fs_lock are holded. 

v1-->v2:
	Drop the needless spin_lock as Jaegeuk suggested.

Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Signed-off-by: Yu Chao <chao2.yu@samsung.com>
Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 608f0df..7fd99d8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -544,15 +544,15 @@ static inline void mutex_unlock_all(struct f2fs_sb_info *sbi)
 
 static inline int mutex_lock_op(struct f2fs_sb_info *sbi)
 {
-	unsigned char next_lock = sbi->next_lock_num % NR_GLOBAL_LOCKS;
+	unsigned char next_lock;
 	int i = 0;
 
 	for (; i < NR_GLOBAL_LOCKS; i++)
 		if (mutex_trylock(&sbi->fs_lock[i]))
 			return i;
 
+	next_lock = sbi->next_lock_num++ % NR_GLOBAL_LOCKS;
 	mutex_lock(&sbi->fs_lock[next_lock]);
-	sbi->next_lock_num++;
 	return next_lock;
 }
 
-- 
1.7.7



------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
