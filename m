Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455C5CD13CF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Sep 2024 08:13:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sl2C2-0003Pd-3i;
	Mon, 02 Sep 2024 08:13:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sl2C0-0003PU-FC
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Sep 2024 08:13:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HHN87a9bldbWJAZvtzj6UosjsE8vJ2kQpT6kUSzUDwE=; b=bEanjde2er/hPOV6XrODVHpJNc
 l9KU+Eyum668ROr9ELJWusHbzsRtXeupt4eZ73IICCPATiZPpzmDIigkX8+EoNmzLdlZB/StEi1E5
 ztGTWCpkzfKLflSnBUHAi5N4cUmcOulcMZh4iU7XVSztqc3REvKsUMWLYkN4MsDIMpvU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HHN87a9bldbWJAZvtzj6UosjsE8vJ2kQpT6kUSzUDwE=; b=UbCCKbr9MNvl/iaz6jZin961IE
 hYOgkCFftNYTDiO9SoBmgw5AIaQWxml7cMcwgzBAz0sPl8xTdfs8R2tX4ZihuRnINbZ6M3MyeOoUv
 5WOeAP6tMuIwexAcXoCG8mC9oQJcKb5c50IA1XnkIT/Z9ellYwK2xuLIypAhF5XRl4l0=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sl2Bz-0000eQ-Io for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Sep 2024 08:13:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B5ABDA415F4;
 Mon,  2 Sep 2024 08:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F65C4CEC8;
 Mon,  2 Sep 2024 08:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725264812;
 bh=F6vs45rHNeph1oTKE2f2kjgTNGniVmqFJlmqSB39dkA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rITedFPdMCrORPmGDNJWgoiHajp3uO4bZ0+HUZ3A2X2YFi6S/U8qeRB7d7h/ETnso
 aKFaFPmr3eLLPEZC2Zqqd99KmJ5wJtb3L6AG4k8Tmqx5m+s94Cxs/cKEpt7zb1jZXS
 k4fOtsiwm1b5UbFfKY7cZtg3f6Sjt0OG4DhzQ4JoK8OdRcdxTzG6RiBjj92swXJdfZ
 lSn4souNCRQTdNyOkVt9tyfUDRiOxRT1ebecGRVeVQhGhVZOTjFYzi4CDvIMGQHwxt
 WUOkNPzOrO0Euk1Ub5B05SMpOlD4f8/i/4NKbvM25zaXG88IGUvKoNdz0tAM5Wlj+s
 rVMeepLDywEYw==
Message-ID: <0f1e5069-7ff0-4d5f-8a3a-3806c8d21487@kernel.org>
Date: Mon, 2 Sep 2024 16:13:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julian Sun <sunjunchao2870@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240828165425.324845-1-sunjunchao2870@gmail.com>
Content-Language: en-US
In-Reply-To: <20240828165425.324845-1-sunjunchao2870@gmail.com>
X-Headers-End: 1sl2Bz-0000eQ-Io
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Do not check the FI_DIRTY_INODE
 flag when umounting a ro fs.
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/8/29 0:54, Julian Sun wrote:
> Hi, all.
> 
> Recently syzbot reported a bug as following:
> 
> kernel BUG at fs/f2fs/inode.c:896!
> CPU: 1 UID: 0 PID: 5217 Comm: syz-executor605 Not tainted 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
> RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
> Call Trace:
>   <TASK>
>   evict+0x532/0x950 fs/inode.c:704
>   dispose_list fs/inode.c:747 [inline]
>   evict_inodes+0x5f9/0x690 fs/inode.c:797
>   generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
>   kill_block_super+0x44/0x90 fs/super.c:1696
>   kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
>   deactivate_locked_super+0xc4/0x130 fs/super.c:473
>   cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
>   task_work_run+0x24f/0x310 kernel/task_work.c:228
>   ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
>   ptrace_report_syscall include/linux/ptrace.h:415 [inline]
>   ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
>   syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
>   syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
>   syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
>   do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The syzbot constructed the following scenario: concurrently
> creating directories and setting the file system to read-only.
> In this case, while f2fs was making dir, the filesystem switched to
> readonly, and when it tried to clear the dirty flag, it triggered this
> code path: f2fs_mkdir()-> f2fs_sync_fs()->f2fs_write_checkpoint()
> ->f2fs_readonly(). This resulted FI_DIRTY_INODE flag not being cleared,
> which eventually led to a bug being triggered during the FI_DIRTY_INODE
> check in f2fs_evict_inode().
> 
> In this case, we cannot do anything further, so if filesystem is readonly,
> do not trigger the BUG. Instead, clean up resources to the best of our
> ability to prevent triggering subsequent resource leak checks.
> 
> If there is anything important I'm missing, please let me know, thanks.
> 
> Reported-by: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ebea2790904673d7c618
> Fixes: ca7d802a7d8e ("f2fs: detect dirty inode in evict_inode")
> CC: stable@vger.kernel.org
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>   fs/f2fs/inode.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index aef57172014f..ebf825dba0a5 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -892,7 +892,8 @@ void f2fs_evict_inode(struct inode *inode)
>   			atomic_read(&fi->i_compr_blocks));
>   
>   	if (likely(!f2fs_cp_error(sbi) &&
> -				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> +				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) &&
> +				!f2fs_readonly(sbi->sb))

Is it fine to drop this dirty inode? Since once it remounts f2fs as rw one,
previous updates on such inode may be lost? Or am I missing something?

Thanks,

>   		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
>   	else
>   		f2fs_inode_synced(inode);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
