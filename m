Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84558C3DA49
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jul 2024 01:12:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sYEvo-0005OM-Ev;
	Mon, 29 Jul 2024 01:12:09 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sYEvn-0005OG-Ql
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jul 2024 01:12:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4f3KaMsOuMskuEqIKv4E6Advah0ockcJlTHNZ5wd5sU=; b=d9tofM6IKK47irH/LwCr9dzfjW
 Pk+caSRuthO+vr8IQE8cvP/kKt12JS5mQmaf2WoDJM1fOWIa9DVqay5STdbK7JdTl+6bvjx8/mtKD
 ie4I0za+KYEjRtn/pdA30B2rWE3J94egPdiPl7h1VOPHcgBAl6JWLDVum7r4g8J8Bek0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4f3KaMsOuMskuEqIKv4E6Advah0ockcJlTHNZ5wd5sU=; b=fD2jCqI2fG9AemDuNK1NGbT6NZ
 kz0r5Tk3qyEiG71bXWsWEaIlUJgrJSMkX8Bs8jyPtmK5T5n4pSub9QX9aPm4tsCknowxStp5OJKTh
 M30RWjSvEnOcGOut4hh9ajGeJPf3ovwyelUB3y2DW7R3m1m5rlG2KeTM3hfK0gP9FiXk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sYEvn-0000o9-QT for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jul 2024 01:12:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 74B0861357;
 Mon, 29 Jul 2024 01:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED34C116B1;
 Mon, 29 Jul 2024 01:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722215522;
 bh=BnZP0WSDPhlTGSjXpTvyZEGM+Tf2TVJiglL2mtw++L0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UozLDJoFlpdji7cnN5R2T1ysGypIWktH8NQVfyu+Koj+Gnft7UNBu22/yO4iLfeBS
 vP45/WkhXUHvbJnZtybzeTtlwqrUPRtzDN/SOiH4StytQ2ZxiaqmJbquvwKARCUEYY
 oum3+BSqkba8pnZO1wfKUYdFiOnOHFk6DQRMBOIh5dmS4dgKi2OPiDyOKXtvSHWL/O
 GT0OkU13jKtnYuwDtlF/bjwxde3p3ZH9Nx6cldewVGoAxN4UW2Cl3JvpCDdwzb3jsS
 VdA2uZfX1GkwF1C5ySpdUvMJfnTiaMdcwk/WoCv87COYdAqj7ulT200dHWxWntIngh
 BqWJgi8iiO/Pw==
Message-ID: <537aa35f-c3a7-41d0-aaa4-d000daf39fa2@kernel.org>
Date: Mon, 29 Jul 2024 09:11:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240725020841.894814-1-chao@kernel.org>
 <ZqUOFzAPXE8plKU0@google.com> <ZqURxBYKHipWcz_U@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZqURxBYKHipWcz_U@google.com>
X-Headers-End: 1sYEvn-0000o9-QT
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid use-after-free in
 f2fs_stop_gc_thread()
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
Cc: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/27 23:27, Jaegeuk Kim wrote:
> On 07/27, Jaegeuk Kim wrote:
>> On 07/25, Chao Yu wrote:
>>> syzbot reports a f2fs bug as below:
>>>
>>>   __dump_stack lib/dump_stack.c:88 [inline]
>>>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>>>   print_report+0xe8/0x550 mm/kasan/report.c:491
>>>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>>>   kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>>>   instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>>>   atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
>>>   __refcount_add include/linux/refcount.h:184 [inline]
>>>   __refcount_inc include/linux/refcount.h:241 [inline]
>>>   refcount_inc include/linux/refcount.h:258 [inline]
>>>   get_task_struct include/linux/sched/task.h:118 [inline]
>>>   kthread_stop+0xca/0x630 kernel/kthread.c:704
>>>   f2fs_stop_gc_thread+0x65/0xb0 fs/f2fs/gc.c:210
>>>   f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
>>>   f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
>>>   __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
>>>   vfs_ioctl fs/ioctl.c:51 [inline]
>>>   __do_sys_ioctl fs/ioctl.c:907 [inline]
>>>   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>
>>> The root cause is below race condition, it may cause use-after-free
>>> issue in sbi->gc_th pointer.
>>>
>>> - remount
>>>   - f2fs_remount
>>>    - f2fs_stop_gc_thread
>>>     - kfree(gc_th)
>>> 				- f2fs_ioc_shutdown
>>> 				 - f2fs_do_shutdown
>>> 				  - f2fs_stop_gc_thread
>>> 				   - kthread_stop(gc_th->f2fs_gc_task)
>>>
>>> We will call f2fs_do_shutdown() in two paths:
>>> - for f2fs_ioc_shutdown() path, we should grab sb->s_umount semaphore
>>> for fixing.
>>> - for f2fs_shutdown() path, it's safe since caller has already grabbed
>>> sb->s_umount semaphore.
>>>
>>> Reported-by: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/linux-f2fs-devel/0000000000005c7ccb061e032b9b@google.com
>>> Fixes: 7950e9ac638e ("f2fs: stop gc/discard thread after fs shutdown")
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>   fs/f2fs/file.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 7a37f2b393b9..62d72da25754 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -2388,7 +2388,10 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>>   		}
>>>   	}
>>>   
>>> +	/* grab sb->s_umount to avoid racing w/ remount() */
>>> +	down_read(&sbi->sb->s_umount);
>>
>> Is this safe for freeze_bdev()?
> 
> bdev_freeze
>   -> fs_bdev_freeze
>    -> get_bdev_super
>     -> bdev_super_lock(bdev, true)
>      -> super_lock(sb, true)
>       -> __super_lock(sb, true)
>        -> down_write(s_umount)

Oops, let me check this.

Thanks,

> 
>>
>>>   	ret = f2fs_do_shutdown(sbi, in, readonly);
>>> +	up_read(&sbi->sb->s_umount);
>>>   
>>>   	if (need_drop)
>>>   		mnt_drop_write_file(filp);
>>> -- 
>>> 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
