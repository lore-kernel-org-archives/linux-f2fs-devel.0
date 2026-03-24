Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDAAFEC0E1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rPVFHjchAyIO8//ZjhdnAL8ktcRjJbvUbsRqIPgmqbI=; b=Dz8WIJWSBaRvldNOUG8AA/1XnT
	EydnmLvjRPPOD6Yf8obhZ+MrOU7bgAaWEgVy25VPwNMlHT0Eja/SUpQFJJAGJT4sXvWWWmqRAA17F
	JnrnEQqebebdJL1f5/s6APYJm4XGHYF6+yimIErfMCAJhoeuSQ6QsbCuYry7HK768Eb0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w55cM-00052U-Ke;
	Tue, 24 Mar 2026 17:32:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1w55cK-00052M-3o
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Mar 2026 17:32:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=glZAgsTOfsRVYzKBZpXDSBt68mvbr5hae29vhXnDM9s=; b=ihHkn6iM1ReGQensbsKXJYECdR
 SygMD0ExgCIMiDBKOp+SSznLACbOLcqUjvE8Yo49tkykKkYlr51R+W7JWDU0pHxxgBGosScBAdXtY
 mYb2pmlYppop8CIohzttBDT0otSUDMBjNuZUTSt9cpkshL5l9WlRzABF+oADNfk+iwXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=glZAgsTOfsRVYzKBZpXDSBt68mvbr5hae29vhXnDM9s=; b=GGb0mEuNcYcsnoZJBTpFOMsl52
 7fAW3qGY2uhj7rdRagc0olND59TxIzAfn/zBWsQs79ZdWw//UOWjV52spyiCV73Mzdi0cO3owI9Yn
 DCo5bvcsLE7cEFu4PexxY9pTGFHt9ZMlO9NIlnCywN1Dwn3aEEvuX478VH2NHOf+CqoA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w55cJ-0007qG-Bq for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Mar 2026 17:32:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 18C9F408C1;
 Tue, 24 Mar 2026 17:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC31AC2BC87;
 Tue, 24 Mar 2026 17:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774373545;
 bh=4KEG2mXKSt4DOHTbhIg7Yk2lcuYoLiu6H9zILZxm96s=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=O+H7izK/6vBfqsc+xiT+xc9aERWq01L5FK6YVL4IH7tg6lLTyezgyZPBwNn78g3Fk
 TPNQgwU85pLy5XAPNeulEiG8n5EfQPWFpyCMXpstzZYFzhGgdLpa3X64xcQZ+2YOiO
 3umiq9lXokqG7ElbpXTt+O14g8GwVncfnJmtJ7WbEWvxUI0EM1W7moQ3ihjcUQROiQ
 aEh4ip+lFwZ8AHLyUu3aA7W4OCMnDhPYt1mANFabqzDik8tMhGpQsPHGzssxDppGz8
 f60D6Esenhy72To51q45eRbjcnfT+DGeJQqXXKLMSwfM32GLB96ZKehRYa6cyFS6Pc
 4L+BviB3xGzZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 02C703808203; Tue, 24 Mar 2026 17:32:14 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177437353253.1223048.6770609846094260738.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 17:32:12 +0000
References: <20260316185922.2184759-1-daeho43@gmail.com>
In-Reply-To: <20260316185922.2184759-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1w55cJ-0007qG-Bq
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to skip empty sections in
 f2fs_get_victim
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 16 Mar 2026 11:59:21 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In age-based victim selection (ATGC, AT_SSR, or GC_CB), f2fs_get_victim
> can encounter sections with zero valid blocks. This situation often
> arises when checkpoint is disabled or due to race conditions between
> SIT updates and dirty list management.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to skip empty sections in f2fs_get_victim
    https://git.kernel.org/jaegeuk/f2fs/c/3dd8312599c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
