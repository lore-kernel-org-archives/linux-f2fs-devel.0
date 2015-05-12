From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: disable the discard option when device does not support
Date: Mon, 11 May 2015 20:48:46 -0700
Message-ID: <1431402528-24156-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch disables given discard option when device does not support it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bd8a405..19438f2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1186,6 +1186,7 @@ try_onemore:
 			f2fs_msg(sb, KERN_WARNING,
 					"mounting with \"discard\" option, but "
 					"the device does not support discard");
+		clear_opt(sbi, DISCARD);
 	}
 
 	sbi->s_kobj.kset = f2fs_kset;
-- 
2.1.1
