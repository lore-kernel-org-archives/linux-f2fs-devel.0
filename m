Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56D1CD3423
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 May 2026 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y7iFWw6vHdic0LpphFRaEUKHjQYZbWVAzljM6v6QfFk=; b=Cl66UlNHhFBBA99WviZw6U1moQ
	hGRnGTGrxZDJe9RSYwCzADycRByA6HKCtJMTSjJlrC+aPUFJ9+FYhk4bb2+0anYzqVzv8VJzLKpAV
	mKhWlNs39KQtFuQRGDQJshH80CH8+13dYhxy8+NOTm+UIULqKlh1D8Chhh/bBPWPksOI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJBDt-0002hU-Bq;
	Sat, 02 May 2026 14:21:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wJBDr-0002hM-SI
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K/+nQA2Wh0su98+N815/azVsLyy2ptcHLEd74SX0hIw=; b=jQEytNusak9++wUOGPxhCIvIO/
 ltntsI+9BXe+GuFZAik+jnT27OGuFIObYSoONVsHY2KnsZNl+AwlJuKZRLLlCbUYBSDFO3oKSkuO9
 tL04ptSZ+/ceBY75zQcihrK98MKYS74rN2Wo7zisL6ahTWfKOes/S8/U3R2GvHnoR4oQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K/+nQA2Wh0su98+N815/azVsLyy2ptcHLEd74SX0hIw=; b=LtZADdNwy4LRWcoKnIw7aDLOxQ
 8G5j6shk8Dwj89YrwYAOi+vuZtKBDZDQh3K5fiYBixIlGhDPY0Tu26iZ1ubJnELA0lt7zDmnH0KlQ
 LW+blPkjfSE3Zu3Fl35lzbg8eb4pXcOQ7U/9V8GdEajwWI81bz/sehYhP43lN+FyZofs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wJBDr-0000s1-9H for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:21:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 02B4040F59;
 Sat,  2 May 2026 14:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B94C2BCB3;
 Sat,  2 May 2026 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777731689;
 bh=VR5IPc+tFJzycK0UcE5Jbwk0EDkpbGyJE15n77IJHGE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mF7HURzMVcc76AIdcJ4gN+EjOH3PvQ+JAuxCubIcHZ3DqTATPTmSOPz/jj0c5a8eD
 28ZXs+L6pe/biOR5DUyWkJHPJDw5dleKQ/IRG0xh1H5xyiuhhLw3v4NcwXJX/tNmPl
 slpIdOSJ4IBOx6SCzJ67PwcS8rkOVM4CDrlRuUhzIXbtan473DhGspkciBPe0VevA6
 Rp2ocOlWAHkGCdsO0j9rfVlgh+qZXcwWH5E8UI5KU1WwF5OW0XNdX1C6+y6HCJAWle
 4bcHP6g4kfp77H3pKtZwKEQurPLu3aTximYGPcgJm6eEg/e7hAw1UNnz826iFUl/eL
 q1+/gmUdmiL+A==
Date: Sat, 02 May 2026 10:20:48 -0400
MIME-Version: 1.0
Message-Id: <20260502-case-sensitivity-v13-3-aa853140311f@oracle.com>
References: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
In-Reply-To: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4362;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=9b+u/mWoEz9peMeExQH28HkC0yIPxzHosHi0xcms5fc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghQ1BYK25WvfFyqzaHIDtV9hFSfc8aMAu7+E
 /AjIghIsY2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUAAKCRAzarMzb2Z/
 l+sCEACEwFRDD4cEH+PMA/LESHjhccu/7sgZ/W4dO0ReHcgG6q8I3VlIBGNwySJb3aQT6tPBR2P
 3fEALKs5vj4BcjwnQ/T7wi6mwonrIzt3/H+9ZpBO4ICDfo4eylvEsjK07IBWs6+VZrJSZM50aPO
 LCpBxPaF/SjqIgV5o3ECVcsngrUolIDiKCFzdZQZ7RQhKwwL62FAkCtT/F4VZK0MlnxVbmeafts
 i9IBGfkvqLlctMiKC8hRY8VkgQHfePgcxnt5Ls/dSqBQIayK1VGzji8MNrHvBQzltvnpG3JX9Ng
 3d7SaNtBapC50AQ6O5E8D50xh3kD3/Q0Ug2WBke9rBQ1lujCwg+QLZrgBf8f9lGnCd1A5yuGuco
 kkWs7v7kK6Fkpptrz+W5oPDX5UZOv+sZY3trZiulaarYUDRjAnAU5eMnMZk4iD9avtCfSOu/t4M
 XDrmv8f9YTg829LpDEHZjaT7yjoax6U8UgWHZCuxo/Eh82T/uWHhqFBYmtnEpm8e5zzDlOYGVtV
 vLmTYoVy/zHK6VRD9YxUUgOMzcqBDdBwXp7Q/ftJiYg9aZoeOt+vX/FaauCtnkig073tY56kXP6
 eqxS31rR+BIHroVbUd7CHiXnToOhHWg25QOt1V9rfqvGyxziWOIrLyNKY8ExwBn9mYFIPwvAgNY
 9+K8ozD0F9oABqw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wJBDr-0000s1-9H
Subject: [f2fs-dev] [PATCH v13 03/15] fat: Implement fileattr_get for case
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
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/fat/fat.h         |  3 +++
 fs/fat/file.c        | 36 ++++++++++++++++++++++++++++++++++++
 fs/fat/namei_msdos.c |  1 +
 fs/fat/namei_vfat.c  |  1 +
 4 files changed, 41 insertions(+)

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
index becccdd2e501..37e7049b4c8c 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -17,6 +17,7 @@
 #include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/falloc.h>
+#include <linux/fileattr.h>
 #include "fat.h"
 
 static long fat_fallocate(struct file *file, int mode,
@@ -398,6 +399,40 @@ void fat_truncate_blocks(struct inode *inode, loff_t offset)
 	fat_flush_inodes(inode->i_sb, inode, NULL);
 }
 
+int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
+	bool case_sensitive;
+
+	/*
+	 * FAT filesystems are case-insensitive by default. VFAT
+	 * becomes case-sensitive when mounted with 'check=strict',
+	 * which installs vfat_dentry_ops. MSDOS has no such option;
+	 * its 'nocase' mount option selects case-sensitive matching.
+	 *
+	 * VFAT long filename entries preserve case. Without VFAT, only
+	 * uppercased 8.3 short names are stored. MSDOS with 'nocase'
+	 * also preserves case.
+	 */
+	if (sbi->options.isvfat)
+		case_sensitive = sbi->options.name_check == 's';
+	else
+		case_sensitive = sbi->options.nocase;
+
+	if (!case_sensitive) {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+		if (!sbi->options.isvfat)
+			fa->fsx_xflags |= FS_XFLAG_CASENONPRESERVING;
+	}
+	if (d_inode(dentry)->i_flags & S_IMMUTABLE) {
+		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
+		fa->flags |= FS_IMMUTABLE_FL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fat_fileattr_get);
+
 int fat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
@@ -575,5 +610,6 @@ EXPORT_SYMBOL_GPL(fat_setattr);
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
