Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5F5C5478C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Mar 2024 18:20:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rhCvZ-00069f-K8;
	Mon, 04 Mar 2024 18:20:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rhCvW-00069H-Oa
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Mar 2024 18:20:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jhvPXHGwWR6vF0uyUSjVSMN72OSa0LiZgCG4a14mAI8=; b=l7YdlrPeWDaayb07Nhu+j+4hLF
 9XFJZQ/EH9XX5BO4g49LfSe2TBZrAXsEdnhC16FJll9HnbdYwWH0EQpMgNP6HFxLp8vZ4XJ1gM418
 LNXrQ3Jb5os0pbQUhRE9BcIWTMzqW7mvbOFhc8KLkzxMRae5ZO/buhcX9EyXzCWZYaFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jhvPXHGwWR6vF0uyUSjVSMN72OSa0LiZgCG4a14mAI8=; b=ZDT0Ut7N1qLgJtJRO76MwpcGEu
 hwf/sbSE7FFyRpf5NuZgH3xxtAA1gE/0ExwQHmLuaGRGhQXGAlgZn/+XrFJQAPG3ys6vFxq/DEYPl
 2rHPNtLvYLXlBIK1F8nwqtniFwj4hLC1yy2+GtILO4ok8vbC3DcPvi9CBmkQfb1DDye4=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rhCvP-0002fc-5Z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Mar 2024 18:20:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9329DCE16AA;
 Mon,  4 Mar 2024 18:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EC95C43141;
 Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709576429;
 bh=47i4aSHcYknJkYX0Y81klwd89NWLRQui2X+yMo/YfRw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=fgr+72qorvkWFihJFUq5HNnufjMJUan51KutZDP3MRCQZ8tg3YCN0wujp5JEAVj6R
 KG/hdpKSoHY3Z4fE+WgX+u8+6/GzOadBamxKeVUwfLEwHNMppmfq7fZHWS4Lkaiq3l
 gdlwMOeO5pjWLtAkt+AoaF8sgo3xjnP0W3Z7t7vyuRavEn5hfBgCgcSGzkQZqu61bR
 yuOPjf4N2hRccMQnT18dGxy4m4or/Q0oLZXiEaQhLqDEYOBzLHu5e2C5kJIJi73pg0
 wxAD5AeEuRdSslI9U0ugPPmfVga8pkWB4rbLbw139sT6MR0l35g1bhEkon2iOFzuj5
 CDp7r/XlP/ejQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 041D8D9A4B9; Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170957642901.16816.14170425948750995798.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 18:20:29 +0000
References: <1709121594-22314-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1709121594-22314-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1rhCvP-0002fc-5Z
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check in
 update_sit_entry
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hongyu.jin@unisoc.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 28 Feb 2024 19:59:54 +0800 you wrote:
> If GET_SEGNO return NULL_SEGNO for some unecpected case,
> update_sit_entry will access invalid memory address,
> cause system crash. It is better to do sanity check about
> GET_SEGNO just like update_segment_mtime & locate_dirty_segment.
> 
> Also remove some redundant judgment code.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to do sanity check in update_sit_entry
    https://git.kernel.org/jaegeuk/f2fs/c/36959d18c3cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
