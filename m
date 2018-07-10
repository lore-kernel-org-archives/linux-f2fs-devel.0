From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH] f2fs: Keep alloc_valid_block_count in sync
Date: Mon,  9 Jul 2018 20:32:42 -0700
Message-ID: <20180710033242.177557-1-drosen@google.com>
Reply-To: Daniel Rosenberg <drosen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <drosen@google.com>) id 1fcjPm-0001tV-UF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 03:34:10 +0000
Received: from mail-pf0-f196.google.com ([209.85.192.196])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fcjPl-004n8u-0g
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 03:34:10 +0000
Received: by mail-pf0-f196.google.com with SMTP id l9-v6so3469152pff.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 09 Jul 2018 20:34:08 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>

If we attempt to request more blocks than we have room for, we try to
instead request as much as we can, however, alloc_valid_block_count
is not decremented to match the new value, allowing it to drift higher
until the next checkpoint. This always decrements it when the requested
amount cannot be fulfilled.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/f2fs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4d8b1de83143..5af955a8736e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1680,18 +1680,20 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 		sbi->total_valid_block_count -= diff;
 		if (!*count) {
 			spin_unlock(&sbi->stat_lock);
-			percpu_counter_sub(&sbi->alloc_valid_block_count, diff);
 			goto enospc;
 		}
 	}
 	spin_unlock(&sbi->stat_lock);
 
-	if (unlikely(release))
+	if (unlikely(release)) {
+		percpu_counter_sub(&sbi->alloc_valid_block_count, release);
 		dquot_release_reservation_block(inode, release);
+	}
 	f2fs_i_blocks_write(inode, *count, true, true);
 	return 0;
 
 enospc:
+	percpu_counter_sub(&sbi->alloc_valid_block_count, release);
 	dquot_release_reservation_block(inode, release);
 	return -ENOSPC;
 }
-- 
2.18.0.203.gfac676dfb9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
