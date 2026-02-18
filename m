Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182BEE9A03E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Feb 2026 06:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D3R/9OdHHeIppCrDKiC+43a9yYiO+6vLmGM7nFLO2WY=; b=dh3DOkK+1j/dsg4YBk1obMeTYN
	/apQ0JT8srQsfLL7HhYAOlBcESOWUE8g0W/0AInd4E4Wgy9eUXV8r7SGJBzmfvC1cRAePFO0jNsLm
	aam1s82Y6++KjNCmMdvpRoqTON3w2GqZ0FCYX5pa02ggc6zvkXlFJ0ShZ0HcVA2wfRdU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsarG-0000DF-PE;
	Wed, 18 Feb 2026 06:16:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+b7a6f314dcfbee4e7dbb+8214+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vsarF-0000D3-3f for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 06:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=riklaYaC8o2tdvy7FpPnqNZFcL07vFEnM3jtWWsAF2U=; b=AATcNU+RBzDxGgBC72EEWOm5Vm
 IK5XBjAmYRyCDj+/b2Js5UPlOxIxLoWhURQitMXj9Z+jdoaCFRZhCxQO9hhW3B/dykqSUae92Y25E
 f92por+tsko1YYhbxPwX9dlPqAFXvMDpZJq6NX/E0Gk3k4vy48EViPncDByLimJIcR4w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=riklaYaC8o2tdvy7FpPnqNZFcL07vFEnM3jtWWsAF2U=; b=e2vq1yGzUoVCVOuc3A0vBJe5di
 WRgWyhmYOAj7wWhBeDd7lre65uxTrxCX60HNU5x3rg+MsVdUwW1PwRNNHj23eS0fhYt5U6E04FjQU
 unDuYYj2Z+KuzjCY1kJ6K5aErERI/Ob0dac3bvZfLK3HCAoOx8kzmls4SaC6cUF47HwM=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsarD-0006K4-6p for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 06:16:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=riklaYaC8o2tdvy7FpPnqNZFcL07vFEnM3jtWWsAF2U=; b=RGjG0yTHXxQd8Fj6Gc2HmsoegA
 0QRWzXXW8WbtkZZs4gdCcl29FG4LYrjIgjc+aTsJ2ydtwm6oZgkSwEG147jYBbKts7090rqdQFGrc
 WD+AfiwFl+XNemv3RFqPn+e2fIBvbF+dvD+hkubmNr0wQDhqZkGlElXnb2eTrAFSB7YXaNCwKdJMy
 D6hNuL6DuARxlKJ1JRFdn9PW+DdGiOr0S1pWSY5WC8ORGnUmFyzc53ne8rVL9QSjADe+mvAV0RRVW
 vAMbVkrzZC5VXzELtoztCXLdktA3TesnFy6OEa2Fk3FXNRlGxpktOvYbcLeTW3xPRoTNIZfzeuPYU
 f6gAaJLw==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vsar1-00000009Lhz-2toS; Wed, 18 Feb 2026 06:16:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 18 Feb 2026 07:14:44 +0100
Message-ID: <20260218061531.3318130-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218061531.3318130-1-hch@lst.de>
References: <20260218061531.3318130-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vsarD-0006K4-6p
Subject: [f2fs-dev] [PATCH 6/9] fscrypt: return a byte offset from
 bh_get_inode_and_lblk_num
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

All the callers now want a byte offset into the inode, so return
that from bh_get_inode_and_lblk_num.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/inline_crypt.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index c069958c4819..128268adf960 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -315,7 +315,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
 /* Extract the inode and logical block number from a buffer_head. */
 static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
 				      const struct inode **inode_ret,
-				      u64 *lblk_num_ret)
+				      loff_t *pos_ret)
 {
 	struct folio *folio = bh->b_folio;
 	const struct address_space *mapping;
@@ -331,7 +331,7 @@ static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
 	inode = mapping->host;
 
 	*inode_ret = inode;
-	*lblk_num_ret = (folio_pos(folio) + bh_offset(bh)) >> inode->i_blkbits;
+	*pos_ret = folio_pos(folio) + bh_offset(bh);
 	return true;
 }
 
@@ -350,11 +350,10 @@ void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
 				  gfp_t gfp_mask)
 {
 	const struct inode *inode;
-	u64 first_lblk;
+	loff_t pos;
 
-	if (bh_get_inode_and_lblk_num(first_bh, &inode, &first_lblk))
-		fscrypt_set_bio_crypt_ctx(bio, inode,
-			first_lblk << inode->i_blkbits, gfp_mask);
+	if (bh_get_inode_and_lblk_num(first_bh, &inode, &pos))
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos, gfp_mask);
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);
 
@@ -419,13 +418,12 @@ bool fscrypt_mergeable_bio_bh(struct bio *bio,
 			      const struct buffer_head *next_bh)
 {
 	const struct inode *inode;
-	u64 next_lblk;
+	loff_t pos;
 
-	if (!bh_get_inode_and_lblk_num(next_bh, &inode, &next_lblk))
+	if (!bh_get_inode_and_lblk_num(next_bh, &inode, &pos))
 		return !bio->bi_crypt_context;
 
-	return fscrypt_mergeable_bio(bio, inode,
-		(loff_t)next_lblk << inode->i_blkbits);
+	return fscrypt_mergeable_bio(bio, inode, pos);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio_bh);
 
-- 
2.47.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
