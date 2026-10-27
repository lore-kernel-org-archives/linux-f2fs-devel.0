Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEAE606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Oc2y0FjS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mTTJC4k1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HNUQZlYk;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2LhkGi8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:References:In-Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=L7PkthaJ8mG5hG9dqH7MhBiScBv2oTwPpENFFAKfBtw=; b=Oc2y0FjSByIg2sRy3Y707SESMx
	E5KQuDME+sHHuneA//7oijKW6ulTSvUqpVF9WHDaGwWhMS/ulBqSmtFv+D15zM54eUCZIwRlHavhd
	cm/33YvzAsGRCjKguTtKRhnw2BKooClDWdDvHVF4M9/KfUwwc9urfFuMQ+T1CzVye5J0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLmsH-000000001yF-0YDM;
	Tue, 27 Oct 2026 19:30:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <pr-tracker-bot@kernel.org>)
 id 1xLmsF-000000001y8-38uQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 19:30:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zgxuY/x7o/J02YLOsOGYz7LiBbyRuniXRECMpP37/Hk=; b=mTTJC4k1RDVFBJWBx++d0aUzoH
 l5J5NvpaaoiUEzGPt3k4ycT4baMlIANJABpGZwg4QzdKD9GbfSxPC6YOtqm3LE3WtxVj8OUrUeUHX
 gj0HYx97M5tWga8QBG50j8g5mo7m5hTMudDbL8K+rN56VHYbxdcakDRWdBtcZ0KkKClo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zgxuY/x7o/J02YLOsOGYz7LiBbyRuniXRECMpP37/Hk=; b=HNUQZlYkDhTCO74BGwAHkWb5Yp
 OPpV5U4671VAXOyql31b88+B6EEG1zmRpuJSsTpOecdKLjEjtgUBID821JBRt+nNd8gV/aGf+UUmN
 PdL+Eb4vCcd4iGo78+HByx666HHV2gfuS5OPfTdk3gHA1SFyWGpU0XjpZ+3Ix7TCLgOQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLmsF-000000001Ys-0Drw
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 19:30:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A0416021E;
 Tue, 27 Oct 2026 19:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100441F01825;
 Tue, 27 Oct 2026 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793129413;
 bh=zgxuY/x7o/J02YLOsOGYz7LiBbyRuniXRECMpP37/Hk=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=h2LhkGi8+byOuo4N1tW/y1qvFj408VN3FxScKjH1EmlaHJFqwqpopeogQgwyaDBDH
 ZZzxT+NqfOvq+JW/Y6eN93RzxsR8JiWehDQw9uLwFx7hzfRjspn87xR03dSIS31ugD
 y3Ii5acBgleq4di0/06rsHqKatWEdGoe1qeDeZGrgkg4UZQVz8bUaFD3Tp6hDzYYoX
 1cegU6xpNhpAStw5w76e/9l37oXH0ZtI4bzAaA11ThWa7KVMm9wywJUSePzrq5pq/9
 pfX6UylKWnubhZ10wOwHDw7WNMNRCkKVLzuoNQ2iedr6QM3qVS6gUAC6PIS+DqroNy
 THzcwcJHpvOhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 074E63AA9F47; Tue, 27 Oct 2026 19:30:13 +0000 (UTC)
In-Reply-To: <at-pjQ691G9O8-2i@google.com>
References: <at-pjQ691G9O8-2i@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <at-pjQ691G9O8-2i@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-7.4-rc1
X-PR-Tracked-Commit-Id: ee17c0cd763b622012bc725253015b6a721b48f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92fcf151766d7406a36f2ba363dc811024146212
Message-Id: <179312941156.284542.13723438000383742281.pr-tracker-bot@kernel.org>
Date: Tue, 27 Oct 2026 19:30:11 +0000
To: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLmsF-000000001Ys-0Drw
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 7.4-rc1
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
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
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pull request you sent on Mon, 26 Oct 2026 19:27:09 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92fcf151766d7406a36f2ba363dc811024146212

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
