Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AAEC3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:55:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgQGi-00081r-PY;
	Tue, 20 Aug 2024 14:55:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sgQGd-00081f-HY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 14:55:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MQi8IBaTokev7L4yqleb9iiIViytEQinS4WQC4tNZ2U=; b=I2C/C39nuns/0KrzGidOTOSgcD
 raH37LDLWNfFSG3hUqloeQrTCDv5O/dH3HEMa8V4w33+13mBrcLDdehA8BklqkxK5u6DTBg+on9Kq
 V1DwMPEKakQYx/5l47t1Mct8VyRfZZ3+/GaUSLBePAQA+lMHvccAaoc0cfAxtKst2FGY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MQi8IBaTokev7L4yqleb9iiIViytEQinS4WQC4tNZ2U=; b=l
 Ff9lxwo1Rl99iwq/FjXR+fifvakpqfwTIkI1vmVbSRQI6ht5cO0A3wd6DRe/2MvkSMErd2x5VS8dL
 fmufHMYYBW5/r7CkmoeR2SXMK9/11DnDGHzZIB+z3pLewD/j1AbhCk5wu9Jhy69+RftYFFqf29DUH
 hKEz+mnDcs6MqgB8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgQGd-0003Ii-Jm for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 14:55:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 455EF601CD;
 Tue, 20 Aug 2024 14:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA452C4AF0E;
 Tue, 20 Aug 2024 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724165717;
 bh=TD4pC/7gOAIBRtl7hXh73ZpX5mOA2MdaM84eq+diEMI=;
 h=From:To:Cc:Subject:Date:From;
 b=EtXVGECgRWDIRijkjHcl5yBeVwhoNpGuHrbJmX6Y6LBDg189ihRoz0Dj2h7k+IEmb
 WXeSWw+3lx08siQiNqYbTZE9FvV2NYEXeH/GieXZPHrMY22jgRE6SXkKLls98xi1m0
 9OlC//DrMJjvIlJt9loHYKIYo27LohbYrgzuP6Q4JjqigFnIPmXADNhgMBp4MkzHWK
 fyeALRQMC7b8lpUaM+4Ed1BxBdkHrS6yOUml8M4qLEOp2+8cAT4gfhdigo+fIUKaUm
 nrGWezAkG7zf0XJlIqt2ZGPS6BD35T4wNgAJQjL0Fpmnc+lE9mMLQ4NNnzJJYKV2wP
 Sy9mYVauoBl/g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 20 Aug 2024 22:54:59 +0800
Message-Id: <20240820145507.1372905-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sgQGd-0003Ii-Jm
Subject: [f2fs-dev] [PATCH v3 1/9] f2fs: convert f2fs_submit_page_read() to
 use folio
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
 fs/f2fs/data.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4f4e76c33611..0655fddfc4ba 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1086,7 +1086,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 }
 
 /* This can handle encryption stuffs */
-static int f2fs_submit_page_read(struct inode *inode, struct page *page,
+static int f2fs_submit_page_read(struct inode *inode, struct folio *folio,
 				 block_t blkaddr, blk_opf_t op_flags,
 				 bool for_write)
 {
@@ -1094,14 +1094,14 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	struct bio *bio;
 
 	bio = f2fs_grab_read_bio(inode, blkaddr, 1, op_flags,
-					page->index, for_write);
+					folio->index, for_write);
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, blkaddr);
 
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
+	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0)) {
 		iostat_update_and_unbind_ctx(bio);
 		if (bio->bi_private)
 			mempool_free(bio->bi_private, bio_post_read_ctx_pool);
@@ -1269,7 +1269,7 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 		return page;
 	}
 
-	err = f2fs_submit_page_read(inode, page, dn.data_blkaddr,
+	err = f2fs_submit_page_read(inode, page_folio(page), dn.data_blkaddr,
 						op_flags, for_write);
 	if (err)
 		goto put_err;
@@ -3668,8 +3668,8 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 			goto fail;
 		}
 		err = f2fs_submit_page_read(use_cow ?
-				F2FS_I(inode)->cow_inode : inode, page,
-				blkaddr, 0, true);
+				F2FS_I(inode)->cow_inode : inode,
+				page_folio(page), blkaddr, 0, true);
 		if (err)
 			goto fail;
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
