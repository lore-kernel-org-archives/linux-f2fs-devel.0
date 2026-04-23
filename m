Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3438DF589CD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tHk/07S0EDtPW+G7+sfNW1NO4h01oOXmClne5kYwb6A=; b=SaWDeZUAnN7vCBOvtg06+V7JA8
	Ga0gx+TzCxVqCf08WXKnQgldjgkOiZGTead5idQMsw6XDIaVaDkdXWXFs/IDb9HU922MTseyueNOM
	NJrSd623ADApAd3D9P4ffb3/pQaO9l02PfjK/dohISwR9LoTzRmLobAuCRl1nyM7vTd0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFtrP-0005Jd-K4;
	Thu, 23 Apr 2026 13:12:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFtrO-0005JT-1S
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:12:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RjA4t1lHiEXPEev8/EJ0E1T05ue8WWlalE26yN3F84k=; b=TdDT1xi4if0c3YpxAN0KmjSkDA
 yPaesS6AALWOC1ytNqAmEy5i7250qXcriIKA6SsQFG9909yrwuy+octNHLuYH3A4UjmHay5Qr8IO/
 BL1DxWl87FlCwd+gVqIUEhHUmc7FFrEUoc/S1e8HK9WLmcCAeAv8DNFtlw7UYHc157KM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RjA4t1lHiEXPEev8/EJ0E1T05ue8WWlalE26yN3F84k=; b=eCsyLmKJ9USEWbjjTezGyyqZHo
 8kbFX+NqyeMZdKH3x8ioMYLInfOiQV4hv5tg5JeI5zPj05+S/iiJT1NT1rcHRn8Oh4ycagIbQ3rbk
 cEiyTlb0RW8GMd/lmtKZP/n7i3tnOFbzN9rCWAKv8SfMm2I5TSRj8I+f2JzbLoXRV/Hs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFtrK-0006oP-63 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:12:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 80D9C60181;
 Thu, 23 Apr 2026 13:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ACAC2BCB4;
 Thu, 23 Apr 2026 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776949955;
 bh=uXDyD+EwjECxSZf0mUntOuY7XcXST0vj1dof/taqFWQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JrpRvRZntlzmSt9ocwtUhG6ddWZYDRjHd3wHgujHOMI9U+AYhPisLM30AAtQOLlQe
 01Gd53D7Q2vV9Tlsf8KbLhukDQ5hgQYYOpvuq1dTVpn98qVCcMFZjP6zWh9T6RmOwm
 Q4J5y/KnxbQrB55wwDsee3/b7gsbkSNjakEee+EF832pC8iCotKy5yM1V3jXf0Hmci
 YPfnl/mmb+3P6krg8qFiojfja3mKm573/WirWY5axwhFtXAJoxqHklWs9N3mNaoLzO
 aDR/XD/+lyu/LX6JiNaoqZTKOdgpjX5DEG9QZvF8LI5U3eLFapcJPiBWMh405SKV6O
 vB1BHojFWdvbg==
Date: Thu, 23 Apr 2026 09:12:08 -0400
MIME-Version: 1.0
Message-Id: <20260423-case-sensitivity-v10-5-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=TP8XZKgmTAxM/QUA73jikSOpFVJB/k8sBiRSJXDKGtA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hqzW2r9DI2tTyUqjzcjwCpAxGOG+xohzyr4R
 dvViUQRyjiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoaswAKCRAzarMzb2Z/
 l4lWD/92UiZReSXXnnUPKjJmt1G4ZpWEncOQ6tZt0cCjJtDe8G6HC7Ymp5d7309jhHESdw2+Ql9
 hmp5c5DBfW72+LbAklR4Cawp9cGUD2ZfV6+gafPxQiq5nDMCDEPDC31pZxzycBAu1hECkD13Mek
 VKS9Q7ItH0o62WvApgRwqNo3dCv4K1cxI1lPBOv3k0yEe4tuHj0/WvZv+6zsZErGj6QJwVp5cEr
 fAzIhEJhBBzUm/Dd85zcYTRfJmqq4mg5+uRxl79jBXtmYvTP/gsYnB9jnIkKSMHIcg2x9Zo0ENL
 KWmrsj4UHG4m9OwNzj3AR97JH7KTsEHwO684d+eL+kgc7U09eo1MH3DjA6W2Oqo0UmIzNwmemFn
 UPR12UzycdjzphFEetoAb4Kgcd4WnBp9F9znLQgF1N8Nc2JQBoXIhUOU6Z/pCbqvzx0cBy99GuA
 f6eH1dp+pHhjxUEGq2wpsXv8J2lWcJNXdX6WrEGjsy5+SGO+iJCK5uBUqbNJTsnIBUxnYERA1Ww
 oMaxHM4H0mcU5rJ5lk8u8cFX8AnrYhnWxyvzpodJax6nUvjtCMtFghxVclEdLXJcHD5KflWHlxD
 l6scL4KOO0s0EIcxLPT8W0cjAY0hLtqH+4LUUdAAkm/EWeH/hdY3fvfCowy0gHjHmMNxC4mz7Og
 W+xGMMk+5zhUy7w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFtrK-0006oP-63
Subject: [f2fs-dev] [PATCH v10 05/17] ntfs3: Implement fileattr_get for case
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
