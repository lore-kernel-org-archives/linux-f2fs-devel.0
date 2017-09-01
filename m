From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: don't check inode's checksum if it was
 dirtied or writebacked
Date: Fri,  1 Sep 2017 10:25:11 -0700
Message-ID: <20170901172511.7045-2-jaegeuk@kernel.org>
References: <20170901172511.7045-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1dnph3-00061u-UY
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Sep 2017 17:25:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dnph3-0005zZ-7d
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Sep 2017 17:25:21 +0000
In-Reply-To: <20170901172511.7045-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If another thread already made the page dirtied or writebacked, we must avoid
to verify checksum. If we got an error, we need to remove its uptodate as well.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 3 ++-
 fs/f2fs/node.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b4c401d456e7..c33b05aec1a1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -153,7 +153,8 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 	struct f2fs_inode *ri;
 	__u32 provided, calculated;
 
-	if (!f2fs_enable_inode_chksum(sbi, page))
+	if (!f2fs_enable_inode_chksum(sbi, page) ||
+			PageDirty(page) || PageWriteback(page))
 		return true;
 
 	ri = &F2FS_NODE(page)->i;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 388a00262a5f..fca87835a1da 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1187,9 +1187,9 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 			nid, nid_of_node(page), ino_of_node(page),
 			ofs_of_node(page), cpver_of_node(page),
 			next_blkaddr_of_node(page));
-		ClearPageUptodate(page);
 		err = -EINVAL;
 out_err:
+		ClearPageUptodate(page);
 		f2fs_put_page(page, 1);
 		return ERR_PTR(err);
 	}
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
