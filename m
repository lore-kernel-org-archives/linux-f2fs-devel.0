Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F08E9A03B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MwjwjgtvcuZAeaI1A8iZujCXkjrJ/XIMIF/xY1zOHyQ=; b=habIfvt0kTbdlse4b4nt1RAN5/
	hxVe/zjgE8VrCE54xiMWEwhnMHSH8MDdbenOR10ZN8cOQ2Abh8nMpOQ99wrtD+apGHoHTRQEBE/XT
	+wWy8YKuZdN/T3qcEADSdQHtB8AUiIEmLbX7B8n6pQ8wpeuci68Vst0pQFjEV7WAMzuQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsSP8-0004IL-3g;
	Tue, 17 Feb 2026 21:14:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vsSP7-0004I9-Co
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:14:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ScMEDmB076+hqZ+ps1vGqxbfDfH+movYOrW9hNYmRkI=; b=QkTMiSOzwUShbCC7PMf1i3mNED
 y0021d7w8sJJlfTh0GYzx/O4Xpjn2nxjMUe4qexID8Nl14x1a3yvn42RazYeW+T3b5uY55w0KIpSP
 3RkxOGQTePtFejgJXSQQqOn1Oix5HFinvZPTSkPxipBp/Ao1QL1KpiKR2UE8+aa38iJ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ScMEDmB076+hqZ+ps1vGqxbfDfH+movYOrW9hNYmRkI=; b=f3AAV1XsblCih8ApW4MmqT7+Rf
 Sec0ZunCuZdkPElWrm9nyksbg+WZddBtl0x1iCOcI4dtWmk6e5som1t3hpyoTf944SLHNJyxLUOgx
 KGj1nPwrnPO/skpyJcELEtRCwnzA4HseeTNRz7zj6NIpHURVU6aPydvbCOB8lh8h7JNk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsSP7-0001TI-EM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:14:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2CFE9444EF;
 Tue, 17 Feb 2026 21:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0374CC4CEF7;
 Tue, 17 Feb 2026 21:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771362875;
 bh=rF0onOkRJ1MrR79ZRlAH0saur24ktYQyPGIU00QVPCI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=obNAHU30KeK7e4E+sJrNxIjHjieqmvasFe6OLCrFOzjIJ/x/ojJyR0JO/ZkJX3uKX
 tbWWtrc5dHY8LwitoshVEtU/1kxURSuzZIjO8r6uOdGHN18+12Urb+dFuH67HYbwhT
 DI/Yw/Kr77gPExDFVz6ed7SpTm8irFrx3L9YGbh4TpucAbeBjCbzUo8hygal10yJRL
 xBSwgaiQww96d3ZVpu08zOJmu+zi9YB6vCrQNEcrYCrJQasyYZ2peWj5ctsXwB1q7s
 4MajCpqM0F2EM1gDpyQG2Glw6Qc+6LCZgMx4vt+uN6/sO5VpYO1WkvlgkjKbwgyU8D
 SJBJRAHiqaIeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 0B0D13806667; Tue, 17 Feb 2026 21:14:28 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177136286684.643511.2911265753074075940.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 21:14:26 +0000
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
X-Headers-End: 1vsSP7-0001TI-EM
Subject: Re: [f2fs-dev] [PATCH V3 0/6] block: ignore
 __blkdev_issue_discard() ret value
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
Cc: axboe@kernel.dk, dm-devel@lists.linux.dev, kch@nvidia.com, sagi@grimberg.me,
 linux-xfs@vger.kernel.org, linux-block@vger.kernel.org, cem@kernel.org,
 snitzer@kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-raid@vger.kernel.org, song@kernel.org, mpatocka@redhat.com,
 jaegeuk@kernel.org, bpf@vger.kernel.org, yukuai@fnnas.com, hch@lst.de,
 agk@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Carlos Maiolino <cem@kernel.org>:

On Mon, 24 Nov 2025 15:48:00 -0800 you wrote:
> Hi,
> 
> __blkdev_issue_discard() only returns value 0, that makes post call
> error checking code dead. This patch series revmoes this dead code at
> all the call sites and adjust the callers.
> 
> Please note that it doesn't change the return type of the function from
> int to void in this series, it will be done once this series gets merged
> smoothly.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V3,1/6] block: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,2/6] md: ignore discard return value
    https://git.kernel.org/jaegeuk/f2fs/c/699fcfb6cb80
  - [f2fs-dev,V3,3/6] dm: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,4/6] nvmet: ignore discard return value
    https://git.kernel.org/jaegeuk/f2fs/c/38d12f15c477
  - [f2fs-dev,V3,5/6] f2fs: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,6/6] xfs: ignore discard return value
    https://git.kernel.org/jaegeuk/f2fs/c/2145f447b79a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
