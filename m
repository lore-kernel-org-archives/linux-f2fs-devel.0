Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DE2CCA490
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 17 Oct 2026 03:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A673uOA2y29TcwkmbfzdS7+EmIsjRlw42wjktXQrB64=; b=aDdMT5irKvRwN4Q5Vg7x95ZBYP
	IY+5+aSQKg7uM9W9fU7MBmbIoD8rUxktKaWWZWcs4ytIX5qZllnTlJmu9RAP4svr0t3qsflTh1gdQ
	oTzrHZIvJvUySW7L3pXGst+OmNLVo9GKcR1Csw5S8C9q0QtJllQq/wsIZ2G1gzfp9RCg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHufG-0008Nf-88;
	Sat, 17 Oct 2026 03:00:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1xHufF-0008NY-7B
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 03:00:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d1w1gkneqWGuArFWraDyPd1NUAgGJPZmhQDiFlysjeU=; b=dNa53QCjm15kbGaFo1tUuRNoiC
 Wy8zkeOb16heMNPb+dZN/zZa2+vdC33R2Zqg1qfDKLRH2NVWdZUYAHCiYn2OiTWIUDAyBKI46dgQo
 zMSmfPIL7MRbyZ3BiFkTC3IafXJMifbmGouf73mUqUVpLztb0Pan1Aa851s8XmsfVAuE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d1w1gkneqWGuArFWraDyPd1NUAgGJPZmhQDiFlysjeU=; b=Svxr7yyOldHnFLfigc/1kiSgPC
 0uzW3meozxtEx0vwa5/SDQy5iqw2RwHVJA5jViEwmiEjCzDdqveZAeVCjvN7/UdbBWQT7YapTwNyY
 kj93Ucwz6hlIe4mOKI1isNCdwy+fLf2aC2xmc15dF34A/LY9HxqMBDKustefDSU1n5NQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHufD-0006PK-Rf for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 03:00:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 72C2440A2B;
 Sat, 17 Oct 2026 03:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACE51F000C7;
 Sat, 17 Oct 2026 03:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792206046;
 bh=d1w1gkneqWGuArFWraDyPd1NUAgGJPZmhQDiFlysjeU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NlA2n5fxsGEyenc3lkuEfjmsSUpaqRuXhc9Ek57hIcfkzHhyipTh2CWXDlAOiddxJ
 MlNSXfX8TgfIrP0wXx1E4t0HzANjWEFEn7ycwvLUzcQqgbK2dtS8/++EA0L6sh7KSk
 rfqcLjMdMiDR2VCCGHn+OuLYCjFxBZBA/+DhOOCOdhbDdbrmHj8EwYSfPVjCKJp/l6
 8xsdHLWCtNdop27qrIljhuewb7XrHSUWV+AMLr4l3NjuY4l6ejqkMUNtGUqVN+t6If
 leouUvbaGMhBlrmQYK0XTwBKHxdqPxCEVZzN5UBdBPDQn6gazqi3hN5a/l992Kv01L
 jllZtxogsY7oQ==
To: stable@vger.kernel.org
Date: Fri, 16 Oct 2026 23:00:22 -0400
Message-ID: <2026-10-16-1-daily-reply-0017-f2fs-bdev-release-drop-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016173526.GB122880@google.com>
References: <20261016173526.GB122880@google.com>
MIME-Version: 1.0
X-Headers-End: 1xHufD-0006PK-Rf
Subject: Re: [f2fs-dev] Patch "f2fs: move release of block devices to after
 kill_block_super()" has been added to the 6.6-stable tree
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Eric Biggers <ebiggers@google.com>,
 linux-f2fs-devel@lists.sourceforge.net, stable-commits@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> Not a clean cherry-pick, missing follow-on fix, and not Cc'ed to mailing
> list.  Nack.

Dropped, thanks.

-- 
Thanks,
Sasha


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
