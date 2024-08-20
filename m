Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4C6C531DF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:55:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgQGk-0005xj-NT;
	Tue, 20 Aug 2024 14:55:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sgQGe-0005xR-6Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 14:55:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P9ioZz98uu6Kea08W7GUWIDy8AT3ibFPVtBUFzy7zRM=; b=UvNBP5BFjGV48Qa/YMl/q/EVNv
 mDdFML0d4Gmj8wDEBRISOO/K2D1mEz7NIr6/TKeEmKUcBNKoOod4L5GJXHLhiui+UnLV8UOefrCPH
 MaVnFJaZjF8OCpJbUbV0X0rsDaT2lTrxRlG3HQ/C6Zm2Cl48twKgxJhH7ezSuykXNvLs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P9ioZz98uu6Kea08W7GUWIDy8AT3ibFPVtBUFzy7zRM=; b=Cy0LPAEv0yzFwDfJaC243JXZNW
 TrRsw38Jd6ohA3PNQ9N438mJggW/Hc5jwZh7+2L4kqh4fxxMz/Pp34FE3dzI776icotU41x8Vjyjp
 kZ1vmHo48W6SaCY46F/HQe70cyu9beYJISY0zeplJWSOw7Fme0fG8aq4Z7zoLG5eunoc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgQGc-0003If-4A for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 14:55:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C14EB60A0C;
 Tue, 20 Aug 2024 14:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3333AC4AF14;
 Tue, 20 Aug 2024 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724165720;
 bh=dIBiDWZZ+VdfSBZiAekt52/vy7xcWhmfXf3ack5GSCs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j6YRMsvVecL9B1bmTNWjFJuNSXWmdQ7OdSG6fF+1gpPpXs4Xl4uYU9AI0IFY5/lk4
 zAtmVqjNjeXLiXDVkjNu8AmhYH9SQ2ym2sbNmHYC+vneakLPaCwTXTB2AC+8jP3E6A
 4Sr0IzasbVYY1AfqaRJZuvZ/8Rhi7mEzm56S3TOVhDWzDW0t6xO2gTL46sX5jSXPNw
 OlY9UKHjZ8S3VvWTQZMaE3o16VfPJnJwqHpv+JgYhCthsG8Zb2kpznDaT2N6H6WdWF
 GopiIVuWOuWRKzfz93Q35kosR424bbz25vL2i7e8EchI4tpE4MnghbDQ0nj2wh4F4R
 cxSvRhetPSaiA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 20 Aug 2024 22:55:01 +0800
Message-Id: <20240820145507.1372905-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820145507.1372905-1-chao@kernel.org>
References: <20240820145507.1372905-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1sgQGc-0003If-4A
Subject: [f2fs-dev] [PATCH v3 3/9] f2fs: convert f2fs_write_end() to use
 folio
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
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 85ac05c3655a..e114d738b6b4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3698,7 +3698,8 @@ static int f2fs_write_end(struct file *file,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 
 	trace_f2fs_write_end(inode, pos, len, copied);
 
@@ -3707,17 +3708,17 @@ static int f2fs_write_end(struct file *file,
 	 * should be PAGE_SIZE. Otherwise, we treat it with zero copied and
 	 * let generic_perform_write() try to copy data again through copied=0.
 	 */
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		if (unlikely(copied != len))
 			copied = 0;
 		else
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	/* overwrite compressed file */
 	if (f2fs_compressed_file(inode) && fsdata) {
-		f2fs_compress_write_end(inode, fsdata, page->index, copied);
+		f2fs_compress_write_end(inode, fsdata, folio->index, copied);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 		if (pos + copied > i_size_read(inode) &&
@@ -3730,10 +3731,10 @@ static int f2fs_write_end(struct file *file,
 	if (!copied)
 		goto unlock_out;
 
-	set_page_dirty(page);
+	folio_mark_dirty(folio);
 
 	if (f2fs_is_atomic_file(inode))
-		set_page_private_atomic(page);
+		set_page_private_atomic(folio_page(folio, 0));
 
 	if (pos + copied > i_size_read(inode) &&
 	    !f2fs_verity_in_progress(inode)) {
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
