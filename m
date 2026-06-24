Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1141CDB479
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nVLQAAycgJpzS5/pIIW0nWQE4YYViAkoF2XdU7IsLXM=; b=HwuyPvDDP/6JFm66ZtBNPcF1J8
	wfS8HRPZMSE9U9fhA2FsST15To6z2r5xdVH78yiyDKEKCY9Zrmp+rxXxVdyHKmmD3ehLCrrfUaNqu
	PKoWzSv2tavg3e/s7rwEBfp0tex2dDXejwgdpfydQZIKzxtx+2vu3ZA4zUh4AuM282HQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcFoN-0006qv-28;
	Wed, 24 Jun 2026 05:06:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wcFoL-0006qo-OU
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tnb0tfseVuJy6ztSSzQ0+AU1yHkyqxTSNK4Dw8VuZEw=; b=M/uc//Wd7vOul7OLyNq1fiRfQA
 mLKAbIScRw57LinBJGnUIWkPkbGZcrjbycR3baG5WgagnmelXr9ms2qNBGGIMqKN+7mNFkJ13wjKc
 iy9NR+0H+2TlmKlKeyWo7CZlqDPOB33wrTW9Hivzwt1JmnWIz321q8iEnPqo54U/pbb0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tnb0tfseVuJy6ztSSzQ0+AU1yHkyqxTSNK4Dw8VuZEw=; b=eK2pU+wFQgnni3+yts+wquDbeJ
 b49QiMIZiXWGhfU7Jn7+VWG/A2N9ShFRpoNXXHfTe5sML2tLssV+oq/Y3EGzIoWzymkNnuhDkfxxy
 vGsOU4BBvZkviLRgmUO8SSAr6qbTBiWkx7ZCnKXHsGTQ08FQjBJaGn2kBw3CtmWN7qBw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcFoK-0004mG-Pz for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5532B60138;
 Wed, 24 Jun 2026 05:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1B41F00A3A;
 Wed, 24 Jun 2026 05:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782277559;
 bh=tnb0tfseVuJy6ztSSzQ0+AU1yHkyqxTSNK4Dw8VuZEw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lVePk+nxDYyyFQ3wSnWoDkOkUFBrt6ijaZFhOX3Rj+jDahxShF94zAsOaf+wBkwjp
 F7AVuZSrGIKf0xcdx80rMqsafrmPXZ3OyFdCzmk2HXUz5ijAUnv4fah0iI6LLzoH/Q
 s3K//h9bR8lzc490fuK+I85OA5e0d1b8LofOzXPBegYr0B67rYYFOM50rjY2HFIumX
 CWaV+8s9UiV8j6JHl6nVYz+ukjExnsp9Ievqe828Zn8UZFdq3DlYjVFHfA7lBJ/HBV
 2RTcQN+FMIFBdJgpKIJFm3wy3+uO1roUGQvbwP75FuVeQa9Wk6YrLpcGqoBfx0dUJp
 1AgRT9CiV/I6w==
To: linux-fscrypt@vger.kernel.org
Date: Tue, 23 Jun 2026 22:03:19 -0700
Message-ID: <20260624050334.124606-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624050334.124606-1-ebiggers@kernel.org>
References: <20260624050334.124606-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wcFoK-0004mG-Pz
Subject: [f2fs-dev] [PATCH 01/16] blk-crypto: Simplify check for fallback
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

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 block/blk-crypto-fallback.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 2a5c52ab74b4..2a8f40a65158 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -494,12 +494,11 @@ bool blk_crypto_fallback_bio_prep(struct bio *bio)
 		/* User didn't call blk_crypto_start_using_key() first */
 		bio_io_error(bio);
 		return false;
 	}
 
-	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
-					&bc->bc_key->crypto_cfg)) {
+	if (bc->bc_key->crypto_cfg.key_type != BLK_CRYPTO_KEY_TYPE_RAW) {
 		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		return false;
 	}
 
 	if (bio_data_dir(bio) == WRITE) {
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
