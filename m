Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F554607F49C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NJ3QwLXv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LFRRSXKl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XctIKWM9;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crLbjQ2/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hPiWLoyqjkxJJuF+gRHZbTKALgTUI5VC+pwVYyfNiZA=; b=NJ3QwLXvz2rxq/KKeatsw349gI
	RoJm1J72mxMM+MOst44g8GbDtpUSQJK3cWFAdIwOPnVkrPkipXLtJ7vXAUzviHNvM/QBRD77bPwjf
	3VnQFwfXgQ83MssP5pwEkJ35CEm/PNOHm8CrXBsBEa4vtebtb7Q9nNLcvcBlqvfPJVS4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIpTQ-00086R-7y;
	Mon, 19 Oct 2026 15:40:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xIpTD-00085v-JP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qwGM5xmeEPX+GaVpTSduBVTgYgRIBuVMbExrrgClW+Y=; b=LFRRSXKlOWgCFkQZ3bFyCYQVf6
 md8SYhcgDbXoF2ZkZV9KKXqefCus7PwLWnouCdgxTRYTgWUsk7PWkxrDqExF/gZeAkH4VdgKbsSnq
 kkg9Wf8FCMlYu6hU+BXgpZks+wcEU29MudhVpyF4zdPBb1iMEkRUIz1eU0eZbbc5s3Zc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qwGM5xmeEPX+GaVpTSduBVTgYgRIBuVMbExrrgClW+Y=; b=XctIKWM9xvuritw+7qvU0UrpcM
 SjuK2UtdyGAtyx3LY17XHTjwPpPG9S6CftGAntf+HLOeJ+Il8m+Wqo8EXkobzgipz/He1LaPYZnv1
 NPp/9cq23a2R1eQ8K1sgDTVbAOAqvxE/JmJFbP1jbzdajNE/GkdEMk8B9svVpMNQ68Rg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIpTC-0006vG-Vf for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CD35402D6;
 Mon, 19 Oct 2026 15:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800BD1F000C4;
 Mon, 19 Oct 2026 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792424409;
 bh=qwGM5xmeEPX+GaVpTSduBVTgYgRIBuVMbExrrgClW+Y=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=crLbjQ2/0i1E5J+f61nXdnmUhYI8V+mKmbI5ryzsA2PSbcoe+DE5+maPSO6oIdxZo
 0ZtO+0eub6zceTLEA23QkoGnB4Slk9+YAwkieK3vhRn0Ur6AmZE2vLGy6TgJoFgX59
 J73Rur9/1ohJaEsTuvkAmWSgpJNY0m2IDfyMChloo6mM/KpzsRM7umMNAwI5t4JMhW
 adFYTv6l6g1pcxSPNoJRKYSvM7iiA1eDvu3vbAL/wtOfER6Hn1FjcjifmtAivX9o4T
 70UzRrureUYhoERZCLNmzpPPVFl2arRRyThOTEsSF7G1CbCBIxCNso13EqpbNAhewX
 hSjxdRn9a5r1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 773963811A71; Mon, 19 Oct 2026 15:40:09 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179242440802.2714099.4838078075531499701.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 15:40:08 +0000
References: <20260828141240.2391915-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260828141240.2391915-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xIpTC-0006vG-Vf
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: flush SIT journal during
 filesystem resize
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org, sunqiuyang@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 28 Aug 2026 22:12:39 +0800 you wrote:
> During a filesystem resize, SBI_IS_RESIZEFS prevents new SIT entries
> from being added to the journal and forces existing entries to the SIT
> area. However, f2fs_flush_sit_entries() returns early when there are no
> new dirty sentries, leaving existing journal entries behind.
> 
> After the main area shrinks, a later checkpoint can access a journal
> entry whose segment number is outside the new geometry and trigger
> f2fs_bug_on().
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: flush SIT journal during filesystem resize
    https://git.kernel.org/jaegeuk/f2fs/c/a6ede4054551
  - [f2fs-dev,2/2] f2fs: refresh pinned allocation boundary after resize
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
