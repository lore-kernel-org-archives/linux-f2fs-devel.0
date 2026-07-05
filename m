Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5AEC44506
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+tWcKB+dLzToOZqejhxg5pGKabJ8uxsseJt/L6H5AqU=; b=HOKazPTb8EQgO8xHnvNUOQvVZe
	46tVZf4+EVrHVrua0LC4U8EXchiKJPwgBxnYIpd4D+R/svkXbUUsUCqksSQo+5JC6UmLTk+3Vt/V6
	OByB0ZVgovpwayzkLp1szp7eNYworNkoLlsv0oCPYgFUYPu81jx6yriWNGcfsFPKyw1E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgSoz-0003ve-PO;
	Sun, 05 Jul 2026 19:48:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wgSow-0003sx-FI
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 19:48:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tKdpjr5i/RImosIY+eiFhMqxSz+elKzS2xT7ckJAoUE=; b=Qilc1C56ftFyezdmD/K2UnEwPP
 KwLuMUkdIt4O90NOigF9TbX47K4LF5uLqTnzIE1VCppLa8Y13b363LPGgwtCZFAeJyeEtAEfaZRcp
 E041xpgHGWyojKJwHlhcd0XUgGiPABDprS667bHrtol5NmJ7P/tLGlMWqm/7IELIVpXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tKdpjr5i/RImosIY+eiFhMqxSz+elKzS2xT7ckJAoUE=; b=nMSKpeBzmYdb9u3K2V05b0C0fm
 p8vNcD+Dtvuio6ZgD2NzGT+4WPDRUqTE4zt4vxq024Na8mZfp0g/PA3VL/RPtCuHPxMjJS8baThzf
 hga1KTq/jmDRMk2b2E1yvHDACs7cb6ALfZOLYGNiRBJqflZ1cSNxT3Ihb4FoweuMtEx0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgSof-0001Br-Qn for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 19:47:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9A714145C;
 Sun,  5 Jul 2026 19:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFBB1F00A3A;
 Sun,  5 Jul 2026 19:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783280859;
 bh=tKdpjr5i/RImosIY+eiFhMqxSz+elKzS2xT7ckJAoUE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bkwvRjw1u1rp8gSn/ECS1DhIstnM96dOMOctkXi9ZJoEBiZ5NatqO9gm0NIepGdiF
 2BZBCLA4sqWoMpbfy2xPqmS2J1Jvr5VOxgZ4kjC5DbrNnozQYD4NWByhJYtG1Rlb24
 MyVgEn8TT7ne0TSKx3p3TEACoM6GTUbJbY6s+HCWz/YTIJ9Ug9/fmFLn5jaCvD52fi
 dB9ldBpoTliTHkLctHksCnEnl2+Y9fTS82BEOo+ZqzAXY+/AsYmYguB3mFatir/iok
 JJBDioWjALQGx9y8dQ2MVCPGdJfyQ2rSFDscJL0maGVf54UJlvNlR1Z9jxHfdNbPJd
 O8xRMHslucJtg==
To: linux-fscrypt@vger.kernel.org
Date: Sun,  5 Jul 2026 12:45:39 -0700
Message-ID: <20260705194555.75030-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705194555.75030-1-ebiggers@kernel.org>
References: <20260705194555.75030-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wgSof-0001Br-Qn
Subject: [f2fs-dev] [PATCH v2 02/17] blk-crypto: Fold
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
 block/blk-crypto-profile.c | 22 ----------------------
 block/blk-crypto.c         | 23 +++++++++++++++++++++--
 2 files changed, 21 insertions(+), 24 deletions(-)

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
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
