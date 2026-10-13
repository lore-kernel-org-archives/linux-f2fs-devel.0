Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44281CC6B12
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3BouFOjMU2Ksm3jGevCBtGAxwrozacozFtYzEy0o0pU=; b=KU5OPfHnhAQkXPD1/rYZ9Uj634
	SGZJTqkDNZ1YkVO67HEPfRdIjur7LAbxXR5QkBGnL/yEBKeB2UzITmqZiahdfqPdCW7uzjTBV2u+E
	PnbpjHC2/3099RA7Fp5VI4wsKU4av8NNeqYTKXpdEfPxm7tWpcg03KMKcalPeC9C+Q5Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl1A-0007Z5-B2;
	Tue, 13 Oct 2026 22:30:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl19-0007Yu-8g
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yWVwpbRKYnzhxmi3juF3jFzrWHMsDiBWTp2swHsSpdE=; b=Y4ozHinqSy6tc8frRTFgpJ9TrG
 +MTOhjurB/OkU6oCIYGZWNq+cqpbr607h9GogKepojPJmAb5TLDVIVGYyxiTS0CJGJKLVYrg2YQuN
 RdnST+598QLrNsioDc+Gr2bXfBY5R+FLLSK4XI665Na4o6wslW34FiauJm5W9Jwo2N1E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yWVwpbRKYnzhxmi3juF3jFzrWHMsDiBWTp2swHsSpdE=; b=l1lr/c8sik/4vRNgPnTEtnHdRf
 9Fcf4cETsWHkpkoxvRm4++1gO4bIZdFj8DumizJIpdg9SBl8OxmG61sDQFqVRs0xT23n+4C6UC6oN
 GB69HEz6NZete3QOaNJL411mo+OknnKMOyqiV2dSg70A8/91v6Tb5R9XuLcfN3T9EmUY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl17-000658-Ta for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F28743E33
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 22:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CB41F000FF;
 Tue, 13 Oct 2026 22:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930636;
 bh=yWVwpbRKYnzhxmi3juF3jFzrWHMsDiBWTp2swHsSpdE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=SkHur7/UlDg+ZykQmYGGB+1biAZCirOCX/kbReHD6O9Zpq6sRnmYnplMNsvaTbqZ1
 q88pdpyb/rH/obCTbiBC4ehwRhq9pSKjcwy/vMySo4+DJlkDIZ3Dm/SwPDtmAcAmev
 UCFOS2eelb36QdVi5+rwmGB3AQbji3q6D72+CbN/Xgfyacu+G2zpFxUm49Dv0YXlaf
 rcVmpfgG9L1LNLL+E1DXPF0N+SQaasYwBFfO+WFSh6uJ9NKJyT4TPJjSyCwDcITW00
 wHTapJZy8ImBZUtGxbbbHYK1qf3mGALMgrAONVa7XHF96fI2l7oDcrJRp3Xy7tml5m
 Dd4BZDco5mvZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 773A939E4DBA; Tue, 13 Oct 2026 22:30:36 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193063501.1493834.9099224335687107412.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:35 +0000
References: <20261001000616.3824366-1-chao@kernel.org>
In-Reply-To: <20261001000616.3824366-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGl17-000658-Ta
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check continuousness in
 f2fs_sync_meta_pages() correctly
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  1 Oct 2026 00:06:16 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> In f2fs_sync_meta_pages(), whenever i becomes zero inside while loop,
> below check may be skipped, it failed to check the continuousness:
> 
> 	if (nr_to_write != LONG_MAX && i != 0 &&
> 		folio->index != prev +
> 		folio_nr_pages(fbatch.folios[i-1])) {
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly
    https://git.kernel.org/jaegeuk/f2fs/c/1383cff4ccf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
