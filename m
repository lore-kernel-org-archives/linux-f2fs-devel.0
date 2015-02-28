From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to issue small discard in real-time mode discard
Date: Sat, 28 Feb 2015 17:23:30 +0800
Message-ID: <019801d05338$52aae5b0$f800b110$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Now in f2fs, we share functions and structures for batch mode and real-time mode
discard. For real-time mode discard, in shared function add_discard_addrs, we
will use uninitialized trim_minlen in struct cp_control to compare with length
of contiguous free blocks to decide whether skipping discard fragmented freespace
or not, this makes us ignore small discard sometimes. Fix it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index daee4ab..fcc1cc2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -549,7 +549,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 		end = __find_rev_next_zero_bit(dmap, max_blocks, start + 1);
 
-		if (end - start < cpc->trim_minlen)
+		if (force && end - start < cpc->trim_minlen)
 			continue;
 
 		__add_discard_entry(sbi, cpc, start, end);
-- 
2.3.1
