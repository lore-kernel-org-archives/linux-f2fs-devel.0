Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117C4D65559
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:05:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tG2kO-0001Pf-8i;
	Tue, 26 Nov 2024 21:05:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1tG2k4-0001PJ-8V
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 Nov 2024 21:05:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qSYTBlcseVNXlCo/KMiXDHlcPhcS9mB1dP8QGByVN8o=; b=aeQjMY/jchaSKMqJiV5Og2o+oW
 KSdZ7u2bBtM6FsuJxBE0zvO7tcCgVJUTzVaabvERpHsz0MNh7RuNp70YgjC8Vtb9obsvA5w2rnVhm
 3Be7DroSDGZveCeaknO+G8Uf/PdHCp5yTXNaB2IdT+sfhnB4j3lIQCNF7Rsz7SPievsg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qSYTBlcseVNXlCo/KMiXDHlcPhcS9mB1dP8QGByVN8o=; b=HLRZCYm3kWuNNI9ANPuuVVGWHq
 XQ3J8BidviU0K+QXbv1IT5KCmmdU9MPrVKVhX/aQ0bPfP7XzmYEv5khYy/m3o47pPZQSgAnQ7v2/v
 8WrXfXl9vbfovUeTEF0IUppnAzyhfJbSappLyiCIJpK9OmVM8fNf8akl2X98cndgrjnA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tG2k3-000118-2e for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 Nov 2024 21:05:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 54DD45C5787;
 Tue, 26 Nov 2024 21:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694BDC4CECF;
 Tue, 26 Nov 2024 21:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732655097;
 bh=YPmXuQPcvXDeOU6wdX0I3xds4LdcmSU6DSZ03NIy33g=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=VnjvQ8NyXU096Iil5A087LwqVPlILJelfnjfxil8E8A8NYDNX0ddYrCM+hTPlgfCh
 EbnRUsURyD64kuO/nvZYKsruYU1YGkJqeND4vOH0AM4juBJzT1vmC1LsIcw8WfaLy6
 rAsyEQmAbnbLBzZbcyLNpyp0GUN6Q62SLRVhgXLNdoCDjg1qXOQHIOlTLuT173CT8b
 RMJVcrdwPlv6Djtx3BXHGCjLNSAVCH6JUn0EuC/viZ0aZrlXvourAQIC0RYZDCEy4C
 isVqSF/Nr871GP9mIv9qtQwW55tWilnN4V2VN+hHD3EhYr37jjz4z8P6eduNC4CXOk
 tl4xNEwRQWlTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7E57C3809A00; Tue, 26 Nov 2024 21:05:11 +0000 (UTC)
In-Reply-To: <Z0SdunZ61-OMaH1o@google.com>
References: <Z0SdunZ61-OMaH1o@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0SdunZ61-OMaH1o@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-6.13-rc1
X-PR-Tracked-Commit-Id: bc8aeb04fd80cb8cfae3058445c84410fd0beb5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44b4d13b70f682a86fee356786cc3e17987fae4d
Message-Id: <173265511031.539328.15285927195255109686.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 21:05:10 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1tG2k3-000118-2e
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 6.13-rc1
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Mon, 25 Nov 2024 15:54:34 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44b4d13b70f682a86fee356786cc3e17987fae4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
