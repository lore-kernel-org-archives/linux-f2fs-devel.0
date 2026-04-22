Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46125FAD3E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w/WJGRhEAbniypfwT2N0RfRtXNZLExAu5OwMOu3S+Ms=; b=SAdcL9gOCKhCaOQ1zBhLhKUvxK
	OyoLIUfHrnopQ8RZuHEa3JwcezQuig9hVpDbh+7ZUEzW3RdIol/MMqLMbqOwsFcY99deVEiaclMye
	7EYExUpDi24poc/I1y0pSy0L1Uxp6DgPFbfyAdeP9wGqu/Q6Kcd+K80cHCkCEtqQ9ptc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFh1X-00065S-6R;
	Wed, 22 Apr 2026 23:30:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFh1U-00065L-Ua
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A/TMb7z1IOzCWuGNbww2f5zeTnCzmKbWrYWTjRwse6U=; b=YF2FsY96tuUSUC0n5xgUPP7oBe
 7imy/kHH8+hlNMJUtGfcxnuiQJNYPCGws4E/NiwnTWb+Dv2qkgsznXWmKKCnw9Y26Bdu+ABWhe4Jm
 E/hDtPQsKQOvL8s1dCl3oLMYk+PKX/caz1rLlitERaDWnqqOfeBPOcLIv53Z0vVGjHPs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A/TMb7z1IOzCWuGNbww2f5zeTnCzmKbWrYWTjRwse6U=; b=WUJVgK5WSR4RWAACiWuN0LuATW
 zxUZy30g7Iw7L9fycY45hq3bVtlNwWLXbevVuLlCE18J6ihCxip3BwXMHgDFAxCaiJISoMQFuiBmL
 RWyCmyRP6oQbOjJnPRcUNlHToMnQQvI5DiWUT22CXO1v8c+zJqaAuEvXm0klzmaNgsnc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFh1U-0006cr-Vv for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A2CDB4031D;
 Wed, 22 Apr 2026 23:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D5FC2BCAF;
 Wed, 22 Apr 2026 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776900619;
 bh=bctXXTPbBEuad4Pxq4bP9lSf9quyJ0lnmg+KuyXxPH0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=M3ZxNZDIeZhKMd2X9+NlQlR577y1NpSl01J2FVXN03pWa3CBeSLxdQ9DUQ6f9Y4sw
 UMi9BgF0IpRMZVW/toOsMY2defUR4VHWR/IwSqkSbcsgOInXbmIgUZ21m4cNNtUDjl
 5d/BI3BFEp9bkrt2MgaXMcBcYxUISQTZzr2+uktLrkBBJMoH+nonIuhGVud0I5PGiO
 2vHzgh6+UgAr9AGqq7KifwNOJ/wVnVdhvWwyMtRWaprSzYHu7oLhI6rcwkcpQTJwlr
 hHy4JgcZKsuFjGYBzXYFlQWYBsgcdhjrVpsY1MO/TWyFeTjOrMK6ReLmlmdF5Btz4x
 vlnYzNOMAxREw==
Date: Wed, 22 Apr 2026 19:29:55 -0400
MIME-Version: 1.0
Message-Id: <20260422-case-sensitivity-v9-1-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3501;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=tI06eoaKz9315rXjbGykMIxbiHJmdgGU8s/nGVMwtnA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoFA3fAjX74FSJ4imm2PqqdSRR23lY9hRXdR
 H8tIE2EgfqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 lzkGD/wPvBSeGWtLxCSOZNi/+/xYdOyxsFXcUJHyozmi+gSkQc7kE8CBS/h/E04hWxe+jumJLYc
 5isVzwGsG47c/YCSbsJ05QXTlXdbDIlnhdMrjD81dhtOGU49mWssVMdR+HNe7QMGgHTdeNteK8m
 8xLQ8DLGOJadTfo1vil0z4FVIVOKIcB3kGPmp7Ze0JWoFm9Fn/b6Zddy7/5nQSma+S2fgzGrVQA
 +u6SV5xXGdCIKOCOCQVdfHP3VqfO0JbrmMvOzOLC4ZvWw+h/roCoFoKbTuFib6uTayXf524jOFZ
 1+11lz9L7vEvbGretw87tWH+HTUTmnycdGW6xM0c12NzcE1DwZhBGwu5SVyJxDUpkfIAFkDUHbH
 7a73p6w0SaEv3lRaKc9aS4LDGg9Eih7ZDcO21+OA4/NdiQGvhY5gAlbVjJQpiiYydqu8AtkL6Xl
 i07wNoI598Q+erp8RLgYgO25xuOgohaMvzUzQ45UyS7xnIsRaQhWzyNEwfOGWDkaJUr2zzlX9ob
 zTta1H1PWaru8vK6xCNF6D9m9wHi7IJIPtC/VCqLt7On40mipe8SwaGlFAiDvHDD1n2tB/cLvoU
 usmAoioCylaoAj7jIXEVYcFvpWuDU8bnL7Co0DhUO9UXTLJEnktM9czBhSe+wXHAr0mf2SNBRSj
 8N1Ovw8vYuS5zVw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFh1U-0006cr-Vv
Subject: [f2fs-dev] [PATCH v9 01/17] fs: Move file_kattr initialization to
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
