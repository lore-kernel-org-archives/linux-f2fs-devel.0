From: Liu Xue <liuxueliu.liu@huawei.com>
Subject: [RFC PATCH] f2fs: recovery missing dot dentries in root
	directory
Date: Fri, 26 Feb 2016 06:39:23 +0000
Message-ID: <1456468763-21662-1-git-send-email-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuxueliu.liu@huawei.com>) id 1aZC4C-00059h-Ck
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 06:39:56 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aZC46-0008Dw-3F
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 06:39:56 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

If f2fs was corrupted with missing dot dentries in root dirctory,
it needs to recover them after fsck.f2fs set F2FS_INLINE_DOTS flag
in directory inode when fsck.f2fs detects missing dot dentries.

Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
Signed-off-by: Yong Sheng <shengyong1@huawei.com>
---
 fs/f2fs/namei.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 55a7362..7b07a47 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -260,6 +260,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	struct page *page;
 	nid_t ino;
 	int err = 0;
+	unsigned int root_ino = F2FS_ROOT_INO(F2FS_I_SB(dir));
 
 	if (f2fs_encrypted_inode(dir)) {
 		int res = fscrypt_get_encryption_info(dir);
@@ -291,6 +292,12 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
+	if ((dir->i_ino == root_ino) && f2fs_has_inline_dots(dir)) {
+		err = __recover_dot_dentries(dir, root_ino);
+		if (err)
+			goto err_out;
+	}
+
 	if (f2fs_has_inline_dots(inode)) {
 		err = __recover_dot_dentries(inode, dir->i_ino);
 		if (err)
-- 
1.8.5.2


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
