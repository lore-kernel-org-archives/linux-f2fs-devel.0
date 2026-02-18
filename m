Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF88E9A03B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Feb 2026 06:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c91ZHpKSQOrbjL9Yne/dtq282A8creB4OB9+dx+GVVc=; b=Z1bB9VIZeQ2ajXYHKIPJS8vTbO
	zILlSmadGH3i0iQxnwQNbfG46m7zaEsf3eykWOEjDG1/jpgPG3HKmJdRIuZSFtjVQju5NsX4nGeod
	UDEQVRU4PFl9vFRvnN7mDJUiGemR1+vwHSLTwHkA6Dm6KnAODbUH91k3xJj1x1tDqBYI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsarK-0002U7-QP;
	Wed, 18 Feb 2026 06:16:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+b7a6f314dcfbee4e7dbb+8214+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vsarI-0002U1-UG for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 06:16:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+UxDPHpgLWPAQ48/oe5SjMgmPm5GDnzoABlzt1PeouA=; b=I+5AE/1H410iy5YN5FA2wYDXHn
 LbMVqbQ1/NSy5GTUtQD84fu2BUESkjP5IGN0aznVfdNp0F7zw481Spe+jux+ln9ebfx3tZFLghcHF
 CXFTrOkKEo696rS7kqezd68TJv+U4vBE0iKMzOhTQK5VEnIayNp9ZnO6/mmPlu7QEKQQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+UxDPHpgLWPAQ48/oe5SjMgmPm5GDnzoABlzt1PeouA=; b=MAUmI1RfBRqO2L1+vmUFcRXktW
 pJI5TYyodle+nB+wRc2YmM5E9o88hu1mM3vGGrDr52aCqtEx3atSYwuY2YBwfTmJlObkkPliDbtEd
 MZ58GLYYkcABGVPUFfpHk2BdaWkJixCZZyyGfWUxEXoBcAllCv6NdypTOhim8VFE23PA=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsarI-0006KW-Bf for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 06:16:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=+UxDPHpgLWPAQ48/oe5SjMgmPm5GDnzoABlzt1PeouA=; b=UIGhpvD+Fh1mQPvtisuEczdJq4
 vjNDcXGn+JbvJ9WUBDqJAC08lJ1rZjX2+m38VZx2fPQKNA1uwZ9QRycQwKHT7i6KdJryF1sI2JOJa
 ueABy0icfl7cSEShRm0gBhq+PCLT7eMmtce7J6WGz55Q1AdSlj2CJsqaGK+WbfUN5cnfSR7W2MG1m
 DYhZpg4dpCdsNRRy9zjiWDd/gG5pViQ1QdtRbj2JwiatLW1ETMD7CeoE61KMajry7GF0bhbUn91Y/
 jizXelkxDhRhIIQfmNClbMpRDcXtwbmx+hTmuO5kXImyu7+XHCtzdGhfLpIDyT4uy3H6Yd2xfRZdS
 ldbDMjyw==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vsar6-00000009Li9-3jsx; Wed, 18 Feb 2026 06:16:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 18 Feb 2026 07:14:45 +0100
Message-ID: <20260218061531.3318130-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218061531.3318130-1-hch@lst.de>
References: <20260218061531.3318130-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vsarI-0006KW-Bf
Subject: [f2fs-dev] [PATCH 7/9] fscrypt: pass a byte offset to
 fscrypt_zeroout_range
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

Logical offsets into an inode are usually expresssed as bytes in the VFS.
Switch fscrypt_zeroout_range to that convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c         | 6 +++---
 fs/ext4/inode.c         | 3 ++-
 fs/f2fs/file.c          | 4 +++-
 include/linux/fscrypt.h | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 36025ce7a264..e41e605cf7e6 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -113,7 +113,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 /**
  * fscrypt_zeroout_range() - zero out a range of blocks in an encrypted file
  * @inode: the file's inode
- * @lblk: the first file logical block to zero out
+ * @pos: the first file logical offset (in bytes) to zero out
  * @pblk: the first filesystem physical block to zero out
  * @len: number of blocks to zero out
  *
@@ -127,7 +127,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
  *
  * Return: 0 on success; -errno on failure.
  */
-int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
+int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 			  sector_t pblk, unsigned int len)
 {
 	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
@@ -135,7 +135,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	const unsigned int du_size = 1U << du_bits;
 	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
 	const unsigned int du_per_page = 1U << du_per_page_bits;
-	u64 du_index = (u64)lblk << (inode->i_blkbits - du_bits);
+	u64 du_index = pos >> du_bits;
 	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
 	loff_t pos = (loff_t)lblk << inode->i_blkbits;
 	sector_t sector = pblk << (inode->i_blkbits - SECTOR_SHIFT);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 396dc3a5d16b..945613c95ffa 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -405,7 +405,8 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 	KUNIT_STATIC_STUB_REDIRECT(ext4_issue_zeroout, inode, lblk, pblk, len);
 
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
-		return fscrypt_zeroout_range(inode, lblk, pblk, len);
+		return fscrypt_zeroout_range(inode,
+				(loff_t)lblk << inode->i_blkbits, pblk, len);
 
 	ret = sb_issue_zeroout(inode->i_sb, pblk, len, GFP_NOFS);
 	if (ret > 0)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c8a2f17a8f11..239c2666ceb5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4162,7 +4162,9 @@ static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
 
 	if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT)) {
 		if (IS_ENCRYPTED(inode))
-			ret = fscrypt_zeroout_range(inode, off, block, len);
+			ret = fscrypt_zeroout_range(inode,
+					(loff_t)off << inode->i_blkbits, block,
+					len);
 		else
 			ret = blkdev_issue_zeroout(bdev, sector, nr_sects,
 					GFP_NOFS, 0);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 5b86d7d0d367..065f909ebda2 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -450,7 +450,7 @@ u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
 
 /* bio.c */
 bool fscrypt_decrypt_bio(struct bio *bio);
-int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
+int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 			  sector_t pblk, unsigned int len);
 
 /* hooks.c */
@@ -755,7 +755,7 @@ static inline bool fscrypt_decrypt_bio(struct bio *bio)
 	return true;
 }
 
-static inline int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
+static inline int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 					sector_t pblk, unsigned int len)
 {
 	return -EOPNOTSUPP;
-- 
2.47.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
