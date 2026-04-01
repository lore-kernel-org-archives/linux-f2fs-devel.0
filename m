Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D7E1112243
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Apr 2026 23:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oDxtTFr8RebOVWzy8dIzX/lPOAvGdEN8l9K2or+nGB0=; b=TjQ545nxNl6JHJpPk1LbMGUdAO
	0d0hU7hlDTBCBeMrFc6oj5l2E31nqtq7aBxjLPklQ1UFWXH81494BN7Dexs80rpCeLnEO3hqSbzcw
	ZPuZItDPeJEfmISZx1SKMd1F8Y5MTYVNbAcdXBVlMByQMq/E96VrfDCbuTC4RhmNdKig=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w857U-0006lr-1D;
	Wed, 01 Apr 2026 23:37:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1w8577-0006lB-Jx
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 23:36:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2YDUKSBWek14LTO/ntgOOgG13ByBdNofBG98ZV/Ktq0=; b=YS7UNMFYDMf+5YIViIl/hL/7ZR
 L3C8CPUUJ1mmQ3gTQKQeyeePwWlENFee7ElEjdK+siKW1hR0ByVCTT+dtrQFVo4Ncq6By/ESFHFgM
 DA9sJuGXmcebI4+AsH0hNjLtgcl0RJ5t8p4Z74R/2d9wTLOMhqTbpN1tO7ZdqCBYToxo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2YDUKSBWek14LTO/ntgOOgG13ByBdNofBG98ZV/Ktq0=; b=O0DgPLYisjyOIa5qPtcjXjt0Eu
 YU7qPwHRlLgXRe9MLiUTloMpgG1VZsmhm6f33YBYPFsZ2ybOskOPvbjWJUrSsBATfeWq2BjHkhRsr
 J8SgeF5kHb4WuFFHZlFYhjhFkYpnGsddWe66ryoiVdGExDvkzuPuJ7iC3Cr3vinLSDC8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w8577-0007tq-5g for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 23:36:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A8F860120;
 Wed,  1 Apr 2026 23:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1D4C4CEF7;
 Wed,  1 Apr 2026 23:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775086593;
 bh=ycGJXVbkzn7fjheMc4OWJv/d8Qf8+icFTrjAGQu+PYY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BgKk0rA6/fxQhGIcKv8FeKkLx9QG1BOmW5LafU7rNPUStTaSQn12Xp8PXpvooraBj
 VVDPsKmF/xPhrCMm3PYk5eL5mc953y+lTRa7hYSENFIKK5j7GrTMsA2S6+O+6mxXvL
 25+bmqUU9f/9voJCxEfJ7dt5YJaAHIEkZrlTwl242SvCwYxN6LvHPBEK5DLynMTMZP
 1bpXYt7i5KnQDbH69KIMmOVcco+RRfaPi6y1Q2e6QUk/JeNbmFJOJEx89QIe3e+DFr
 1dlUSaYB1WTMcq22LgE4xJ48aor/7AHPOO2RKoo5K6B2dd+IsmDe7VubwMOaqkpmz5
 txzsGK8QoS5WA==
Date: Wed, 1 Apr 2026 16:36:31 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260401233631.GA14247@quark>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-5-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-5-aalbersh@kernel.org>
X-Headers-End: 1w8577-0007tq-5g
Subject: Re: [f2fs-dev] [PATCH v6 04/22] fsverity: pass digest size and hash
 of the empty block to ->write
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
Cc: fsverity@lists.linux.dev, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Mar 31, 2026 at 11:28:05PM +0200, Andrey Albershteyn wrote:
> Let filesystem iterate over hashes in the block and check if these are
> hashes of zeroed data blocks. XFS will use this to decide if it want to
> store tree block full of these hashes.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Acked-by: Eric Biggers <ebiggers@kernel.org>

> pass digest size and hash of the empty block to ->write

"empty block" => "all-zeroes block"

(it's not empty, it's all-zeroes)

> + * @zero_digest:	the hash of a merkle block-sized buffer of zeroes

"a merkle block-sized buffer of zeroes" => "the all-zeroes block"

(to hopefully make it clear, as in patch 3, that it's the salted block
hash, not the value that fsverity_hash_buffer() gives)

> +	 * @zero_digest: the hash of a merkle block-sized buffer of zeroes

Likewise.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
