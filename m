Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D59C76196
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Apr 2023 17:00:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pmHM2-00030u-K0;
	Tue, 11 Apr 2023 17:00:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pmHM1-00030o-L7
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Apr 2023 17:00:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zI5eNzUmpAqdyLhfDuLQcjm+eebg/i+4co3orCKL1ZY=; b=kNjgg74PMp+2ZygwJSg9XFdRYe
 U7Mb1U5VRWA8tEEboWpUjIiNwYIJCcr9bp6/2wzB7qzwHnf7DZvUU4ObgXAjA1pt/cEPb4KgJmT+D
 Uuws2ahAzcCloalY7Lm0y8xDvEuf0OZ6W2hcf6XhO2QgU33p8QxQTEC3T1UpcffdhoUM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zI5eNzUmpAqdyLhfDuLQcjm+eebg/i+4co3orCKL1ZY=; b=LyfuQ4j5zbcQ8guLakVoaC8F84
 ZViKPV2jRujEoUaY1LfoAKIQAR2Cn3JiX5OT6aMmWNUmfZ55vfYZ2emvIoFPED0H50Al6sEhAzaTb
 DwrjvaL2+ehSIoEX6hH5UaErj+UEJPDSLCX63JtuWIn9/WL2Eq4kVuhPvNXZT13BX8G8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pmHM1-0005Cg-TV for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Apr 2023 17:00:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 887266299A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Apr 2023 17:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB0AFC4339C;
 Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681232420;
 bh=UNSRSV9N/VyQhvGkfoOPWdKjQBu0P4UsjBMlYKJS+hw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=CPker5tChAsnSZapefS0UD5yHNC1NcLDv0bwoPc4z0HrfRv2eFGeQI2mMiFDxyd2A
 KlZjSaDPI4pbdCxf98o1BJBiwUJGRMXUIrft70j0rKo6UpQ03UoOQ+XLhzjSmjOIDH
 iY/5ogLJKyxdGDxtAUTD6yXxFKSJyrgajdgipGaDdUKPzXBSPBF2+1D8afylXNSmeg
 j1DX7HwbYg40jLet0Y/6I3a/N5E/12DQW+8xfpmbkA4p7RbSvJWeg6ktN/N1x+NFds
 951TCkvCZLgb2tAxniAx6ZvhqtccumbLk+x53DkPdQb+hCbvNYs8nKu1JS7rA50p3C
 NOH4e7+vGanyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C5B9CE52441; Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168123241980.4928.10692103692042697319.git-patchwork-notify@kernel.org>
Date: Tue, 11 Apr 2023 17:00:19 +0000
References: <20230410021222.1826966-1-chao@kernel.org>
In-Reply-To: <20230410021222.1826966-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pmHM1-0005Cg-TV
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to drop all dirty pages during
 umount() if cp_error is set
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 10 Apr 2023 10:12:22 +0800 you wrote:
> xfstest generic/361 reports a bug as below:
> 
> f2fs_bug_on(sbi, sbi->fsync_node_num);
> 
> kernel BUG at fs/f2fs/super.c:1627!
> RIP: 0010:f2fs_put_super+0x3a8/0x3b0
> Call Trace:
>  generic_shutdown_super+0x8c/0x1b0
>  kill_block_super+0x2b/0x60
>  kill_f2fs_super+0x87/0x110
>  deactivate_locked_super+0x39/0x80
>  deactivate_super+0x46/0x50
>  cleanup_mnt+0x109/0x170
>  __cleanup_mnt+0x16/0x20
>  task_work_run+0x65/0xa0
>  exit_to_user_mode_prepare+0x175/0x190
>  syscall_exit_to_user_mode+0x25/0x50
>  do_syscall_64+0x4c/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to drop all dirty pages during umount() if cp_error is set
    https://git.kernel.org/jaegeuk/f2fs/c/c9b3649a934d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
