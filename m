Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500E7E67493
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Nov 2024 02:57:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t6hqf-0004eY-IX;
	Fri, 01 Nov 2024 02:57:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t6hqe-0004eQ-2u
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 Nov 2024 02:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oI+yUaE9h3HpyZNhJI1hwkxINsSPS9TSP0qMZEwMmn4=; b=HJDRdfC5tvnPVzYSLtTMkW9fif
 rcTJMZlNdKGwq5+3rF3D8er1RnKXYmNuF6qj0mR20ccbEfxoy0LxapSrDej8i46Rhj9tiUuTW36hv
 ff+q4LHGf4IeVos4t9wSB4VyMloEAqqq59bqu9fzZxQ1NoL+ga9EXMw7KNreMpYDqc1s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oI+yUaE9h3HpyZNhJI1hwkxINsSPS9TSP0qMZEwMmn4=; b=hMHr+0WFYbihm5vb1OFXE08kci
 pQJyOB1tkJZQD0To5r70IglJXZXpU1b1KFzCItbXfbr4SsrzzN+esQtEJDXJEExNCLBVt/+KABRyy
 hYTOBvo+7btNhMRUcndJscg8i0JYaeNNEx+YeDVb0J284tZ/0oCejODFjIxI4IQ6T+b8=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t6hqd-0003Fm-7p for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 Nov 2024 02:57:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id DB9CBA41A30;
 Fri,  1 Nov 2024 02:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637C6C4CEC3;
 Fri,  1 Nov 2024 02:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730429824;
 bh=a5NoWWYguUVibk5QAlWSTdse0oOpmio5ZTRSxSKdTHQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=LDgtB2n/HKHauidVy8f6LWxckuLLteBQUPkA57BwctbN+eQ1yakpFY3sQDHCTOrJg
 xN3vpCWW2tMu/Ke0ecwhFcpPNVtFbzhSGirlOLjm+ShI2QsvOvSFVK8PX7sSonAV4a
 DKACWeJ7NumwAjf3vqJQ0sOneT9upQmjyT4y8eRQGA/nHO+zfhexQzsuAZjl57YDnI
 SOMBvT3g12aFu/ZHx7U39eeDDR/1oynkUkilbwkPOsMfeAXjggQ9TndK9QzuD545g1
 +ZxyfqNLtwwcT9tK4YHT+C9tip5WP8iecrCP7aTqcdubMEpvse+VY0AoIaXFy5d/pR
 1KQsEUD15OesA==
Message-ID: <b822c677-b241-4469-a1fc-0aaf5b0e7895@kernel.org>
Date: Fri, 1 Nov 2024 10:56:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Long Li <leo.lilong@huawei.com>, jaegeuk@kernel.org
References: <20241031064553.55283-1-leo.lilong@huawei.com>
Content-Language: en-US
In-Reply-To: <20241031064553.55283-1-leo.lilong@huawei.com>
X-Headers-End: 1t6hqd-0003Fm-7p
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix race in concurrent
 f2fs_stop_gc_thread
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
Cc: yi.zhang@huawei.com, lonuxli.64@gmail.com, yangerkun@huawei.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/31 14:45, Long Li wrote:
> In my test case, concurrent calls to f2fs shutdown report the following
> stack trace:
> 
>   Oops: general protection fault, probably for non-canonical address 0xc6cfff63bb5513fc: 0000 [#1] PREEMPT SMP PTI
>   CPU: 0 UID: 0 PID: 678 Comm: f2fs_rep_shutdo Not tainted 6.12.0-rc5-next-20241029-g6fb2fa9805c5-dirty #85
>   Call Trace:
>    <TASK>
>    ? show_regs+0x8b/0xa0
>    ? __die_body+0x26/0xa0
>    ? die_addr+0x54/0x90
>    ? exc_general_protection+0x24b/0x5c0
>    ? asm_exc_general_protection+0x26/0x30
>    ? kthread_stop+0x46/0x390
>    f2fs_stop_gc_thread+0x6c/0x110
>    f2fs_do_shutdown+0x309/0x3a0
>    f2fs_ioc_shutdown+0x150/0x1c0
>    __f2fs_ioctl+0xffd/0x2ac0
>    f2fs_ioctl+0x76/0xe0
>    vfs_ioctl+0x23/0x60
>    __x64_sys_ioctl+0xce/0xf0
>    x64_sys_call+0x2b1b/0x4540
>    do_syscall_64+0xa7/0x240
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The root cause is a race condition in f2fs_stop_gc_thread() called from
> different f2fs shutdown paths:
> 
>    [CPU0]                       [CPU1]
>    ----------------------       -----------------------
>    f2fs_stop_gc_thread          f2fs_stop_gc_thread
>                                   gc_th = sbi->gc_thread
>      gc_th = sbi->gc_thread
>      kfree(gc_th)
>      sbi->gc_thread = NULL
>                                   < gc_th != NULL >
>                                   kthread_stop(gc_th->f2fs_gc_task) //UAF

Hi Long,

Thanks for catching this.

Can we cover f2fs_stop_gc_thread() w/ write lock of s_umount in
f2fs_do_shutdown()?

Thanks,

> 
> The commit c7f114d864ac ("f2fs: fix to avoid use-after-free in
> f2fs_stop_gc_thread()") attempted to fix this issue by using a read
> semaphore to prevent races between shutdown and remount threads, but
> itfails to prevent all race conditions.
> 
> While upgrading to s_umount write lock in f2fs_do_shutdown() would fix
> the current issue, however, using s_umount lock requires extreme caution
> to avoid lock recursion. A better solution is to introduce a semaphore
> to prevent races between concurrent f2fs_stop_gc_thread calls.
> 
> Fixes: 7950e9ac638e ("f2fs: stop gc/discard thread after fs shutdown")
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> ---
>   fs/f2fs/f2fs.h  | 1 +
>   fs/f2fs/gc.c    | 9 +++++++--
>   fs/f2fs/super.c | 1 +
>   3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3c6f3cce5779..7ae1e2a4789f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1679,6 +1679,7 @@ struct f2fs_sb_info {
>   						 * race between GC and GC or CP
>   						 */
>   	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
> +	struct semaphore gc_clean_lock;		/* semaphore for clean GC thread */
>   	struct atgc_management am;		/* atgc management */
>   	unsigned int cur_victim_sec;		/* current victim section num */
>   	unsigned int gc_mode;			/* current GC state */
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e40bdd12e36d..e1b8bf98b5fa 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -232,14 +232,19 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
>   
>   void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
>   {
> -	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
> +	struct f2fs_gc_kthread *gc_th;
>   
> -	if (!gc_th)
> +	down(&sbi->gc_clean_lock);
> +	gc_th = sbi->gc_thread;
> +	if (!gc_th) {
> +		up(&sbi->gc_clean_lock);
>   		return;
> +	}
>   	kthread_stop(gc_th->f2fs_gc_task);
>   	wake_up_all(&gc_th->fggc_wq);
>   	kfree(gc_th);
>   	sbi->gc_thread = NULL;
> +	up(&sbi->gc_clean_lock);
>   }
>   
>   static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 80a53dbf1c38..47a15050ea9c 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4419,6 +4419,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   
>   	/* initialize locks within allocated memory */
>   	init_f2fs_rwsem(&sbi->gc_lock);
> +	sema_init(&sbi->gc_clean_lock, 1);
>   	mutex_init(&sbi->writepages);
>   	init_f2fs_rwsem(&sbi->cp_global_sem);
>   	init_f2fs_rwsem(&sbi->node_write);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
