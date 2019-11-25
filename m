Return-Path: <SRS0=iO/g=ZR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AE2C432C0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 Nov 2019 22:45:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A352207FD;
	Mon, 25 Nov 2019 22:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="D43Laibs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="kt75/oZN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtDsSrUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A352207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iZN6b-0007dN-74; Mon, 25 Nov 2019 22:45:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1iZN6Y-0007cz-8t
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Nov 2019 22:45:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TAoLTjMRJhVJnd5MZaHImCleEqu+5y4LIqFAy0Innyo=; b=D43LaibsY61hN8fnxM9af310Fh
 YU+RNvXyV7opcPqkDQTjTY6wu3aCqho2qAP+09jF6HdkbdB/YscGDgPFBtuDxY/ngyjHqxjcYi3vW
 W8WzXmf+TojQSYIXQpQB22TeVckBWLa5IBJOozCVpnfMOzPX7PRoXs2XNDYY4LRZMyRo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TAoLTjMRJhVJnd5MZaHImCleEqu+5y4LIqFAy0Innyo=; b=kt75/oZNbYilA8eHwqdsgr7E+5
 yKmzxbl0xhs1KimxToeLsd+vcV6B/abh4Jup1K+tW/DZSZu3e2rRSWCblYni5YpZqGnfnxk68Ifnz
 YRBypdugL/p/AijLytUGOCNrTNv2aS9Uw5BC8hhHi4Nxr3hg9AK5jncam6fDn8E6cyQk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iZN6U-00DXD2-KK
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Nov 2019 22:45:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574721902;
 bh=iBG0BodDs0Gwe2XN+3tSn6/CzKDz6Y3Hq1qD3RP8fVM=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=DtDsSrUSnwwRHJAs7q+wn7NCy+oJCewmy6M4mKnDLa+fekgv+KY8iLupXJKXPmKtA
 fIp/hp484Qs8GDHFCzdKv6pW4DBnmxFSwhFsgb1CnOsQhgThquEGZWqucgX1gUkZvS
 Omu3s1Fbv+nmbK84xJ+WeEVZMb7Lip6E4uFdlcyI=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20191125044503.GB9817@sol.localdomain>
References: <20191125044503.GB9817@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125044503.GB9817@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 73f0ec02d670a61afcef49bc0a74d42e324276ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c1ff4836fdab94c7c15b23be57bf64c1e56a36f
Message-Id: <157472190253.22729.6647142236304424052.pr-tracker-bot@kernel.org>
Date: Mon, 25 Nov 2019 22:45:02 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1iZN6U-00DXD2-KK
Subject: Re: [f2fs-dev] [GIT PULL] fsverity updates for 5.5
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
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Sun, 24 Nov 2019 20:45:03 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c1ff4836fdab94c7c15b23be57bf64c1e56a36f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
