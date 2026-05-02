Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046E2CD3423
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 May 2026 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQsNpPU8Iu7sdO2XCcZ3ekEfi7q5XH7eVSAA3BIbEKo=; b=DanErKJoAzcOkXdMRVH0vD73zX
	6qthV4WBDZ3WWtX9vP8ARYXfwaUf6pBDs6v94zHxNCSUqKDdzxdU2FSLjhUYSSYA+y4NErRkwjvrb
	zf3ThTQ7rAyBceDc+NPVo0oG0n5KBBRUoEO8MZgEai2Jdtt+ViPBkU2vXWUiLgJNcj3Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJBEI-0000W4-Md;
	Sat, 02 May 2026 14:22:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wJBEG-0000Vp-LX
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:22:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KQ6v8/XE00gOuJZ2DMrbUuMMEc2T2hPgO5EDoJ7YR40=; b=Y+Z+Ta40+JsP0dFc00Y05N15pw
 Fz3hf9IzpH7piqYx7pW4o5s4b+E/AmICRSorRpYjct2aY++5zBxMgtMpdYGSMMdtAHLhX8ILmsEZv
 f3Eosq+ZVuNTEmOFt138gLcEgE5O+csLhioEI3IVcoJAxWsPpczJaHG+USH7efhOVNdw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KQ6v8/XE00gOuJZ2DMrbUuMMEc2T2hPgO5EDoJ7YR40=; b=kOMWni3XHABo+HtmdXASdwcyrU
 43O0jBjmUb7ak0AC+gAWl6oI7DQ+hIGmLr7B6NM3h2l11t6vwvWJNAxdPEbIqbo3ov0ooLxCx3CQz
 8+xZ+CnOZecgIL65+sUIiPxD0IomWuWOxOWqr79pAt+ZDdgfy1Q8FeUHJV2AY913IsII=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wJBEE-0000u6-0U for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:22:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B566B444E5;
 Sat,  2 May 2026 14:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3C5C19425;
 Sat,  2 May 2026 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777731707;
 bh=+3MOBq8tIY5WA12oHUqvFyZTiNAU0Ok39mLnTTLF1eI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=V+BAYZ1NA3rmiLjK52LlHGI017V2rmw4FyiFpAEuPnWNAzLV/BklFDv+0ndD/6KMy
 C69l8rQXa0qc232YT+0IOv5GI56arFXXf2EEW7bMFRvC3Z4GBtj8YsQ0ovUM5PBLmd
 JRmgC2VOpr85pPqT4Vi7J5/s2Giagkk+yQjvsAN4UvxeHheoF+y7y0vxUNa90sIbSu
 6nIkOqTLIfbQyISce5Kr3iDivS4uAVkQ3DeQMQ5e9h1TU1IwrDxJSqzHuRsP2TTzDC
 aaOYl7BVYC0NUDGM7fj/CK2TbGPQqtrxhZTzd71pHRzpqHmRafFZ1EFj1YDJKaM6As
 pfRbQCGoLVuxg==
Date: Sat, 02 May 2026 10:20:51 -0400
MIME-Version: 1.0
Message-Id: <20260502-case-sensitivity-v13-6-aa853140311f@oracle.com>
References: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
In-Reply-To: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=2Xqe+DnVGNfulHUCzpURt2jTiqbh233GQupN+nsg0Mc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghQ1F2LuRfI+wJoJda72084qSBTHeEbEJZrV
 vWjO3v+igGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUAAKCRAzarMzb2Z/
 l2b0D/4lJDck+X5c7GEdQg3CzSN/Hrj8Rb/bYN3MswvFTuVU9mxcMgaXy9foEzRaRjYdVCnqrRp
 H09KFeqd+f1/zX3w5Hugvt0PJSmsL51Il8ss2eiqoYdeFz+8CefSE+ox7FJT/ZnMkYH7dgpzTsG
 iY749krRyYTob3TzvpXllZuactlV5E0jPnYP1a/JR+SbLh+IbDgb6OTsCxl+PXbD8iWiu5xIjLy
 4oB6A0qYzTalIXpUrqb7bRAy8/Pi/mp++e9KR+sJrF7CDWKUjCAKR1j4Aj+IFVuYYb8W5RHRuLS
 87OTZEyLSVs60PIzw9sAneZrfWN6Prl4fc2OFFeCdJW7HBBJzDGfEpjM3JwPPFsa5PWYkeWp6yR
 HE8jY8iUx9DnclTSzFIrG/ytxX6v7IdsKYzgC7fYmokAWx1cZIF9l8UZhPF5FgIx1HLONT4XELR
 QhYOvHrIVzp7Kgx+gLDIUvsNTuMtuDVZT54sNBxurgR9wWrWiMLHIHJ9BxnVQGUwdYjvPOTef93
 GDykLA/GaMm7jVp0We5fWyRyEOs7CFl/11F71jqKx3JIx4jXlo6vw+JNGqmTXUr+58CeBpnE8MQ
 uqsb49sTWHqcS8oetmV+s8g8kQt6Z9XCfQzsBtRgzfkEqcsNdRNIlMuEGyxyiX3aGDOTGhISXcN
 vad1rdHefQvad7Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wJBEE-0000u6-0U
Subject: [f2fs-dev] [PATCH v13 06/15] hfs: Implement fileattr_get for case
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
