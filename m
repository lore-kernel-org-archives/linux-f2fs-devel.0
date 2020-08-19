Return-Path: <SRS0=hFix=B5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A2DC433E3
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:08:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C582207FF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="aTfjmf9p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="R5neKHwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C582207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k8UNR-0007U2-7H; Wed, 19 Aug 2020 20:08:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <krisman@collabora.com>) id 1k8UNO-0007TZ-RP
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Aug 2020 20:08:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wo8SADISwwcMPiUkzFbhTWjKxz/s4NTXZaSMtO+VvfQ=; b=aTfjmf9pniL5QJ7y+C7GTERhUt
 Ssh+dgDbs7JRQmAvUO2mc0CmLdy4u5gPymhcrEiDC8ryJ4QabaiD1SSZ+KhtPLcWTxMKl9NFgkOAh
 a+Zjl2LOIZm/8kxD6jNtGAQbfacASsIFqF9q54uCRrKM8YB/z6JJbT/Cc8D2JNkz8I00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wo8SADISwwcMPiUkzFbhTWjKxz/s4NTXZaSMtO+VvfQ=; b=R5neKHwNhPz564OBkVxOcejRCZ
 EC9W16aptSd/qpRgp0oD31D4ln5Uy6QcUF3bj/LvGaSMfBxwR24FBH57eXArUHG5WWejCia1qzUf/
 QhEjyNvoafmkbFCEHJj/IvU/5S7vfp3bukgwr2GVxmNVssJipBR4+dV9fuGFQXxqtENc=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1k8UNK-00Cjro-JB
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Aug 2020 20:08:02 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id ADB66299804
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 19 Aug 2020 16:07:30 -0400
Message-Id: <20200819200731.2972195-2-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819200731.2972195-1-krisman@collabora.com>
References: <20200819200731.2972195-1-krisman@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1k8UNK-00Cjro-JB
Subject: [f2fs-dev] [PATCH 1/2] direct-io: defer alignment check until after
 EOF check
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
Cc: linux-fsdevel@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 Jamie Liu <jamieliu@google.com>, kernel@collabora.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Jamie Liu <jamieliu@google.com>

Prior to commit 9fe55eea7e4b ("Fix race when checking i_size on direct
i/o read"), an unaligned direct read past end of file would trigger EOF,
since generic_file_aio_read detected this read-at-EOF condition and
skipped the direct IO read entirely, returning 0. After that change, the
read now reaches dio_generic, which detects the misalignment and returns
EINVAL.

This consolidates the generic direct-io to follow the same behavior of
filesystems.  Apparently, this fix will only affect ocfs2 since other
filesystems do this verification before calling do_blockdev_direct_IO,
with the exception of f2fs, which has the same bug, but is fixed in the
next patch.

it can be verified by a read loop on a file that does a partial read
before EOF (On file that doesn't end at an aligned address).  The
following code fails on an unaligned file on filesystems without
prior validation without this patch, but not on btrfs, ext4, and xfs.

  while (done < total) {
    ssize_t delta = pread(fd, buf + done, total - done, off + done);
    if (!delta)
      break;
    ...
  }

Fix this regression by moving the misalignment check to after the EOF
check added by commit 74cedf9b6c60 ("direct-io: Fix negative return from
dio read beyond eof").

Signed-off-by: Jamie Liu <jamieliu@google.com>
Co-developed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/direct-io.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 183299892465..77400b033d63 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1160,19 +1160,6 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	struct blk_plug plug;
 	unsigned long align = offset | iov_iter_alignment(iter);
 
-	/*
-	 * Avoid references to bdev if not absolutely needed to give
-	 * the early prefetch in the caller enough time.
-	 */
-
-	if (align & blocksize_mask) {
-		if (bdev)
-			blkbits = blksize_bits(bdev_logical_block_size(bdev));
-		blocksize_mask = (1 << blkbits) - 1;
-		if (align & blocksize_mask)
-			goto out;
-	}
-
 	/* watch out for a 0 len io from a tricksy fs */
 	if (iov_iter_rw(iter) == READ && !count)
 		return 0;
@@ -1217,6 +1204,24 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		goto out;
 	}
 
+	/*
+	 * Avoid references to bdev if not absolutely needed to give
+	 * the early prefetch in the caller enough time.
+	 */
+
+	if (align & blocksize_mask) {
+		if (bdev)
+			blkbits = blksize_bits(bdev_logical_block_size(bdev));
+		blocksize_mask = (1 << blkbits) - 1;
+		if (align & blocksize_mask) {
+			if (iov_iter_rw(iter) == READ && dio->flags & DIO_LOCKING)
+				inode_unlock(inode);
+			kmem_cache_free(dio_cache, dio);
+			retval = -EINVAL;
+			goto out;
+		}
+	}
+
 	/*
 	 * For file extending writes updating i_size before data writeouts
 	 * complete can expose uninitialized blocks in dumb filesystems.
-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
