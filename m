Return-Path: <SRS0=qeLJ=7O=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8D7C433E2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31EB2065C;
	Mon,  1 Jun 2020 19:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="hvFynMc9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PO4+8l/8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yHvB5tN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31EB2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jfqDM-0002gp-D5; Mon, 01 Jun 2020 19:35:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1jfqDK-0002gZ-LS
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jun 2020 19:35:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bjEBdWzPfeU1nqUZtiNKL9zcaRu2zIIB8W6KE2LbFi8=; b=hvFynMc9OyV355xQ/WyS7n/ps9
 bn4Fx5fthGiPwrOyyBjKtBYd7AxseTHQWk80fnBMud86DFtPTwxn/aWlJCFrh0FhyoIxPQ931XF/1
 AML8YtZaL1EUJuD1VZcccgwxs7WCXePhmjIdY5rUtnfyGqUwyBHAOISUV/VbKHXNVkvw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bjEBdWzPfeU1nqUZtiNKL9zcaRu2zIIB8W6KE2LbFi8=; b=PO4+8l/8D2DADnrlqJOWAWRoTt
 ZHNGS78ac+cUm0wM8VzmNfhbclQ8+xBPRz5pHCFfzFYMC9UtaUcb70wrpbZTwD5UZmnhE1N7HL30l
 BuHU6HQ7RpqSvsbTojA6feoX2PFc67iEnIShgZL31QSJ0aWXKKNOulR7PJzaaacqfCHc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jfqDD-004f0e-OG
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jun 2020 19:35:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591040102;
 bh=tUb3ekvU9GlhHcK4V45Bi06IqlKQCN2nkMKHtfMvVso=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=yHvB5tN0rf5bOSh4MLRjHoZIDvOq9AuIa+SvvQM835LQ3dji88L4esQeK5PxwflsZ
 Pn1NWQtfhceZty02BxQswjwaz1BD9yMQes3bkD+u6u3Y4N/8sorEca/tPkgqYMt18X
 0yq63fhTUl5lLCN8EgZBcRiXy0ph3hrjk6GWXspY=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200601062848.GA11054@sol.localdomain>
References: <20200601062848.GA11054@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601062848.GA11054@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: e3b1078bedd323df343894a27eb3b3c34944dfd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afdb0f2ec57d4899eda2c5e09fc3a005f2119690
Message-Id: <159104010228.18844.5659318322191292629.pr-tracker-bot@kernel.org>
Date: Mon, 01 Jun 2020 19:35:02 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1jfqDD-004f0e-OG
Subject: Re: [f2fs-dev] [GIT PULL] fscrypt updates for 5.8
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

The pull request you sent on Sun, 31 May 2020 23:28:48 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afdb0f2ec57d4899eda2c5e09fc3a005f2119690

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
