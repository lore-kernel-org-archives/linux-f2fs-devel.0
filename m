Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E906C561E6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6CVuIQhV8lOTdxom3Yz6EprEPj4Bw3FxI+GUuH5Lv00=; b=A6u/fv0tVCuqtISrWU3DGgOWgS
	KpCWHVwfThS2vdx/zXqv+lZBUTn7WaFFo+aCMtBAmnG9IPwKnHGgdfA9ukeC63tTqDsEhYR5GX0AL
	QBlxSIwq2WdSC8vWh2+3jnMHHP/A8XicB2pQFx1Ic4ny45jhLJwGeT3PYX6midPE8hYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3Q-00087L-9n;
	Wed, 05 Aug 2026 21:21:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3O-00087D-7k
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Ghld3Bgtyd8N4z/I2BF8xaP1MK1xRhcD1IDIrCmmoQ=; b=UfjqvWthlL5Ym7Bg7oddGpIbVS
 SJYhkY4Btnmvnc+EY26kdoOZbWxg3q1eTnS+i7I1wkaFyGAWzzbDRbSFWFtZbtkYAQm2S8Ty9rTbj
 oGrsY0cxLB9U3H5iXWI68jpsIqfot5eECkSA+/Kznu8A8c4RaJel+kiNJydYLM3DLpWs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Ghld3Bgtyd8N4z/I2BF8xaP1MK1xRhcD1IDIrCmmoQ=; b=GuYy30QAFM4kxhUhYeH8sx2DhN
 cJ3BgAa8LaAYH8raK5qZ1fbVtfvoizCrJ5s5ahe2t5XrQ6EQmu7LnQkrl4fU6zuvPr5Q5TuxLqOLe
 AgbhqStsI9QOMfhSH+mQ7743HFu8RzPAZh0T4sZqm+6hzK8J1/3yAkIqQpvM/QH78wv4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3L-0007Aa-69 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32E4F437D3;
 Wed,  5 Aug 2026 21:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152E81F00A3E;
 Wed,  5 Aug 2026 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964885;
 bh=5Ghld3Bgtyd8N4z/I2BF8xaP1MK1xRhcD1IDIrCmmoQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=lg8uk6yX1wy9cqF2ymdzThp+oC57BM+3pzvJOB8fvrDEZHSrMbL1iCIvs6ccP2WoX
 pCl3yhwc0i10wwXABfc5YYisSLsrbGNkEAMY4wl+zYDnwiRzEUSL8bYAwLXOZ/lUTa
 F2eDLwYyQ288OHwfJnc8mInpgsAYNUeRsoMSn26ahtWDCvZ9IynTeFMA3ej+4RSAFf
 rPz1RlsOr0MBdFhA2ruiF1Lkc5CKwNMgW5nxqZrqUS8NbWmHSBeHVT8kpnTrrGlmqj
 N1BJ8mUJP49lNfUX6rrZTqDVU7oPyZD5xI75IPCXbgLo2ee2jy0FDUCW8k4JK87L+4
 RQycacVrs72sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19942392FFD1; Wed,  5 Aug 2026 21:20:46 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596484463.530543.6481276544684455442.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:44 +0000
References: <20260804014849.1942326-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260804014849.1942326-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wrj3L-0007Aa-69
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: avoid NULL checkpoint thread
 access in sysfs
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  4 Aug 2026 09:48:48 +0800 you wrote:
> checkpoint_merge can be enabled even when no checkpoint merge thread is
> running. A read-only mount is one case: f2fs does not start
> f2fs_issue_ckpt there, but ckpt_thread_ioprio is still writable through
> sysfs.
> 
> The ckpt_thread_ioprio store path updates the saved ioprio value and,
> when checkpoint_merge is enabled, calls set_task_ioprio() for the
> checkpoint thread. If cprc->f2fs_issue_ckpt is NULL, that dereferences a
> NULL task pointer.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,1/2] f2fs: avoid NULL checkpoint thread access in sysfs
    https://git.kernel.org/jaegeuk/f2fs/c/5cb33b00c8fb
  - [f2fs-dev,v4,2/2] f2fs: protect critical_task_priority updates with s_umount
    https://git.kernel.org/jaegeuk/f2fs/c/8e4692c6c165

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
