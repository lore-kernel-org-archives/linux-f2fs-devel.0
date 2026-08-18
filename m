Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7F3C5DF67
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:References:In-Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vKmTIDPMiFa/J6NrkNQ0B0XG11tMdZqZT3JDRzIZiAg=; b=JIN3WZvMYPolsn9AaNXroco/mf
	G5fWoU7qSXXsXVnTNEv96DK7AjjxVQHwTN/Ckf7WhAb1VfRVvsCqsujHUZvcaL2yXYCE5lJST9ZMN
	OkKOZUAj0I3fyDCw3Wc9y0thRpLE4vly3YNlW2n4KUp40u9MA0MyC7S0SbQwHAmnUI1k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwAxq-0006M1-Pj;
	Tue, 18 Aug 2026 03:58:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1wwAxp-0006Lv-Kc
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 03:58:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gklsedvwg/1RBEAFZOJaRdv25Q5XetfTjtahYKt3FGY=; b=A5jo6gIF+4xxZbmPtEG7cWtpbv
 /wQhAjI0wHMnR9Z1kzSR/7/M1ncZX3R/Ci4vUCQBv4fD/4yjjz2055T1BFgZTJUuU9OXaQRrAKGEK
 Oqd7IYWV/I1pCwKRp6C+GvtwQtCq3dSiX41bMM3uCeDmBOu3Yjvcr5gLnugWmFvxrPTg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gklsedvwg/1RBEAFZOJaRdv25Q5XetfTjtahYKt3FGY=; b=YCEvdA0jBhnF0hUMY20JEuZALz
 os5NI8QhStCWQEXuq1biS5lYX37DYPtCWPV3qXc/VNpNaUtnhconHEe/xEha6yvp1M6XdG8CcBw2/
 wVgrXtF6ASC1UQ6Mm67C8mDznubuPktURFep5BFwXLHw+ok6lZXxguiiVfGsMN822cqo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwAxs-0004Aw-FK for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 03:58:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91564416A1;
 Tue, 18 Aug 2026 03:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D111F000E9;
 Tue, 18 Aug 2026 03:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787025487;
 bh=gklsedvwg/1RBEAFZOJaRdv25Q5XetfTjtahYKt3FGY=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=Hs0z7ei/yI5eRfjNBvWmtqktBzf6/Yt+m7WF/z66EHe/dV4TVgEIh99vkwyOSVEkm
 wL8CPLEUL+8pXlU7v8G9F+DLFt5wvRk7dS3u+mY9S6IWuyu755v+f1+xbZD7Phpuwf
 LoNMnQvpssVBrLMLx0hOYgBSwYtrOQYjsHgV5hA3ymy+ndwzEgkH6u9b8lPCNYwdIH
 U+fXGSBvKgl872L4FXmUBAPAfdcwTK/wLiVxuPBZ2AAmRSW3sbz+eCjfbpyGRUxCyI
 0LidkTntVEnUu1XcCyI9K7QaF0uemtr5rJawcgm5tLpYX6pIP+4YnwFPOYzcCD5MTS
 LmAnTSCx0lbVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93B193926381; Tue, 18 Aug 2026 03:57:20 +0000 (UTC)
In-Reply-To: <20260817173311.GB8327@quark>
References: <20260817173311.GB8327@quark>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260817173311.GB8327@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 7dd38d9dd7a05329825fe2324d4d8e27ad4b3cec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d7443e4dca1e8637930f3baf64e2fe82033e669
Message-Id: <178702543910.1862718.5095788167656687707.pr-tracker-bot@kernel.org>
Date: Tue, 18 Aug 2026 03:57:19 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1wwAxs-0004Aw-FK
Subject: Re: [f2fs-dev] [GIT PULL] fscrypt updates for 7.3
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
From: pr-tracker-bot--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: pr-tracker-bot@kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Mon, 17 Aug 2026 10:33:11 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d7443e4dca1e8637930f3baf64e2fe82033e669

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
