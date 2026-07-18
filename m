Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C358C44524
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=04Br0rxuCKyL/5S0oTHRuTIBqlLF4eknG1V+zSxO9Wk=; b=fq/FVDdWenYlDeCIiEbKvAlSJn
	Y47NbWohnObDCsji9G+oXbsb4a7fYUWz2PrwQxPE2NTClVf/DlOtpEk4rjQSPHHehrYGBYEFQElyb
	ZtRcv++zh90Ba7Efnr3XaNLFynbXV58jkbHOZs56pGgLgbsDk0X9Rw52Cr3bPpPAt51U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlCuP-0005sG-Lk;
	Sat, 18 Jul 2026 21:49:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wlCuO-0005s8-NM
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0gESiSJCAMF2nF6DvOYmrqypPXEEEvUEZD60a26iDS0=; b=RwKzly9zB4HqQE5ho4qMyLqtqs
 MUTVUh/BAZXIVkNWoKtFvcmTgsoelQngub4xSgWXkLZCDIX4h7UAB+ShYA/Dc/6+x3INwMOJwmnHQ
 Vt2ixCIYEIugAY23tq8h7v3GOhsWTFgSdX9k4+gxXxtrYVgptW99tB6Bff9PsruRbcIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0gESiSJCAMF2nF6DvOYmrqypPXEEEvUEZD60a26iDS0=; b=TSDpXDth2f5KvuenScwkCGBQqm
 BDn7YECeNgtNdVJll5BNkNqhe3Xf7dXC8X+5Ji51HaZAQ6YF89wxp8rFKWrwwznzPciSUmqUBmsUj
 U5aVTN5Wrh4TkjAHKv0RIybQDhBw3bWNu7kOchDZwp1LW8GddeRt5WZTnTYySWMRiFA8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlCuO-0003WJ-7B for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A2D4760018
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 18 Jul 2026 21:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2561F00A3E;
 Sat, 18 Jul 2026 21:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784411349;
 bh=0gESiSJCAMF2nF6DvOYmrqypPXEEEvUEZD60a26iDS0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BVtd71J2kLUxAd0N5bHGPILTOS3c1+n6T1M5mOBwIW6SdWiPcRncWpFHIx0b436s+
 pSQNwCQrgd9ZG0ciFXM4utybbl07BJ4GLQjeOOSS1eBd74D45gp0axnzoAfb3wAKPc
 zDNIc79Tlk7IyLdWa5bWxx7zuMVYpJxA3Rk3D1z/hlULVJo9zAMqhnk8uZyw0yy4/X
 uXp134DHz9C/K4J0nOX8y0K9ibwBK6ZhKtJmpe4b3IXpwumfKo/+hWj8E67c0Ocx4l
 xGbFXbJC4y9rV6M5r3EBnOsa/nzikQqdQFT2258BX5ZX4KwTLnk1fps4lV/Chj9wB3
 QH86kpdwUOFMQ==
To: linux-fscrypt@vger.kernel.org
Date: Sat, 18 Jul 2026 14:46:55 -0700
Message-ID: <20260718214655.63186-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718214655.63186-1-ebiggers@kernel.org>
References: <20260718214655.63186-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wlCuO-0003WJ-7B
Subject: [f2fs-dev] [PATCH 6/6] blk-crypto: Update docs for
 blk-crypto-fallback motivation
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

The "Objective" section of inline-encryption.rst suggests that
blk-crypto-fallback is just for testing.  That's no longer accurate, so
update it accordingly.  Also fix a typo later in the document.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/block/inline-encryption.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
index 0052c7011b48..0df964507f76 100644
--- a/Documentation/block/inline-encryption.rst
+++ b/Documentation/block/inline-encryption.rst
@@ -37,12 +37,12 @@ initialization vector for each sector, and can be tested for correctness.
 Objective
 =========
 
-We want to support inline encryption in the kernel.  To make testing easier, we
-also want support for falling back to the kernel crypto API when actual inline
-encryption hardware is absent.  We also want inline encryption to work with
-layered devices like device-mapper and loopback (i.e. we want to be able to use
-the inline encryption hardware of the underlying devices if present, or else
-fall back to crypto API en/decryption).
+We want to support inline encryption hardware in the kernel.  The API for using
+such hardware should also support a fallback to the CPU, so that users only need
+to use a single API and more of the code can be tested without actual hardware.
+We also want inline encryption to work with layered devices like device-mapper
+and loopback (i.e. we want to be able to use the inline encryption hardware of
+the underlying devices if present, or else fall back to the CPU).
 
 Constraints and notes
 =====================
@@ -295,7 +295,7 @@ hardware implementations might not implement both features together correctly,
 and disallow the combination for now. Whenever a device supports integrity, the
 kernel will pretend that the device does not support hardware inline encryption
 (by setting the blk_crypto_profile in the request_queue of the device to NULL).
-When the crypto API fallback is enabled, this means that all bios with and
+When the crypto API fallback is enabled, this means that all bios with an
 encryption context will use the fallback, and IO will complete as usual.  When
 the fallback is disabled, a bio with an encryption context will be failed.
 
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
