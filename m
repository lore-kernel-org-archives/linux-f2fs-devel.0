Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CE0C5AC67
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYeYYubSENGzDvHUyOiq1HI9Rn/Zcbn+gUeHDttglT0=; b=bwRvRA6yyFP+vWYNQk9WTda+pI
	7rdX9v2WIAHyjitfesY8BkODIAGoLcvU8KfaUOZqbfmxUl42idKT8hRClvCA3WTkKivFc+XPZA14s
	kTXNXBhrOzrrSQOII3TBk0NdYt+/1M36mgYrkYHa2AGraz0FJ0NSBG71234xocnm4mEw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wte8k-0004dm-MN;
	Tue, 11 Aug 2026 04:31:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wte8i-0004dR-Va
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:31:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rHJQdT4aGQNlu3oL3QhEJVLUmVmr1KIhRrkRh1vTXmY=; b=O31OeC1JXbKti61iELWOO2Sd1P
 tEagALNUkTM0by/Lec/nyQRKesYnZ/TmWCewaT+a0n/YlgLwbcPG3ir6oB2vIyuS5ERTd9SOuSPcg
 MoK/f70kzevhsunrZ+ce0KhawEU8GVqmvG0OodfwgCC45ojGbC7cLYv4LPWSVLKJEYKw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rHJQdT4aGQNlu3oL3QhEJVLUmVmr1KIhRrkRh1vTXmY=; b=L6C0xReU5tc9AjIlWg7je6gQIZ
 4LqohPLHXOfMt0XOOSOuO/THokDvIeruFgMlLycSWXhbkL78iyxC43G9Q3xwvxqmSKgU8OJCTy+18
 iXygJns5cFZvizUt7qvn0L6MiAjBwCbeKJor1hPZ9Rg5KGUp4Hg9FxA0jLE9vu7+V7KU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wte8l-0008LT-U5 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:31:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1DB7F43F05;
 Tue, 11 Aug 2026 04:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018991F00A3A;
 Tue, 11 Aug 2026 04:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786422655;
 bh=rHJQdT4aGQNlu3oL3QhEJVLUmVmr1KIhRrkRh1vTXmY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=BGmiG+lN10SU5frt62df0JvZfSMYmDglu0+YcahnST+nMzQH5RjHu835ck30etf4e
 tECb8uRUlzIQgr+pPvX371m7YHsDZp85xaCvZLKtDBhlse1Gr/gMQcBfYozxde6X3G
 LHjNpcRY0Z82X+phizeg2oAuZGczHjs/Tau8KR39XOw7S1UfSS89KxMkQaqu1aJSjm
 TTV8qxFFAM0S36q5QdRub+4ACIrrOhkTrmFMpfdyrSP6zmuZMcAteP4ZYJ/vFeD6EX
 dwyhbr6whpnj1Ns8Rxb37gAUM/M7LIceYBrkMicykOg1G/asHwzRUQZcgrvdnqKuEK
 d+4B3gF4nl79A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 9396B3926278; Tue, 11 Aug 2026 04:30:12 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178642261113.332426.14184401363226407725.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 04:30:11 +0000
References: <20260806033918epcms2p7fa34d6df7c1045b19ac026d44b877f2f@epcms2p7>
In-Reply-To: <20260806033918epcms2p7fa34d6df7c1045b19ac026d44b877f2f@epcms2p7>
To: Yonggil Song <yonggil.song@samsung.com>
X-Headers-End: 1wte8l-0008LT-U5
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: issue multi-device flushes in
 parallel
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, dongjin_.kim@samsung.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 06 Aug 2026 12:39:18 +0900 you wrote:
> On a multi-device setup, submit_flush_wait() walked the dirty devices
> in order and aborted the whole loop on the first device whose flush
> failed, leaving the remaining dirty devices un-flushed. Each device
> still needs its own data made durable, so a failure on one device must
> not skip the others. It also waited for one device's flush to complete
> before issuing the next, even though the devices have independent
> flush queues and could be flushed concurrently.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: issue multi-device flushes in parallel
    https://git.kernel.org/jaegeuk/f2fs/c/e1116f8e98ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
