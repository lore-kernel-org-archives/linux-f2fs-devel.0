Return-Path: <SRS0=hFix=B5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689DFC433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:08:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D299207FF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="KExvavnU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="X4qAB37/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D299207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k8UNP-0001P5-Hb; Wed, 19 Aug 2020 20:08:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <krisman@collabora.com>) id 1k8UNO-0001Oy-5O
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Aug 2020 20:08:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/wwIWpK3YQAcMq6PMpamBYITI5sk01+ZkyOqbscF+CY=; b=KExvavnUi0a7VFySuK5XPaVV2i
 +hfFdtR+IPnrTgabLasPkast8EAEwX5plFJuqZQFemot1AoUAy+rj9RjPySHpUP+UEGQ8g00VqNX1
 aFOK8JzAaOrUoPAWInkBMeQFq37ooOk4q/+8lqiYqXjIcvOzhanz8CKa+JUVVpNVlooE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/wwIWpK3YQAcMq6PMpamBYITI5sk01+ZkyOqbscF+CY=; b=X4qAB37/wFS1RY4Hjsmd4GsWKa
 iut+zfLYkVC4PFvVGWEk6raFeyiomUiRkPYZmdJ47tk6CZRc2DOVhrE0XhJmNnRG/XWRHSfZeUaOX
 6RxCTSj6eKMpkZU1y8atK12rJXuMpgOkM1W5p7FdvTXNJEPekSPGQ/y1dPMVV5Yrh1JA=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1k8UNM-00Cjrs-Ua
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Aug 2020 20:08:02 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id A9565299C0F
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 19 Aug 2020 16:07:31 -0400
Message-Id: <20200819200731.2972195-3-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819200731.2972195-1-krisman@collabora.com>
References: <20200819200731.2972195-1-krisman@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1k8UNM-00Cjrs-Ua
Subject: [f2fs-dev] [PATCH 2/2] f2fs: Return EOF on unaligned end of file
 DIO read
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
Cc: linux-fsdevel@vger.kernel.org, kernel@collabora.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Reading past end of file returns EOF for aligned reads but -EINVAL for
unaligned reads on f2fs.  While documentation is not strict about this
corner case, most filesystem returns EOF on this case, like iomap
filesystems.  This patch consolidates the behavior for f2fs, by making
it return EOF(0).

it can be verified by a read loop on a file that does a partial read
before EOF (A file that doesn't end at an aligned address).  The
following code fails on an unaligned file on f2fs, but not on
btrfs, ext4, and xfs.

  while (done < total) {
    ssize_t delta = pread(fd, buf + done, total - done, off + done);
    if (!delta)
      break;
    ...
  }

It is arguable whether filesystems should actually return EOF or
-EINVAL, but since iomap filesystems support it, and so does the
original DIO code, it seems reasonable to consolidate on that.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/f2fs/data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5f527073143e..d9834ffe1da9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3510,6 +3510,9 @@ static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
 	unsigned long align = offset | iov_iter_alignment(iter);
 	struct block_device *bdev = inode->i_sb->s_bdev;
 
+	if (iov_iter_rw(iter) == READ && offset >= i_size_read(inode))
+		return 1;
+
 	if (align & blocksize_mask) {
 		if (bdev)
 			blkbits = blksize_bits(bdev_logical_block_size(bdev));
-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
