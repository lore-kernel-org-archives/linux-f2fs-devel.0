Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9988FCD3423
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 May 2026 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9BA49TW7+endGm8XrfNUT5ypQhjQZpR0C8ZSutZM+w4=; b=fMu2a71WMlzuIFFXOF0be7Y8kF
	KRjd+qcuGRYKLbTD+yrui8oJda5tcT6n/pFVTiwyrS9+DOpBw3IqQja+xG/GoS9YRl5rXJyPvtqyE
	j4k0xkLqDRal+mXLZNBhJbkljkyGxOh1rCl47FqMGKiPWkIAcsrbFlYNgvTfEqViByRc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJBDl-00025U-GJ;
	Sat, 02 May 2026 14:21:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wJBDk-00025J-8L
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:21:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bLYGD8UhEfZ0gI1O0q/9fKsjTL83YjgnGhMcoMvuzIo=; b=KbV0HRXZiwKkMN0c9G+zyvXTXK
 7vyj1aEd/vKkpriSI5UMJYtJBtotJzLAzzIU02dJye5qLkampcLiHnIrDuLvbugVo0i7KJAkvxbq3
 zXmWTF1Km5otux2vXZIZfOOFzUoZMaxCcNPO/nz7P+rdI5mC/RlTFrH84JsPYxufxUjA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bLYGD8UhEfZ0gI1O0q/9fKsjTL83YjgnGhMcoMvuzIo=; b=PUmfjJhfv5DS1MrWx9WwJjp2St
 FmqT9cAAk2adyEQ/kqvLv4YpHRiR6+T5CvZzXyl6QgLHLCg9DjFcsnZ0nhzBpys6RGHgT4nqDwnjZ
 EvnusnYnpJUoLrlw1GPr8k7dz+tn/zLhqGWJsXzWcwZWvS2Cj8zQmsJ9bCcBxCBq8m3U=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wJBDk-0000rd-Eb for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:21:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AEB0444E1;
 Sat,  2 May 2026 14:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6D2C2BCB3;
 Sat,  2 May 2026 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777731678;
 bh=93lkf1HBQv1pjT23tKqszLwADekuVqw95GHVpFk/qSc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=c9dqznjqT3nK0gCeQf+quqbALJ8ZkUx/FFV7TY+6LxJNYXOuPjd18CBcyRsW7f8Xo
 6U0JvbsS17ncMuKHbtY6r0j1lVz72vfsVnNSyCb1BCp5hxNjNyq9+rJIkK4xWhox5X
 KLEoejPahTxkRDbaukchtykIpVIzsv2N87a7n+OPeo5GZPqOy72bPuTiwOOWfmvYIi
 qSrsD7ZJPp9sS649/dSuRGSMF0+o7yhh6/3p30Yi/6lWFkg3tA7ZRtCwsuJiq8zooe
 +i80WYpX1Ewa8uI54CY9/87F1WtD1c9n6rOFJgOEDK5QH+UdMJGtYjCnx/pNYz5Xad
 jDSjFr1aSQm9w==
Date: Sat, 02 May 2026 10:20:46 -0400
MIME-Version: 1.0
Message-Id: <20260502-case-sensitivity-v13-1-aa853140311f@oracle.com>
References: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
In-Reply-To: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3605;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=AWgZwG1E8rlvIL3m0PCLX9DfISmeBrTqPl/lfHkVgk0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghQxFmZlM8hYOkYPWqHSSZmcZJ8CLh1PP/PV
 +Mcq86IS9aJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUAAKCRAzarMzb2Z/
 l6D0D/9nv8DJn/N4olT5nofAbnfCPhd3NiX0SPC6Gijz5K/lVi+fk2ZgRC0u9rHGkFoB2v8+IPA
 IE8J75WNmzrOhZbbkEeHle4EL/+O9LZFxmCLI3NscUDjscohPfIuRiDHSuCIDdTtUvaSFcteY6Q
 lSL2D7xPQPiUS2wmlT9UFZI19hIvSAIK7NZ1/MY5O4pqKYTQTp3a+R9h4n14GJdyxuQsPepP6PE
 BrHtJdqxb8OS32B9wi7zNgIi/OkyHUYob0OJXTMESPNcM5uokgn19Z3j+3d8f/IF101sARLiR4D
 nWn2wItMJv3zHiccy609tHPxcNZm5mQyHdrBJyVL1eAi8Z5yEDoNvVNF9oqx4LnqUB1JJdboWQT
 ondxrZ3iYYdeEZtlgJpB4vyLJ6S0YSJveawbMLUcrq/N8uZAjIL2YU9uxsZU4p0obzywlqqN1rq
 jZoBk9Hkuv9rEhLudlSHA/tEKURDapop2YKRLPRtljb6bpKDZr/gnLfYb3cZTDp5dnnfPkOb9lP
 a+2ffHzokxKLL0+Lb6MDogG9EK4bSjQELufwgdCIzfFT9NJ5Fv4mcxCfJmgggaaOrQIUhxKC6cr
 aPc/Wy0JR3yXVRtVPbkCn5hTBg9u2/daaw3lEGVVHE+FDG+aWEkZdkPr4aUBVNLYy0Mab6f+9ey
 WkQt0xrO3fuUkCA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wJBDk-0000rd-Eb
Subject: [f2fs-dev] [PATCH v13 01/15] fs: Move file_kattr initialization to
 callers
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
 linkinjeon@kernel.org, sprasad@microsoft.com, frank.li@vivo.com,
 ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org,
 hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

fileattr_fill_xflags() and fileattr_fill_flags() memset the
entire file_kattr struct before populating select fields, so
callers cannot pre-set fields in fa->fsx_xflags without having
their values clobbered. Darrick Wong noted that a function
named "fill_xflags" touching more than xflags forces callers
to know implementation details beyond its apparent scope.

Drop the memset from both fill functions and initialize at the
entry points instead: ioctl_setflags(), ioctl_fssetxattr(),
the file_setattr() syscall, and xfs_ioc_fsgetxattra() now
declare fa with an aggregate initializer. ioctl_getflags(),
ioctl_fsgetxattr(), and the file_getattr() syscall already
aggregate-initialize fa to pass flags_valid/fsx_valid hints
into vfs_fileattr_get().

Subsequent patches rely on this so that ->fileattr_get()
handlers can set case-sensitivity flags (FS_XFLAG_CASEFOLD,
FS_XFLAG_CASENONPRESERVING) in fa->fsx_xflags before the fill
functions run.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_attr.c     | 12 ++++--------
 fs/xfs/xfs_ioctl.c |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index da983e105d70..f429da66a317 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -15,12 +15,10 @@
  * @fa:		fileattr pointer
  * @xflags:	FS_XFLAG_* flags
  *
- * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
- * other fields are zeroed.
+ * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).
  */
 void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
 {
-	memset(fa, 0, sizeof(*fa));
 	fa->fsx_valid = true;
 	fa->fsx_xflags = xflags;
 	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
@@ -48,11 +46,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
  * @flags:	FS_*_FL flags
  *
  * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
- * All other fields are zeroed.
  */
 void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
 {
-	memset(fa, 0, sizeof(*fa));
 	fa->flags_valid = true;
 	fa->flags = flags;
 	if (fa->flags & FS_SYNC_FL)
@@ -325,7 +321,7 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	unsigned int flags;
 	int err;
 
@@ -357,7 +353,7 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int err;
 
 	err = copy_fsxattr_from_user(&fa, argp);
@@ -431,7 +427,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 	struct path filepath __free(path_put) = {};
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 46e234863644..ed9b4846c05f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -517,7 +517,7 @@ xfs_ioc_fsgetxattra(
 	xfs_inode_t		*ip,
 	void			__user *arg)
 {
-	struct file_kattr	fa;
+	struct file_kattr	fa = {};
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
 	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
