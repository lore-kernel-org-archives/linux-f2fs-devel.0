Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8B6CCFA13
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QxQD3DgETqIaRR2ogSomTfUaNYXySYscdxvqq2fXTTI=; b=BNYNWgMezhBlRlSe6OmLg+RYmY
	bLeNC21rbOn9e4fS3sw80XmwIxv396ZmMr7eaBGhHpxLzB4xx6XUEvHjm4rWjmlG82gsG+I30/suX
	p/LliZ+X7Y6pbrDuYWHZdWTMtFot31V+06ftPtVgHLHOjkmhFBbjd7vdPXyhg5wFJ9rg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wI9KE-00083D-5A;
	Wed, 29 Apr 2026 18:07:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wI9KC-000832-8t
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 18:07:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZUBRZ3AHzcx/hOWcVir5DYYmz8m+45qoTT313fZl1W0=; b=ltRd+J/y+973sKt65bOodQS3RM
 xysvguKrjGagevvGE3iOQVQMRrSWa14GbYDPoYTO4vsutL7+BThlBPgEEjjmVoCG64hMwpnpiIW3C
 YvIJnJwNYABijPaNmoshdffuAlu9J2RtKynyvjfZ3Ukar6H0jEGCq8AzaLmHB7j7mbpY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZUBRZ3AHzcx/hOWcVir5DYYmz8m+45qoTT313fZl1W0=; b=UlfqUhAdBlEFNIV/yyd5KHPkUS
 pu+6CsMMOjU3sEGesabiFNXfOuSX8n3J48zaofhwvzxiwleKKeMNg5Ina05foe35j0mFnwmQdyF13
 zRPBoVUPn6JUY0MUmshvcSzvZCYeAZmkgIN/fvuWeaL0MGielqM0ggrKKLl6iRVnOuC4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wI9KB-00014R-N7 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 18:07:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2561761420;
 Wed, 29 Apr 2026 18:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB9FC2BCB8;
 Wed, 29 Apr 2026 18:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777486060;
 bh=Jr2vXTu8AWi0WLbHX7TZXwTWNGI+4Lcw2ajtKVSihdo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=H4hkcKdOtgVohFeEMBly9tiJ+Q7kHBTPSJQh23DNrozGwjpNTktT9vdstPEX5FgWC
 xJLDOUH5RtxNUSqSrXVwDrIWVN70zoNu/XtfCqNWb2UwB/9ywfCs4qCz3/mz6hp6NT
 7Z+yhT14jcEyqbCNPJh5CNKFtqmieeSWOQaZxIpi39uVF5LWQzrWwuypW0pNzScH83
 PuJcQRIICUbp8Gjr+BthDFODkLnWiHc0LMTNTJ19mFA5e+xQucZM7SEk25tyLZxLja
 2uNiNYF11rrGrto5PWGyIjohGyGs4cE/970/AIFWNhv8SkScTYEXYhYD2qOeFlsqQr
 8Ee02zFvzr6vw==
Date: Wed, 29 Apr 2026 14:07:16 -0400
MIME-Version: 1.0
Message-Id: <20260429-case-sensitivity-v12-5-8057123bebe0@oracle.com>
References: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
In-Reply-To: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3431;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=UmPMiHkroOwooAuYrGTrmJ1qLD7CrIqd1OwFLzWWmkc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8kjcdWJaf/Ss0k77ld+dZmJerGJikmCOeLDmS
 LXIqqAiSzOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJI3AAKCRAzarMzb2Z/
 l3vPD/9QjIf1La1fBNPrgqaxaDcBUitjem2nDH7tCSLtjBLhFLpBc6MlsFqrxIJ1AMrSeeHkZlK
 1+Lud/Db8G1zwPNyGNFGBFzT9iL1nq5IruAYeOgD+ER4QmZ1qiZPrC2ozm0AnLMsWwJWu9frM7L
 2DI3iAapDnlsfYI5w90UTlQjNFOAMAUu6tRaJnvDBX4wi6gtuw7bLoWcUDhmCauS7CvR7I/UrQ0
 HShoUYm7g8CHyhkRMmG8ES/eh2uqo1MUbVldlhxP2/gXE5CRPLjLLHL5m9LFcSlibOFvNeE1z0s
 eqsExEY2+XnPZL/Bz5V9vYzPmkNACW5R0ucV6Pc9O/jSvyfi0i32bvbThpBYlbzJkZCnCGGfjXC
 QXbdpo9pBLNc2F7jK5Pv/CaIMqtn0CjBD7pamsGss8KY32wjsbpnN+0SUw5Yn56h+T/mi4HW+Pw
 Yy42x7EIW546o4ZjLZB8xwaEyOm+OPtb443oHZSZeW+7/+bLB+kaS4idk7GhXSIbvBt0qgIse+0
 95K9wSuiQPRJkC22fDfNk6fnK2dD6ZVsmxMLGlSbIvglFWruSVGTs2lQPqfvQLmwN1Vb+HKkN55
 Qs1U3Z8N9ISZMm18ooGPhF3u56nqpLdaoxeoNXXlqqwvl8nVu82yX96I/5Ty8Jx5VsVAEvw4ry5
 nWN5WYvpuCOXzKQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wI9KB-00014R-N7
Subject: [f2fs-dev] [PATCH v12 05/15] ntfs3: Implement fileattr_get for case
 sensitivity
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
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

Report NTFS case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. NTFS always preserves case at rest.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ntfs3/file.c    | 29 +++++++++++++++++++++++++++++
 fs/ntfs3/inode.c   |  1 +
 fs/ntfs3/namei.c   |  2 ++
 fs/ntfs3/ntfs_fs.h |  1 +
 4 files changed, 33 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index b041639ab406..ad9350d7fc3f 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -180,6 +180,34 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 }
 #endif
 
+/*
+ * ntfs_fileattr_get - inode_operations::fileattr_get
+ */
+int ntfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
+
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ntfs_i(inode))))
+		return -EINVAL;
+
+	/*
+	 * NTFS preserves case (the default). Case sensitivity depends on
+	 * mount options: with "nocase", NTFS is case-insensitive;
+	 * otherwise it is case-sensitive.
+	 */
+	if (sbi->options->nocase) {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+	}
+	if (inode->i_flags & S_IMMUTABLE) {
+		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
+		fa->flags |= FS_IMMUTABLE_FL;
+	}
+	return 0;
+}
+
 /*
  * ntfs_getattr - inode_operations::getattr
  */
@@ -1547,6 +1575,7 @@ const struct inode_operations ntfs_file_inode_operations = {
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct file_operations ntfs_file_operations = {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 42af1abe17f8..a5ff04c2efd3 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2095,6 +2095,7 @@ const struct inode_operations ntfs_link_inode_operations = {
 	.get_link	= ntfs_get_link,
 	.setattr	= ntfs_setattr,
 	.listxattr	= ntfs_listxattr,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct address_space_operations ntfs_aops = {
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index b2af8f695e60..eb241d7796ba 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -518,6 +518,7 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct inode_operations ntfs_special_inode_operations = {
@@ -526,6 +527,7 @@ const struct inode_operations ntfs_special_inode_operations = {
 	.listxattr	= ntfs_listxattr,
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct dentry_operations ntfs_dentry_ops = {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index bbf3b6a1dcbe..41db22d652c4 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -529,6 +529,7 @@ bool dir_is_empty(struct inode *dir);
 extern const struct file_operations ntfs_dir_operations;
 
 /* Globals from file.c */
+int ntfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
 int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
