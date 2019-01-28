From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/7] f2fs: try to keep CP_TRIMMED_FLAG after successful umount
Date: Tue, 29 Jan 2019 07:47:13 +0800
Message-ID: <20190128234717.77225-3-jaegeuk@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128234717.77225-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If every discard were issued successfully, we can avoid further discard.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 342b720fb4db..fdd8cd21522f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1063,6 +1063,8 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 	} else if (discard_type == DPOLICY_UMOUNT) {
 		dpolicy->max_requests = UINT_MAX;
 		dpolicy->io_aware = false;
+		/* we need to issue all to keep CP_TRIMMED_FLAG */
+		dpolicy->granularity = 1;
 	}
 }
 
-- 
2.19.0.605.g01d371f741-goog
