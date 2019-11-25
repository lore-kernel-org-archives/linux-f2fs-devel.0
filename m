Return-Path: <SRS0=iO/g=ZR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6ECC33C8C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 Nov 2019 22:45:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EEE520870;
	Mon, 25 Nov 2019 22:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="g9H/LiHN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="l8gIWC6z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9Alqeli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEE520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iZN6V-0007VU-Jx; Mon, 25 Nov 2019 22:45:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1iZN6T-0007V9-7b
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Nov 2019 22:45:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hrgiJaC3eqCYQw9G7uSE9w+VKjb59V/pnHzU5FOgYhs=; b=g9H/LiHN91jRCnGMW4QrHUcH7A
 J2B3oLXN8HV/W2JRSvOJkC21Uqx4yJQfXfZ5em94PDSAVUE5S14dUjCjm4xB0v13j9YKK/4Yn+mo3
 TlSg78ccCWgfdzBYVfsujGeeXtfucJ36HHCc+bK3FegrCgI8xe/XmfQNS3uy3OC5Svx8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hrgiJaC3eqCYQw9G7uSE9w+VKjb59V/pnHzU5FOgYhs=; b=l8gIWC6zsOJrbEu+qLzCRbjdlo
 GSA7sWfrOv6V/kRvFJZrzrma5K2YMeYICsIYGcoJKej8nb+8UiCfBoFML8oFv4DXOzVDFTw2zuTDH
 Fd54xW8OAm5yXdSp5TgaZMDf1I8sVGpy8J9+rpuejmhocK9hMpizvXVrEPuvfXQJE5Lo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iZN6S-00Dg7B-1Y
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Nov 2019 22:45:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574721902;
 bh=AXP7zQMapTN1rWqrZDwdb3wcRiMjJxVjBSUx1h+liqY=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=f9AlqeliSTi2q+Z5YE7YxcEWbjXZMvGJhzMVylW3dD8QZvEoai2ZvVOk0flLPy82f
 0zjKG7wasISlpZIYVBFxEOuITOEy0AgNQJhLZ7OWFVFGm2b7n2jffMHyrpafDCMm75
 VOMjbO6obTXmLy/oBkvIobk6BkMlRnz+IZ4v+obM=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20191125044122.GA9817@sol.localdomain>
References: <20191125044122.GA9817@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125044122.GA9817@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 0eee17e3322625b87ce5fa631bda16562a8dc494
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea4b71bc0bb646f811e4728389485f1d0522f7ea
Message-Id: <157472190221.22729.18046740901098864621.pr-tracker-bot@kernel.org>
Date: Mon, 25 Nov 2019 22:45:02 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1iZN6S-00Dg7B-1Y
Subject: Re: [f2fs-dev] [GIT PULL] fscrypt updates for 5.5
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
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Sun, 24 Nov 2019 20:41:22 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea4b71bc0bb646f811e4728389485f1d0522f7ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
