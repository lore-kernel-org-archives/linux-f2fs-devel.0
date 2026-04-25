Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B67FF885A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Apr 2026 01:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bZmWIfdVLFayDd8JBcJKxv3wt1SkZdDEeZ2BPPq20/c=; b=NEnSd0CrI3R0HbYMyHZeBrEE3Q
	Jyq0RW2hw8yIuIUpilu2gk4sfVIvg8kARj5B10aYuvxdzhMtKoPTIpH49UyEA8AST71dR7QSm6jCr
	kb4czzamkq6HMEcXaEbmR0AOnqNR8QN3F3y/vj8i3uOF1EndgquCE97ooZdQ1ELscXGQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wGSDK-0003Ur-El;
	Sat, 25 Apr 2026 01:53:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wGSDJ-0003Uj-BB
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Apr 2026 01:53:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u3GssT042DH81kfkitTV42dcmSLgashYqmassQheKWg=; b=a2qdunAbMZPpxS9Zs9VapovvAM
 lvTrna16xa+s2YaFoArV/A/ULhJNaQzFYi/TKP8On2r+Cl7dbj4msLowAGGZnBBdgM42wYpdu+QOg
 uzSCq+Cl/bHjHHxTPVS/nABOV4UYiXuZ7bQHB3OqQZvkTgFsCZY+O1EUnrhQaQitz1Tc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u3GssT042DH81kfkitTV42dcmSLgashYqmassQheKWg=; b=jTBCTUsZUpw2fXTmNrutHYqLT9
 vpEm9BLD1xtJfj74z90LAIYH6lM9lagty9k09ZG7pGX1KabdTU1pGI5fkbzZ42C6LC5JaxJ7ViS/E
 lccooLdql0qOClBm2Hmgm0U6AVW/NjKoYppFnIsLwvMRWfPgKCCiXyOSF3x22WUYAqq4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wGSDI-00030N-O8 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Apr 2026 01:53:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1516660132;
 Sat, 25 Apr 2026 01:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8034EC2BCB9;
 Sat, 25 Apr 2026 01:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777082013;
 bh=wqnEoHXABCWnB4qIWNaXjQlMxqtzft0aZTt1jlyUTc4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fozMK6S9eYLfaRO1+ETFl93gEvxMEK3W3hWvSjoJE/6PwL7erxD1UgMB71Hkw/W2J
 rCZKAK38ItJTKA6p3Q43icJu+6uD5WQAYVa96GULbu/NabHBAAQfGtFWmS47rDotPq
 Ld1Xw8SnG0S31/uhfm5XCM6Plg08lXZfy+wkaQIX/jVgQ5yFDLchZxAgozuzSRtYEx
 ttJs+7NZCh6PDCa5gw0Vk+n5v42YE7a7soHU3w1Xdn3HUaT1BB+6v5gIx5hsCUoxNe
 gCkhy4JQDH9H0xJdvSN7FbIcLEHgeItoDVMzQJMlzTW3FUbWihk0YkYxwOedWINTrf
 oY/diOPP+8Pkg==
Date: Fri, 24 Apr 2026 21:53:06 -0400
MIME-Version: 1.0
Message-Id: <20260424-case-sensitivity-v11-4-de5619beddaf@oracle.com>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
In-Reply-To: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Jrgq3TGYmS+gsjYQgXc1oI5YkxxrwLITLmwEPv8w32E=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6QBuYz3NECRagQ5ROLT/1nvTP6F/YQBFkHh
 k+rXhvNmymJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekAAKCRAzarMzb2Z/
 l04kD/9/XtL1PCnDsaBe6bqOf/yFrG0jpUzClM+mDrkjVvvvuGkvYYHioDSZBGQeEG/fJc2u/WK
 PQ4QMfQN6rtxj2xRrd5K3AFaApP2I7IZM9GoJBNVvZO72xHahvDZmkY3Qn35Igd6EbBS+KFewL8
 fMWtHZRLCBLOJGxVRbnfLkLokjnl5APRObRvqIUOkMBcn1YhoZfzDLvLzNDqqtD8y8kFl2OAVDe
 /R335GvPLyh7EmFLRtYvoOPYCSmt7YthR6xdbYx6p35j9HBp3TW2zn10aC3cHTaJWINg2aLOlgY
 CoeTKZC+bds8EvEc7NGViZR1FZ3Q0r1jwaoIh7V0KwZAuz01z4oXVWVJI+QOgNa8ARMHxvv5j6F
 cyfsGwj5z5oKVSSwkviuXbyZkcPlzys+kzkW0qqvzDCpUjfmW+7dizmAMwYGw58xxDY2Xi9wX1U
 TMcGgrZmmX4mFa+x92Aecdl9qv3Hu9VpvOSiwB3jMGhRvxSwifHcB+/cFc1L4ayh7G+GBDujBOj
 Hcr90oXLrjbguBPv48S1bbP7oXpFZMtHcnHEopKsWdMVCLTlpRXFOZjJfbgAEnyu8l1GLos/vs0
 xxFBvhwnA8gmiPMqtRjE4Lu5fiwtDdYlSlzVN8Vc0X3GTWFDkn3SKcrOcjOkVl5oNmVoV/u+8Gc
 1WZsuX/riZO9Lzg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wGSDI-00030N-O8
Subject: [f2fs-dev] [PATCH v11 04/15] exfat: Implement fileattr_get for case
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

Report exFAT's case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. exFAT is always case-insensitive (using an upcase table for
comparison) and always preserves case at rest.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/exfat/exfat_fs.h |  2 ++
 fs/exfat/file.c     | 18 ++++++++++++++++--
 fs/exfat/namei.c    |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 89ef5368277f..aff4dcd4e75a 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -496,6 +496,8 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, unsigned int request_mask,
 		  unsigned int query_flags);
+struct file_kattr;
+int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 354bdcfe4abc..91e5511945d1 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -14,6 +14,7 @@
 #include <linux/writeback.h>
 #include <linux/filelock.h>
 #include <linux/falloc.h>
+#include <linux/fileattr.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -323,6 +324,18 @@ int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return 0;
 }
 
+int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	/*
+	 * exFAT compares filenames through an upcase table, so lookup
+	 * is always case-insensitive. Long names are stored in UTF-16
+	 * with case intact; CASENONPRESERVING stays clear.
+	 */
+	fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	fa->flags |= FS_CASEFOLD_FL;
+	return 0;
+}
+
 int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr)
 {
@@ -817,6 +830,7 @@ const struct file_operations exfat_file_operations = {
 };
 
 const struct inode_operations exfat_file_inode_operations = {
-	.setattr     = exfat_setattr,
-	.getattr     = exfat_getattr,
+	.setattr	= exfat_setattr,
+	.getattr	= exfat_getattr,
+	.fileattr_get	= exfat_fileattr_get,
 };
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 2c5636634b4a..94002e43db08 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1311,4 +1311,5 @@ const struct inode_operations exfat_dir_inode_operations = {
 	.rename		= exfat_rename,
 	.setattr	= exfat_setattr,
 	.getattr	= exfat_getattr,
+	.fileattr_get	= exfat_fileattr_get,
 };

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
