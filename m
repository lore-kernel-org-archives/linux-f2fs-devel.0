From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: flush stale issued discard candidates
Date: Thu, 13 Dec 2018 21:01:27 -0800
Message-ID: <20181214050127.45025-3-jaegeuk@kernel.org>
References: <20181214050127.45025-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214050127.45025-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Sometimes, I could observe # of issuing_discard to be 1 which blocks background
jobs due to is_idle()=false.
The only way to get out of it was to trigger gc_urgent. This patch avoids that
by checking any candidates as done in the list.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 49ea9009ab5a..acbbc924e518 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1651,6 +1651,10 @@ static int issue_discard_thread(void *data)
 		if (dcc->discard_wake)
 			dcc->discard_wake = 0;
 
+		/* clean up pending candidates before going to sleep */
+		if (atomic_read(&dcc->queued_discard))
+			__wait_all_discard_cmd(sbi, NULL);
+
 		if (try_to_freeze())
 			continue;
 		if (f2fs_readonly(sbi->sb))
-- 
2.19.0.605.g01d371f741-goog
