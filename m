Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D281C4451B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5gn7l9fPe2VNvjC3tc4BlFdbHShhASsuK/iJ3k6Z9g=; b=Ikqu4akLL/QYLcy6rc4VK/uMKr
	w29n+pTFkmLgNwhglRtPphvoM5oPoQgszjs0IIyeXA5ql1LqQoCGpYQIWgxvVkFjyueXrCn/5422H
	p/80IcCkZgHXLa6CzMsZ4rmhZgBEn7XlSvz7RYe3hw7mtkEYeANjIZBHEYumwdhjzs4k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlCuN-0006aB-HO;
	Sat, 18 Jul 2026 21:49:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wlCuL-0006a5-R4
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NJWkMqhNzPOnX6d2XCeG2SWavkTSF6lVRqA3hgxwQvY=; b=DxsLUhuRZU2uaYctwqs5VVnhcv
 OWYCo1lg3IM5G2NuJLDwEJ6hL9qkurTmObog6hOWY1+0kJpgdJnXIfUU8qgUDIkwRTx+gle/K83Ws
 mhXoGAEoubZbi70EzoMisNVpXxXKaXEjVcOE+zxGTZ64hAdRKDoxvukK43h51MIpM0QA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NJWkMqhNzPOnX6d2XCeG2SWavkTSF6lVRqA3hgxwQvY=; b=P9K90S8VdJvcuzhsM2anLcWEzH
 4AvOJAB7LtPZ3q5cwnYuCuNnZMvxrGRQPkDRmAriWvRIWxvybw9WoeWCYmrxytwQFqiW5YEsZ0wMl
 6zaU28oinn25bPvNPSXI5XXjJhd/JiIsKzXbzpjDlSTyr55xW8d/bCljQPfFx0C9vUEY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlCuI-0003Vz-WA for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE91B43F3E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 18 Jul 2026 21:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC6C1F00A3E;
 Sat, 18 Jul 2026 21:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784411344;
 bh=NJWkMqhNzPOnX6d2XCeG2SWavkTSF6lVRqA3hgxwQvY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=izWg8MeOHBTG6L6M+o6+HnnLjgGAS+lNf10ofnZLayydZnr3LlVn/QkHr94MF+A3d
 kQ6BqhpO12dd98pHAooSfvPYYU8g4iz5q0uhixsApB/C+3oZEU8owigj6NYOzBBXDx
 G3QOsIAUXBoucad1qbdCC6e8IsAa+XQVRINdsW19h5VtHMoE55G++qr8Oe3nfvEC+7
 ZgWjfWeTvi3ovDBdibhZL6qMtwr+OfuWBN0t2Y22jeIAieALlG/uvWu1L9znKMuaaX
 zS/+ERapCV89mVb+/yEm54t0/6PMjbzIeeTX6TP4+HGxaDh7SpWaYcWf2YOj49u/Tw
 nENo05rLN+UGA==
To: linux-fscrypt@vger.kernel.org
Date: Sat, 18 Jul 2026 14:46:51 -0700
Message-ID: <20260718214655.63186-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718214655.63186-1-ebiggers@kernel.org>
References: <20260718214655.63186-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wlCuI-0003Vz-WA
Subject: [f2fs-dev] [PATCH 2/6] f2fs: Update outdated comment in
 f2fs_write_begin()
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

Refer to f2fs_set_bio_crypt_ctx() instead of the removed function
f2fs_encrypt_one_page().

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 65117dd2e123..a88ed125d266 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3956,7 +3956,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		/*
 		 * Although the block may be stored in the COW inode, the folio
 		 * belongs to @inode and its data was encrypted (or not) using
-		 * @inode's context (see f2fs_encrypt_one_page()).  Read with
+		 * @inode's context (see f2fs_set_bio_crypt_ctx()).  Read with
 		 * @inode so the post-read decryption decision matches the
 		 * folio's owner; otherwise an unencrypted @inode whose COW inode
 		 * is encrypted hits a NULL ->i_crypt_info on decryption.
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
