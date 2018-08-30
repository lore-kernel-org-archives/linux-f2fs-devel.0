From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: avoid wrong decrypted data from disk
Date: Wed, 29 Aug 2018 18:48:58 -0700
Message-ID: <20180830014858.GA91444@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180827225226.14272-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180827225226.14272-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

1. Create a file in an encrypted directory
2. Do GC & drop caches
3. Read stale data before its bio for metapage was not issued yet

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
Change log from v1:
 - move to bio != NULL

 fs/f2fs/data.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 382c1ef9a9e4..159e411785e9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1556,6 +1556,12 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 				bio = NULL;
 				goto set_error_page;
 			}
+		} else if (unlikely(f2fs_encrypted_file(inode))) {
+			/*
+			 * If the page is under writeback, we need to wait for
+			 * its completion to see the correct decrypted data.
+			 */
+			f2fs_wait_on_block_writeback(F2FS_I_SB(inode), block_nr);
 		}
 
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
-- 
2.17.0.441.gb46fe60e1d-goog
