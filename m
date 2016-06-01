From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: return error of f2fs_lookup
Date: Wed,  1 Jun 2016 16:34:14 -0700
Message-ID: <1464824055-47514-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b8Feb-0004Ar-PA
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jun 2016 23:34:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b8Fea-0001SB-KM
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jun 2016 23:34:25 +0000
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

Now we can report an error to f2fs_lookup given by f2fs_find_entry.

Suggested-by: He YunLei <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c   | 2 +-
 fs/f2fs/namei.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ae37543..6fbb1ed 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -230,7 +230,7 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 
 	err = fscrypt_setup_filename(dir, child, 1, &fname);
 	if (err) {
-		*res_page = ERR_PTR(-ENOMEM);
+		*res_page = ERR_PTR(err);
 		return NULL;
 	}
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3f6119e..78efe00 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -287,8 +287,11 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		return ERR_PTR(-ENAMETOOLONG);
 
 	de = f2fs_find_entry(dir, &dentry->d_name, &page);
-	if (!de)
+	if (!de) {
+		if (IS_ERR(page))
+			return (struct dentry *)page;
 		return d_splice_alias(inode, dentry);
+	}
 
 	ino = le32_to_cpu(de->ino);
 	f2fs_dentry_kunmap(dir, page);
-- 
2.6.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
