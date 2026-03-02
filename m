Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1321EA4E07
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=togWG2QjaH/RAr/ce8OoAP29QhxjDVfiMO9AC1J+bvE=; b=LUTFDnEYA3nyyx9+82n/vibW/D
	IZiZ9sWQdbO0Q3SAcLmzfMhkXscu8stUQG4cpJTb5SeHfTbmtxMacxKOwWyguPjZf2HChVJL8WmIY
	yfzOHWiWx1NtSRZvZ88TJJHxdtCifo1k5Q0FSK/Le99L7yZmz7YCsDKh/jYyU1DxDL2w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vx47j-0002HN-JL;
	Mon, 02 Mar 2026 14:19:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+ce5019daea4c3780914a+8226+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vx47g-0002Go-F2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Mar 2026 14:19:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jQrr31xhOATfhSVQeYtAu2Gj/+iqTwvIFNXJ6Ienhz0=; b=ccX9BCk13U5LqCmWRrdw1agYyU
 X9LvqYRORKF7m9Qo4rxIiwIfdXt7jk/LLF+AOa20ByNfCD/HLrMMs38T7HUTWJCkZHc7cTYc0ghLk
 i1FvngG9Tj4hU7BGlkKFsCdPxCpnYJm8Ps0fz8vcO4STTFzIZv4D2tgsMoIp5UP3jdoQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jQrr31xhOATfhSVQeYtAu2Gj/+iqTwvIFNXJ6Ienhz0=; b=TiPmGXnrEmCnBWIyLDDA5F+rrj
 ST+Tjtq8czqWKEUPXZhnRY3QKy2ggJI0/CtsrT/MTqyh5/Tg4VXpRpzMEKb3frnpg8COqJEC3qWGe
 qmuEf7TCiJq+rY6VO+rKkKugb5H2qyabKeNaSyRbJQsC7/gZ0Y3nr6ujiWul38kX8z/c=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vx47f-0001US-Ox for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Mar 2026 14:19:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=jQrr31xhOATfhSVQeYtAu2Gj/+iqTwvIFNXJ6Ienhz0=; b=wG+oB8KvJfQ7mvHGgReBMYbr+w
 EHM4psIEP/MVbCOBq1+uAA/W0K3NdOgTJzQgmmb0BBpnWDYwdOs2kaoWZvWIXxCUMyetQGDxVTMU9
 gKtpOvlP12ZUK89rh/vnzKWA+kPUi+sBbhi6/YoRhrnZCQ7WqK+RSVPMpp7l32s3sWOd1ElYmoeeO
 /6XMT95Rzdh1Xe/gme/U/6oX3YkgD6TLWfJxEXiMiHosGpWJ/8AWAmdmyzGyKgnB7tSEX+cWcxPGn
 /qoGMaH2F+wU4a1rTwaWJ0IwZirljsiE29rJlTWLqs8U6GsBf/ggNT3GkeGjNp51Fy8dkJK/qzfd2
 /AU27scg==;
Received: from [2604:3d08:797f:2840::9d5f] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vx47U-0000000DDTu-39cO; Mon, 02 Mar 2026 14:19:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Date: Mon,  2 Mar 2026 06:18:17 -0800
Message-ID: <20260302141922.370070-13-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302141922.370070-1-hch@lst.de>
References: <20260302141922.370070-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vx47f-0001US-Ox
Subject: [f2fs-dev] [PATCH 12/14] fscrypt: pass a byte length to
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

Range lengths are usually expressed as bytes in the VFS, switch
fscrypt_zeroout_range to this convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c         | 11 ++++++-----
 fs/ext4/inode.c         |  3 ++-
 fs/f2fs/file.c          |  2 +-
 include/linux/fscrypt.h |  6 +++---
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index a07ac8dcf851..93087635d987 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -115,12 +115,13 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
  * @inode: the file's inode
  * @pos: the first file position (in bytes) to zero out
  * @pblk: the first filesystem physical block to zero out
- * @len: number of blocks to zero out
+ * @len: bytes to zero out
  *
  * Zero out filesystem blocks in an encrypted regular file on-disk, i.e. write
  * ciphertext blocks which decrypt to the all-zeroes block.  The blocks must be
  * both logically and physically contiguous.  It's also assumed that the
- * filesystem only uses a single block device, ->s_bdev.
+ * filesystem only uses a single block device, ->s_bdev.  @len must be a
+ * multiple of the file system logical block size.
  *
  * Note that since each block uses a different IV, this involves writing a
  * different ciphertext to each block; we can't simply reuse the same one.
@@ -128,7 +129,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
  * Return: 0 on success; -errno on failure.
  */
 int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
-			  sector_t pblk, unsigned int len)
+			  sector_t pblk, u64 len)
 {
 	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	const unsigned int du_bits = ci->ci_data_unit_bits;
@@ -136,7 +137,7 @@ int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
 	const unsigned int du_per_page = 1U << du_per_page_bits;
 	u64 du_index = pos >> du_bits;
-	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
+	u64 du_remaining = len >> du_bits;
 	sector_t sector = pblk << (inode->i_blkbits - SECTOR_SHIFT);
 	struct page *pages[16]; /* write up to 16 pages at a time */
 	unsigned int nr_pages;
@@ -150,7 +151,7 @@ int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 
 	if (fscrypt_inode_uses_inline_crypto(inode))
 		return fscrypt_zeroout_range_inline_crypt(inode, pos, sector,
-				(u64)len << inode->i_blkbits);
+				len);
 
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
 	nr_pages = min_t(u64, ARRAY_SIZE(pages),
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 945613c95ffa..8ef61198e14c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -406,7 +406,8 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
 		return fscrypt_zeroout_range(inode,
-				(loff_t)lblk << inode->i_blkbits, pblk, len);
+				(loff_t)lblk << inode->i_blkbits, pblk,
+				(u64)len << inode->i_blkbits);
 
 	ret = sb_issue_zeroout(inode->i_sb, pblk, len, GFP_NOFS);
 	if (ret > 0)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 239c2666ceb5..8785f7c13657 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4164,7 +4164,7 @@ static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
 		if (IS_ENCRYPTED(inode))
 			ret = fscrypt_zeroout_range(inode,
 					(loff_t)off << inode->i_blkbits, block,
-					len);
+					(u64)len << inode->i_blkbits);
 		else
 			ret = blkdev_issue_zeroout(bdev, sector, nr_sects,
 					GFP_NOFS, 0);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 9fc15e1fbe57..90ac62fda926 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -450,8 +450,8 @@ u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
 
 /* bio.c */
 bool fscrypt_decrypt_bio(struct bio *bio);
-int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
-			  sector_t pblk, unsigned int len);
+int fscrypt_zeroout_range(const struct inode *inode, loff_t pos, sector_t pblk,
+			  u64 len);
 
 /* hooks.c */
 int fscrypt_file_open(struct inode *inode, struct file *filp);
@@ -756,7 +756,7 @@ static inline bool fscrypt_decrypt_bio(struct bio *bio)
 }
 
 static inline int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
-					sector_t pblk, unsigned int len)
+					sector_t pblk, u64 len)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.47.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
