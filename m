From: DongOh Shin <doscode.kr@gmail.com>
Subject: [PATCH 5/5] Fix coding style warnings in f2fs.h
Date: Fri, 27 Jan 2017 10:29:40 -0800
Message-ID: <20170127182940.11389-6-doscode.kr@gmail.com>
References: <20170127182940.11389-1-doscode.kr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <doscode.kr@gmail.com>) id 1cXBIM-0003vz-MU
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 18:30:46 +0000
Received: from mail-pf0-f194.google.com ([209.85.192.194])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cXBIM-00007S-1i
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 18:30:46 +0000
Received: by mail-pf0-f194.google.com with SMTP id 19so19017552pfo.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 27 Jan 2017 10:30:46 -0800 (PST)
In-Reply-To: <20170127182940.11389-1-doscode.kr@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: doscode.kr@gmail.com, linux-f2fs-devel@lists.sourceforge.net

Two coding style warnings below have been resolved:
"macros should not use a trailing semicolon"

Signed-off-by: DongOh Shin <doscode.kr@gmail.com>
---
 fs/f2fs/f2fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 838575a..d501f4f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2350,9 +2350,9 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_inc_inplace_blocks(sbi)					\
 		(atomic_inc(&(sbi)->inplace_count))
 #define stat_inc_atomic_write(inode)					\
-		(atomic_inc(&F2FS_I_SB(inode)->aw_cnt));
+		(atomic_inc(&F2FS_I_SB(inode)->aw_cnt))
 #define stat_dec_atomic_write(inode)					\
-		(atomic_dec(&F2FS_I_SB(inode)->aw_cnt));
+		(atomic_dec(&F2FS_I_SB(inode)->aw_cnt))
 #define stat_update_max_atomic_write(inode)				\
 	do {								\
 		int cur = atomic_read(&F2FS_I_SB(inode)->aw_cnt);	\
-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
