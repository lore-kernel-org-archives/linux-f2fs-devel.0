From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/4 v2] f2fs: record node block allocation in
 dnode_of_data
Date: Wed, 23 Dec 2015 11:00:17 -0800
Message-ID: <20151223190017.GC30505@jaegeuk.local>
References: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
	<1450832388-29118-3-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aBoeA-0004Fo-EH
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 19:00:26 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aBoe9-0006dZ-DX for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 19:00:26 +0000
Content-Disposition: inline
In-Reply-To: <1450832388-29118-3-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Change log from v1:
 - remove redundant set
 - adjust memory alignment

>From 60c6a898094535e850268dd77701255a37cce3d3 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 22 Dec 2015 12:59:54 -0800
Subject: [PATCH] f2fs: record node block allocation in dnode_of_data

This patch introduces recording node block allocation in dnode_of_data.
This information helps to figure out whether any node block is allocated during
specific file operations.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 1 +
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/node.c | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cf0c9dd..a7a9a05 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -226,6 +226,7 @@ void set_data_blkaddr(struct dnode_of_data *dn)
 	addr_array = blkaddr_in_node(rn);
 	addr_array[ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
 	set_page_dirty(node_page);
+	dn->node_changed = true;
 }
 
 int reserve_new_block(struct dnode_of_data *dn)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 90fb970..3e4a60d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -546,6 +546,7 @@ struct dnode_of_data {
 	nid_t nid;			/* node id of the direct node block */
 	unsigned int ofs_in_node;	/* data offset in the node page */
 	bool inode_page_locked;		/* inode page is locked or not */
+	bool node_changed;		/* is node block changed */
 	block_t	data_blkaddr;		/* block address of the node block */
 };
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6cc8ac7..ff2acb1 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -542,6 +542,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 			set_nid(parent, offset[i - 1], nids[i], i == 1);
 			alloc_nid_done(sbi, nids[i]);
+			dn->node_changed = true;
 			done = true;
 		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
 			npage[i] = get_node_page_ra(parent, offset[i - 1]);
@@ -678,6 +679,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			if (ret < 0)
 				goto out_err;
 			set_nid(page, i, 0, false);
+			dn->node_changed = true;
 		}
 	} else {
 		child_nofs = nofs + ofs * (NIDS_PER_BLOCK + 1) + 1;
@@ -691,6 +693,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			ret = truncate_nodes(&rdn, child_nofs, 0, depth - 1);
 			if (ret == (NIDS_PER_BLOCK + 1)) {
 				set_nid(page, i, 0, false);
+				dn->node_changed = true;
 				child_nofs += ret;
 			} else if (ret < 0 && ret != -ENOENT) {
 				goto out_err;
@@ -752,6 +755,7 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 		if (err < 0)
 			goto fail;
 		set_nid(pages[idx], i, 0, false);
+		dn->node_changed = true;
 	}
 
 	if (offset[idx + 1] == 0) {
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
