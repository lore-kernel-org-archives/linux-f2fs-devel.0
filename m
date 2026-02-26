Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759C0FD8FC4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlhelCD8lYFsmyzRABW7UB9pUjvWBzCqHDQ88+hMyt4=; b=XMVEzCHwqEngif7wFsfzW/gnhV
	VVrlLffsGbKCVHeDiWWcBdIEbq/vLLizuz3MD3ZLpAEjHchmZJpjqcF3wUfwZHy5E3HYOkoqNY16t
	nfWOQs92XtbrokbJH0Q2YDXVQkY93awzs0bAJFi7NJSTY/3mb64eRiO69USiRw0bnBCo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vvcgu-00009u-4J;
	Thu, 26 Feb 2026 14:50:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+c5cab09b19de097b6dd3+8222+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vvcgr-00009N-B0 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 14:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CvEhxu1jDUgHPuJ6XjlwS8JGVnwgBWdyt3k5o8ZsoXw=; b=I4X+9TzVvyFpE4O1akunUQcJkx
 8Nq5uyMw1mwn/g1lJacW3go9Tm3Wc9+7lWuvsV73q198apEHltfk0LI0Wanw6k4RTnkyw+7MtLGDm
 WiCRbmA0a3wiKVaRVoByPgyq+gIOQDImdAOaGZXW35rfW7P7WK6kmqwpbs0k1KjFYrI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CvEhxu1jDUgHPuJ6XjlwS8JGVnwgBWdyt3k5o8ZsoXw=; b=lJc3CR0usj+smVgg/4XbdBWGa8
 1oblIpRRjrjsQlN7Oytw6oauG5fY/Qyu6Y2BYTa8uRSE4fiFTH+X2/Jd1s2hNOX+7B2W4vHmODr7C
 cAD2zFRR3IZfrjek1vwzLWa381dFNFHrMEg9gY0JaW0mbkih9lgCc6QnILAvfA4snKv0=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vvcgq-0000SR-B9 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 14:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=CvEhxu1jDUgHPuJ6XjlwS8JGVnwgBWdyt3k5o8ZsoXw=; b=Z8WthAZ7WKgVtkgBGZe3gde+uf
 0OEjgVOVzGLDwstnfUGSB63Xcoe2RkWydUFL6Dv0a6YqtNimE3FPP4GHPojlcf1OPTETSj1nK1/ho
 7nEtH1hudN/xRt2zstLwoUBgBKJqHxcP/t/PSHOPQFMg8qn/q/WEZrrI9oWXW90OlnrO6cUK32cSt
 uM8tDbGc+4zSib1ayULYztvwp07j6S7hTiRBbZldAmPZtwvItswnhIeVSUlHOzWIpd8otS6KiBuR9
 oPIbJFUhQ/icfVWKx9kUoCfYn91gokGc4uU0+KAP4LvcNJIkWD8nGlm1rXZGG1223GtNfdtq8WAtS
 hXDDe+hQ==;
Received: from [4.28.11.157] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vvcgf-00000006NbN-1rG3; Thu, 26 Feb 2026 14:49:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 26 Feb 2026 06:49:27 -0800
Message-ID: <20260226144954.142278-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226144954.142278-1-hch@lst.de>
References: <20260226144954.142278-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vvcgq-0000SR-B9
Subject: [f2fs-dev] [PATCH 07/14] fscrypt: pass a byte offset to
 fscrypt_mergeable_bio
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
Switch fscrypt_mergeable_bio to that convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c          | 3 ++-
 fs/crypto/inline_crypt.c | 6 +++---
 fs/ext4/page-io.c        | 3 +--
 fs/ext4/readpage.c       | 3 ++-
 fs/f2fs/data.c           | 3 ++-
 include/linux/fscrypt.h  | 4 ++--
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 6da683ea69dc..0a701d4a17ef 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -100,7 +100,8 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 			len -= blocks_this_page;
 			lblk += blocks_this_page;
 			sector += (bytes_this_page >> SECTOR_SHIFT);
-			if (!len || !fscrypt_mergeable_bio(bio, inode, lblk))
+			if (!len || !fscrypt_mergeable_bio(bio, inode,
+					(loff_t)lblk << blockbits))
 				break;
 		}
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 5279565e9846..b0954d17904b 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -316,7 +316,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
  * fscrypt_mergeable_bio() - test whether data can be added to a bio
  * @bio: the bio being built up
  * @inode: the inode for the next part of the I/O
- * @next_lblk: the next file logical block number in the I/O
+ * @pos: the next file position (in bytes) in the I/O
  *
  * When building a bio which may contain data which should undergo inline
  * encryption (or decryption) via fscrypt, filesystems should call this function
@@ -334,7 +334,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
  * Return: true iff the I/O is mergeable
  */
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
-			   u64 next_lblk)
+			   loff_t pos)
 {
 	const struct bio_crypt_ctx *bc = bio->bi_crypt_context;
 	const struct fscrypt_inode_info *ci;
@@ -354,7 +354,7 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	if (bc->bc_key != ci->ci_enc_key.blk_key)
 		return false;
 
-	fscrypt_generate_dun(ci, next_lblk << inode->i_blkbits, next_dun);
+	fscrypt_generate_dun(ci, pos, next_dun);
 	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 3db3c19a29e5..5df5e7e6adde 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -448,8 +448,7 @@ static bool io_submit_need_new_bio(struct ext4_io_submit *io,
 	if (bh->b_blocknr != io->io_next_block)
 		return true;
 	if (!fscrypt_mergeable_bio(io->io_bio, inode,
-			(folio_pos(io_folio) + bh_offset(bh)) >>
-			 inode->i_blkbits))
+			folio_pos(io_folio) + bh_offset(bh)))
 		return true;
 	return false;
 }
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 830f3b8a321f..ba7cfddd6038 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -342,7 +342,8 @@ static int ext4_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 		 * BIO off first?
 		 */
 		if (bio && (last_block_in_bio != first_block - 1 ||
-			    !fscrypt_mergeable_bio(bio, inode, next_block))) {
+			    !fscrypt_mergeable_bio(bio, inode,
+				(loff_t)next_block << blkbits))) {
 		submit_and_realloc:
 			blk_crypto_submit_bio(bio);
 			bio = NULL;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 338df7a2aea6..dca273fedfde 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -541,7 +541,8 @@ static bool f2fs_crypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	if (fio && fio->encrypted_page)
 		return !bio_has_crypt_ctx(bio);
 
-	return fscrypt_mergeable_bio(bio, inode, next_idx);
+	return fscrypt_mergeable_bio(bio, inode,
+			(loff_t)next_idx << inode->i_blkbits);
 }
 
 void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 26561b7994e0..98fb14660d40 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -870,7 +870,7 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 			       gfp_t gfp_mask);
 
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
-			   u64 next_lblk);
+			   loff_t pos);
 
 bool fscrypt_dio_supported(struct inode *inode);
 
@@ -889,7 +889,7 @@ static inline void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 
 static inline bool fscrypt_mergeable_bio(struct bio *bio,
 					 const struct inode *inode,
-					 u64 next_lblk)
+					 loff_t pos)
 {
 	return true;
 }
-- 
2.47.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
