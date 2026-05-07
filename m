Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BC8CD3442
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 May 2026 08:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ywWlCKs1XnMmZkXGmKPgpG4gQqkGrLrLPalsXywUC5o=; b=K5MeY4Gw5VYUpq/Ho3mGYbwDfO
	07Pl8Dqechx9Mc89ExLhwhJrvwXDf07pl7sG0PuSdTeNJ3CWDI6a3HCqF6Rb5KpYtsm6WZEFGO4mC
	0vpQCs5HvaMgL7i80aJamwHXW1uiGWGtH0uVbfjlLI/4u2tJQt8mqQL7ZWPqbiGTisCI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wKuUi-0005jl-CX;
	Thu, 07 May 2026 08:54:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wKuUg-0005jd-Ru
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 08:54:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UywzuY1AUphAg7H4Zg3bBPIz+83ahi/5Z4qRp8DG+Wo=; b=IulRCZsSbOvaOfxlFSt1gx6SqG
 YBXoUP2kgBGBIiL0TBrAdmnY3pJXIsoNFa+XeVUftRELFyuuGWQuOQfzVfuEQXiRYITvO+MK53NQE
 FxqONYiAbcIbEp8VFxLAtVWPSI+y+3lew6LsDIKQwofvDD9VJGC1liASb3FzIQ5bXnIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UywzuY1AUphAg7H4Zg3bBPIz+83ahi/5Z4qRp8DG+Wo=; b=dpsBFxasLWWW50YxnQv4HehxCW
 tjLe9EEHvd9ubOeQhJudcv0yo3532MB2m5e9pnl7G9zznzLg7KU1Q/8v8k4G/FbHqccNZuZQxBBZI
 eyHmxCTV5iCqMvHo+wfqvmt40GtrCNj5e06Lx7F3cRMvgFxVMY3ZZprQgR377kpjUbJM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wKuUf-0002AN-Ca for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 08:54:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E64A4036C;
 Thu,  7 May 2026 08:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5A2C2BCB2;
 Thu,  7 May 2026 08:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778144040;
 bh=CpkP5qXoychwgQhX7e5UaD0uZEj/2vnARHn3ZWzY3lE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mdgAia4VjXayPTDEocoKQ5NFbkqPGipGQV03bbMQQShP43/KoaXumCHe4egRLVeGN
 eEXgrPNHpoBmYNEnazpFH4EJVqFPnHSFJoIuyG4BasSqyXflwBiSiz183urtPZ/aSH
 4Ydvq83P4EkoSlToNMhAr+O4JxihtQrNZMvyznTIteBkW9lA8KBGhZrglyyNhUjK2P
 t3h2t3fe6cgheS96KMbVbq4Eh8b4LEInjnRwVYiE4KpXBUAw28jAPw0Vc25iO5oNh5
 3hEvGharzmYjTSpGIDUO9HbZRW+76Xq/cssp+UWeSkb24ugB2FicDtFOOfY0pWtcvc
 hJ0JUl9IWSoUg==
Date: Thu, 07 May 2026 04:52:58 -0400
MIME-Version: 1.0
Message-Id: <20260507-case-sensitivity-v14-5-e62cc8200435@oracle.com>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=L0NeySD9QaaPp35s1Dug6uu6ElkMQLL1BoFsiPZmIBE=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp/FL13DJRT6JTajZnDiuUp7aIst6+o4YGoXcYV
 unAdfCmXpaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafxS9QAKCRAzarMzb2Z/
 l0lPEACeBg0D/yuuSIDAEl/vYv/EEPCmU0v+ilcE7+SBZIDJHaPnMpOHcq2VcriDEoGLeDrFBA1
 M5OdlF+qfCDnUt/ZGOBj4CEvGmEvg5rID+7oi5Z3S36u9TunsuyBCR1BeeSpfsr/EZwHO/cDvlz
 wrkw+ABiNWokGIIUVHE1ICZk8oYZtMWrFZ6Q2N34kuZvYuj9pnRmkZqhfLFuEE1VLWHyELIc5E1
 pea8oDHkxAdWpv/439mA611MaiBAhAB0qkDAIFLYX3L3llGvGDi3ZYUeRu61BQ5XSUngAdTHLPF
 wOphbl3YHVLVxZwARMlKD5+Yv7PQpScwFc6bMShhrYD4ka8SidtqTkpWycgtE1GnDwh1EIY4qk/
 zeemz+0yGHpx3Bm5KKRgLfYJaOKYX+RWSQAH4CpsKyfBTgBR198rwy7X4E6eOJnnMAa+CS97zX2
 /4BaxOleA2VZeMUaPjSpb3j6jmbrGA9nLi5UYhNEUJ9bzEPXPJhgYcYxKOi3Ubj2TDhrpUUNUzo
 Kx3KEoMrW5S4yWtMMLAFTqNyVrNRnOZxmfrN/hfjhwQAFMJrJsEM4jd8ZsXsFvNszxtH9I1Z5c1
 Dj4qXXm5zAuwZiW6LXoCTuBOnI8Z8Xc3geTj74ipQoWDhqGh47IyJAABNiuXT55GGeq0DC8ytSj
 UYQzN1kC5Vd9HoQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wKuUf-0002AN-Ca
Subject: [f2fs-dev] [PATCH v14 05/15] ntfs3: Implement fileattr_get for case
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
 fs/ntfs3/namei.c   |  1 +
 fs/ntfs3/ntfs_fs.h |  1 +
 3 files changed, 31 insertions(+)

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
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index b2af8f695e60..e159ba66a34a 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -518,6 +518,7 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct inode_operations ntfs_special_inode_operations = {
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
