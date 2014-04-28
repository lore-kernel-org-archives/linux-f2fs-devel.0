From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: set errno when f2fs_iget failed in
 recover_dentry
Date: Mon, 28 Apr 2014 17:58:34 +0800
Message-ID: <000501cf62c8$86ae39e0$940aada0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WeiLR-00024k-DB
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Apr 2014 09:59:29 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WeiLP-0003X7-Jq
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Apr 2014 09:59:29 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N4Q008IPJQW5RC0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Apr 2014 18:59:20 +0900 (KST)
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

We should set the error number correctly when we fail in recover_dentry(), so
the recover flow could stop for the reason as error number shows instead of
continuing.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/recovery.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index be1e3e8..e950a2f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -75,7 +75,8 @@ retry:
 		einode = f2fs_iget(inode->i_sb, le32_to_cpu(de->ino));
 		if (IS_ERR(einode)) {
 			WARN_ON(1);
-			if (PTR_ERR(einode) == -ENOENT)
+			err = PTR_ERR(einode);
+			if (err == -ENOENT)
 				err = -EEXIST;
 			goto out_unmap_put;
 		}
-- 
1.7.9.5



------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
