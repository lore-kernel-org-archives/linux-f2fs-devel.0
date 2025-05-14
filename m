Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA46C3ABD8
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 May 2025 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+TWC7xvBKsLitrnJoMF11RIkhD8nqwuul8dXG8+zBU=; b=PDq8XXYa4boFrwLPVHFjojFR3r
	S/d4G519bgLwJVgXDGoV1KCOxL+CN1gbKttlc1R6dTHmsW4pchC1fa8Xbu5DlhYA5+wqYfnyxTRY7
	M/4ix5NRfpWgbyOwqUCotEmXX5U8j9CnVd+J0WvePC75yQewCDqfJ+oWKgvwWONxKq9s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uFEDJ-00009P-H9;
	Wed, 14 May 2025 15:40:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1uFEDG-00008j-4M
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 May 2025 15:40:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AaZXqVY7waMgep4c09iIizguVyCrDd18a1b2yi3RZX0=; b=Kc/c8mrHpYxkWAAAetFMxjNPbQ
 K5g0Cy4bo5QgTOtkyvQFpFU53e9s9PfVdKcS92xR6lwcnxvuGlU+Ch305VvXcwCYFyLxAOrtJsuHV
 EXkW89E+5poDoRDGfMnE+ed0vNz6hwhtrfkbUPjsEn3ZJGejlxiW8mtLTJFcbFkFwHZ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AaZXqVY7waMgep4c09iIizguVyCrDd18a1b2yi3RZX0=; b=CMeXAOz9gctZsNDGMo40o0yziP
 gXKbDaUlssJF7qSfrndYFIiLh7IyVuFb9ZRkP+lADUuE/YbF80NPhLK1fiZtKMASdIX9yo0F51U9H
 t8/SsCpS0SCSLWO4ZRDFF1vAzwpA3lcTnBRSohb5eGRVgetUMIEAhVHKgqx0U6Zta5pI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uFEDF-0002DO-Jc for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 May 2025 15:40:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E46C05C55D9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 May 2025 15:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2844C4CEE9;
 Wed, 14 May 2025 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747237194;
 bh=XS01oqWI7MSKtVOwYi0RK+ZB6YU61HJHwn6jt2+5Eqo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=QFdj8DHABoRT7DQVWCEvQiWbQ+JZww14VKuXAugxR68XskrByFo4/5tqAdcWtbrbc
 KiMY3zNVB9YflpFTw6Lgo2mfTIJRP2hngDq9sRtkeGRn/6Efl5jwWpSmHVM3PKwpnn
 1VgNJb0/e8WAAvshNhuP7wQhVUhypnfFKMXTl1nij1dEBm9mrQnJyUlHUNJE2Lv0kX
 T4V7yGet93/gbmFYkrxUn+M0+LAvYRcen1R5pQPVVpTIQPdfOytZBN1BmjLvM8EkyI
 XGu9yC59R8d6pPo5GhCBekFDlSZDmltMbGMFVZ56iJk/t3nKYTX6Eai4qoBBORrEQD
 5+ti4SkkbaeGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 711AD380AA66; Wed, 14 May 2025 15:40:33 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174723723226.2412407.3443427617975733647.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 15:40:32 +0000
References: <20250512115514.2641059-1-chao@kernel.org>
In-Reply-To: <20250512115514.2641059-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1uFEDF-0002DO-Jc
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix 32-bits hexademical number in
 fault injection doc
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 May 2025 19:55:14 +0800 you wrote:
> FAULT_KMALLOC                    0x000000001
> 
> There is one redundant '0' in 32-bits hexademical number of fault type,
> remove it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix 32-bits hexademical number in fault injection doc
    https://git.kernel.org/jaegeuk/f2fs/c/13be8795761b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
