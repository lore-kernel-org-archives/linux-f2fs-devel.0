From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 2/3] f2fs crypto: check dir entry just
	for	directory
Date: Wed, 27 May 2015 15:27:49 +0800
Message-ID: <003201d0984e$bccd8140$366883c0$@samsung.com>
References: <00d501d096d2$cdd373f0$697a5bd0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YxVlb-0002AL-2l
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 May 2015 07:28:43 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YxVlY-0007cq-SC
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 May 2015 07:28:43 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NOZ001VLZFLJE20@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 May 2015 16:28:33 +0900 (KST)
In-reply-to: <00d501d096d2$cdd373f0$697a5bd0$@samsung.com>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi all,

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Monday, May 25, 2015 6:08 PM
> To: Jaegeuk Kim; Changman Lee
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH 2/3] f2fs crypto: check dir entry just for directory
> 
> This patch fixes to add a judgement condition to verify type of the
> target inode before empty directory verification.
> 
> So wrong verification could be avoided for non-directory inode.

Proposal for ext4 encryption indicated that encryption policy will only
be set to an directory in below link:

https://lwn.net/Articles/639427/

So the previous patch could not fix the issue exactly, I'd like to use
the below patch instead.

>From 28540d2ab2150e586a96314336651eea74f48c7d Mon Sep 17 00:00:00 2001
From: Chao Yu <chao2.yu@samsung.com>
Date: Wed, 27 May 2015 14:51:52 +0800
Subject: [PATCH] f2fs: do not set encryption policy for non-directory by ioctl

Encryption policy should only be set to an empty directory through ioctl,
This patch add a judgement condition to verify type of the target inode
to avoid incorrectly configuring for non-directory.

Additionally, remove unneeded inline data conversion since regular or symlink
file should not be processed here.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/crypto_policy.c | 3 +++
 fs/f2fs/file.c          | 6 ------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/crypto_policy.c b/fs/f2fs/crypto_policy.c
index 30b0b73..d4a96af 100644
--- a/fs/f2fs/crypto_policy.c
+++ b/fs/f2fs/crypto_policy.c
@@ -92,6 +92,9 @@ int f2fs_process_policy(const struct f2fs_encryption_policy *policy,
 	if (policy->version != 0)
 		return -EINVAL;
 
+	if (!S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
 	if (!f2fs_inode_has_encryption_context(inode)) {
 		if (!f2fs_empty_dir(inode))
 			return -ENOTEMPTY;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index af5ef5f..4d42d66 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1485,12 +1485,6 @@ static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 				sizeof(policy)))
 		return -EFAULT;
 
-	if (f2fs_has_inline_data(inode)) {
-		int ret = f2fs_convert_inline_inode(inode);
-		if (ret)
-			return ret;
-	}
-
 	return f2fs_process_policy(&policy, inode);
 #else
 	return -EOPNOTSUPP;
-- 
2.3.3



------------------------------------------------------------------------------
