Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C36C19F32
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:22:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tqcKl-0004oK-0o;
	Fri, 07 Mar 2025 18:22:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tqcKi-0004o4-W3
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Mar 2025 18:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BT6OjbtDCOFHHAijJpjMRbh4BDIQM0uytaFHqbNbas4=; b=KtqjCjEsecjSxRqySCjvSSHDW8
 af1CQjA5dBAdvFQ0q7B/AZSNFI4ms3onRHtcEQfTtzMDvOcV0/Fx3wuPPymSKwf7oro+R60+i6JYx
 hVuRP0ymVBx8laGGOCId3bjDAeAW4xPk1soLGn4UAfrgBWqWb9EE+FLWCBWcDEq2t9Mo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BT6OjbtDCOFHHAijJpjMRbh4BDIQM0uytaFHqbNbas4=; b=PSvXuvJc1Tg6ge6UW0Xd6apDMA
 aytjxI0N6J/OsMV7m3Kf4x0VIvQIS0EHDRD715mlT4I9REKwHQ6SZ+GdT69xuT4CFgH6/rL63CNfv
 glFv6rLMGqdLyGB2AZWmt2l/0r4h5h9WOtHLmUHgRlG0XrLf0268uWzrqU4xNnHYM9xc=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tqcKi-0004XT-Qp for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Mar 2025 18:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=BT6OjbtDCOFHHAijJpjMRbh4BDIQM0uytaFHqbNbas4=; b=rpXKwVnb0knBI4GHlLAYlc+0As
 1r+wS9W1bNGX5vr3dqANb97Ev4egsqiYcBMrZMpcMHdxvXeOT+GlGLRqOauWrC/fOToQHAB6wAMkQ
 LLeQ1Fe97u6BfTv3oi9qmBjI8AoQOfNQLfqex9XvOdCyeOVNb+tK/q+bcpCdIZxR+VJ1shsmlH37+
 INDzO5AFPaDBkief51jGwTswtyDWYk3DpZMZvwkUT2HXJjk9BsvjUtFB/WaDSafbKA579GLfszW9Y
 1szDmqnP0vNbSUSJWYWXQ55V7NBuOCrZaeSV/GcuxiEtkzA6Zsl3niMGDFb7SBL3zJYzVz2g4MDXC
 WOMGnKQw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tqcKX-0000000EFjm-2Iim; Fri, 07 Mar 2025 18:21:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri,  7 Mar 2025 18:21:50 +0000
Message-ID: <20250307182151.3397003-5-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307182151.3397003-1-willy@infradead.org>
References: <20250307182151.3397003-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tqcKi-0004XT-Qp
Subject: [f2fs-dev] [PATCH 4/4] f2fs: Remove f2fs_write_node_page()
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
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Mappings which implement writepages should not implement writepage
as it can only harm writeback patterns.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 36614a1c2590..b78c1f95bc04 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1784,13 +1784,6 @@ int f2fs_move_node_page(struct page *node_page, int gc_type)
 	return err;
 }
 
-static int f2fs_write_node_page(struct page *page,
-				struct writeback_control *wbc)
-{
-	return __write_node_page(page, false, NULL, wbc, false,
-						FS_NODE_IO, NULL);
-}
-
 int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic,
 			unsigned int *seq_id)
@@ -2217,7 +2210,6 @@ static bool f2fs_dirty_node_folio(struct address_space *mapping,
  * Structure of the f2fs node operations
  */
 const struct address_space_operations f2fs_node_aops = {
-	.writepage	= f2fs_write_node_page,
 	.writepages	= f2fs_write_node_pages,
 	.dirty_folio	= f2fs_dirty_node_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
