Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90D6C44501
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 02:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aySfqYKLCm8YaArwIf50AH/pDhvFQIS4pXwyDPEjV7Q=; b=UV048SJ9P9P6WcNyIa696DnIdn
	Ct9G7Xio9iZ0tXlDmrdT6nNJkWILLNrXEAWEWj1UjAHZ9nD7/zy+o+jDmNQDi5TokQcEqsnY+ZreC
	rmeIa5rhSXXPL7j7f1aojc3OT97GT8IIJDGiR1M1sWBHsn0m9eDjv/kVoowdfnmLPw7E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wj6a9-0007kl-VC;
	Mon, 13 Jul 2026 02:39:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wj6a8-0007kd-7Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 02:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QaORzSDkR90GYfmKCub9QkAr8t4t0KNC6u6lCI50uUA=; b=ic1mYZO+RKbx3rqiSotZi8X/V6
 olOaxhPzlDZCjcG04LtD0M2ftrNJ22Qi9CS5v3M+yHwBikwEnyXBj16clpg2wGUgCYhjwEEDjgzN0
 RTlpQJALVFP21ZGX4NF2KgeMYLYznF1MYiYmbVxXfxnJyRlI7ZPRm4QJhzPUKGd6ET44=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QaORzSDkR90GYfmKCub9QkAr8t4t0KNC6u6lCI50uUA=; b=S7Mek2mLrP3KR4GFKtxmWUBER1
 3GS3QnBvB6CnQq1BSx9QVPesko8waPLylOD5E5tp71sFHIwsbbnmTNl3/d+5OvLLAZK6yVAUP3tuO
 Smod4iapxPy9YUSYBVhlBsMx0GxjD0y2WFLdUhekXvb7CwxLC22a1ROg/V3FePoDRoWU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wj6a5-0003Ae-03 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 02:39:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B55AD43601;
 Mon, 13 Jul 2026 02:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFDC1F000E9;
 Mon, 13 Jul 2026 02:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783910375;
 bh=QaORzSDkR90GYfmKCub9QkAr8t4t0KNC6u6lCI50uUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=d+Phk90hDIyyQR7xf45lSXzQN9S34n7eDLdI/5q0yuSibJapOgyfO9t+AkO8JJWmL
 zSJJK3F7T12A6eoFm9mQRG1QZL47sCf34o9gDaw1wpqUKgfd1dl5jhNu4kak/DFIeR
 kP8GcFl8sekY3LmOj3DRKJAt/12am9Vgelly1Fn74Evp2pBZUa6QAM/CuGaPl7hyxs
 YDbsMyMC/Hjx4Sx89Odhijd74zGOWbpIvWZ01RbPB7WweYP3IyTleQzSaDCBRCD+1v
 9BQmCdW7Acu6NFJk3V1rMbu6D7c8roAGtfQFg4T4iFa9CfdPdUSRrRqTFhZL2YPVXp
 UC+MxzbA7hRig==
To: linux-fscrypt@vger.kernel.org
Date: Sun, 12 Jul 2026 22:36:54 -0400
Message-ID: <20260713023708.9245-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713023708.9245-1-ebiggers@kernel.org>
References: <20260713023708.9245-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wj6a5-0003Ae-03
Subject: [f2fs-dev] [PATCH v3 03/17] blk-crypto: Allow control over whether
 hardware is used
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

fscrypt uses inline encryption hardware only when the "inlinecrypt"
mount option is given.  I'd like to keep that behavior even after
standardizing on the blk-crypto API for file contents encryption.  That
is, the default should continue to be the well-tested CPU-based
encryption code, and the use of inline encryption hardware should
continue to be an opt-in feature for systems where it's beneficial and
has been fully validated (including verifying ciphertext correctness).

To support this use case, extend blk_crypto_config with a new flag
BLK_CRYPTO_CFG_ALLOW_HW.

For now it's always set.  Later commits will change that.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 block/blk-crypto.c          | 11 ++++++++++-
 drivers/md/dm-inlinecrypt.c |  3 ++-
 fs/crypto/inline_crypt.c    |  4 +++-
 include/linux/blk-crypto.h  | 13 ++++++++++++-
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index de60f03b4d4b..0fe6ef0eea1d 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -300,6 +300,7 @@ int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
  * @dun_bytes: number of bytes that will be used to specify the DUN when this
  *	       key is used
  * @data_unit_size: the data unit size to use for en/decryption
+ * @flags: BLK_CRYPTO_CFG_* flags
  *
  * Return: 0 on success, -errno on failure.  The caller is responsible for
  *	   zeroizing both blk_key and key_bytes when done with them.
@@ -309,7 +310,7 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key,
 			enum blk_crypto_key_type key_type,
 			enum blk_crypto_mode_num crypto_mode,
 			unsigned int dun_bytes,
-			unsigned int data_unit_size)
+			unsigned int data_unit_size, int flags)
 {
 	const struct blk_crypto_mode *mode;
 
@@ -318,6 +319,9 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key,
 	if (crypto_mode >= ARRAY_SIZE(blk_crypto_modes))
 		return -EINVAL;
 
+	if (flags & ~BLK_CRYPTO_CFG_ALLOW_HW)
+		return -EINVAL;
+
 	mode = &blk_crypto_modes[crypto_mode];
 	switch (key_type) {
 	case BLK_CRYPTO_KEY_TYPE_RAW:
@@ -328,6 +332,8 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key,
 		if (key_size < mode->security_strength ||
 		    key_size > BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE)
 			return -EINVAL;
+		if (!(flags & BLK_CRYPTO_CFG_ALLOW_HW))
+			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
@@ -343,6 +349,7 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key,
 	blk_key->crypto_cfg.dun_bytes = dun_bytes;
 	blk_key->crypto_cfg.data_unit_size = data_unit_size;
 	blk_key->crypto_cfg.key_type = key_type;
+	blk_key->crypto_cfg.flags = flags;
 	blk_key->data_unit_size_bits = ilog2(data_unit_size);
 	blk_key->size = key_size;
 	memcpy(blk_key->bytes, key_bytes, key_size);
@@ -368,6 +375,8 @@ bool blk_crypto_config_supported_natively(struct block_device *bdev,
 
 	if (!profile)
 		return false;
+	if (!(cfg->flags & BLK_CRYPTO_CFG_ALLOW_HW))
+		return false;
 	if (!(profile->modes_supported[cfg->crypto_mode] & cfg->data_unit_size))
 		return false;
 	if (profile->max_dun_bytes_supported < cfg->dun_bytes)
diff --git a/drivers/md/dm-inlinecrypt.c b/drivers/md/dm-inlinecrypt.c
index be1b4aa8f28b..35379f5c84df 100644
--- a/drivers/md/dm-inlinecrypt.c
+++ b/drivers/md/dm-inlinecrypt.c
@@ -406,7 +406,8 @@ static int inlinecrypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	err = blk_crypto_init_key(&ctx->key, key_bytes, ctx->key_size,
 				  ctx->key_type, cipher->mode_num,
-				  dun_bytes, ctx->sector_size);
+				  dun_bytes, ctx->sector_size,
+				  BLK_CRYPTO_CFG_ALLOW_HW);
 	if (err) {
 		ti->error = "Error initializing blk-crypto key";
 		goto bad;
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 47324062fee5..aaf71f6068b0 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -134,6 +134,7 @@ int fscrypt_select_encryption_impl(struct fscrypt_inode_info *ci,
 	crypto_cfg.dun_bytes = fscrypt_get_dun_bytes(ci);
 	crypto_cfg.key_type = is_hw_wrapped_key ?
 		BLK_CRYPTO_KEY_TYPE_HW_WRAPPED : BLK_CRYPTO_KEY_TYPE_RAW;
+	crypto_cfg.flags = BLK_CRYPTO_CFG_ALLOW_HW;
 
 	devs = fscrypt_get_devices(sb, &num_devs);
 	if (IS_ERR(devs))
@@ -175,7 +176,8 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 
 	err = blk_crypto_init_key(blk_key, key_bytes, key_size, key_type,
 				  crypto_mode, fscrypt_get_dun_bytes(ci),
-				  1U << ci->ci_data_unit_bits);
+				  1U << ci->ci_data_unit_bits,
+				  BLK_CRYPTO_CFG_ALLOW_HW);
 	if (err) {
 		fscrypt_err(inode, "error %d initializing blk-crypto key", err);
 		goto fail;
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index f7c3cb4a342f..5f40821f99cd 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -68,6 +68,15 @@ enum blk_crypto_key_type {
  */
 #define BLK_CRYPTO_SW_SECRET_SIZE	32
 
+/* Flags for blk_crypto_config::flags: */
+
+/*
+ * If set, inline encryption hardware will be used if available.
+ * If unset, CPU-based encryption will always be used (requires
+ * CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)
+ */
+#define BLK_CRYPTO_CFG_ALLOW_HW		(1 << 0)
+
 /**
  * struct blk_crypto_config - an inline encryption key's crypto configuration
  * @crypto_mode: encryption algorithm this key is for
@@ -77,12 +86,14 @@ enum blk_crypto_key_type {
  *	filesystem block size or the disk sector size.
  * @dun_bytes: the maximum number of bytes of DUN used when using this key
  * @key_type: the type of this key -- either raw or hardware-wrapped
+ * @flags: BLK_CRYPTO_CFG_* flags
  */
 struct blk_crypto_config {
 	enum blk_crypto_mode_num crypto_mode;
 	unsigned int data_unit_size;
 	unsigned int dun_bytes;
 	enum blk_crypto_key_type key_type;
+	int flags;
 };
 
 /**
@@ -150,7 +161,7 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key,
 			enum blk_crypto_key_type key_type,
 			enum blk_crypto_mode_num crypto_mode,
 			unsigned int dun_bytes,
-			unsigned int data_unit_size);
+			unsigned int data_unit_size, int flags);
 
 int blk_crypto_start_using_key(struct block_device *bdev,
 			       const struct blk_crypto_key *key);
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
