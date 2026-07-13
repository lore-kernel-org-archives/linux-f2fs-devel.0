Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A1BC44506
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 02:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EUrN+epuidoW1NB0qDL4gMy4P25Nz/7ThHlk9CghBsI=; b=kPZ1MD4m3j2w4WWmEu1hA4N0l5
	GyvyHpIO83DZuL+cLOSBoKHc4l4IDccMjXH/l+qF+0b3zxv07sY4cGmQY2nkDnwXxfaAqAJHEtHuT
	L/gF4gnm4f00BtyXzMA/OH7sjeVXBRLrq7AVantCXhi425xIQQU1MPnCpmCk2vcONo6k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wj6a5-0003ui-PI;
	Mon, 13 Jul 2026 02:39:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wj6a4-0003ub-5Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 02:39:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qHUq8H2gRat8UEbbTCOj349IaUIr6uNiumAUkOuvUW4=; b=BznX7TpmNQvNIZbl6PLzmlS87O
 6+1QnX/SgsXv029cphvPf28Iga5ULUGTaxX7PnNfA8SEWpcEq8wG9LJoi7HAb53NocWIA2Qvv7qji
 mFpwBeU5D5MRebvZHy6TsMDmxBm7SJ/TiZ3Aa11FoXq4RYLKcAs9jNsIzBazMVmgsZYQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qHUq8H2gRat8UEbbTCOj349IaUIr6uNiumAUkOuvUW4=; b=Varcrp+54c3Yr7rFVL94ysJReF
 dWq5Al3V1eJrixijgi1VygkbHmouiD5/mkl2LVWQDinLQ4TbF5QsKibwfqN90sAxNz1VBsbxtELIR
 WImEgkw+EAILwXAIXiw7PcmZiYhwi8ukdCRs4gMRuN9OZ5seFlPilKIus3SbDoOZQ1wU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wj6a2-0003AR-LB for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 02:39:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC36E429E4;
 Mon, 13 Jul 2026 02:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2961F00A3A;
 Mon, 13 Jul 2026 02:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783910372;
 bh=qHUq8H2gRat8UEbbTCOj349IaUIr6uNiumAUkOuvUW4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jrW/JYM3ACUG+nhVVkCsyXJIFV5lZoq4QSBhj7fBWsGJSoRCWJYLRmhzHkAJGqMVe
 8GZ5fICsJYPHOGTlUM5gr8uGyFKiOAe1vf3DYrG2UtDStan2eFVA870cmpg/X0PaKx
 ccev9HVIMioftE4tyM/MJODhjjuyBCOiwQ3s+pogXjAn4Rxx/F1gKG2TcU1xNyOO4A
 W5Y26dhNgqIR7Amh9UJgzoFB9y/DQA6EHwk4/o8cHbjtF9kdlffr9IB1mZ88xeOjb8
 OIbzkJzROp8E4DhAFrHBB14HnhBZ7pa/85bX5Za/6UkCddKiwmyAGBRdQv7OfIg0GV
 1DR9mnRxmQsxA==
To: linux-fscrypt@vger.kernel.org
Date: Sun, 12 Jul 2026 22:36:52 -0400
Message-ID: <20260713023708.9245-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713023708.9245-1-ebiggers@kernel.org>
References: <20260713023708.9245-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wj6a2-0003AR-LB
Subject: [f2fs-dev] [PATCH v3 01/17] blk-crypto: Simplify check for fallback
 support
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

Since blk-crypto-fallback supports all blk_crypto_keys except wrapped
keys, just check for that condition directly instead of using
__blk_crypto_cfg_supported().  With this done,
__blk_crypto_cfg_supported() is now used only for the hardware support.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 block/blk-crypto-fallback.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 2a5c52ab74b4..2a8f40a65158 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -496,8 +496,7 @@ bool blk_crypto_fallback_bio_prep(struct bio *bio)
 		return false;
 	}
 
-	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
-					&bc->bc_key->crypto_cfg)) {
+	if (bc->bc_key->crypto_cfg.key_type != BLK_CRYPTO_KEY_TYPE_RAW) {
 		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		return false;
 	}
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
