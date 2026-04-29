Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B92CCFA13
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQsNpPU8Iu7sdO2XCcZ3ekEfi7q5XH7eVSAA3BIbEKo=; b=N2kLgUihVw2se3WIrJv+uufX1a
	s/2mZkC31Qj3YksP1DelFMBmw0uLwJydvgHUZvgpUFu1yF0w/Clwym3VLN4wYUUgpn43mklYOodID
	mvFPxyO+KJQKNDeCx9j5Vtp9ohtOs+IrqwF6DY7T/mWwLjLwQ8MMEi4LJqrgGywD7Ang=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wI9KG-0004RB-LT;
	Wed, 29 Apr 2026 18:07:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wI9KE-0004Qx-Pm
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 18:07:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KQ6v8/XE00gOuJZ2DMrbUuMMEc2T2hPgO5EDoJ7YR40=; b=Y3g8ihZFHaitiReN8LFKi4xOEt
 2tX9F3bZxyI0tvNVU09QfcdoVO4MW8LFu9Ba/AM4nHOxUZiaHH7W3uM+DxgdfmTXmVAlvRnDAND7i
 wSGrG5eTPMOKoNUGDwPYtTfbYUV8UTA7SX4L150WVA70cm6iv/ffRTWh54EPtQtBOZQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KQ6v8/XE00gOuJZ2DMrbUuMMEc2T2hPgO5EDoJ7YR40=; b=Bwg+5sQsxEcaSiNK1QpcWLovZN
 bW0LFLNmFX1v0ru3VGKOPEy76w1w6br7PMnkTFwWFk6npt40MdGp5/exGMa/CVRtgKJUQThBwzssP
 wHuZSpjv8rXxwoA5610y24GPqwmEy0gtyFYpqKrO9LSxgIEviCQI39AsV3jxNTtt1Dy8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wI9KE-00014m-2G for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 18:07:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 78C0B61143;
 Wed, 29 Apr 2026 18:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A24C19425;
 Wed, 29 Apr 2026 18:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777486063;
 bh=+3MOBq8tIY5WA12oHUqvFyZTiNAU0Ok39mLnTTLF1eI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=sn5WNYcwOS5XkPUDifxALSSvjDsQAw+ctspndg7a+7yGJf66U5P/pwLtU37qZgdMl
 LIKkqy62iDfd5R6bLLajEXvtUAepv4Qzue7IPilxoZgCg1lGP05qvpG2DS33iWExBD
 6TjR9HPXAEFvLzL/FKMQR/q2Kdpb2dXYT+v6J4EjhVSTGFAq76Ce3yGRQCH6WqYlR3
 Yand7R2gFHFpRIM9CeDi1VGnHS2Dltv3UyfJvZh//bW6cZa4+vzZzkgXqNiV8aDjXu
 /1MUlShgFOIPwiMYGDqwi+ECUr/tDxKCY5mfIRqvbxkoeHazrCHDp+G7lB9yrEPiE8
 +/l5Gi/iOpYDw==
Date: Wed, 29 Apr 2026 14:07:17 -0400
MIME-Version: 1.0
Message-Id: <20260429-case-sensitivity-v12-6-8057123bebe0@oracle.com>
References: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
In-Reply-To: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=2Xqe+DnVGNfulHUCzpURt2jTiqbh233GQupN+nsg0Mc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8kjcMbu8J3ZZsnJNx5OSfXNR0ib9yCFwb/FWx
 f6j5ru9r0OJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJI3AAKCRAzarMzb2Z/
 l0ElD/9CG/JBuZOsRDy5u0rsIVVp85xaf9Pwdb9wPm1EMWgEdP/MtQqJT+aF418t1ODxydLtMbc
 URaCw4swffGw8Y9Ye6yA58Rkqc7e3fnaboPeS8N4szbZKUjx31UN4UTJ1w2EtNmSsjJtewLfetr
 OAxzPaqmIwv4QgVmC0Ds66xv6/aICpiNRrkjn6OWG+qngSobPfJ8OGwPVTY3kJ2Wi6XSVaGgxzg
 FS09eFYuvC+OPL3xmuMIy+fBg5PXd1X64C5Xg1QJQQGV+KOEREy9WK6sywnWl4HPWmv10GgbART
 4w11eU0QBjohFy2eW8cW3EXzdRKo+odZPIruAWWjXhVHLpEIis9vXChLWL4QiLqIPP9QySWzkPX
 Z0gxKe2VuAHjwMp4+FDkWU16A6H5+OOz2bBOrPABYoJpopDyMTvU8YfeJ0XroDBvTWv/Gvuvch2
 skDD1L0DvmgD8s89IBfqWRHsjdphECH/yAOdJtm44UNqIyaWA9VKbZb3N2KUHkIyMWEf7noSinH
 Gr2WAV6ebteMNaqeWqfeUzVR6N83mRgI32XBHGpui0ZP6iqgrx9S1tepz2qjQmTu65Y+s4pgKiY
 P05zJTQuM1wDP6Jnzc03kVW9sL9G+15YpY9OkzbPgzrfORIqiEfZnfDijD53dLzj3EGx7LHm/ju
 NctRkRdmw4g3Sow==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wI9KE-00014m-2G
Subject: [f2fs-dev] [PATCH v12 06/15] hfs: Implement fileattr_get for case
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

Report HFS case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. HFS is always case-insensitive (using Mac OS Roman case
folding) and always preserves case at rest.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfs/dir.c    |  1 +
 fs/hfs/hfs_fs.h |  2 ++
 fs/hfs/inode.c  | 14 ++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index f5e7efe924e7..c4c6e1623f55 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -328,4 +328,5 @@ const struct inode_operations hfs_dir_inode_operations = {
 	.rmdir		= hfs_remove,
 	.rename		= hfs_rename,
 	.setattr	= hfs_inode_setattr,
+	.fileattr_get	= hfs_fileattr_get,
 };
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ac0e83f77a0f..1b23448c9a48 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -177,6 +177,8 @@ extern int hfs_get_block(struct inode *inode, sector_t block,
 extern const struct address_space_operations hfs_aops;
 extern const struct address_space_operations hfs_btree_aops;
 
+struct file_kattr;
+int hfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int hfs_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 		    loff_t pos, unsigned int len, struct folio **foliop,
 		    void **fsdata);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 89b33a9d46d5..f41cc261684d 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/uio.h>
 #include <linux/xattr.h>
 #include <linux/blkdev.h>
+#include <linux/fileattr.h>
 
 #include "hfs_fs.h"
 #include "btree.h"
@@ -699,6 +700,18 @@ static int hfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	return ret;
 }
 
+int hfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	/*
+	 * HFS compares filenames using Mac OS Roman case folding, so
+	 * lookup is always case-insensitive. Names are stored on disk
+	 * with case intact; CASENONPRESERVING stays clear.
+	 */
+	fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	fa->flags |= FS_CASEFOLD_FL;
+	return 0;
+}
+
 static const struct file_operations hfs_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
@@ -715,4 +728,5 @@ static const struct inode_operations hfs_file_inode_operations = {
 	.lookup		= hfs_file_lookup,
 	.setattr	= hfs_inode_setattr,
 	.listxattr	= generic_listxattr,
+	.fileattr_get	= hfs_fileattr_get,
 };

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
