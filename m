Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EF7FAD3E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GXxgFPVIUJn1NwuMkzJqcGzdVlSATcASOgQ+44aonM4=; b=fvwt6qo2la8tZwXiTTi5JVuPmb
	HoH7/LSByfAsmCWQ+G0PLu7LQkAqWgd2xlxin04Ha5CdzhnjQjQKtR+Oy5XWC7thijJZ5L4XAnDyO
	XWDMurCJxw2Rxx3GLG1UTl39H3r3EDE2auV9OHQxqCkLKnMmR7Qq1zrZgz28v0vgix/E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFh1b-00047X-Sk;
	Wed, 22 Apr 2026 23:30:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFh1b-00047R-1h
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4v9wqjMqYdgaddeZ/JwwYGx8kxeDhvSp9zNQUxYq2fc=; b=giITIaMGvJNJJPvkNAQPcdMqLH
 y5Q2M8r+daSSAy0YiE3EgdqcsSuf6ZnJuJ5wCo71Sgce9Jd//bp7BK4Lfuofwxlx4DbMkWfBeu8tA
 hM+tNIqxpZjo4C7Tyn/Xsr/b7txiri3XqZqvlO+Ub7aYtqluCUpM7eLDmgutWBe37NSI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4v9wqjMqYdgaddeZ/JwwYGx8kxeDhvSp9zNQUxYq2fc=; b=midZMa4EweE6iSoKocvsWRxthr
 Vr0mxYeUORhEtdnwq7Px6wy3N+9sQhDAELgu7C4o6opa9XeAtMJetB4TtAGYIFimoMvfF1laYsx04
 wtyMdGCA5rboGLB5kSJmpCNEz9BobZ4Id9O+8xam98KlfL+OcYnGhJNfDZcPK+61lAcs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFh1a-0006cz-Cp for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DE2461868;
 Wed, 22 Apr 2026 23:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6FDC2BCAF;
 Wed, 22 Apr 2026 23:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776900624;
 bh=GBRThfl8AJdjIQY1hCpFaRdtjODXMDI8+pFJwoD6QKg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=k4tE+CtTCy91lH1KLjuk7dfQpj6x+CJYPTK6VM3JdAzb2vo+y/AHucgF/7TO2nrwC
 PFIqQSVrVcPTzjKI0WXiEgAudH1Ls3taP7YsEaruiOD+gHa7QWmZQA4VwVMSbyTv3e
 dgalGd0/+90yVhyns0efRHSGZyQYaxn4mwDEpL2MQHNUcAw1QHtnkBfSb881RrXNc5
 G8R7n8EYvehqtnQ7Ppn6B0zTLVs8HyS81fb7UwyBiUZfcCoO2sm+5VtczdxqG57B2/
 N19U3BqnNXvgq8/O5TI4SpgsFJsRlXhST7xmb4rH/iP3AsLZJg3JMRRX1rvG2t83Le
 9YdrQYSLHOQwQ==
Date: Wed, 22 Apr 2026 19:29:57 -0400
MIME-Version: 1.0
Message-Id: <20260422-case-sensitivity-v9-3-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3856;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=z0G26qNOK5JhmRz9M45By4F6NKvq8eKa6ZlbA0umD2I=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoFLiiW56L89RUwmlQ1soliZZq/DIsmpLKff
 +1C1pI+Xv2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 lxikD/4hV6I9M/Jf/EZpJ7Rimh/r1H4+EuXqE0e13+FCtxToJagCMUfLVT5Tu6XJiukLE+qRVON
 PJ0TnIaJb5uH7KoYv7lIDR48gJHnByI2naajmjIyPpWn9sFrjAZbsqxN0NGX8YEIyaINMuLgO6M
 hvLO6BPGo1OSYLCOkE03yLxwcZYA0Yq/FEwzpME1YidTJI3SeRaDaqoVT4wR8ljZUR586OurMc3
 TNAi/vUqyl5buBLS2PoSzCYld0vmZ041CnswPJs+QeiaStllhlpyAbfksawWItng9NuxHMj5+Af
 8CJ4OssG9/xdvKZmtTVWRr4U74BBqIsy78plQOwEPkdZKQc/Ky5Hai20Zlr8WyPYnvxi/O6GDUm
 hwtK7kLW87zDFT29P5h0M1aO719mSkbZKqpJsi8eRdM6v1USMzl0YJEEmb0Z6ztI+eTj05lwszc
 mXlbcs4cmLhg50qy+ipQBcJ5JCqca/WoTBqIADQ3tNTfBYTiAF9RWDiV5NeOgp7WlmfuYAplZXl
 oa1RcobsoKkMfP0I2UwNP2mXM8rm1bSad+oGyjIuNDXQ1GTDHGR5XnQXXNva7wpGv1eqrjk2efY
 94ziO6VTPWSjlE6jhCHO81/8RkRx7cLM1U155965kwZSO/qP1nIijYP3NLwcfs4cEwyDsaaYZsG
 PsSVmFmotp0IkIg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFh1a-0006cz-Cp
Subject: [f2fs-dev] [PATCH v9 03/17] fat: Implement fileattr_get for case
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

Report FAT's case sensitivity behavior via the FS_XFLAG_CASEFOLD
and FS_XFLAG_CASENONPRESERVING flags. FAT filesystems are
case-insensitive by default.

MSDOS supports a 'nocase' mount option that enables case-sensitive
behavior; check this option when reporting case sensitivity.

VFAT long filename entries preserve case; without VFAT, only
uppercased 8.3 short names are stored. MSDOS with 'nocase' also
preserves case since the name-formatting code skips upcasing when
'nocase' is set. Check both options when reporting case preservation.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/fat/fat.h         |  3 +++
 fs/fat/file.c        | 23 +++++++++++++++++++++++
 fs/fat/namei_msdos.c |  1 +
 fs/fat/namei_vfat.c  |  1 +
 4 files changed, 28 insertions(+)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 5a58f0bf8ce8..99ed9228a677 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -10,6 +10,8 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 
+struct file_kattr;
+
 /*
  * vfat shortname flags
  */
@@ -408,6 +410,7 @@ extern void fat_truncate_blocks(struct inode *inode, loff_t offset);
 extern int fat_getattr(struct mnt_idmap *idmap,
 		       const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int flags);
+int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 extern int fat_file_fsync(struct file *file, loff_t start, loff_t end,
 			  int datasync);
 
diff --git a/fs/fat/file.c b/fs/fat/file.c
index becccdd2e501..34d8588fcd3f 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -17,6 +17,7 @@
 #include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/falloc.h>
+#include <linux/fileattr.h>
 #include "fat.h"
 
 static long fat_fallocate(struct file *file, int mode,
@@ -398,6 +399,27 @@ void fat_truncate_blocks(struct inode *inode, loff_t offset)
 	fat_flush_inodes(inode->i_sb, inode, NULL);
 }
 
+int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
+
+	/*
+	 * FAT filesystems are case-insensitive by default. MSDOS
+	 * supports a 'nocase' mount option for case-sensitive behavior.
+	 *
+	 * VFAT long filename entries preserve case. Without VFAT, only
+	 * uppercased 8.3 short names are stored. MSDOS with 'nocase'
+	 * also preserves case.
+	 */
+	if (!sbi->options.nocase) {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		if (!sbi->options.isvfat)
+			fa->fsx_xflags |= FS_XFLAG_CASENONPRESERVING;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fat_fileattr_get);
+
 int fat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
@@ -575,5 +597,6 @@ EXPORT_SYMBOL_GPL(fat_setattr);
 const struct inode_operations fat_file_inode_operations = {
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
+	.fileattr_get	= fat_fileattr_get,
 	.update_time	= fat_update_time,
 };
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 4cc65f330fb7..0fd2971ad4b1 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -644,6 +644,7 @@ static const struct inode_operations msdos_dir_inode_operations = {
 	.rename		= msdos_rename,
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
+	.fileattr_get	= fat_fileattr_get,
 	.update_time	= fat_update_time,
 };
 
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 918b3756674c..e909447873e3 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1185,6 +1185,7 @@ static const struct inode_operations vfat_dir_inode_operations = {
 	.rename		= vfat_rename2,
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
+	.fileattr_get	= fat_fileattr_get,
 	.update_time	= fat_update_time,
 };
 

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
