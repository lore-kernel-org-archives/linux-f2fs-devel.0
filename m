From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2] f2fs: fix wrong statistics of inline data
Date: Mon, 07 Apr 2014 11:18:34 +0800
Message-ID: <000001cf5210$28c139e0$7a43ada0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WX05m-00027L-SN
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Apr 2014 03:19:26 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WX05l-0005VU-2C
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Apr 2014 03:19:26 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N3N00KO9585TO90@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Apr 2014 12:19:17 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If we remove a file that has inline data after mount, our statistics turns to
inaccurate.

cat /sys/kernel/debug/f2fs/status
  - Inline_data Inode: 4294967295

Let's add stat_inc_inline_inode() to stat inline info of the file when lookup.

Change log from v1:
 o stat in f2fs_lookup() instead of in do_read_inode() for excluding wrong stat.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 0cea874..a9409d1 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -207,6 +207,8 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		inode = f2fs_iget(dir->i_sb, ino);
 		if (IS_ERR(inode))
 			return ERR_CAST(inode);
+
+		stat_inc_inline_inode(inode);
 	}
 
 	return d_splice_alias(inode, dentry);
-- 
1.7.9.5



------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees_APR
