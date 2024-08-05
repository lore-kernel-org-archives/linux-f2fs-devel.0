Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C3FC52D6D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:31:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sb7Ab-0001Hl-RJ;
	Mon, 05 Aug 2024 23:31:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sb7AX-0001H3-2f
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XEKHbLAPDQOKTItc4uo1WB2g3rDhEdPB94M+f7Ovnzk=; b=P7H0WMRl5HK8n0fI4P/QUnh0YW
 QRom6J/sMtQ6XRgtVckdtjcRwBJMeJItrtkAZZH20HrzxaRChrKa+t/kGVAoNDVLhgaOSOUaw5s5U
 eCET0v28S80RWVv11+n3H4P9/dKkToShxEIKBxLjbisaWaHNe7J6MJLY9q0BpAQpZwLs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XEKHbLAPDQOKTItc4uo1WB2g3rDhEdPB94M+f7Ovnzk=; b=TY5A8RzL1LXJr+EraA/jQhr5/V
 EWUa3pJMA5sFbF/4/QoeOeYgvcY7CkjZ3Ag4197wUSJepPlkRc6e1AYlMSbpuMyQQBGmrjd7Pvgph
 eXuL3GOFW+XP4dpzUGiDvvD01/g6SS3AMVtziq4WL9f33o12K0rfCPv5eoIPAuWVbAhU=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sb7AW-0005Bh-5c for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 55F14CE0C48;
 Mon,  5 Aug 2024 23:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23491C4AF54;
 Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722900652;
 bh=DWXHm383eXgnYAXqu2T1KjAOSvVJYaQJUm9hcHncQCE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=AsXQ1usc6kuEkKuHAqkuutjYQNQxjRTw3msC19C698qNhbCixqlQOuc7h5qd0Gq12
 +Q4JwRDbDYirTVUZBDMp1RzkDB/Isp4op8vBlfTDW/ON1hnREUnKwePhWlvNTNnfca
 Kae3VZX+yfNBCvcYIQqzK0J83aljuBgrQ4xFnfi0Ci01+Q6/LzVELNxOVcqKQpRj0s
 2SG+kB7SB+8pblbmnUayC5VB0nyyIr86rtgvj8XqiqcghZ6PjNis8AOkKg//OoMe+6
 MiarzJj9w5Cb0bnk5E8SRYym7IENj47r0EW8D8YLtT2POE0qA0p+uIEbPj08+t3QZ8
 lTVGSOLcBsWSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 179ACC43337; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172290065207.2803.4270306685689335916.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:52 +0000
References: <20240626014727.4095350-1-chao@kernel.org>
In-Reply-To: <20240626014727.4095350-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sb7AW-0005Bh-5c
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: reduce expensive checkpoint trigger
 frequency
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
Cc: jaegeuk@kernel.org, wangzijie1@honor.com, zhiguo.niu@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 26 Jun 2024 09:47:27 +0800 you wrote:
> We may trigger high frequent checkpoint for below case:
> 1. mkdir /mnt/dir1; set dir1 encrypted
> 2. touch /mnt/file1; fsync /mnt/file1
> 3. mkdir /mnt/dir2; set dir2 encrypted
> 4. touch /mnt/file2; fsync /mnt/file2
> ...
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5] f2fs: reduce expensive checkpoint trigger frequency
    https://git.kernel.org/jaegeuk/f2fs/c/f541093786a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
