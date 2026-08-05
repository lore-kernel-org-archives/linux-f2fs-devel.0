Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C78C561E6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ihLAIopnBSfgMq09bvOmcegtZZWjALD3hY2Sb01O2sI=; b=Uf88qSK4nxXEAktS3vhNrCm+8a
	OGxPzZeBpgcFAsU9tx7UKZvsg1s4twmL0Dqy7HKWpwiLE0c53cnzw60IsJEquLUUgjkOFQryZdgCQ
	uI59d4jwjumzEQ+LL9hn/XmzfBY2oDkNQa5eG2WKr2tE+4DKHV+mfFosBR6zAUhdjIQY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3W-0002CO-Qm;
	Wed, 05 Aug 2026 21:21:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3R-0002B8-21
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rpaPKwoiXdtvJftI7KiorHJDeRmku6CQ00S4mdbb3nk=; b=evcOj6mRlCniUDgdOS51yOcWW1
 dxdJm8Gq1k2DFW8NdZqw95gyXHHB94sNeDIscMF64xJ+yfq+svC9lW9s68LCeqTAReMiTJI1zpeRJ
 fYphsVlFq7yTBvB5vC4ssRb6w8NmtBAMI6P+nh9IdvWKoqE+CrhAsiJgflRUQ6hlF9hc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rpaPKwoiXdtvJftI7KiorHJDeRmku6CQ00S4mdbb3nk=; b=RU7Q28d7dTiXfKClB606q9Foit
 kpIYYyqw+/2yj2gGBVQJcAjambytVNIIWAWjh0wc50/QhLz4XKXPHJNhTiFLlYijcCARurw6oeN3I
 Fg5AV5QEKcRv9cb7O8VX3aguGETJmdtjuJBzKzLfETuaXb6/ZSXT9+YqyGFkATIQtU20=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3U-00044B-0f for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3313143C84;
 Wed,  5 Aug 2026 21:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D731F00ACA;
 Wed,  5 Aug 2026 21:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964891;
 bh=rpaPKwoiXdtvJftI7KiorHJDeRmku6CQ00S4mdbb3nk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=bPlzYW/mg9JJ5qFOid5wSlG52qLQ1p4UfV7HR4JbSVDm/3eUzYnDEydMYl4mcbV0L
 +Zu9JA1fpf0dy50nKCQftPGLa4riIIocrl9j8thpE/pUxAePTJtr4nRN859kJOXC48
 Ek53g3mE30IG1kB7z46s4Kkt5DOkIWHON5NZOVJAN8Xp06RFD3+yoIgrONfw9dGi6E
 Q6W8eJ5CmyY1xXecP1A+hBGO3yzq598zZRyjp2XLMkkbTVm3yOmKBbeq1XS3HObpxr
 cq2tIJeEpCg02Duhci8bDSShnPmVWe0VLK/w7BeRNlpmn6Y3xufDrB3K3fygMfbjTr
 805swMZmnGMtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 198EB392FFD1; Wed,  5 Aug 2026 21:20:52 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596485063.530543.5619013017977546387.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:50 +0000
References: <4493e1b9c502f9394cb6522ea433f43a64f218da.1785775861.git.bvanassche@acm.org>
In-Reply-To: <4493e1b9c502f9394cb6522ea433f43a64f218da.1785775861.git.bvanassche@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
X-Headers-End: 1wrj3U-00044B-0f
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Run f2fs_write_end_io()
 asynchronously
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Aug 2026 09:52:22 -0700 you wrote:
> The bio_for_each_segment_all() loop can take more than 10 ms for a large
> bio on an ARM little core. This is too much for interrupt context. Hence
> perform the write bio completion work asynchronously if a bio is large and
> if f2fs_write_end_io() is called from atomic context. This patch reduces
> the time spent in f2fs_write_end_io() from about 10 ms to about 150
> microseconds on an Arm Cortex-A520 core if the max_atc_write_bio_size
> parameter is changed to 16384.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: Run f2fs_write_end_io() asynchronously
    https://git.kernel.org/jaegeuk/f2fs/c/3de6b8094115

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
