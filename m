Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98176FD8FC0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xXfalWg4Sx0fSnJ1c95D5O8XZoRI4LovmAY99rfW9cc=; b=dCBx6nPzBUCESVI4X6StKUIT/p
	BaCUol3g9fqORCSIht1V/Cutaz8HiMeS/w5k7BJEu7tsRDk3B2L3jWQmV8ehf2Ucd9CP+jTYuPJEd
	lPuew1GrA+0UdGceJ9rtRqevc+qDa9WPTt9eqQKIgW2BD+OspqrAWjMGtiqsTlm2pPGk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vvcgs-0000Tn-9w;
	Thu, 26 Feb 2026 14:50:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+c5cab09b19de097b6dd3+8222+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vvcgr-0000TK-9b for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 14:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2MKwitb679q/7EFRawvNRTcIo328h9sEUi+N9CTrDp0=; b=LXKrTqhAPCp8PcpAOnRyvS+wwp
 UeBFNDVz2Rxt4cS0tTaBGYZFTaY1oammHwuYp6RmLG7XXrWZr+kJV5ZND8rJ/lRKh3avd28MfbKLs
 KRSe89OVmGsL9CFY1FJqd5MJgWKDktJakbU8haEbPdmFuRVQAYDZDzG4QYQ3DiXtrTeI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2MKwitb679q/7EFRawvNRTcIo328h9sEUi+N9CTrDp0=; b=Lifc1ZwJXTGFNiycv4hnvAUxma
 6wzpHTSdT8cO5omaSTZTbIk2cLLMKOHGiqbVO094XoRxk+DiTG0SBzIx3dCwm+9il7BUH+XWLJp4R
 L6W2v52e4u/9Wt3DFeU/dXNS9WNEYiL6CL4euOLqrEQnMt0oPG1+O7BW6gmgf1kI2hR0=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vvcgq-0000SU-LU for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 14:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=2MKwitb679q/7EFRawvNRTcIo328h9sEUi+N9CTrDp0=; b=H4EabXF/irN8FD02iELnKSzwK/
 hCTlIJw+XgFwRw/LbVRYCzvvxI4vhAYAymfxFb9P0krpCmpgI9pYJmO7a8m8Pr4z7FlCN1fJ3jwI3
 Vp9uG0Imz8e8gNBvJ6Wg9dXM9Y87WXU7sNvOj6xWNjo/sYVa0fJZypeyrZrpHPMj8JsRr3yfQFNGN
 2lxCXttT9u8LcZe0bGI2u2r/wSV+VsTvfq1KgByU8UqdwbSojTdqnG/qHZmnO0pWtFmP4an06mbTD
 HeQkjQAtFSrIU9D3k3anzlvquUIymuCrGwkbI4U4iwjqvzjZELCzb5eIOOScFw/g3KLHML5FXE5fx
 04NsViug==;
Received: from [4.28.11.157] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vvcgf-00000006Nbr-3asH; Thu, 26 Feb 2026 14:49:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 26 Feb 2026 06:49:29 -0800
Message-ID: <20260226144954.142278-10-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226144954.142278-1-hch@lst.de>
References: <20260226144954.142278-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vvcgq-0000SU-LU
Subject: [f2fs-dev] [PATCH 09/14] fscrypt: pass a byte offset to
 fscrypt_zeroout_range_inline_crypt
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

Logical offsets into an inode are usually expressed as bytes in the VFS.
Switch fscrypt_zeroout_range_inline_crypt to that convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index e7fb2fdd9728..7558b3e69701 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -70,12 +70,11 @@ static void fscrypt_zeroout_range_end_io(struct bio *bio)
 }
 
 static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
-					      pgoff_t lblk, sector_t sector,
+					      loff_t pos, sector_t sector,
 					      unsigned int len)
 {
 	const unsigned int blockbits = inode->i_blkbits;
 	const unsigned int blocks_per_page = 1 << (PAGE_SHIFT - blockbits);
-	loff_t pos = (loff_t)lblk << blockbits;
 	struct fscrypt_zero_done done = {
 		.pending	= ATOMIC_INIT(1),
 		.done		= COMPLETION_INITIALIZER_ONSTACK(done.done),
@@ -142,6 +141,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	const unsigned int du_per_page = 1U << du_per_page_bits;
 	u64 du_index = (u64)lblk << (inode->i_blkbits - du_bits);
 	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
+	loff_t pos = (loff_t)lblk << inode->i_blkbits;
 	sector_t sector = pblk << (inode->i_blkbits - SECTOR_SHIFT);
 	struct page *pages[16]; /* write up to 16 pages at a time */
 	unsigned int nr_pages;
@@ -154,7 +154,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		return 0;
 
 	if (fscrypt_inode_uses_inline_crypto(inode))
-		return fscrypt_zeroout_range_inline_crypt(inode, lblk, sector,
+		return fscrypt_zeroout_range_inline_crypt(inode, pos, sector,
 							  len);
 
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
-- 
2.47.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
