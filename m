From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: remove false-positive bug_on
Date: Thu, 1 Jun 2017 15:47:20 -0700
Message-ID: <20170601224720.GA41246@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170526235923.31058-1-jaegeuk@kernel.org>
 <995a8c2b-d29f-5c82-6d7c-90e93770f620@kernel.org>
 <20170601021206.GB35573@jaegeuk-macbookpro.roam.corp.google.com>
 <0655d27f-a0e0-71d7-5890-13eb4325dfc8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0655d27f-a0e0-71d7-5890-13eb4325dfc8@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

For example,

f2fs_create
 - new_node_page is failed
 - handle_failed_inode
  - skip to add it into orphan list, since ni.blk_addr == NULL_ADDR
   : set_inode_flag(inode, FI_FREE_NID)

f2fs_evict_inode
 - EIO due to fault injection
 - f2fs_bug_on() is triggered

So, we don't need to call f2fs_bug_on in this case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e53c784ab11e..868d71436ebc 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -425,9 +425,10 @@ void f2fs_evict_inode(struct inode *inode)
 	if (is_inode_flag_set(inode, FI_FREE_NID)) {
 		alloc_nid_failed(sbi, inode->i_ino);
 		clear_inode_flag(inode, FI_FREE_NID);
+	} else {
+		f2fs_bug_on(sbi, err &&
+			!exist_written_data(sbi, inode->i_ino, ORPHAN_INO));
 	}
-	f2fs_bug_on(sbi, err &&
-		!exist_written_data(sbi, inode->i_ino, ORPHAN_INO));
 out_clear:
 	fscrypt_put_encryption_info(inode, NULL);
 	clear_inode(inode);
-- 
2.13.0.rc1.294.g07d810a77f-goog
