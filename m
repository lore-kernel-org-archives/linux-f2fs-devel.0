Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347D7D29C2E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Jan 2026 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHIXS/TvW/hHN+WbDIss20glHIPDlmZCxK5qtsrFQTs=; b=MfffZZBzlQxObqBVXHYbjC0D4a
	E/AVep5ht1wKY4xKh/qZT0e+u52JS21M07Qn2TVPtfRYadNqHtyuc1kAgh5h5OBaHvChvSFOytA8z
	RWhZmYtuDN92XtCjvSs+A5yLy4sHQB3ZtIeYavZKOpSeczlpqzz6Ay8YleWVLXHg/alo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vhpiD-0001ZJ-3q;
	Mon, 19 Jan 2026 13:54:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vhpiB-0001Yy-Nd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Jan 2026 13:54:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z45lru4bLkLyn/z2yQCayeYuf/I6u5k0IVUVR8DrRvk=; b=jCvVafN+wav0STedQCl1VOakIE
 8zHQTUhOzava+NcYTQr8a7IyZAYd6XYC04Fr7nnAd2OjqA+eVCY6c+g3SWfzmFPa6nEjSmhEId8MD
 7yf1MEGpYrIn0r0WYuXedDWLauNzR+L1/aegMmG/PJIu9kxfHb9b5z8u0cLWukovy8Bw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z45lru4bLkLyn/z2yQCayeYuf/I6u5k0IVUVR8DrRvk=; b=S/aJqU2wAPrgHb8qB6YTh2Wb5V
 99NRL+WF4anmjCId+Zh/8Diz62oJeS/AjynHljNpX8UUt4mtb4kNI3bZCEzYu3ki2YuW+2C4moyu4
 X3Mi09A6aFcdvFfn1piKnDdtosduZsFV++7eO+/qwMJbYox4aV3+nOgGnati/syzYIRU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vhpiC-0005rT-1Z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Jan 2026 13:54:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 19135444FA;
 Mon, 19 Jan 2026 13:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA4DC116C6;
 Mon, 19 Jan 2026 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768830861;
 bh=pgmLHFyZNQlKmAjQhScPRJvri3LPzgKN4WS9zj4fs1g=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=nUDaEtc2kFVPAHXZNY5tOHzSbZVNuTevoqPghmmWzFTyc511MPYtj/bFrDyn3Te3e
 8pUkJan4WPzX8l4O2+Ms81Qj4aVUhDh8spSe0PAlLGTU5UDYBiDGiQUcnZ6Yuj6ieh
 OIeJaoSL7OvZglX+2TGrQKk16rNkWJSIbcep5wf7wdmc5EKaVYCIRrMrZRdaFSMS0s
 QNkmjlxDvHHyoLGgZuu2dvujeyDa9p+hHLGr6ylMhypE5iOeRNJEV8gJiVtiZ9wV81
 dr5i18769kfCEd0jm88tibgi6gcvrvYZuWcACg94MNG+bSgmKIU1G+uxjLEeUIX5Fb
 BG1Er0Cs6S+2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F306B3A54A38; Mon, 19 Jan 2026 13:50:51 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176883065077.1419958.17121432983363983595.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 13:50:50 +0000
References: <20260109144617.3282553-2-monty_pavel@sina.com>
In-Reply-To: <20260109144617.3282553-2-monty_pavel@sina.com>
To: Yongpeng Yang <monty_pavel@sina.com>
X-Headers-End: 1vhpiC-0005rT-1Z
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: avoid unnecessary block mapping
 lookups in f2fs_read_data_large_folio
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
Cc: jaegeuk@kernel.org, yangyongpeng@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  9 Jan 2026 22:46:18 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> In the second call to f2fs_map_blocks within f2fs_read_data_large_folio,
> map.m_len exceeds the logical address space to be read. This patch
> ensures map.m_len does not exceed the required address space.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/1] f2fs: avoid unnecessary block mapping lookups in f2fs_read_data_large_folio
    https://git.kernel.org/jaegeuk/f2fs/c/540d34c18272

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
