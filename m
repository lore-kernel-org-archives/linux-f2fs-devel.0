From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: fix missing error number for xattr
 operation
Date: Thu, 28 Dec 2017 18:00:56 -0800
Message-ID: <20171229020056.60558-2-jaegeuk@kernel.org>
References: <20171229020056.60558-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eUjyt-0005Ss-MX
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Dec 2017 02:01:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eUjys-0001XU-Tj
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Dec 2017 02:01:07 +0000
In-Reply-To: <20171229020056.60558-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This fixes generic/449 hang problem caused by no ENOSPC forever which should be
returned by setxattr under disk full scenario.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 5e2b905cc0c4..600162f4ddbf 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -433,6 +433,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 	if (F2FS_I(inode)->i_xattr_nid) {
 		xpage = get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
 		if (IS_ERR(xpage)) {
+			err = PTR_ERR(xpage);
 			alloc_nid_failed(sbi, new_nid);
 			goto in_page_out;
 		}
@@ -443,6 +444,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 		set_new_dnode(&dn, inode, NULL, NULL, new_nid);
 		xpage = new_node_page(&dn, XATTR_NODE_OFFSET);
 		if (IS_ERR(xpage)) {
+			err = PTR_ERR(xpage);
 			alloc_nid_failed(sbi, new_nid);
 			goto in_page_out;
 		}
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
