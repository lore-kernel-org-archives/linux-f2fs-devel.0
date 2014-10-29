From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: do not discard data protected by the previous checkpoint
Date: Tue, 28 Oct 2014 22:05:52 -0700
Message-ID: <1414559153-92771-3-git-send-email-jaegeuk@kernel.org>
References: <1414559153-92771-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414559153-92771-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We should not discard any data protected by the previous checkpoint all
the time.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d391a59..06dda73 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -517,7 +517,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
 	for (i = 0; i < entries; i++)
-		dmap[i] = (cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
+		dmap[i] = ~(cur_map[i] | ckpt_map[i]);
 
 	while (force || SM_I(sbi)->nr_discards <= SM_I(sbi)->max_discards) {
 		start = __find_rev_next_bit(dmap, max_blocks, end + 1);
-- 
2.1.1
