From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: clean up code with __has_cursum_space
Date: Tue, 01 Dec 2015 11:42:54 +0800
Message-ID: <000201d12bea$7cdbdb60$76939220$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Clean up codes in lookup_journal_in_cursum() with __has_cursum_space().

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ed2c5de..74c4748 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1740,13 +1740,13 @@ int lookup_journal_in_cursum(struct f2fs_summary_block *sum, int type,
 			if (le32_to_cpu(nid_in_journal(sum, i)) == val)
 				return i;
 		}
-		if (alloc && nats_in_cursum(sum) < NAT_JOURNAL_ENTRIES)
+		if (alloc && __has_cursum_space(sum, 1, NAT_JOURNAL))
 			return update_nats_in_cursum(sum, 1);
 	} else if (type == SIT_JOURNAL) {
 		for (i = 0; i < sits_in_cursum(sum); i++)
 			if (le32_to_cpu(segno_in_journal(sum, i)) == val)
 				return i;
-		if (alloc && sits_in_cursum(sum) < SIT_JOURNAL_ENTRIES)
+		if (alloc && __has_cursum_space(sum, 1, SIT_JOURNAL))
 			return update_sits_in_cursum(sum, 1);
 	}
 	return -1;
-- 
2.6.3
