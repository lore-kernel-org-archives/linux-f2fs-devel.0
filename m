Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98677C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hbSOYrQAtggOmDIRWs9NJnAFEakKh8XIb2OVMTu3wXE=; b=dS9oJUGWancXe5fIMRPMZ8JXD5
	xCV6dzMEO3tv71F5TDsGAXpEFNC89j/xkzmqG8kiudaDBich1VrpsIrqip3yKbu9sVeD/P8CkXEdg
	iGoPSHn0M5QjfutZozFbKhQmP0pf84pyQcvOi5urnBIa9QSaTiDhUbLx72/k7TFz2AFI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqnUj-0002G7-04;
	Mon, 03 Aug 2026 07:53:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqnUh-0002Fy-F7
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:53:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s2kmPaBfw4Q8qnlJbZoUCA5TVNQr1VvZKD7T+D/ZMnQ=; b=Hu5Z426oOt4MkbLxyAWjmLCmO1
 Zga0sGBfewveB4m7E6G04gx4JPKK25MvLsolZ4AV0gSOm4iVRScmOVtRWBlz5gHqV1+8aak0c4JK+
 8Llq0LGxhuqPYVMpP+yd1YfeUiRfpfCT4cNiTi2b7wFCu/ECLe57Vh8iajHZMcq5Pzq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s2kmPaBfw4Q8qnlJbZoUCA5TVNQr1VvZKD7T+D/ZMnQ=; b=ZjUvBjFR6h1QXf8fn0ApkTIhQv
 NHT9m1QblHCR3A3BCAnq+CnAB0b73H+2prmbTnnu/QcrY2DFCmhREp/CfYptBd2LQBfoEepF5EKMg
 RoqNzVfMW1FpsUoO1hVrPDZwBTWCw7TEgDEt78EyXVvzJjMaeW4pUr+B5RLivygBUGjM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqnUg-0007IH-QM for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:53:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3538B600FF;
 Mon,  3 Aug 2026 07:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504051F000E9;
 Mon,  3 Aug 2026 07:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785743628;
 bh=s2kmPaBfw4Q8qnlJbZoUCA5TVNQr1VvZKD7T+D/ZMnQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ERjb+lao44DX2QBSKo3tlfGIymcpKToyvtzmF53mJg7TByXHqhepvqEHeSTf+9ez/
 G3XH5D2sxismuq7b1UQhz3v9LeC+/fPiRBg0Vc8IMlN50v5YjM9CsbMvglKKTuFYqK
 pgKKnn57at0IKm56TuWCCfMOlGxSaJ0iLZ6HTff8hqrVCbJdR3wPN9/LrH8pi03dkO
 coP8680TZc+8VtSI4s1Dm1m/hD+ua6oNBnvK4U8sOkvlE8abxVa0+znF/4EttgzLqq
 fyIZ/0/xhfFUmQEM/IC8rc2IftfxVPLNy9ziOCZluqhngmqoa1Gf0ZyyfBo9cXnoFK
 X28LwMqaMi3ww==
Message-ID: <c235897c-bec7-45f2-aed9-1efa7e0646ed@kernel.org>
Date: Mon, 3 Aug 2026 15:53:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260724090532.351989-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260724090532.351989-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wqnUg-0007IH-QM
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid NULL checkpoint thread access in
 sysfs
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
Cc: stable@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/24/26 17:05, Wenjie Qi wrote:
> checkpoint_merge is set by default, but the checkpoint merge thread is not
> created for read-only mounts. The ckpt_thread_ioprio sysfs store path uses
> the mount option to decide whether to update the task ioprio. On such
> mounts, writing the node passes a NULL task to set_task_ioprio().
> 
> Keep storing the requested ioprio, but apply it only when the checkpoint
> thread exists. Take s_umount for ckpt_thread_ioprio and
> critical_task_priority too, matching the existing protection for GC thread
> entries.
> 
> Fixes: e65920661708 ("f2fs: add ckpt_thread_ioprio sysfs node")
> Cc: stable@kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
> Reproducer:
>    mount -o ro -t f2fs /dev/vdb /mnt/f2fs
>    echo be,4 > /sys/fs/f2fs/vdb/ckpt_thread_ioprio
> 
> Baseline dmesg:
>    Oops: general protection fault
>    KASAN: null-ptr-deref in range [0x00000000000007b0-0x00000000000007b7]
>    RIP: set_task_ioprio+0x8b/0x360
>    Call Trace:
>     f2fs_sbi_store+0x2af/0x2580
>     kernfs_fop_write_iter+0x360/0x620
>     vfs_write+0x5f8/0xf50
>     ksys_write+0xf9/0x1d0
>     do_syscall_64+0x5f/0x550
> 
>   fs/f2fs/sysfs.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index be92c05a5420..0294544d3d34 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -557,7 +557,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   			return -EINVAL;
>   
>   		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, level);
> -		if (test_opt(sbi, MERGE_CHECKPOINT)) {
> +		if (cprc->f2fs_issue_ckpt) {
>   			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
>   					cprc->ckpt_thread_ioprio);
>   			if (ret)
> @@ -1007,13 +1007,16 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>   	ssize_t ret;
>   	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
>   					a->struct_type == GC_THREAD);
> +	bool thread_entry = gc_entry ||
> +			!strcmp(a->attr.name, "ckpt_thread_ioprio") ||
> +			!strcmp(a->attr.name, "critical_task_priority");

Oh, seems you fixed another race issue in this patch as well?

"mount -o remount,ro" vs "echo xx > critical_task_priority"

Can you fix this in a separated patch?

>   
> -	if (gc_entry) {
> +	if (thread_entry) {

bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio") ||
			!strcmp(a->attr.name, "critical_task_priority");

if (gc_entry || thread_entry)

>   		if (!down_read_trylock(&sbi->sb->s_umount))
>   			return -EAGAIN;
>   	}
>   	ret = __sbi_store(a, sbi, buf, count);
> -	if (gc_entry)
> +	if (thread_entry)

if (gc_entry || thread_entry)

Thanks,

>   		up_read(&sbi->sb->s_umount);
>   
>   	return ret;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
