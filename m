From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Space leak in f2fs
Date: Wed, 13 May 2015 17:24:17 -0700
Message-ID: <20150514002417.GC68412@jaegeuk-mac02>
References: <5552FA7D.7000704@huawei.com>
	<20150513174417.GA56247@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Ysgwu-0006TV-6B
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 May 2015 00:24:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ysgwt-0002sz-EZ for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 May 2015 00:24:28 +0000
Content-Disposition: inline
In-Reply-To: <20150513174417.GA56247@jaegeuk-mac02.mot.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: hujianyang <hujianyang@huawei.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi Hu,

Found a bug in the previous patch.
Could you check this out?

Thanks,

---
 fs/f2fs/super.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 19438f2..647591b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -431,8 +431,17 @@ static int f2fs_drop_inode(struct inode *inode)
 	 *    - f2fs_gc -> iput -> evict
 	 *       - inode_wait_for_writeback(inode)
 	 */
-	if (!inode_unhashed(inode) && inode->i_state & I_SYNC)
+	if (!inode_unhashed(inode) && inode->i_state & I_SYNC) {
+		if (!inode->i_nlink && !is_bad_inode(inode)) {
+			spin_unlock(&inode->i_lock);
+			i_size_write(inode, 0);
+
+			if (F2FS_HAS_BLOCKS(inode))
+				f2fs_truncate(inode);
+			spin_lock(&inode->i_lock);
+		}
 		return 0;
+	}
 	return generic_drop_inode(inode);
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
