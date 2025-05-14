Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E0DC3ABCC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 May 2025 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IRwvniC0k76r63MtsUC4Vp/eSba5nqRBtFllGjEII0w=; b=d5OqvujlGT2y8/pXKolzojRTZG
	d47XSvSMpMzGFQ17QZi+hz9OvN+XUdhDR5/TjewdtJ+YP7LbRgXXmnZyGgRx7tSaV0sNC0hLOzlJT
	W9cuThr+f2ZUGJwcHUPMMaom983nhafoONJo2nOsQJ2SwrX528cDv3GwJ+IwmqLmbAEs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uFEDE-0004SI-Px;
	Wed, 14 May 2025 15:40:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1uFEDE-0004SC-7g
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 May 2025 15:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CZbJ8kes5c/2P6PG7mGWg8CYwsDDwzcnqZo1GAuGHlk=; b=kUZIePVBeAaRNy2ZWGHCu4ZTLG
 MJT1UqIVwXguSc0t7DupdC2ggZR/HjU4y/xC140OkRr0xzUnYGb/92b6TCRxVbKyKH19vQjNbITNy
 NA+JAyZFDX9NKbHOdRYTfEV1LMWmW7kfUe/LifKU4zO5GKHDzhgXiNjf6pKLvjFhM05o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CZbJ8kes5c/2P6PG7mGWg8CYwsDDwzcnqZo1GAuGHlk=; b=WuxjEQwKQyoveSYuv8qpNXqbwJ
 gTYUF9ELx7RNbe1Qo3oZwAcxNpHThLKsq118tSlli7HEG51HrMUx6ME8OVJScEfBJ0lGDzwWyMtpH
 90TTdxiTt2HFhCuVH/hbzJVyNLZkJXDstH5k1rWto3HrKM61PDdTA5gvlMgpbhRrW1VY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uFEDD-0002DG-G3 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 May 2025 15:40:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 161D14A853;
 Wed, 14 May 2025 15:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFE7C4CEE9;
 Wed, 14 May 2025 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747237197;
 bh=Sz4YK8rbWcb/mqL039IAl49CvL35GI7XnAS3+n+eh98=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=fEsVTkpJlieTN3Wr1GK9pRSBK60nx+63s4cPnjIfsiC+D9Rt+M66H6ccbou+9UeWS
 3nsWP6n0ixo+44Uznj3MPY2hT4yJqZHtgcPSlBf07erd0Oty/lGP1mgevFznk4mUl/
 lo5J0cV+krW2ckp/IUSJbmgCNuTxzZlrXKIj4lMyWXO3rSQeKwmpaDPsCsP8WxYAbu
 kZpCM/AYveqXTHKAMR/zK6FufhZlyqyrTno0HfI+w9Ldh9PSbHp8dM5IFuFp/JHyC+
 CIn14zJr+GLly9+8dzPIgpzKEiA28eGpmTsJUYf2EPc9gRFyy6Ee9rJrp2QK7z+hML
 qHOiB1ziSp7Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70E43380AA66; Wed, 14 May 2025 15:40:36 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174723723510.2412407.16198049270620230058.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 15:40:35 +0000
References: <20250512073611.718-1-yohan.joung@sk.com>
In-Reply-To: <20250512073611.718-1-yohan.joung@sk.com>
To: yohan.joung <yohan.joung@sk.com>
X-Headers-End: 1uFEDD-0002DG-G3
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: add a method for calculating
 the remaining blocks in the current segment in LFS mode.
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, pilhyun.kim@sk.com, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 May 2025 16:36:09 +0900 you wrote:
> In LFS mode, the previous segment cannot use invalid blocks,
> so the remaining blocks from the next_blkoff of the current segment
> to the end of the section are calculated.
> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/segment.h | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v5,1/2] f2fs: add a method for calculating the remaining blocks in the current segment in LFS mode.
    https://git.kernel.org/jaegeuk/f2fs/c/91b11bd8152c
  - [f2fs-dev,v5,2/2] f2fs: add ckpt_valid_blocks to the section entry
    https://git.kernel.org/jaegeuk/f2fs/c/313d10d79a82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
