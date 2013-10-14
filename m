From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH RESEND] f2fs: introduce function
	read_raw_super_block()
Date: Mon, 14 Oct 2013 18:47:11 +0800
Message-ID: <525BCBAF.1010003@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1VVflT-00059T-OI
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Oct 2013 10:52:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VVflS-0006du-Cv for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Oct 2013 10:52:43 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Introduce function read_raw_super_block() to hide reading raw super block and
the retry routine if the first sb is invalid.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/super.c |   54 +++++++++++++++++++++++++++++++++---------------------
 1 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3b786c8..5e913de 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -746,30 +746,46 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 		atomic_set(&sbi->nr_pages[i], 0);
 }
 
-static int validate_superblock(struct super_block *sb,
-		struct f2fs_super_block **raw_super,
-		struct buffer_head **raw_super_buf, sector_t block)
+/* Read f2fs raw super block.
+ * Because we have two copies of super block, so read the first one at first,
+ * if the first one is invalid, move to read the second one.
+ */
+static int read_raw_super_block(struct super_block *sb,
+			struct f2fs_super_block **raw_super,
+			struct buffer_head **raw_super_buf)
 {
-	const char *super = (block == 0 ? "first" : "second");
+	int block = 0;
 
-	/* read f2fs raw super block */
+retry:
 	*raw_super_buf = sb_bread(sb, block);
 	if (!*raw_super_buf) {
-		f2fs_msg(sb, KERN_ERR, "unable to read %s superblock",
-				super);
-		return -EIO;
+		f2fs_msg(sb, KERN_ERR, "Unable to read %dth superblock",
+				block + 1);
+		if (block == 0) {
+			block++;
+			goto retry;
+		} else {
+			return -EIO;
+		}
 	}
 
 	*raw_super = (struct f2fs_super_block *)
 		((char *)(*raw_super_buf)->b_data + F2FS_SUPER_OFFSET);
 
 	/* sanity checking of raw super */
-	if (!sanity_check_raw_super(sb, *raw_super))
-		return 0;
+	if (sanity_check_raw_super(sb, *raw_super)) {
+		brelse(*raw_super_buf);
+		f2fs_msg(sb, KERN_ERR, "Can't find a valid F2FS filesystem "
+				"in %dth superblock", block + 1);
+		if(block == 0) {
+			block++;
+			goto retry;
+		} else {
+			return -EINVAL;
+		}
+	}
 
-	f2fs_msg(sb, KERN_ERR, "Can't find a valid F2FS filesystem "
-				"in %s superblock", super);
-	return -EINVAL;
+	return 0;
 }
 
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
@@ -791,14 +807,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_sbi;
 	}
 
-	err = validate_superblock(sb, &raw_super, &raw_super_buf, 0);
-	if (err) {
-		brelse(raw_super_buf);
-		/* check secondary superblock when primary failed */
-		err = validate_superblock(sb, &raw_super, &raw_super_buf, 1);
-		if (err)
-			goto free_sb_buf;
-	}
+	err = read_raw_super_block(sb, &raw_super, &raw_super_buf);
+	if (err)
+		goto free_sbi;
+
 	sb->s_fs_info = sbi;
 	/* init some FS parameters */
 	sbi->active_logs = NR_CURSEG_TYPE;
-- 
1.7.7


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
