From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: [PATCH 1/2] f2fs: use true and false for boolean value
Date: Fri, 18 Oct 2013 17:24:07 +0800
Message-ID: <1382088248-10615-1-git-send-email-haicheng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, Haicheng Li <haicheng.lee@gmail.com>, Haicheng Li <haicheng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
---
 fs/f2fs/segment.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3b20359..862fef3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1277,9 +1277,9 @@ static bool flush_sits_in_journal(struct f2fs_sb_info *sbi)
 			__mark_sit_entry_dirty(sbi, segno);
 		}
 		update_sits_in_cursum(sum, -sits_in_cursum(sum));
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
-- 
1.7.9.5
