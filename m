Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E41FF885A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Apr 2026 01:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O8sJzuUoLz/fWa8eYWCexky63J+JLZ1vAXNNzjNtyac=; b=HGwojofrgq62nGnGWTxyNLSDKk
	fqm5jqD9GTwEMTZ8aoUiLChMiru1xF9NkxFHqmYy4wLGvkjq7UxS/aPxpl9+cWxPy5DSJooicYtMc
	2lKOGuCRNP3itHTgaXgSd7aIxSDTJW8RuXzOiOFBBPiqA2tTZEAlpEB7qvU8usfqWxTs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wGSDN-000198-IK;
	Sat, 25 Apr 2026 01:53:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wGSDL-000192-MP
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Apr 2026 01:53:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HuErOA4O997tOmmpDEc8uiQ76qd6tgShuzi8zme5nbw=; b=dylReZgEaiAP3XVRBIh3LnyM2G
 1+f5DUGNu6mSMGrfffpz1okjsoyAnYl6GcM8Mn1LyPY5+P96BTpaX/gWcarM16RIwGMqzRxpFHrOS
 Bqaex3qEqWBI8lvlGGQ9fZE8v5KdUzq7gxwH5U3/VH2QClXuIG6jxIIaOS2Lsl1tB0cc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HuErOA4O997tOmmpDEc8uiQ76qd6tgShuzi8zme5nbw=; b=IEgHCtod9wixSKHkFaElXY1c30
 qKEtdxp+Y4yxJi9KuSTq12+RpgV/wcMla6EwCualwFRb4qvvG6aNK3I6M2kQCIT/6DsiFJWJqRoKu
 R3lYWfINrSlhAcUiDF4JkiAGl1ntf2VtZhmswPP/gYhrV5Gxh5J3A+/GXbY/dvV4HyPM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wGSDL-00030c-33 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Apr 2026 01:53:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 80C3760052;
 Sat, 25 Apr 2026 01:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002FEC2BCB2;
 Sat, 25 Apr 2026 01:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777082016;
 bh=0ZgfzLmgsh6e0l/cgy9Aq0IcvErUYWyzdo9BjjxntFE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=UBs5CqZk9XmHH+jgnzvUHWwrjxpWzmgBWd233DJnIteiFNVgF5sdQ3cWc/IMLCZGN
 sgbPO7lQQftktNrs5nH2ccx7tJ1wW42rD0ntCCTww854954wi9QhyVq8wnLagXZXlT
 wvS/Pe9Mcx4l3TlTPCA1MlcXBMRC3LClIV1zkb4ehj9hDXqppBL9GcU7BjijAwUc3b
 4CZTkDlLetCbFjNTj2wBJF903piUjaVjPwQcPMtvLms4Zg2PC/c3QaAoEzEj4QsJn6
 D+NH1wQNf9G7eCbuvBOh6oqw4mdRqSYdRbJLGWmUcqNs8bNYIeuWlUCCgi5rC8yPtM
 qpm12Q/e3Wwjw==
Date: Fri, 24 Apr 2026 21:53:07 -0400
MIME-Version: 1.0
Message-Id: <20260424-case-sensitivity-v11-5-de5619beddaf@oracle.com>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
In-Reply-To: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3307;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=the5hfrb+NDfAlxqcoZBavzUZ+JgwGcn+44RCBEP0nA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6QyVflZ8+aiiVlNbBUCfNUyu6AJiwcinI9A
 Y3kemH1MfeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekAAKCRAzarMzb2Z/
 l/DLD/9HvrJZgrlELaA9rMcCLaKNI+B6L6bhlkPmhjbLhUEmS+AQ4OcaPliMGmAB0AOiqZDAYhX
 hp1us4Ye+CBbz/O640iIQoUTlVgWwh4Gc0r2xox7g6OAkZ8Y3KliS+8q3RGDJ8xrMGM5Cth3XYK
 Yc4qRzxPlFlVD835duE0tCqQrccEpPkeTkJLcjixk1oZFYH07yzm3g+hRoS660B7DMjHx8UUGbT
 xfJujr4TKVOC9sIwcdVgHjMkdOL+OIupMCZAAV7YKe1x5QdtJir8BOXDbQV0sOA/nsbmGaRuPri
 UusmK9pPm4fIDh2hLZJVxU5G4gcYZhKq4on8CvuALeuNybu2no0SBiXn6yb1bPaNxjfFOzE+qnc
 cTXb/k5ZZd7In5lJnY3Eqd6gFH1Q7lMwESttYNfFk2zR6Y7IOVrWwdVVY0S8V3GIbkWUyxQVsB5
 v8nO2aFd41BIQKodyOTAy/K1kZgNYcYoh/isImgVihrSSp8bacOILRzIis9lp7sbad3ndgHcf3M
 oCd6Dyfua1voL+lGbdMUF2ojOn+UNiovHxHXWqnA16VappNdb37VlzGyWkWnitjOc3jkdodM7Ki
 Bj7TzOSWvkX3yYrHp3xIcabfI7Q5lra00YwRJs6ajG1YvHvH12viJamZWFlCDN8FTQREsinpNND
 +BFfUs9c7NLNrrA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wGSDL-00030c-33
Subject: [f2fs-dev] [PATCH v11 05/15] ntfs3: Implement fileattr_get for case
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
 fs/ntfs3/file.c    | 25 +++++++++++++++++++++++++
 fs/ntfs3/inode.c   |  1 +
 fs/ntfs3/namei.c   |  2 ++
 fs/ntfs3/ntfs_fs.h |  1 +
 4 files changed, 29 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index b041639ab406..447ea0f9b9d5 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -180,6 +180,30 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg)
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
+	return 0;
+}
+
 /*
  * ntfs_getattr - inode_operations::getattr
  */
@@ -1547,6 +1571,7 @@ const struct inode_operations ntfs_file_inode_operations = {
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
