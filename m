Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723C6FAD3E2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tHk/07S0EDtPW+G7+sfNW1NO4h01oOXmClne5kYwb6A=; b=mzvO2jxwla+L8wk3iinuxSpgZe
	GO9YOwbzeS4YblsJvoOj2UxDWRzDwVmXEOqxwpSC1RzkM1MNPOVDgz2PyFrwtmVz1a+GXvbgcDiGf
	6pPWU2zfqJS7EV4CSASWax33AEOWFBvXmrKDln0Yt/KCGU1f/Q2VHb/yAyTMOV12qNrk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFh1l-000189-5G;
	Wed, 22 Apr 2026 23:30:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFh1k-000182-6K
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RjA4t1lHiEXPEev8/EJ0E1T05ue8WWlalE26yN3F84k=; b=Tt3qGL1c01bJULr5S/aV4K/T/w
 4okFE3/CYBN3q1Rt377Txj535VW7UEYrLZD3oL1QPFmqgUTV5SI0TsylhYEZTSByKEc6cyK7ppvOt
 cK0kQ2AxFuswpujZ5sfY7yk2bYHq3bFcrcv/tmyfu5lpaPkeJAEKaGclohrfAP2vvnrQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RjA4t1lHiEXPEev8/EJ0E1T05ue8WWlalE26yN3F84k=; b=cuIzkYbRB1Q1MrZSgtnA6Tgq1A
 BFoqRo1WBb/+9jpBYV+bxMJ/kwIEJ4h9JMRTYmCrG5jNtumOr6dwj9rbAMux4yH7YNDrf/7Pm5lFo
 ex+VkQ2LZ/AB52yOPkQQv09/k2s5Ri5Cird/TC7iDGFFAqLUuyfR/XsziG3xPToZ6lU0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFh1j-0006di-H6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BAF842A54;
 Wed, 22 Apr 2026 23:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FD5C2BCB6;
 Wed, 22 Apr 2026 23:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776900629;
 bh=uXDyD+EwjECxSZf0mUntOuY7XcXST0vj1dof/taqFWQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=TfZ2ZURiQDjM9jIhw2PX5LXyihmkQrEF5J1XlyfHeDUZ6P/64RtmHifZk6bN89ST6
 9rJFkc0sUEYRcrGQWxq7e6SJO7B028PBh+ZqFnGJTIvH5m4dGUO/P9vlXGMjVd/MXC
 TeUfdFTvsUJ3vHXf8HeBREc+90qA8nU2vqk18YGB0af1koVDg2AAqhcdXwgoNlbjxK
 f4Dqk6NDvzo2IcZkNdjbF2aD2nfJ+hrJLgKEPehm0dFPCVTbh9cmr3iH24f727gE/t
 uQExxl40mTqZRppiahA+Mjla5y9vutYxg9F+g6GExP0pBKwwylA3oJpuS7dricvbWs
 Bssrjg1Gu5tUw==
Date: Wed, 22 Apr 2026 19:29:59 -0400
MIME-Version: 1.0
Message-Id: <20260422-case-sensitivity-v9-5-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=TP8XZKgmTAxM/QUA73jikSOpFVJB/k8sBiRSJXDKGtA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoF54td2uxTYw9UHbUy9URChJW7i55Pb0Wpv
 R3sQhyegaKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 l5/7D/9F9AL04x9XuT2y2wyuPieesYRkavfa/vcDiOeC1gwg9Sh3F7OabChty8t5hsgf8xpL/zN
 KzI5qD27wQgBA4c/zOcyb4d0/AIBeILDnAFeWY8IrPfdsq/tVcuDB3HRxb6sc2TOf+xlLjY3zgm
 9bJ4DtlcJW9UlvzPz9qA9n8cYSzfAbkiBBeQJ3QEB5rRnIjbwrKywPWmmb1jlNcHmnn2Lv71qFu
 rkYL/qPQ37z38s+HpCzvrqksJEVSdSawJRZk4SuMoLSADwQjL97whNOyrRdCJSUhpWOz/o744Bv
 bLsQcg5D53nUl5E5QUCL0y/dyyg8GqIynrq9XWTzvZhojKj/ahkONOL4YAdGg3aOrlYBt3aIw0X
 FcEQnZm8zwFlUaRXtgi5p9MwXvzn25D0y2y+ltllnJ4rnh6d9VGIBvgYzbRbRpy41BenSp/99N7
 gXFgYbuhhkbeL4cioFNW2+Ia0tPMFcJMsx1F2SBslUTm1YBkoo8QydjNaHsKGhEdENKptSMmrqS
 82vqKa4OEgl1dL9CovJEgEv/qgkgRcCDrHxIIAvAiFpl8mJUp/PKQwWNWjXxnR1yrGnWLPleNOH
 hhdgWrfSU1al7RS5D3rfdzMK/5DxQ95JySEkUHuZIcHmVpA6Id7hGcEHABUsnXInJ4Wkt3x2pDc
 uTN9G/qgLV/vpzA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFh1j-0006di-H6
Subject: [f2fs-dev] [PATCH v9 05/17] ntfs3: Implement fileattr_get for case
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ntfs3/file.c    | 23 +++++++++++++++++++++++
 fs/ntfs3/inode.c   |  1 +
 fs/ntfs3/namei.c   |  2 ++
 fs/ntfs3/ntfs_fs.h |  1 +
 4 files changed, 27 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index b041639ab406..bb3b3a89204d 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -180,6 +180,28 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg)
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
+	if (sbi->options->nocase)
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	return 0;
+}
+
 /*
  * ntfs_getattr - inode_operations::getattr
  */
@@ -1547,6 +1569,7 @@ const struct inode_operations ntfs_file_inode_operations = {
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
