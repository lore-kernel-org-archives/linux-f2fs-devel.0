Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF79CD3423
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 May 2026 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9K4/IazUvJlsxYf7KQJSvKkRwjF1qx6gzmbGme8B2Nw=; b=YYee5zpvBNiwyXZd6Pwatsso4T
	EnG0MXhyp/imWFA/SE5SgAUE756y4BSf0g23Ryvj2VdLZtwLjDV1LA+ShW+VYQAx9YwtFnK2XhzeB
	ZJQypz4bFf7YzjpwIL2srVKDjsw404oZQks2jK9oOzW+MMLTzAq1Pm1AtyKHNEbUNFro=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJBE1-0003dG-FA;
	Sat, 02 May 2026 14:21:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wJBE0-0003dA-Nt
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:21:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WCarbD7R9nuMMwHti3cmIiJ5MWU/G4Yv/bi+M0CG1VI=; b=NMNRVAFs2uhhxdikv0H6DxP3XR
 npm0TA+UJJwnsGKGcT88v5mq679YL3CwqUfHqpnYObDB7czU6kl01V4kQORfncfbESZkE9A8D1yEI
 CukuF9EdHBMJ979ER4cHcx9xacM8++xOnLDYlkjxKmpHn5eHgkDIhBAq/woHgbmjGZ9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WCarbD7R9nuMMwHti3cmIiJ5MWU/G4Yv/bi+M0CG1VI=; b=N4rLzjVcuJ0lNAGq1GIdxl4VBv
 t2vlXcn4l0rPBdHtgSsTx+3ZfrIKHtLHZdFDIDanO/mkFVzvItTWfcykwRfLUjHgZD/5Kn9dxAQBi
 dlOMxy7ubBRbKUHmKoikXEx9j1vNhTcTfkLzpwVAAXCrlQknXzAq8RXoUnIEDrLM310I=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wJBDx-0000sg-Ls for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:21:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1AC8260126;
 Sat,  2 May 2026 14:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4603DC19425;
 Sat,  2 May 2026 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777731695;
 bh=dJoqE7xg5dnDwM8zJtU22ff7SFmezUgNm6OnXSD6EvA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WyjdR5lb9D8b02akU1M7YOd6zUj1wjvRXJgEjmvNVDUmBHc5yY+CW0OkboOq3Nvci
 sY94N3aXFL6LyVhp2CwWVWw68XO1Vn4lD02PO0mTTlQL7mA8itScfQOV3BCPFh+jd9
 Qp/dGl6WJ2Rsu4zblVDXhwz3ykFBeUJLQrkJj3Y4qN3geD8I92L8pI1dZZAA/i4M+r
 pw52Z5gNoGzQpLUoLfGDUYSmNupcZznx2u1SdJIuf1pz+T/YSJT9t2wqfeNmJQN+Rm
 PtGtVzJeCtoiA/YauyAp26dKMBu/Rfw+ZgLS83t6i7nMFR/4XDGhE7FLaEvxjnB8dF
 uirmNFIWKfE5A==
Date: Sat, 02 May 2026 10:20:49 -0400
MIME-Version: 1.0
Message-Id: <20260502-case-sensitivity-v13-4-aa853140311f@oracle.com>
References: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
In-Reply-To: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2811;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=w3256AVp6CHVnoJXu0KmBiEb3facwwFeSKlsCd+l9ow=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghQwVydV/I6FUYHtpFOKOuxrA5/yrQacOPAA
 XepyKUb+vyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUAAKCRAzarMzb2Z/
 l2xrD/461UqAsREpMVKet2RbTKHxJsI0yc9d+c1UnTQLFF9/UHlxCoFemStk2bG27wgEU8YkPi5
 pp0TXqGq04h5xhIr/0QLrl65NW3rVVA1RSQO6HEO9jBiNpd1Ze4M81TANAnZwgoCXtyERVO8jNu
 uoPAkMsLP8TXZSgkqjWfOi1EOBKNaYPndA2/ll1sIQIrzfhw9tejp5+CAk5qy55NaWDVo7Bxhp7
 5+6uTWeGLhIgTtZO+Qfog6FcQYq9SoqYed5zp+U/FTgKnLsDBJO8Q3Ra8CWwwp9+COslescvHjn
 fiF0YNAAOH/c3Ammw2bKNNdyQgLRyTERvoIyauudqAzZWTM4NQ0kVFlPPHhiMZ54qb0LULlmFhR
 CWPFn4vAR8kXe/65s7Wh6IAWHoJwQJpnyHmw5PQ1y3R+7p6bFPBRzIE0Z/Y944+GePV51PQWmbn
 oG95qaWEOrww393FMcSwV8Fot8uYlqsVZMIR6qqXSGCt1QGKuFK4GXeXGixAubZJpfdtFHvT/RS
 NGovTmsPtzmSEWhmIZI2PLYfcs+Az33gQdBVmoMwuBzqptsbELyBb7W7NszDFcIgEkyeeUyN/wK
 5M+eivWKwhV7l876sdXHwErHowguQuiRaLSDrl1BOx8LhLVA/n0Fbm8IV7Fbk+FBhw8Vl0+LqD3
 IcrnyunSfNdjGrA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wJBDx-0000sg-Ls
Subject: [f2fs-dev] [PATCH v13 04/15] exfat: Implement fileattr_get for case
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
flag. exFAT compares names through the volume's upcase table; in
practice that table folds case, and case is preserved at rest.

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
