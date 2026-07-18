Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDE9C4450A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sVvLX7TGH4yBE+HmkIGCFX8g/5Q3JpnyO4ffWHCWMHA=; b=FVsLDciITTthCgw++Ag+UpjrxK
	idhlpIQLioFd01HnT4oU8nzFQ7LPAet8L8ubySnnqw8V5PtqYUH2Fb+/wdx+dfDuiONvDEuPIcYh6
	N8BbTbHD4FMVCLMeK2WQe0aCKP8s8KbSRsqRr03+UKL7diMsWo0WN5AfzmevF+Igzwjg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlCuK-0005re-9m;
	Sat, 18 Jul 2026 21:49:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wlCuI-0005rX-A5
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2xDXV67Vek3YVUUcSTKyTdZEU/LcZVKunALSMqoxvdE=; b=XLYn09rJmjLxLl++D8TKpnOE6q
 tjJrwaR6LCNGhvgdjGbsBKiNB0apTMNMgNusX48s2ddA2+R8SySG7Ho3/fHmdhchaP7cAZkS6BHnS
 3f8sja3+l6rd44qwEDZTjbcD+BdeekZT/+7rA4CrigMoJ9Bn/0z4zPhzeHxoYfrA7r1s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2xDXV67Vek3YVUUcSTKyTdZEU/LcZVKunALSMqoxvdE=; b=OtxPLbvD42mFC3ZMnL+Qq24DVf
 35B6lN5qx8okFE/hUHr3ZqN0YDiHX3zLv6GlDdtT7+g+ssVKWcrTDnie8CJ/ACtt4KA2alrXSi3uU
 VUxWJ991IJsSK6J92bN8tZnJMq7iXMECmwcEFFni1VKze/OwUjlcktbmCcXS7CaLMktk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlCuH-0003Vx-So for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B831418A1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 18 Jul 2026 21:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAC61F00A3D;
 Sat, 18 Jul 2026 21:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784411343;
 bh=2xDXV67Vek3YVUUcSTKyTdZEU/LcZVKunALSMqoxvdE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nOz1PA5te72VepSoLCsCgOIbaXHv1S9jkM7enCiZVtrGkDI06SxwPF+NRIlMz+zXf
 XqcdOuzdr6TkQqPoSyR8WAST99xtoszV1NU0Us4Rh80Zh+KKRl4G7bg5E6h/EO4Frk
 cH1dzwGgWOBCrJlIdO5IzOWJP+THsDFVSIvpYsMR/xEhfXtPg/O64nzmsxKnF43ZjQ
 Sf7novlrXnT70NJtgFNufVftrSH0iRW3lkTCGd8Ek+nlL6iYm44Eqf4KoVPDt1qiIO
 9RgbkY6OmnPHAZq708SrxtDVdE/me/C/LDyL47ij2ekw11bMowTAVWTgUD8rJpYGKE
 h5gXHIkI6QevA==
To: linux-fscrypt@vger.kernel.org
Date: Sat, 18 Jul 2026 14:46:50 -0700
Message-ID: <20260718214655.63186-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718214655.63186-1-ebiggers@kernel.org>
References: <20260718214655.63186-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wlCuH-0003Vx-So
Subject: [f2fs-dev] [PATCH 1/6] fs: Update outdated comment for
 SB_INLINECRYPT
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

Update the comment for SB_INLINECRYPT to match the latest code, where
SB_INLINECRYPT now controls whether blk-crypto uses inline encryption
hardware rather than whether blk-crypto is used.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/fs/super_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index ef7941e9dc79..3bdd7f7fb9e5 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -300,7 +300,7 @@ struct super_block {
 #define SB_NODIRATIME   BIT(11)	/* Do not update directory access times */
 #define SB_SILENT       BIT(15)
 #define SB_POSIXACL     BIT(16)	/* Supports POSIX ACLs */
-#define SB_INLINECRYPT  BIT(17)	/* Use blk-crypto for encrypted files */
+#define SB_INLINECRYPT  BIT(17)	/* Use inline crypto hardware if available */
 #define SB_KERNMOUNT    BIT(22)	/* this is a kern_mount call */
 #define SB_I_VERSION    BIT(23)	/* Update inode I_version field */
 #define SB_LAZYTIME     BIT(25)	/* Update the on-disk [acm]times lazily */
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
