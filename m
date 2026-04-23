Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4E9F589CD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Y/OWTCrNmUyu3YYuwZ+g38FhFTm/wcXwCB0xrvw4ns=; b=LXN3dqnEQ5J1r2y1bQzI7T8dL1
	e9LQbQj0XkmIquENfHTRF3SyxPT+i6+hjUdl3XmywlPHSNXT6GYrav0/9ykySGz9xrM7MtYUvJDHG
	VXzv12fHz8f6gmPkM83Rtood1Zb86RmD7Uhz2jRprDBRtHqlIIMfyNhdOG3DhNXtMqvs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFtrm-0003hw-06;
	Thu, 23 Apr 2026 13:13:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFtrj-0003hQ-UE
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:13:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZwHCXtKjVGI8PiFAlzBLx2xGCSvzyiUm64F3nXSzkTo=; b=YaJzAWe2mB3Awobdw2ChVJj6Sr
 dCnrYy4SUbKLVkY8O8I/1LzISCQQdijZ5HFZo0Hm+MygJeNGMeVEarlod3KkaMuiDKk5cK008Z1F1
 FvMm5Y4BdWCf/d3qYBF8pGmR4DKTe00vhi45Q95RckS0riiNh8tnViIUFqF0nwV9KmiE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZwHCXtKjVGI8PiFAlzBLx2xGCSvzyiUm64F3nXSzkTo=; b=NVqw7JfLeTUhfN9XXyMYynJfnl
 Hi4KnPNlxy/9hUhPmCACOjac6IBu7vxcEQDLcKW3uO77YblzuZ+ALnNxQwiMO2tAOcG0W6nqa82Mw
 nobhQNHehS8GScVf3xJZ5aL9+w98tv84M1uUTH1jT5OWSyZ+N4Ld0dU2KAL/odRhlPsg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFtrd-0006q6-5f for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:13:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 697A940AAE;
 Thu, 23 Apr 2026 13:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21458C2BCAF;
 Thu, 23 Apr 2026 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776949974;
 bh=xTnUJBzhUaJt7Dk+a5+/UM+0og4vgCLh8INVoPYiQlA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lPM16o/sNzHkzOjlOaPRa0y9RJbPLZbCTOyIH29KrrDYZ/n9y4s+YNT6KxLXg3kcz
 CD2SQyfWtBZdoEEjdvDT4mwGdNiXqojNcy5Z36UzgK2qNLa+OuXfTXR6YYCnvavPXr
 VrFfPWHlgpjjOqyuzRpE5Hm5sDFir+Nt41guOPmCqBTZQPM9q8iuNso1PeJPgDQsrY
 NMh3c6l9ffyAp8bspC+KOMRwYDuNs+IOcH4pRcJRqVX5a6EfUzuOfoNipDLMSrjwi6
 LCvAbmbr4O9KuwA2ItCJ0fuek1ZkRiHuBez4NHzT5p+2F7bh5KdPXlayM84UOI/Ztg
 r8uyN72BeVBPA==
Date: Thu, 23 Apr 2026 09:12:16 -0400
MIME-Version: 1.0
Message-Id: <20260423-case-sensitivity-v10-13-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4806;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=U3Tf1iN9l6gRsu2HPLJbtQm3eFhk1EJ4rfpa5UQrh+k=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq0JHFJUq25NmA3t1UhOZHaHx4uPK2myeQ2p
 rSy1x1GvLGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l60QD/9f3C8ut9/eTp+/vstUXouz8Ayy73cHBgh2xknNmM+PGTvcw6LY0kl0b4tYWdILo1HApMa
 za/G3ejAqZj/Bu8eE+UVGG7W3P2l0mUs9utKAlY5dAiJhvoFDNMZLaDwjyQoqjVM+eGrGz80QTO
 6z92dV8sidTSZDO/yuiVE+dGa3s/ARSnp0vQnT1rbnDbD7JNJHsco7OE27MB21m03yPWAsfX48D
 sKhJdNkjUfOBXqcjAze7V91l4+SSG9rLvrS8qEyTpUEUj0Lznpu7hbS8c1Vo4ffeKVG4msYKsEs
 7jmfumMaOg2mO/HcOf5Y5HELWh1aA2jWl56rDE/ln3KI5PgUqntAQYR+M2YsEM7XKCBZ83lBeHV
 ANuVRi998lV3YYrcc8I25V1sPngqIpehjoJ0q1a73gM7fUJ9uj7/hJAa3ugIsUu30K4kV3gHssL
 V6uUCwdVrVPr4BIxagij4HPvtlqglhP9iIRaHPeWui1x36FI+xWfrB8oAVxB9BwE5HyllpTjJSN
 A6bdV6/K9KLj//Cl1AqNRzopPWcM6BL+5Q3No7dX5ptCYSsJ5b68NcrclehuxY++2or2PRcrG+C
 xeVprW6fvA+ZJbGouiM0OjN+VcH8I8qnx4Q4MU3IGw/eMlmrZ4qbPQsWluNL0G1mVGFCsET5fhH
 Ie9aSV+InsDwPZw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFtrd-0006q6-5f
Subject: [f2fs-dev] [PATCH v10 13/17] vboxsf: Implement fileattr_get for
 case sensitivity
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

Upper layers such as NFSD need a way to query whether a
filesystem handles filenames in a case-sensitive manner. Report
VirtualBox shared folder case handling behavior via the
FS_XFLAG_CASEFOLD flag.

The case sensitivity property is queried from the VirtualBox host
service at mount time and cached in struct vboxsf_sbi. The host
determines case sensitivity based on the underlying host filesystem
(for example, Windows NTFS is case-insensitive while Linux ext4 is
case-sensitive).

VirtualBox shared folders always preserve filename case exactly
as provided by the guest. The host interface does not expose a
separate case-preserving property; leaving
FS_XFLAG_CASENONPRESERVING unset reports the POSIX-default
case-preserving behavior, which matches vboxsf semantics.

The callback is registered in all three inode_operations
structures (directory, file, and symlink) to ensure consistent
reporting across all inode types.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/vboxsf/dir.c    |  1 +
 fs/vboxsf/file.c   |  6 ++++--
 fs/vboxsf/super.c  |  7 +++++++
 fs/vboxsf/utils.c  | 28 ++++++++++++++++++++++++++++
 fs/vboxsf/vfsmod.h |  6 ++++++
 5 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 42bedc4ec7af..c5bd3271aa96 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -477,4 +477,5 @@ const struct inode_operations vboxsf_dir_iops = {
 	.symlink = vboxsf_dir_symlink,
 	.getattr = vboxsf_getattr,
 	.setattr = vboxsf_setattr,
+	.fileattr_get = vboxsf_fileattr_get,
 };
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 7a7a3fbb2651..943953867e18 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -222,7 +222,8 @@ const struct file_operations vboxsf_reg_fops = {
 
 const struct inode_operations vboxsf_reg_iops = {
 	.getattr = vboxsf_getattr,
-	.setattr = vboxsf_setattr
+	.setattr = vboxsf_setattr,
+	.fileattr_get = vboxsf_fileattr_get,
 };
 
 static int vboxsf_read_folio(struct file *file, struct folio *folio)
@@ -389,5 +390,6 @@ static const char *vboxsf_get_link(struct dentry *dentry, struct inode *inode,
 }
 
 const struct inode_operations vboxsf_lnk_iops = {
-	.get_link = vboxsf_get_link
+	.get_link = vboxsf_get_link,
+	.fileattr_get = vboxsf_fileattr_get,
 };
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index a618cb093e00..a61fbab51d37 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -185,6 +185,13 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto fail_unmap;
 
+	/*
+	 * A failed query leaves sbi->case_insensitive false, so the
+	 * mount defaults to reporting case-sensitive behavior. Do not
+	 * fail the mount over an advisory attribute.
+	 */
+	vboxsf_query_case_sensitive(sbi);
+
 	sb->s_magic = VBOXSF_SUPER_MAGIC;
 	sb->s_blocksize = 1024;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index 440e8c50629d..8655670061dc 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -11,6 +11,7 @@
 #include <linux/sizes.h>
 #include <linux/pagemap.h>
 #include <linux/vfs.h>
+#include <linux/fileattr.h>
 #include "vfsmod.h"
 
 struct inode *vboxsf_new_inode(struct super_block *sb)
@@ -567,3 +568,30 @@ int vboxsf_dir_read_all(struct vboxsf_sbi *sbi, struct vboxsf_dir_info *sf_d,
 
 	return err;
 }
+
+int vboxsf_query_case_sensitive(struct vboxsf_sbi *sbi)
+{
+	struct shfl_volinfo volinfo = {};
+	u32 buf_len;
+	int err;
+
+	buf_len = sizeof(volinfo);
+	err = vboxsf_fsinfo(sbi->root, 0, SHFL_INFO_GET | SHFL_INFO_VOLUME,
+			    &buf_len, &volinfo);
+	if (err)
+		return err;
+	if (buf_len < sizeof(volinfo))
+		return 0;
+
+	sbi->case_insensitive = !volinfo.properties.case_sensitive;
+	return 0;
+}
+
+int vboxsf_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct vboxsf_sbi *sbi = VBOXSF_SBI(dentry->d_sb);
+
+	if (sbi->case_insensitive)
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	return 0;
+}
diff --git a/fs/vboxsf/vfsmod.h b/fs/vboxsf/vfsmod.h
index 05973eb89d52..b61afd0ce842 100644
--- a/fs/vboxsf/vfsmod.h
+++ b/fs/vboxsf/vfsmod.h
@@ -47,6 +47,7 @@ struct vboxsf_sbi {
 	u32 next_generation;
 	u32 root;
 	int bdi_id;
+	bool case_insensitive;
 };
 
 /* per-inode information */
@@ -111,6 +112,11 @@ void vboxsf_dir_info_free(struct vboxsf_dir_info *p);
 int vboxsf_dir_read_all(struct vboxsf_sbi *sbi, struct vboxsf_dir_info *sf_d,
 			u64 handle);
 
+int vboxsf_query_case_sensitive(struct vboxsf_sbi *sbi);
+
+struct file_kattr;
+int vboxsf_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+
 /* from vboxsf_wrappers.c */
 int vboxsf_connect(void);
 void vboxsf_disconnect(void);

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
