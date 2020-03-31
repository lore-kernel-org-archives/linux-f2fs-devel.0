Return-Path: <SRS0=YdEG=5Q=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CC2C2D0F2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Mar 2020 21:50:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B7020842;
	Tue, 31 Mar 2020 21:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lwjU/lKL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="VLs0UbLY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBosVPQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B7020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jJOm1-0000Wm-1M; Tue, 31 Mar 2020 21:50:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1jJOlz-0000WQ-Sw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Mar 2020 21:50:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ClU5bDjN6yPcbq4TjGMuez4NsE9ZgHd0bsKyqUrq5ms=; b=lwjU/lKL7D9g8Z+BAkitJo/1zh
 GFoFGxe/9UUasPTd1/cVMb7mWZfJYw9L5AYNIBU9JXWWAMMElcgFsHd8d/rbkWpSzAm1QONPH7RnF
 MOXHDxIIefbFd4D7YZVFcSxJ1dqd2NAh6DApF4sglILyTvo0IONl/Gg/1PCLdMX9K0mE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ClU5bDjN6yPcbq4TjGMuez4NsE9ZgHd0bsKyqUrq5ms=; b=VLs0UbLYny9eiX8oFpqMa+V8WH
 OAha7MMKjS0DSaEIM8/fq+X5OLb6v2z/Cbx/IoWOMiw2ZxMphDAILS+GPfi9HQSaA6vFG1aoNR74V
 FRBQI3bwuvwfNxon03CF9Lh5/RGK66f5DgjwBcWBJNyXLecgR9So/5HTKOGx3BbVx7vQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jJOlv-00HDnQ-J1
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Mar 2020 21:50:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585691402;
 bh=LcVm+V24+2+NTOJ9JrmVVXkl728hyFi9uw2iR9GZGHU=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=QBosVPQuppbe6iZRabDz1qeEjuf4lM4SbPhgQX19V+1KKwMbxjrmHXREfGjQgEAUF
 1k3zIgblJ+TDv4YnoOKB9A98doinoZvVZuc8iMFiMPG+UFI7hDw4U4aD3I5STWWgcy
 isOSyBj3OEr06AjfDkcZv2vMHRFMaEr6lNNQwIms=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200330165359.GA1895@sol.localdomain>
References: <20200330165359.GA1895@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330165359.GA1895@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 861261f2a9cc488c845fc214d9035f7a11094591
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1455c69900c8c6442b182a74087931f4ffb1cac4
Message-Id: <158569140192.7220.17954616110607840136.pr-tracker-bot@kernel.org>
Date: Tue, 31 Mar 2020 21:50:01 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1jJOlv-00HDnQ-J1
Subject: Re: [f2fs-dev] [GIT PULL] fscrypt updates for 5.7
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

The pull request you sent on Mon, 30 Mar 2020 09:53:59 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1455c69900c8c6442b182a74087931f4ffb1cac4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
