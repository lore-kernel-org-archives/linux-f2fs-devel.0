Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046D5C3ABC5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 May 2025 08:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YsSzocURP4sNFnrDcFmO4MkCNRoCYE8O/j/7nuoJknk=; b=Y1v90ri6gOK+P5xmIlGICu1Pnc
	f2Ozg8I0Ahl2bvEywAKP5UDnARiaCyuy2vkL+ztfPeWFNEZr86bkgVQek2ya2iXfYQwUXQPgJbx27
	fqfLOym3u5Tz0zoq1ce+ha5zHv2zZvkHqS9SfKmOS1qmeeUF4iPi7QME5tlI92GBxDxI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uCZqh-0007b6-Dp;
	Wed, 07 May 2025 08:09:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uCZqY-0007ak-B7
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 May 2025 08:09:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=snvy+wI56EslrdFPti0EBhBb+vUOcu6fkgtYpXIsYIE=; b=O1VNj2Q7qH6p2EuRZzlPy+Lhz8
 gysVFnKyAXMPo7VEyxjEwfGEYcywc1Fc9qu00eId2OaICI5JPgyk7K90Cp+sgozxP07F1A7vwdaP+
 DYDTnkvap5S7mVUKBoRJod5u9PitVvnfn7vmu+T2m7rZt0KAJ9A8DzWxWG8o5l66eAag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=snvy+wI56EslrdFPti0EBhBb+vUOcu6fkgtYpXIsYIE=; b=b
 ZHQHKnYJGrH4QTmW+5za4vXNr7NVXF1EmprO0VXTU+esrFyAjzqTBMs01NbOQwYRGLupnW3RqkyH1
 hjZMFC3IgSek6yCGm3PMtwwdBwtNiHzuafSez0BG2O5RzHPl49IHyI8Nf5IM/ctVMyrfpKSX0SfK1
 +bgsTq97dZzP6qEU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uCZqI-0005TK-LK for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 May 2025 08:09:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F58F4A6E8;
 Wed,  7 May 2025 08:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DA6C4CEE7;
 Wed,  7 May 2025 08:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746605356;
 bh=QE7e2KY0A+q2dpAbO61o5sBZfaxAZhLRk3k9BFApyzw=;
 h=From:To:Cc:Subject:Date:From;
 b=LTHbY5XurQEDiBofBKW8WiSyrtIO2pcmDH9VCHGwB3qiimPrcNVxJUfSPtpXyXvhA
 q8XgDDj2e919Pgw9PfyoXQBLNhN5RVvUL2f0d4IpQCYWvB3pOnFwBigDCgi0tSr9qw
 tf1q+EFef6627grKzj9u2TN+UOiQVDFCtEK8AmRENF6652sl7G4Lv0wXthZ1/2RI3A
 tqFltVgdbp0D5YPZ8AdXaHxpnCZDrwxqW1kEMHfbwwmVffjBIKc8W0evyaTb9o5kd1
 lOkQq/hTC4mwckyrqEFotoK/R/Q50JIombVSMvpVC8BV0of+MWBJy7m/DbwCtxqZ3u
 hraE1Ih5+3Iew==
To: jaegeuk@kernel.org
Date: Wed,  7 May 2025 16:08:38 +0800
Message-ID: <20250507080838.882657-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
MIME-Version: 1.0
X-Headers-End: 1uCZqI-0005TK-LK
Subject: [f2fs-dev] [PATCH] f2fs: fix to return correct error number in
 f2fs_sync_node_pages()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If __write_node_folio() failed, it will return AOP_WRITEPAGE_ACTIVATE,
the incorrect return value may be passed to userspace in below path,
fix it.

- sync_filesystem
 - sync_fs
  - f2fs_issue_checkpoint
   - block_operations
    - f2fs_sync_node_pages
     - __write_node_folio
     : return AOP_WRITEPAGE_ACTIVATE

Cc: stable@vger.kernel.org
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ec74eb9982a5..69308523c34e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2092,10 +2092,14 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
 			ret = __write_node_folio(folio, false, &submitted,
 						wbc, do_balance, io_type, NULL);
-			if (ret)
+			if (ret) {
 				folio_unlock(folio);
-			else if (submitted)
+				folio_batch_release(&fbatch);
+				ret = -EIO;
+				goto out;
+			} else if (submitted) {
 				nwritten++;
+			}
 
 			if (--wbc->nr_to_write == 0)
 				break;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
