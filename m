Return-Path: <SRS0=ikBs=FS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC83C2BB48
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Dec 2020 20:57:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC9A22DA9;
	Mon, 14 Dec 2020 20:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC9A22DA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kouty-000061-Fk; Mon, 14 Dec 2020 20:57:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1koute-0008WR-Ec
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 14 Dec 2020 20:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F0ggFg4yEGg8sCuNtmVDnS7CvpGdCsVjg31fX7bdpIo=; b=gl53r/sW763tlKw0GEwgRDbA7+
 NyqzYDxm0GpNhX9ycmg/q6yLDxD8d9AvPKL+JeTFlSVQZ2+aojue725P28AhZAilwwwWdgUJVHp3R
 P38LrN1uVpCJMjeWF7wUdVtYthq6RvHySQqFPZBT1zU1V9IktuHd06E5MO8x2IrIchx0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F0ggFg4yEGg8sCuNtmVDnS7CvpGdCsVjg31fX7bdpIo=; b=K9SBtMLZDPzCoRrGUA1Lq9Mp4S
 gxMqMpluV1D3DxzPHc2lP0DgGuucKFkpxpnYls26cCmncDyawfv7IdTcHIAb+DPMCyD7LPlM7doeE
 aYxlFQDiJauwtwr1+P/hxI7Ssl6A0wjCyhm4QzVgnti2Zgtt26bOSAOuVbMhUPkbmc+Q=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1koutV-00E73I-Py
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 14 Dec 2020 20:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607979388;
 bh=8TA3M2fJC6eWzRxFjGh7dv0C/qOTmpZPhaCxujp6Nhw=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=GtNRIf8R7iFQLnZ+asV6awJfdvY2iwacFvGd201A+KsaSGv5L+sPRSk+rckYd37BU
 dJsaBrFj+FkiM81+odFK3mOHmVSfJ+V3tTJqvnyyPJOXNiKzmWbBvzazJi5j8hoFeZ
 kGqi7m6jvq6RVjshfQ3tJ1GUoJYgTBZIycDDZXcoa3spz11vvqzIBCWdWhv32tp11n
 KtlE8PlVu2QNUB7EmUFyX3g9IbBzqa26oGodoKh2lc0ouwJ3nRdVEDrIqbXi/URI3t
 EGXoEL1d9kNZSkj6aJr9m7MrYDNdbEBDKvNsz1HmG2hm6Yh83empS9+JWe1XDDi7QB
 3KKEjibp7dU1g==
From: pr-tracker-bot@kernel.org
In-Reply-To: <X9b9G8p8AiRAzDwV@sol.localdomain>
References: <X9b9G8p8AiRAzDwV@sol.localdomain>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list
 <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <X9b9G8p8AiRAzDwV@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: a14d0b6764917b21ee6fdfd2a8a4c2920fbefcce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c7fdaf6ad9fe868553c2e1fc8a920249820ac3e
Message-Id: <160797938816.26822.16942745095924482464.pr-tracker-bot@kernel.org>
Date: Mon, 14 Dec 2020 20:56:28 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1koutV-00E73I-Py
Subject: Re: [f2fs-dev] [GIT PULL] fscrypt updates for 5.11
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Sun, 13 Dec 2020 21:50:19 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c7fdaf6ad9fe868553c2e1fc8a920249820ac3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
