Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11865C53219
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j6jiM1pj09hqBhEVIHKLPf0VglXWqR9Gv1YC1fUO9yw=; b=FSJT7JI3RBGBOUrgOUmP46dmJ/
	BkOm4jtNwkfWZPAEm2dVBPAt+9OvZ63FlHPacic/B5ts5cy8ZBYb5GAnS9KfN9IKf/DfGrg9qX67X
	MPIjLbeqg34kVgPXbg57Ira1/E6+ZJxv7El+OmIPnWnTirlstCH6qOHGgfLJEce9otqg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wp6Cc-0007Qc-1S;
	Wed, 29 Jul 2026 15:28:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wp6CL-0007Q4-Je
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:27:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V0k1AZmb/TvfY7wNf00QwgRAmyWqz6BMjGXKysMVXCI=; b=hJdLI+9TJ1Tlc64bOo4xOoG86R
 a5iLlTRsdGX77tNwomFYFAaNDpV3IUv7+oICyEX9D1uHv/yYEzPbCPYq50BjAo3aWqJCKKN7xztVc
 Q5YVC2R8He3fe+RIIF3z27JtHwAKdgy8p+gXk5T9wqlTtVFHTFv5JQcHL+psxpqoU1iY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V0k1AZmb/TvfY7wNf00QwgRAmyWqz6BMjGXKysMVXCI=; b=J
 A1dqrGS7B9cR7bomrAk6yaQ3WRPC/NCeBwat5rJ5it7ONHUyWfP4rGom7eEdncPP4poD5DdKUwZAu
 B5QkPWQdnDpkPaT80psw5Kc3hxF5KZnMOHSJ1HPyVDIfUEJim/ZXkaBGY7XYRZraNZ0VOl1XHIYz/
 xGT/MYt3aLjxTvJk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp6CI-00013a-H3 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:27:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60C4A6001D;
 Wed, 29 Jul 2026 15:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C1E1F00A3F;
 Wed, 29 Jul 2026 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785338865;
 bh=V0k1AZmb/TvfY7wNf00QwgRAmyWqz6BMjGXKysMVXCI=;
 h=From:To:Cc:Subject:Date;
 b=Xje73TiTqYQPZPhEPQIExUs2UFQsFkWuaH+Kh88qKjzKJeOamBj+t0rKn6PsIGVP0
 2+Xf5twiaCwOOJo/TARfoGbM7cSPHArOvl/Qp+MyrqgSEHpSscUMIi7bqDG1kTaHNs
 NSaiYc5982FWa5ebgtkG1CvPE6GQZ/iCpzLMloYCY/orBM9/IAli/vd67QB/V0CDlA
 T6LTUmjRCm2MObWMUyjW7Ze68ygjpzB32YUZplxbU71vkcCB0I7PL/3YrngO5ha9S4
 OskiTSEe2m9/uGtMUaknTW/tCgoME3bXZn31F7KF3ubvEMVkeEHUGNId5E6zYlD68Z
 UGHLvXrJFOCmg==
To: stable@vger.kernel.org
Date: Wed, 29 Jul 2026 08:25:39 -0700
Message-ID: <20260729152539.21888-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Headers-End: 1wp6CI-00013a-H3
Subject: [f2fs-dev] [PATCH 6.6] fscrypt: Avoid dynamic allocation in
 fscrypt_get_devices()
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
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

commit 6fe4e4b8259e1330945b5f3c9476e08473b8e0e8 upstream.

When a blk_crypto_key starts being used or is evicted, fs/crypto/ calls
fscrypt_get_devices() to get the filesystem's list of block devices,
then iterates over them and calls blk_crypto_config_supported(),
blk_crypto_start_using_key(), or blk_crypto_evict_key() on each one.

Currently, the block device pointers are placed in a dynamically
allocated array.  This dynamic allocation is problematic because:

- It can fail, especially at the fscrypt_destroy_inline_crypt_key() call
  site when it's invoked for inode eviction under direct reclaim.

- fscrypt_destroy_inline_crypt_key() doesn't handle the failure.  It
  just zeroizes and frees the blk_crypto_key without calling
  blk_crypto_evict_key().  That causes a use-after-free.

For now, let's fix this in the straightforward and easily-backportable
way by switching to an on-stack array.  Currently the fscrypt
multi-device functionality is used only by f2fs, which has a hardcoded
limit of 8 block devices.  An on-stack array works fine for that.

(Of course, this solution won't scale up to large number of block
devices.  For that we'd need a different solution, like moving the block
device iteration into the filesystem.  Or in the case of btrfs, which
will only support blk-crypto-fallback, we should make it just call
blk-crypto-fallback directly, so the block devices won't be needed.)

Fixes: 22e9947a4b2b ("fscrypt: stop holding extra request_queue references")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260713023708.9245-1-ebiggers%40kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260719055602.78828-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/crypto/inline_crypt.c | 57 ++++++++++++++--------------------------
 fs/f2fs/super.c          | 25 ++++++++++--------
 include/linux/fscrypt.h  | 18 +++++++------
 3 files changed, 44 insertions(+), 56 deletions(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 8bfb3ce864766..47645c5539bc8 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -21,22 +21,14 @@
 
 #include "fscrypt_private.h"
 
-static struct block_device **fscrypt_get_devices(struct super_block *sb,
-						 unsigned int *num_devs)
+static unsigned int
+fscrypt_get_devices(struct super_block *sb,
+		    struct block_device *devs[FSCRYPT_MAX_DEVICES])
 {
-	struct block_device **devs;
-
-	if (sb->s_cop->get_devices) {
-		devs = sb->s_cop->get_devices(sb, num_devs);
-		if (devs)
-			return devs;
-	}
-	devs = kmalloc(sizeof(*devs), GFP_KERNEL);
-	if (!devs)
-		return ERR_PTR(-ENOMEM);
+	if (sb->s_cop->get_devices)
+		return sb->s_cop->get_devices(sb, devs);
 	devs[0] = sb->s_bdev;
-	*num_devs = 1;
-	return devs;
+	return 1;
 }
 
 static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_info *ci)
@@ -95,7 +87,7 @@ int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
 	const struct inode *inode = ci->ci_inode;
 	struct super_block *sb = inode->i_sb;
 	struct blk_crypto_config crypto_cfg;
-	struct block_device **devs;
+	struct block_device *devs[FSCRYPT_MAX_DEVICES];
 	unsigned int num_devs;
 	unsigned int i;
 
@@ -132,20 +124,15 @@ int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
 	crypto_cfg.data_unit_size = sb->s_blocksize;
 	crypto_cfg.dun_bytes = fscrypt_get_dun_bytes(ci);
 
-	devs = fscrypt_get_devices(sb, &num_devs);
-	if (IS_ERR(devs))
-		return PTR_ERR(devs);
-
+	num_devs = fscrypt_get_devices(sb, devs);
 	for (i = 0; i < num_devs; i++) {
 		if (!blk_crypto_config_supported(devs[i], &crypto_cfg))
-			goto out_free_devs;
+			return 0;
 	}
 
 	fscrypt_log_blk_crypto_impl(ci->ci_mode, devs, num_devs, &crypto_cfg);
 
 	ci->ci_inlinecrypt = true;
-out_free_devs:
-	kfree(devs);
 
 	return 0;
 }
@@ -158,7 +145,7 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 	struct super_block *sb = inode->i_sb;
 	enum blk_crypto_mode_num crypto_mode = ci->ci_mode->blk_crypto_mode;
 	struct blk_crypto_key *blk_key;
-	struct block_device **devs;
+	struct block_device *devs[FSCRYPT_MAX_DEVICES];
 	unsigned int num_devs;
 	unsigned int i;
 	int err;
@@ -175,17 +162,12 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 	}
 
 	/* Start using blk-crypto on all the filesystem's block devices. */
-	devs = fscrypt_get_devices(sb, &num_devs);
-	if (IS_ERR(devs)) {
-		err = PTR_ERR(devs);
-		goto fail;
-	}
+	num_devs = fscrypt_get_devices(sb, devs);
 	for (i = 0; i < num_devs; i++) {
 		err = blk_crypto_start_using_key(devs[i], blk_key);
 		if (err)
 			break;
 	}
-	kfree(devs);
 	if (err) {
 		fscrypt_err(inode, "error %d starting to use blk-crypto", err);
 		goto fail;
@@ -209,20 +191,21 @@ void fscrypt_destroy_inline_crypt_key(struct super_block *sb,
 				      struct fscrypt_prepared_key *prep_key)
 {
 	struct blk_crypto_key *blk_key = prep_key->blk_key;
-	struct block_device **devs;
+	struct block_device *devs[FSCRYPT_MAX_DEVICES];
 	unsigned int num_devs;
 	unsigned int i;
 
 	if (!blk_key)
 		return;
 
-	/* Evict the key from all the filesystem's block devices. */
-	devs = fscrypt_get_devices(sb, &num_devs);
-	if (!IS_ERR(devs)) {
-		for (i = 0; i < num_devs; i++)
-			blk_crypto_evict_key(devs[i], blk_key);
-		kfree(devs);
-	}
+	/*
+	 * Evict the key from all the filesystem's block devices.
+	 * This *must* be done before the key is freed.
+	 */
+	num_devs = fscrypt_get_devices(sb, devs);
+	for (i = 0; i < num_devs; i++)
+		blk_crypto_evict_key(devs[i], blk_key);
+
 	kfree_sensitive(blk_key);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c018d548e1634..95adc2c4c3c08 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3248,24 +3248,27 @@ static void f2fs_get_ino_and_lblk_bits(struct super_block *sb,
 	*lblk_bits_ret = 8 * sizeof(block_t);
 }
 
-static struct block_device **f2fs_get_devices(struct super_block *sb,
-					      unsigned int *num_devs)
+static unsigned int
+f2fs_get_devices(struct super_block *sb,
+		 struct block_device *devs[FSCRYPT_MAX_DEVICES])
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	struct block_device **devs;
+	int ndevs;
 	int i;
 
-	if (!f2fs_is_multi_device(sbi))
-		return NULL;
+	static_assert(MAX_DEVICES <= FSCRYPT_MAX_DEVICES);
 
-	devs = kmalloc_array(sbi->s_ndevs, sizeof(*devs), GFP_KERNEL);
-	if (!devs)
-		return ERR_PTR(-ENOMEM);
+	if (!f2fs_is_multi_device(sbi)) {
+		devs[0] = sb->s_bdev;
+		return 1;
+	}
+	ndevs = sbi->s_ndevs;
+	if (WARN_ON_ONCE(ndevs > FSCRYPT_MAX_DEVICES))
+		ndevs = FSCRYPT_MAX_DEVICES;
 
-	for (i = 0; i < sbi->s_ndevs; i++)
+	for (i = 0; i < ndevs; i++)
 		devs[i] = FDEV(i).bdev;
-	*num_devs = sbi->s_ndevs;
-	return devs;
+	return ndevs;
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index c895b12737a19..e55ba9f1e3839 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -57,6 +57,9 @@ struct fscrypt_name {
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
 #define FSCRYPT_SET_CONTEXT_MAX_SIZE	40
 
+/* Maximum supported number of block devices per filesystem */
+#define FSCRYPT_MAX_DEVICES	8
+
 #ifdef CONFIG_FS_ENCRYPTION
 
 /*
@@ -161,21 +164,20 @@ struct fscrypt_operations {
 				      int *ino_bits_ret, int *lblk_bits_ret);
 
 	/*
-	 * Return an array of pointers to the block devices to which the
-	 * filesystem may write encrypted file contents, NULL if the filesystem
-	 * only has a single such block device, or an ERR_PTR() on error.
+	 * Retrieve the list of block devices to which the filesystem may write
+	 * encrypted file contents.
 	 *
-	 * On successful non-NULL return, *num_devs is set to the number of
-	 * devices in the returned array.  The caller must free the returned
-	 * array using kfree().
+	 * This writes the block_device pointers to @devs and returns the count
+	 * (between 1 and FSCRYPT_MAX_DEVICES inclusively).
 	 *
 	 * If the filesystem can use multiple block devices (other than block
 	 * devices that aren't used for encrypted file contents, such as
 	 * external journal devices), and wants to support inline encryption,
 	 * then it must implement this function.  Otherwise it's not needed.
 	 */
-	struct block_device **(*get_devices)(struct super_block *sb,
-					     unsigned int *num_devs);
+	unsigned int (*get_devices)(
+		struct super_block *sb,
+		struct block_device *devs[FSCRYPT_MAX_DEVICES]);
 };
 
 static inline struct fscrypt_info *fscrypt_get_info(const struct inode *inode)

base-commit: c5596480c50e081668ff170e80db6314a033be11
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
