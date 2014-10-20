From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 04/09] f2fs: fix race conditon on truncation with
	inline_data
Date: Sun, 19 Oct 2014 22:18:27 -0700
Message-ID: <1413782312-11631-4-git-send-email-jaegeuk@kernel.org>
References: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xg5Mi-0008Oa-OB
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:44 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg5Mi-0000qm-0Z for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:44 +0000
In-Reply-To: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Let's consider the following scenario.

blkaddr[0] inline_data i_size  i_blocks writepage           truncate
  NEW        X        4096        2    dirty page #0
  NEW        X         0                                    change i_size
  NEW        X         0          2    f2fs_write_inline_data
  NEW        X         0          2    get_dnode_of_data
  NEW        X         0          2    truncate_data_blocks_range
  NULL       O         0          1    memcpy(inline_data)
  NULL       O         0          1    f2fs_put_dnode
  NULL       O         0          1                         f2fs_truncate
  NULL       O         0          1                         get_dnode_of_data
  NULL       O         0          1                       *invalid block addr*

This patch adds checking inline_data flag during f2fs_truncate not to refer
corrupted block indices.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8e68bb6..543d8c6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -473,6 +473,12 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 		return err;
 	}
 
+	/* writepage can convert inline_data under get_donde_of_data */
+	if (f2fs_has_inline_data(inode)) {
+		f2fs_put_dnode(&dn);
+		goto done;
+	}
+
 	count = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
 
 	count -= dn.ofs_in_node;
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
