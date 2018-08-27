From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid wrong decrypted data from disk
Date: Mon, 27 Aug 2018 15:52:26 -0700
Message-ID: <20180827225226.14272-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

1. Create a file in an encrypted directory
2. Do GC & drop caches
3. Read stale data before its bio for metapage was not issued yet

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 382c1ef9a9e4..c3557fd4a0bd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1550,6 +1550,13 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			bio = NULL;
 		}
 		if (bio == NULL) {
+			/*
+			 * If the page is under writeback, we need to wait for
+			 * its completion to see the correct decrypted data.
+			 */
+			if (unlikely(f2fs_encrypted_file(inode)))
+				f2fs_wait_on_block_writeback(F2FS_I_SB(inode), block_nr);
+
 			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
 					is_readahead ? REQ_RAHEAD : 0);
 			if (IS_ERR(bio)) {
-- 
2.17.0.441.gb46fe60e1d-goog
