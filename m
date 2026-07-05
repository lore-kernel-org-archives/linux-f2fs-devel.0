Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4ECC44503
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qLiQxYIc+OoLkWHDDOG5ljF3u9onQD4WfV2w/OS3GQg=; b=dkUvjpUcFYApmXnYkckzwa1Lo0
	jObHzYm+goWfVzTLJJFY+lmKhvOBDH0IGWlRnqu8vq5n4/sebqcN7XtdGf1DCPVq0xvKi6K+rlJMw
	aP7Ccwcjn4k7FeZC/ybg/emZ92Qz/RMTaX5DcFIrLoZj/x06k3bzV21y7xtNdPb46qS0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgSoz-0002Ov-MS;
	Sun, 05 Jul 2026 19:48:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wgSoe-0002OO-GC
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 19:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ccW1qV9UN5V52RLw/3xBnC+VL1s84LZKZzkFmXShJlU=; b=g0cH7rqTY0o8LJTp+b6F7iT+6K
 cDugB1BUIPO0wSsD1j/YwfKqEuJB4L7OMaQ/1jq3XzS/eDAglVd/HA9m35GVzsyiqs7Rw3T2bd+HR
 2Rs+sDKxCojJhZuyaB9W0SL4Zc21cxXuqEk53rNePZjFq+7Fg3OQLN3oXTYtLv+Npvgs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ccW1qV9UN5V52RLw/3xBnC+VL1s84LZKZzkFmXShJlU=; b=gNwNm/CV3OSZSIHDF7T2u4Eoyi
 zMtBX+El3bTil2eT6UWRk7nFLEjdcAKFzkhDG9SEgOAkNl/lyA1qELDcJAn6mGf24VOWDisZCgUuc
 GkKBIQh+SayfLd4fSQh1m5grf2NCi4q65d4ZATCVqrxfgqNBVpEXWpE71gPACMj/eFg4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgSod-0001BT-K3 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 19:47:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F16761383;
 Sun,  5 Jul 2026 19:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5500D1F00A3F;
 Sun,  5 Jul 2026 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783280857;
 bh=ccW1qV9UN5V52RLw/3xBnC+VL1s84LZKZzkFmXShJlU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EVQP0AL65F6G4DPoUlRU+C+e0GBHXoJUhnk5l8rldhiLdToO6OPqGZiUS9HmxNnLq
 xulRs2Zl/a9FVOL13BouqsFVwTmNEzWasAnU6zg8J6u+eIUXqVxnHKJ3SjmssNvkXO
 VmB8/kloOSXmq/cPKcM+YEnG995a8euwtm5IidEzGuD3XfgNKsjxBymyDwnqV29AwO
 fIGUrndcXnLmDIRqZKXtv6/2Y0T8SfcJKrx5dmbygV2cHoA3Zh/Vjxowq3p+9ZyNpf
 TFx8TDaCCs6IDtEW4Qj3gVPj0Vpr1oCNb61O/0gtnZjeeje2f5cOfXf1RDkVBg3B1n
 FwRSy/5KUYnhg==
To: linux-fscrypt@vger.kernel.org
Date: Sun,  5 Jul 2026 12:45:38 -0700
Message-ID: <20260705194555.75030-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705194555.75030-1-ebiggers@kernel.org>
References: <20260705194555.75030-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wgSod-0001BT-K3
Subject: [f2fs-dev] [PATCH v2 01/17] blk-crypto: Simplify check for fallback
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
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
