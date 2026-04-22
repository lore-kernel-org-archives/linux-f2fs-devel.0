Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6898FAD3E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+mJkz2Rfdrblv6r63Ig4ppQbfuplsim/Z3uR+yFG+G8=; b=h0LImN0VT3CNHfyXSCuEqxfl3z
	v9Mcopg6AWi1xfV6c1VR8VVgEQWxcoo45eWIe+TXTp46khh4jxIUY2Bh6+b/6GsOMWvV5IxGfREpM
	q6+/mIBxwaZh4HRQErJbdYYHBfcameBIxoosMtwNeKJi5JVRFKwV+NQwIEulk2eyOZWU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFh1m-0001qE-3V;
	Wed, 22 Apr 2026 23:30:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFh1k-0001q7-CL
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yZnawMMIti1hdbVyCQQBy0di/l+fgCU3tOyYllFO3JM=; b=SIkPSS8UqFeQAkvEs1ntJQoYBB
 L+dtJw53wuCHCiKfILTdis22H44XR3VD6q7EyR4GEiheC8AyDMXjRyH7rfjPROGzkaLcSo0R1tjP8
 Gaaf7vuN7JQWuzDmwhLqkC6s2WOb9s5WJ8sMybJRabYZGrysEvrjjK4pGINCuP1ktGjc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yZnawMMIti1hdbVyCQQBy0di/l+fgCU3tOyYllFO3JM=; b=CEEnrVzscqpybg6Sd3/s4URlv9
 p1daIFuLPTgFRvh0kGaxu9Ntz/3vPEedDo34W9mk6Q5B/89CqFjerKj+SvpJLnomb5IrdEMdxL/zu
 GTZwGTwkc1Ea9LePDmSaW3xqI//K6Sa1LGGVPXwniyTXUYsdfDCRj5sBgjN3tzzsORWg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFh1h-0006dW-Ch for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CA60961870;
 Wed, 22 Apr 2026 23:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB28C2BCAF;
 Wed, 22 Apr 2026 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776900631;
 bh=MPKaRNRTQAJmLU63db2cpCz96vGgkp/OyFEdF/JZV/w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=e1fXpcMgY2SMHELymHXAHGmlviYXMcVNNlzqAal1VpBV7erYU5endNHTdfpX5MooZ
 f+JuWCRMqWL8e80hPpoWXAMxwkLn7IB16/cZi65NHBXkaEf5TnjrdoRFxM8gZBlUgw
 Jk5gSsECQJX431rYYHXu3slHqw18xxQLdCv2bHvyydinfN/H8Och5gEK/HOFZ1URNE
 sikpykcJTWAt1mjnIFmlUtkZL/SlIfOInaRd0XfuqRpPEkd5nL/zwnCt0YOWtB4QCE
 qVqm6JBvyG2Jyn5j2Fqlxel64Q8npSc62QcurcUgvsUsFjsTWnYi5wPy/wVugDgj3N
 c0Cs7DCx8Ifaw==
Date: Wed, 22 Apr 2026 19:30:00 -0400
MIME-Version: 1.0
Message-Id: <20260422-case-sensitivity-v9-6-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=sBcf0hJ0mC4j6QqtM39zu2705aCjapPtH74zbWqfwDA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoFF0e4b6ogjDyg7qWQkKa2tzF23QmRrkvgl
 1JhhI/4PUiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 l6l6D/47inW6njVnLrm9cGl7rHBeXIeOzLam4R8IitrDpY/z9a0zHYqOMJJtNF4VPorGh56iQmq
 /Y33ADa4D2dGJvToyK1aWZiTwsw+VjlbXb8UFyE40/8uCycVaLHZzxWWKH9s4MECvRJ8nkhSh/N
 rYsQCA5w9+t/IOUESMngCZN63l6bwvacQhWLL155XEsRY0XECv4Y6CQtbJH48v9WH885Ai9sr7v
 XlvyYXX7BowqvkHrRxctP8guMj0SVXnKJXnlY2U53sWE3BYeIejoxMnc6IVfYQnv/r81SBpuRj0
 jPXLpDfwbrklFXl3YBT2jrfPnO+dnjRWY1GIvEmYRMOAWFfCapZl1ugQ+PSX2RZ27MwTfLjNcU8
 brWqM7TwREyysQvVO1A11EoMHpUWqw8U2CzrylD5rQt8EeYl7WG6WAGFUxdqZYLRtgB9mGxDfTF
 /qnkuIbEku1s8PeZW0ZgguYkwD4iXOAdJZaOauoHa8GJ/cFg0ibvBufljiRD/96SVfAw5iR+0/6
 Z19gbXyPIL9b5rK4/m+yxTHbgJ8v7ZLIs5KVqLYRgkj/LX+C7oXRKSeYnBzRe9B7K7Mip7V+QLq
 J1HUIJX2OJifJx3FpAitNTAGywhsnFNHHR9na6cAAoNKdYNJxTJlSASJz14vppwK7TS5KJZA28l
 5dJ1Gsn27wSg1ow==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFh1h-0006dW-Ch
Subject: [f2fs-dev] [PATCH v9 06/17] hfs: Implement fileattr_get for case
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

Report HFS case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. HFS is always case-insensitive (using Mac OS Roman case
folding) and always preserves case at rest.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfs/dir.c    |  1 +
 fs/hfs/hfs_fs.h |  2 ++
 fs/hfs/inode.c  | 13 +++++++++++++
 3 files changed, 16 insertions(+)

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
index 89b33a9d46d5..f9a10444353a 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/uio.h>
 #include <linux/xattr.h>
 #include <linux/blkdev.h>
+#include <linux/fileattr.h>
 
 #include "hfs_fs.h"
 #include "btree.h"
@@ -699,6 +700,17 @@ static int hfs_file_fsync(struct file *filp, loff_t start, loff_t end,
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
+	return 0;
+}
+
 static const struct file_operations hfs_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
@@ -715,4 +727,5 @@ static const struct inode_operations hfs_file_inode_operations = {
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
