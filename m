Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278F3FD8FC3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GyDCA2Z8ddvHcEBly7XrdFXnhRIcMKQ9ldFhjoW11yk=; b=eBU3+ksYbYvGzzeTuwAx76duOG
	tDkRpShZz+Jq8Mcd8Ts9ZN5pX5lnVOK1E3mCF6VLxcuMMdUXYoWYU8rsBLcrHgWJb3xdwyHPeZOUC
	EejQdEstbuTNelA0mrkzs1KnARqBwF5Ra0bHxeKg72SfuQoH/DEPQUyIEeWCmNDTGf00=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vvcgt-00009i-O1;
	Thu, 26 Feb 2026 14:50:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+c5cab09b19de097b6dd3+8222+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vvcgp-000096-Rl for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 14:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yBnfuv1eK/qR7jtdeboy/reS0RE7q6bJCLLGY3znk6c=; b=EH56MG/2CgkRS2+5vAj/EKtQvG
 FvrY/QUznMA7RP4QoXD0e4fcMeGlMI8tG+AOulbQ6n1+2Z1KkuB1KT4bI03b88waZaoFY9lZVLy8s
 Gn74E6LOnZ64NBlNADfJS1RbqRjc46g60kLVFyj9dwz9bM9NewLhvJNymLGfew0VG7N0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yBnfuv1eK/qR7jtdeboy/reS0RE7q6bJCLLGY3znk6c=; b=kVDX7O5mdyss+tQf1HCJvAb5da
 +oyUPx1h7k5+U+IZGfeT5hwzNyGMqW+0JBjDtqYtVgXgt7oxQW8XKRciXkqEQvtwNXPDGrf8zOw9R
 9dVPaGzbcupuC3UdPBdckHy7aJlL4yNgbRMD7WK3Z7yEyX39BAFdvzddAroFm8IdMK0I=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vvcgp-0000SI-99 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 14:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=yBnfuv1eK/qR7jtdeboy/reS0RE7q6bJCLLGY3znk6c=; b=ejAnnMwRPu51TGDaedPXz6zDKU
 EIS8mfe5UxmmBMA2XbTdHyxrxKfIpG2VAJvNJbsiVeZkrvBVRpVdsizqABYL4cKo+u5+0DujePM7m
 qHsC+c1rix4It2qae/RT3KTDlqd3BYM2AkQzR7aF3henuabzt9m3vJLC2Hnl2c3PdPPFZaR6fqT8P
 Xy2aDeO9/GG5WXreDzcZ1+g7F7dQXKOdRlUKZHLYBLNa4Xret7CJp9bu948pOysElZ0vsITsZ3MbB
 cXh4ELaMLOLzrIStqt5fR06NGEp7hxV3pTN/l0po7c/zodHTieXUPqMnByv0h7qJaRulqn6ft1SvE
 ySOL2RRw==;
Received: from [4.28.11.157] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vvcgd-00000006NaI-3yRu; Thu, 26 Feb 2026 14:49:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 26 Feb 2026 06:49:22 -0800
Message-ID: <20260226144954.142278-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226144954.142278-1-hch@lst.de>
References: <20260226144954.142278-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vvcgp-0000SI-99
Subject: [f2fs-dev] [PATCH 02/14] ext4: open code
 fscrypt_set_bio_crypt_ctx_bh
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
Cc: Christian Brauner <brauner@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

io_submit_init_bio already has or can easily get at most information
needed to set the crypto context.  Open code fscrypt_set_bio_crypt_ctx_bh
based on that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/page-io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index a3644d6cb65f..851d1267054a 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -417,6 +417,7 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
 
 static void io_submit_init_bio(struct ext4_io_submit *io,
 			       struct inode *inode,
+			       struct folio *io_folio,
 			       struct buffer_head *bh)
 {
 	struct bio *bio;
@@ -426,7 +427,10 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
 	 */
 	bio = bio_alloc(bh->b_bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
-	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
+	fscrypt_set_bio_crypt_ctx(bio, inode,
+			(folio_pos(io_folio) + bh_offset(bh)) >>
+				inode->i_blkbits,
+			GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
@@ -448,7 +452,7 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 		ext4_io_submit(io);
 	}
 	if (io->io_bio == NULL)
-		io_submit_init_bio(io, inode, bh);
+		io_submit_init_bio(io, inode, io_folio, bh);
 	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
 		goto submit_and_retry;
 	wbc_account_cgroup_owner(io->io_wbc, folio, bh->b_size);
-- 
2.47.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
