Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6480C83F1B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Jul 2025 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmmC+KoOCg7U5HFilco+9x/OMUfILTT7TsOZmHx0h74=; b=BKbVnWqlnrRaOoxxVlrLQXbHSD
	DxvyN+23rhKAMDOWTgCc7lGF05Euw06JbrC6WSwqJ4VbiLfuOax/IBlqDcToVzKdnPUnuM5/yC9AB
	OHwHI7FWS4Abq6exrTESLvJv8m8uk+HJVApCDXEhIfCAy0PDwPIDmY738ZqV6RfNZa18=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uaGdN-0004oP-AP;
	Fri, 11 Jul 2025 16:30:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1uaGdE-0004nS-2l
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Jul 2025 16:29:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bPS/mQBWI30tDWyaHAxm/XHazt47t7w+iaPK7KSwr08=; b=j+NKuDe54o28Vlby7r5XtoNs8s
 qflBSeP3QRbKX+y4TtIk+1j3YlofrG40XxXNCkK3lPIIxhpOcckLB+PRSOAyJ8w6ZhQ+duX/n19V0
 E8rL5plfDT+DnaU8nu3FPiGpCmpKueNXQsfGVu+Zxx5n2IfDjYfty/dLQxc8iQlT4sqI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bPS/mQBWI30tDWyaHAxm/XHazt47t7w+iaPK7KSwr08=; b=UnkKeTScpV9+xdCGF6s1NJy5TR
 rNIHwZ5zVJ+2E+9Jq3uVSgvh7L47GJjNfPBxvOCG/gI3MVjFYD6W9WkGmOYL3Re4iAqQcH+dAyBJ3
 jkT63v0FVshqm7DTv9PZo7AL/xD9vCr1dCn54syUehHGa4+wJyG2dBQ0jFQsFSvt9oKU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uaGdD-0006Tp-Ko for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Jul 2025 16:29:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3BA625C721E;
 Fri, 11 Jul 2025 16:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0415EC4CEED;
 Fri, 11 Jul 2025 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752251386;
 bh=incKL2zc0l+sFdNc3xEoLvkCgWmIEiVGwblLyaSzneg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=kG4kxYHHIISUREQL+FSJUpJQWkjFU51Cg+MHi/9q6CrWSeUOqBQsslL3l4oF8hiGU
 APpE/gmOOg52TAExukNyNEMYtZfMys887+06OmiFk83zoRUzoVlPHU4FC5IMZLi/qB
 HsHHCj75KnCQeKU2FCTiwXprY0VliSZJcR+YJdXyG0D86hKEDNtWQH+Q1qXFgYquGH
 E2YCALtQeiz4cwzw2W5sIUMuqRwUlbAu65N3QdVQuFf7d/l2FsID9ZGjf3bLg09gEe
 rU1MoQsosbi6g0cFRM8ChLhTJ4KacOWl3MqzdNmTDxsfZ5xa01/1wGmvoPGHs8w1jD
 fx4r2k/voYocg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33E8F383B275; Fri, 11 Jul 2025 16:30:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175225140803.2328592.14468679828174241013.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 16:30:08 +0000
References: <20250710121415.628398-1-lihongbo22@huawei.com>
In-Reply-To: <20250710121415.628398-1-lihongbo22@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
X-Headers-End: 1uaGdD-0006Tp-Ko
Subject: Re: [f2fs-dev] [PATCH v5 0/7] f2fs: new mount API conversion
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
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, sandeen@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 10 Jul 2025 12:14:08 +0000 you wrote:
> In this version, we have finished the issues pointed in v4.
> First, I'd like to express my sincere thanks to Jaegeuk and Chao
> for reviewing this patch series and providing corrections. I also
> appreciate Eric for rebasing the patches onto the latest branch to
> ensure forward compatibility.
> 
> The latest patch series has addressed all the issues mentioned in
> the previous set. For modified patches, I've re-added Signed-off-by
> tags (SOB) and uniformly removed all Reviewed-by tags.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5,1/7] f2fs: Add fs parameter specifications for mount options
    https://git.kernel.org/jaegeuk/f2fs/c/a3277c98b64f
  - [f2fs-dev,v5,2/7] f2fs: move the option parser into handle_mount_opt
    https://git.kernel.org/jaegeuk/f2fs/c/b03e9e44e135
  - [f2fs-dev,v5,3/7] f2fs: Allow sbi to be NULL in f2fs_printk
    https://git.kernel.org/jaegeuk/f2fs/c/405e5e00bfee
  - [f2fs-dev,v5,4/7] f2fs: Add f2fs_fs_context to record the mount options
    https://git.kernel.org/jaegeuk/f2fs/c/d870b85ae2de
  - [f2fs-dev,v5,5/7] f2fs: separate the options parsing and options checking
    https://git.kernel.org/jaegeuk/f2fs/c/85d2da63b8a5
  - [f2fs-dev,v5,6/7] f2fs: introduce fs_context_operation structure
    https://git.kernel.org/jaegeuk/f2fs/c/54e12a4e0209
  - [f2fs-dev,v5,7/7] f2fs: switch to the new mount api
    https://git.kernel.org/jaegeuk/f2fs/c/a0512c55d7f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
