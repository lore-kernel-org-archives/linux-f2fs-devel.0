Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89423EEA84B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Feb 2026 19:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:References:In-Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NYRD7UsPRVRRtszfC7MehZ6rW8rt4OZhWhYyHk3EEyA=; b=KSF8AKet3BaFhLKAt+28D/0VyO
	M4hFf+hqDsCRmBfsVXkd+u1xZsWng3KsEWg1Qt3M5sWlQK5LS2T7g6eS9oE4VAjE5P5+unFkl09Bs
	mYCOhymBTAiY4jrLeSYDFw41TZ0pD/g+LpF2MPWEbv0LQVXwKVuCHC09/n0EvDvXaHjs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vqc8L-0000P7-LW;
	Thu, 12 Feb 2026 19:13:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1vqc8K-0000P1-6W
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Feb 2026 19:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j3MW3CCqCmDF8CqUpTcvPpLTg+08nsMJJm6H0ErsK3c=; b=EsY4Trm0Ln/fCTfUEhURfnblwC
 0UTSw1Ykglq3/Q1WmPq42EUETxCbH/IwkRq1cNG5fUUdsSE5EtM/euSC1P7VqLTmSgYiq5bcwViNJ
 770820dLjeGo0aEf6hliwcqmlL1COuS4lkdfIuEIs7HEyHX3oE3Yx1pm3sd73yCvrqEw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j3MW3CCqCmDF8CqUpTcvPpLTg+08nsMJJm6H0ErsK3c=; b=BcqBp7W/x79ogkw9TPwPkEgTh7
 pybX2eUvGXAV+2y2qqKNuioE7xQvaItnr+CwN42h1hoQ3LyebGmLOmRSGxfglbwQVdOE2YG+TM5QZ
 HdaRY7oC3tW5uUKVmb7b+3I2M5KdLPEuCXe3QJbHmMrB1s2msT2hP1Btym8JtT30/S18=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vqc8J-0005L4-FB for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Feb 2026 19:13:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E36A44405;
 Thu, 12 Feb 2026 19:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DBEC4CEF7;
 Thu, 12 Feb 2026 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770923617;
 bh=KE7WXoqaHK0pd8xHApriiUxk5ihPrBnhvc/Ue8P7944=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=JOjCAWIvw5RTi7LBcEc5cmb66qO0083PDYfMbBEkd2bfs3PZxs9Bxd4NqFezJFdC6
 yaErujmvDgHyrAooB0QpwQNnLUcIKKx5p7N1AG5RCwzBuq9U1eaA7Y7+RVOY+7Sx2n
 uPswMpSoc1HKiB4C5/1wOH3FZ259sUIa2Ar7upUA64LIz5ivT5Iz6Ma3efOw/im/tu
 qgRM8SrQARK09+ZvuRmrAVYC9CaF6FBAHcBfHRtrQGGf7Fg51sMhn+2jvZSfnmvCBk
 +HA17ETv4fuSSRGt1dpIMESC/f8H2yBRz+JJYLVhafGDm+mh2K+q7RroH3a3zdpJmM
 l9Jw/cizAstWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 851713800346; Thu, 12 Feb 2026 19:13:32 +0000 (UTC)
In-Reply-To: <20260212012652.GA8885@sol>
References: <20260212012652.GA8885@sol>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <20260212012652.GA8885@sol>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/fsverity/linux.git
 tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 433fbcac9ebe491b518b21c7305fba9a748c7d2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 997f9640c9238b991b6c8abf5420b37bbba5d867
Message-Id: <177092361114.1663336.16040403932894140877.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 19:13:31 +0000
To: Eric Biggers via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
X-Headers-End: 1vqc8J-0005L4-FB
Subject: Re: [f2fs-dev] [GIT PULL] fsverity updates for 7.0
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
Cc: fsverity@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Andrey Albershteyn <aalbersh@redhat.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Wed, 11 Feb 2026 17:26:52 -0800:

> git://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/997f9640c9238b991b6c8abf5420b37bbba5d867

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
