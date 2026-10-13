Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9D0CC6B1D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0u20zYbiKP/QwsGtLeCxmRQsTFjJubQ+J8pBw0v+xeY=; b=eL06Av8J+VOUJsSqh4TZ69odQh
	HjuxgA+9p68nl7X8E/kd00Wwj3J4G0QvZ+jl1hwG0jT6eQyaUwSHbho9T/jsuhi+CGFgkJgfPw1tK
	w80KbiFVioTMLrbFBw8V9VFquZEYVjA+JC1SEshCX5YHMG0oHkjS0seL8nOjQGyK1naM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl1K-00026P-E9;
	Tue, 13 Oct 2026 22:30:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl1J-00026F-LV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f1czPV9+k4BQL3W+Fs+3/RCZKEfLsAG7rN8tKFHt6wI=; b=XQ/JAUk8P2dlfno0Zj6PF4W9iV
 9Qix6ekXFTq9nRrPMmwEjpCWlkwmdNIpAzgj/OGfDx/qAK7eCEiH2+o0VEmFFVAZhTK1sdeaD7XPa
 77z0St0R/utzc/ufdkFljxn1xBR/z3P8Vw5G30fUiSkjIa25aoCytQuQ4zDCgRUKoxNw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f1czPV9+k4BQL3W+Fs+3/RCZKEfLsAG7rN8tKFHt6wI=; b=K/zhsXguKbMeq/VZhL5rNjgC+i
 GjSag4zfjzolMZjsDDhguj94IjNik/xQIXgCWKuUm0rspu101N1voRJoGo+BrKHWCEGgJimCeI8Sr
 u0eqiUVHHgE3gBlcuQ4l3IHc96M3aeDIKkGGYZ7ta8AH6+Zug+l3dCaD0m1DghynESs4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl1C-0001e6-Sg for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 510136022C;
 Tue, 13 Oct 2026 22:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084701F00898;
 Tue, 13 Oct 2026 22:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930641;
 bh=f1czPV9+k4BQL3W+Fs+3/RCZKEfLsAG7rN8tKFHt6wI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=EtY6kmjFl4N/vls9nr1d/gfmeNHK45rfyWH18WTIXQ+uzLlgJt03J47QWqz9Kcug4
 GsTEzh8sQP3zMvPhkpi6xldzj4i2pvIXP/WLdjCyyMxbLaHPnT1NRmtT1NTGSL6ecP
 vVVbqfSJsEW/EXtBR/80+7xrpAxu4iPmPwbjA+t/6ByqF+0lCRqVYMLLlEnYYFOCvF
 Zv/KI6fs7qt4NG+4MfM4GFlQvhIAI5II+sTBRxWYOAS+f1TZdlZqwFJzhM1iYMr1C8
 oRiq2yNK8KsSy5CcclSt4SDv9EaA+EDRZQkiokzXrRM9xw5HJsh7J+ptZmpnmydhLR
 H4F83aLaDrJNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F141139E4DBA; Tue, 13 Oct 2026 22:30:40 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193063951.1493834.17396004482002929582.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:39 +0000
References: <20261001000450.3822520-1-chao@kernel.org>
In-Reply-To: <20261001000450.3822520-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGl1C-0001e6-Sg
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to set sbi->log_blocksize in
 advance
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
 syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  1 Oct 2026 00:04:50 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> syzbot reported a shift-out-of-bounds in __f2fs_commit_super():
> 
> UBSAN: shift-out-of-bounds in fs/f2fs/super.c:3950:27
> shift exponent 4294967287 is too large for 64-bit type 'sector_t'
> (aka 'unsigned long long')
> CPU: 1 UID: 0 PID: 5622 Comm: syz-executor329 Not tainted
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
>  __ubsan_handle_shift_out_of_bounds+0x36d/0x400 lib/ubsan.c:494
>  __f2fs_commit_super+0x43e/0x4d0 fs/f2fs/super.c:3950
>  sanity_check_area_boundary+0x7c5/0xe20 fs/f2fs/super.c:4040
>  sanity_check_raw_super fs/f2fs/super.c:4215 [inline]
>  read_raw_super_block fs/f2fs/super.c:4625 [inline]
>  f2fs_fill_super+0x1920/0x7fa0 fs/f2fs/super.c:5160
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to set sbi->log_blocksize in advance
    https://git.kernel.org/jaegeuk/f2fs/c/63bb030f36b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
