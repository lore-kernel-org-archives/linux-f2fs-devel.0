Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB84C44507
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=89wW76nICHja3t46dEJKHHNmd2M0Wq5IL/gNsvzv+9Y=; b=bkyxVWSLH+LJ+MO6qe4EwfpVre
	Lm9Rp5G8kShMIjex/zyD+R3neNurYVN6LIZ1yRDGV+m5UJAS/UrTXW1K8iCpucOWjdAOp6PUQx2O7
	srsGW4J4jyHPM5Nq0GJ/eUONJM4HnpEgl4YmuZj/W8mhUEgpUscsE+u+eteQXMUGj9NE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjTO8-0006xu-Ef;
	Tue, 14 Jul 2026 03:00:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wjTNz-0006xM-Jz
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:00:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IjExG8SLdFmswT+7SNT2VlWPxv/Kx5sx61AUKIoe19k=; b=ktjdjO8ynUORKEqSHFPpYm/iyP
 lmpl/+p9yyVk4E3wc70aaz9j+EvPh3MAqbTRp7DuVHiIYXyYQpzQOL2hW3GI4LoL+KpLT0YpL5rl7
 TvJzsFs7mC90XJ7QdLgk2O1rj8nybBczx7SqsAd9+FyWjbn+Fcc18NA69YaUDuyq0n68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IjExG8SLdFmswT+7SNT2VlWPxv/Kx5sx61AUKIoe19k=; b=fucOcfIR9VaX3PodPqlj4XiCDM
 dDdVu4o5LR0lm8qN9Bm298b+Q3GsVN9e9BJWTOWCratNRN994HgSkUyIcrr1fFWHDZGgxyQXfzeKN
 lzmlZTFTR4Px2Ba4hb9uVVEsSr6vZCybBLJ5JZ8xNlHA76btVwn4y3wU5kwZdUt7ExRE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjTNx-0000kV-62 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:00:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BC0343C60;
 Tue, 14 Jul 2026 03:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBD71F00A3A;
 Tue, 14 Jul 2026 03:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783998034;
 bh=IjExG8SLdFmswT+7SNT2VlWPxv/Kx5sx61AUKIoe19k=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=kYF+UtVR/Z+tP0BDgQMNjRPnXw/M1HHg6GG8xmZiCLxUHcREwRJ9Dq/s9SNan6N4O
 cjm+O/x6W31Uh9sWN+fcjRdaD1SYFJ3EU1IkDR6JX5iYquZcCFF3f4B+V0PZxgpoNn
 WPtCqoX3HP7DMihqIGnfMZKamifF1wAKGJZsrl9dZgq1yW0n6ZI58LSPmKVlb9zWsN
 UfVQtWoj7a7321ZQiOwTblibHG7n0z75SpVD4oASjSsR3wAgOFN2R76vdmI6ND2hOp
 XVCQhLM4MtCyaJd+v4JQbVWS9xli5UYj7gm0fdnpmRANegx/9giENWGoW+9+owwwRt
 ZpaNhIZpSzLTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 569EF3924FB7; Tue, 14 Jul 2026 03:00:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178399800888.2939750.13968624423667195416.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jul 2026 03:00:08 +0000
References: <20260713111944.924883-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20260713111944.924883-1-zhaoyang.huang@unisoc.com>
To: zhaoyang.huang <zhaoyang.huang@unisoc.com>
X-Headers-End: 1wjTNx-0000kV-62
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix folio_nr_pages() race after put in
 large folio invalidate
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
Cc: huangzhaoyang@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 13 Jul 2026 19:19:44 +0800 you wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Our v6.18 based Android system is continuely suffering livelock and bad
> page stat as shown in[1] which related to broken xarray slot status. By
> investigating big folio operations within f2fs, we find below races and
> fix it by get the nr_pages before drop the refcount and folio_lock.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix folio_nr_pages() race after put in large folio invalidate
    https://git.kernel.org/jaegeuk/f2fs/c/aebfda7985f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
