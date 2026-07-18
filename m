Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078FDC44523
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uFF49SRTxU1iHvOmgPmnXiTf6OPa/s5wbjB+11EZo0o=; b=alvuscbAyhRozDWQtSrKGlem5h
	p5mZah0U1qN94G6vxnXMmndJepj5IDJSBEcaOBH3WwdQ/1rpuIaIGyiEgZs+qKbtJfZweU37S/jKM
	44YiTxepEkVZVbUm3H6JiBbMPsLY/I+N1pgTAD9TQrsg2bbZVfHT1FJKdhuazp+u4M9Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlCuO-000822-2S;
	Sat, 18 Jul 2026 21:49:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wlCuM-00081u-Un
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uW5iv+RSEE3wkKPr35Uyq8ZKU+zS5v45Ej8aa0FV85o=; b=ftQLsGqnpETSNUWZG+9UTeTyTw
 YxoakCN73C/Jt222c1ai8nInZU6eBTbl9i597d1hAeE73+6hUazrjGFkMfVfPlb/e9zSd3opzARVp
 OofXkkIW7krIcXDOc59IOIpMYad25NjlXT3Foel9oVPsaID9wd78XECRKeE9xBNSHffI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uW5iv+RSEE3wkKPr35Uyq8ZKU+zS5v45Ej8aa0FV85o=; b=N6WZejGxphR+b5qzNKYsDy21b5
 gMY5NdMOSKJm4o1YxAD+GFe9nFqY17jbDiQB0LNJT/V3akx/6Qyw0hv4M5n++kfCEmNAm8NHjcF1l
 ZxpRdt7eXgMD1Y+RcOcJKy8SJXtCopHvNnI5jk/IeyEljI5nDoYFpGWIt/Qh3Y++V5x0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlCuM-0003WC-VS for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6472B6001A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 18 Jul 2026 21:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFF31F00A3A;
 Sat, 18 Jul 2026 21:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784411348;
 bh=uW5iv+RSEE3wkKPr35Uyq8ZKU+zS5v45Ej8aa0FV85o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iGBAPnIDkeUCGJ4C6s2rAeTwuIIqBg7BGPGO/NkGiv5XaKIOietmFCfV72kQjcIlH
 +fxOHyhPvu3BESJ+0bCAK9aq/Bi6XzMsgUc+QLQJjtl3QxxzVqvG6pCT7FUwLc84SE
 Sy7V333TtkhLFsiX0tz7lzWPyKGwYtFB3Ig8AvRbEee4hFnA/LvkjHimQfpA7sXai2
 ofi4gd60KS0yuIRMNchjjQFuRxI79UMs0X00F2Y9aTCD6j07lHajdEIQ+IGX0ONHJE
 fua23sD4qPDkVoNBO3TvuRwsXOlUD7TivFNJtj/XkJqID8KBmDsTPCuxvxelgsrxXH
 y6ce2XzYB1CaA==
To: linux-fscrypt@vger.kernel.org
Date: Sat, 18 Jul 2026 14:46:54 -0700
Message-ID: <20260718214655.63186-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718214655.63186-1-ebiggers@kernel.org>
References: <20260718214655.63186-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wlCuM-0003WC-VS
Subject: [f2fs-dev] [PATCH 5/6] blk-crypto: Remove unused function
 blk_crypto_config_supported()
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
Cc: Eric Biggers <ebiggers@kernel.org>, linux-doc@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

blk_crypto_config_supported() is no longer called, so remove it.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/block/inline-encryption.rst | 29 ++++++++---------------
 block/blk-crypto.c                        | 14 -----------
 include/linux/blk-crypto.h                |  2 --
 3 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
index cae23949a626..0052c7011b48 100644
--- a/Documentation/block/inline-encryption.rst
+++ b/Documentation/block/inline-encryption.rst
@@ -185,20 +185,12 @@ blk-crypto-fallback is optional and is controlled by the
 API presented to users of the block layer
 =========================================
 
-``blk_crypto_config_supported()`` allows users to check ahead of time whether
-inline encryption with particular crypto settings will work on a particular
-block_device -- either via hardware or via blk-crypto-fallback.  This function
-takes in a ``struct blk_crypto_config`` which is like blk_crypto_key, but omits
-the actual bytes of the key and instead just contains the algorithm, data unit
-size, etc.  This function can be useful if blk-crypto-fallback is disabled.
-
 ``blk_crypto_init_key()`` allows users to initialize a blk_crypto_key.
 
 Users must call ``blk_crypto_start_using_key()`` before actually starting to use
-a blk_crypto_key on a block_device (even if ``blk_crypto_config_supported()``
-was called earlier).  This is needed to initialize blk-crypto-fallback if it
-will be needed.  This must not be called from the data path, as this may have to
-allocate resources, which may deadlock in that case.
+a blk_crypto_key on a block_device.  This is needed to initialize
+blk-crypto-fallback if it will be needed.  This must not be called from the data
+path, as this may have to allocate resources, which may deadlock in that case.
 
 Next, to attach an encryption context to a bio, users should call
 ``bio_crypt_set_ctx()``.  This function allocates a bio_crypt_ctx and attaches
@@ -220,16 +212,15 @@ any kernel data structures it may be linked into.
 In summary, for users of the block layer, the lifecycle of a blk_crypto_key is
 as follows:
 
-1. ``blk_crypto_config_supported()`` (optional)
-2. ``blk_crypto_init_key()``
-3. ``blk_crypto_start_using_key()``
-4. ``bio_crypt_set_ctx()`` (potentially many times)
-5. ``blk_crypto_evict_key()`` (after all I/O has completed)
-6. Zeroize the blk_crypto_key (this has no dedicated function)
+1. ``blk_crypto_init_key()``
+2. ``blk_crypto_start_using_key()``
+3. ``bio_crypt_set_ctx()`` (potentially many times)
+4. ``blk_crypto_evict_key()`` (after all I/O has completed)
+5. Zeroize the blk_crypto_key (this has no dedicated function)
 
 If a blk_crypto_key is being used on multiple block_devices, then
-``blk_crypto_config_supported()`` (if used), ``blk_crypto_start_using_key()``,
-and ``blk_crypto_evict_key()`` must be called on each block_device.
+``blk_crypto_start_using_key()`` and ``blk_crypto_evict_key()`` must be called
+on each block_device.
 
 API presented to device drivers
 ===============================
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 0fe6ef0eea1d..bc3a9f59574b 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -386,20 +386,6 @@ bool blk_crypto_config_supported_natively(struct block_device *bdev,
 	return true;
 }
 
-/*
- * Check if bios with @cfg can be en/decrypted by blk-crypto (i.e. either the
- * block_device it's submitted to supports inline crypto, or the
- * blk-crypto-fallback is enabled and supports the cfg).
- */
-bool blk_crypto_config_supported(struct block_device *bdev,
-				 const struct blk_crypto_config *cfg)
-{
-	if (IS_ENABLED(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) &&
-	    cfg->key_type == BLK_CRYPTO_KEY_TYPE_RAW)
-		return true;
-	return blk_crypto_config_supported_natively(bdev, cfg);
-}
-
 /**
  * blk_crypto_start_using_key() - Start using a blk_crypto_key on a device
  * @bdev: block device to operate on
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 5f40821f99cd..938ff536838c 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -171,8 +171,6 @@ void blk_crypto_evict_key(struct block_device *bdev,
 
 bool blk_crypto_config_supported_natively(struct block_device *bdev,
 					  const struct blk_crypto_config *cfg);
-bool blk_crypto_config_supported(struct block_device *bdev,
-				 const struct blk_crypto_config *cfg);
 
 int blk_crypto_derive_sw_secret(struct block_device *bdev,
 				const u8 *eph_key, size_t eph_key_size,
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
