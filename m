Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE588C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 02:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=STJ2FOCdmGLZh275oqoBXKVrL/0vmwI5Gg/Gm9Poqa0=; b=Wy4iVB3nbpjJ3SOEhGDXroeV6c
	upaARMOQfnEEiMeDrzMgr+fE9YH5qSrJ96f2oHG4+XNx27nHkxVOzgm8hsZNcVm5+P8Xm0z/QI+p7
	LUOkFb+RL/HBL14N12A+3Ft8rEHCTUuNWmEfeSNfcms0y2SFMw3MJxhbivbWZj/RAvjs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wj6aA-0006bz-0e;
	Mon, 13 Jul 2026 02:39:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wj6a8-0006bq-MN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 02:39:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mCDh6At6XczSpYrISVO/VKcS3b+jIo/GUafinMXlPuI=; b=crAy1byz8TWbaYtScuU9XdId/4
 3Eh9ZSpU2rQEqnDLt4SxrnSieu3nUJ3XyBjoq6nAO1E0GF64TLaYU2QRUoyL8guALtvFRyxM5vO3g
 KdjKLIDgYaIAGDaqX15VfUb3WbNxedfir2dvg0sidGpt0KSZDsA4QXMN7npM+Me4/SPc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mCDh6At6XczSpYrISVO/VKcS3b+jIo/GUafinMXlPuI=; b=gJkqAXjZE+uQUZRM6Z1yCOqs0f
 yrGxt9B9k65BtpQ8PMI+mG0+S05NL8Aj1RA1hP7jIdAk1ZwniWcGWOAuxbWngIEgxmb3eOjeMsW7+
 7wXbzQkJSO/ejbzEACL+IIiD09ZKxYO3++dBKwmx+vyDZgRqEiDZ2d0B0P6MRCD4DTi4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wj6a8-0003Au-Ov for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 02:39:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30136600AE;
 Mon, 13 Jul 2026 02:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E8D1F00A3D;
 Mon, 13 Jul 2026 02:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783910373;
 bh=mCDh6At6XczSpYrISVO/VKcS3b+jIo/GUafinMXlPuI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XrK6UkLDZDLNmmnjna+IBH3/d71rOYjFG12jwFkpZqw+/+J2uwQRf+Znc1H4EZLzU
 FWyB7gEkju3bMe6D1CH/3RGP/e357bZltZJWW1dguAlJCZweybNPYYlwWqq2V3HIGX
 1fT5pzuiKJk1LWP16o+duzCdJyKaGH+iyC/UH7sM+yBtg1UjoTgYx64/S3PAGnyMHf
 KeD5J7h7rjFJBk2opZ2zlx6kRx47QWhNKKvFHJGsgKMb/ZoY3NMuYWqVdtwyEcAhh0
 TfGsGJEhn/ynH/7DFYjvBfvhMkJR8aEoVwrCGmOI4k37kffKkjYFHGWMnRv/F8UOQG
 CwTM6m4/v8KBQ==
To: linux-fscrypt@vger.kernel.org
Date: Sun, 12 Jul 2026 22:36:53 -0400
Message-ID: <20260713023708.9245-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713023708.9245-1-ebiggers@kernel.org>
References: <20260713023708.9245-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wj6a8-0003Au-Ov
Subject: [f2fs-dev] [PATCH v3 02/17] blk-crypto: Fold
 __blk_crypto_cfg_supported() into its caller
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

__blk_crypto_cfg_supported() is called only by
blk_crypto_config_supported_natively(), so fold it in.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 block/blk-crypto-internal.h |  3 ---
 block/blk-crypto-profile.c  | 22 ----------------------
 block/blk-crypto.c          | 23 +++++++++++++++++++++--
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 742694213529..2c7a0446572a 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -80,9 +80,6 @@ void blk_crypto_put_keyslot(struct blk_crypto_keyslot *slot);
 int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
 			   const struct blk_crypto_key *key);
 
-bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
-				const struct blk_crypto_config *cfg);
-
 int blk_crypto_ioctl(struct block_device *bdev, unsigned int cmd,
 		     void __user *argp);
 
diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index cf447ba4a66e..53126c091b0b 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -335,28 +335,6 @@ void blk_crypto_put_keyslot(struct blk_crypto_keyslot *slot)
 	}
 }
 
-/**
- * __blk_crypto_cfg_supported() - Check whether the given crypto profile
- *				  supports the given crypto configuration.
- * @profile: the crypto profile to check
- * @cfg: the crypto configuration to check for
- *
- * Return: %true if @profile supports the given @cfg.
- */
-bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
-				const struct blk_crypto_config *cfg)
-{
-	if (!profile)
-		return false;
-	if (!(profile->modes_supported[cfg->crypto_mode] & cfg->data_unit_size))
-		return false;
-	if (profile->max_dun_bytes_supported < cfg->dun_bytes)
-		return false;
-	if (!(profile->key_types_supported & cfg->key_type))
-		return false;
-	return true;
-}
-
 /*
  * This is an internal function that evicts a key from an inline encryption
  * device that can be either a real device or the blk-crypto-fallback "device".
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 15e25e41b166..de60f03b4d4b 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -351,11 +351,30 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key,
 }
 EXPORT_SYMBOL_GPL(blk_crypto_init_key);
 
+/**
+ * blk_crypto_config_supported_natively() - Check whether a block device
+ *					    supports hardware inline encryption
+ *					    with the given configuration.
+ * @bdev: the block device
+ * @cfg: the crypto configuration to check for
+ *
+ * Return: %true if @bdev supports hardware inline encryption with @cfg.
+ */
 bool blk_crypto_config_supported_natively(struct block_device *bdev,
 					  const struct blk_crypto_config *cfg)
 {
-	return __blk_crypto_cfg_supported(bdev_get_queue(bdev)->crypto_profile,
-					  cfg);
+	struct blk_crypto_profile *profile =
+		bdev_get_queue(bdev)->crypto_profile;
+
+	if (!profile)
+		return false;
+	if (!(profile->modes_supported[cfg->crypto_mode] & cfg->data_unit_size))
+		return false;
+	if (profile->max_dun_bytes_supported < cfg->dun_bytes)
+		return false;
+	if (!(profile->key_types_supported & cfg->key_type))
+		return false;
+	return true;
 }
 
 /*
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
