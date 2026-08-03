Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141C7C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6KanNI3qPnOmEM3ipvTZVN1RlgrzJ5ygnNDs8Fp+eiM=; b=KwXmpC56iEUhvvQ+i9CX6Vypd1
	Yg8De+TFgPkJYYbs1UlLpXVRdTHl16P2SfXmg19ovXUqwxerF8THj1fRxRnj0WvC87ILihJAfVLeT
	3roS3H7GVYBuTsYDWuhDtwYIw4hDpRr0sJ6aGkAgm0+bBSsaEYxwqNOOXj03Ni49RGy0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqofT-0007SL-GX;
	Mon, 03 Aug 2026 09:09:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqofR-0007S6-V0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:09:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j0F4zT/R0H+GZNU0Ne4PtTdK3NoVRimW+t7mWGC5Muc=; b=jKc4ppRfX52bkJHDcY9soCLa57
 6Bf5w+LwAjfxvhLoKhFJ7Av5imuVlcsLC0EWFi2NT34cPlXtFwjFOCLwFn+VZUZ2qvg8xdWsJRnzu
 LDdQntK9ceqU/oaF3iXy+c9a3DCOJTW9ZIwMDC+LJJNFXvGA60B+dmxlclBc1BfVrh2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j0F4zT/R0H+GZNU0Ne4PtTdK3NoVRimW+t7mWGC5Muc=; b=DnsGbcZCbIPGJH7Zyc0dRJli0V
 spn36CJ9FBjnEQ1EwQHwBYkL6WO1Ohbt2KlCmFXW3k0syXLzgQaLZ77G5KK68/Hxyflv9Cq9/QIbF
 1xwQkm2d7p33mD1Yvtoa1jKAZ/DaG3ye1KjmPUo0RZ/kxjzpxvN4cG5McJtIQqVVQedA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqofU-0003EY-JN for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:09:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C6C84070F;
 Mon,  3 Aug 2026 09:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208D71F000E9;
 Mon,  3 Aug 2026 09:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785748139;
 bh=j0F4zT/R0H+GZNU0Ne4PtTdK3NoVRimW+t7mWGC5Muc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=IKGYZYpA1RBG0OyCZYxHY1yt+8/W7nnvkM3gE9/uggkzbHaYRA617YP1MyE5YV8EA
 dIH0NkH0f5yxZtJ0nqb8nwgyMEBfEYbO7DKsTvmwmNwxvGukMQ1eHw97zcUen/AbW4
 vC4qvjxV16ALARFKeMgM26/OYt+8GQnA3M+iw36Vtj67KNQceW53OQMh4DdU4tcG9s
 L0lvBnYnXf76lL0JEwZr/SXjsSX2J8ZK0WY0akCmLfiNPel93/Z2H6GpIK5Kv9xeLJ
 bymnHvOpi5wKpnZ7TIaS4C9rOwx1ltKdN9lOVYrvpEE5k8YC3L1S1ztkeb7En1FRut
 2xMvKuct2fPoQ==
Message-ID: <a0c713a9-0381-48a4-bbe6-06d20b2e6a73@kernel.org>
Date: Mon, 3 Aug 2026 17:08:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260729192319.4051409-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260729192319.4051409-1-daeho43@gmail.com>
X-Headers-End: 1wqofU-0003EY-JN
Subject: Re: [f2fs-dev] [PATCH] f2fs: quiesce background threads during
 system suspend using PM notifier
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/30/26 03:23, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> During system suspend, a race condition can cause f2fs_gc and f2fs_discard
> threads to call submit_bio() while the underlying block device (e.g., UFS)
> is in Runtime PM suspend. Because Runtime PM worker threads are already
> frozen during task freezing, the threads become trapped in
> __bio_queue_enter() waiting on mq_freeze_wq, leading to a PM freezer
> timeout.
> 
> To prevent this deadlock, register a PM notifier to set SBI_IS_SUSPENDING
> during PM_SUSPEND_PREPARE. Background GC and discard threads check this

Should we cover issue_flush_thread and issue_checkpoint_thread as well in
where we will submit bio?

> flag and immediately stop issuing new bios, allowing them to enter a
> freezable sleep state cleanly before process freezing begins.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/f2fs.h    |  3 +++
>   fs/f2fs/gc.c      | 13 ++++++++-----
>   fs/f2fs/segment.c | 13 +++++++++----
>   fs/f2fs/super.c   | 25 +++++++++++++++++++++++++
>   4 files changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f24e30bb5c3d..c46bf4df9412 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -25,6 +25,7 @@
>   #include <linux/quotaops.h>
>   #include <linux/part_stat.h>
>   #include <linux/rw_hint.h>
> +#include <linux/suspend.h>
>   
>   #include <linux/fscrypt.h>
>   #include <linux/fsverity.h>
> @@ -1494,6 +1495,7 @@ enum {
>   	SBI_IS_FREEZING,			/* freezefs is in process */
>   	SBI_IS_WRITABLE,			/* remove ro mountoption transiently */
>   	SBI_ENABLE_CHECKPOINT,			/* indicate it's during f2fs_enable_checkpoint() */
> +	SBI_IS_SUSPENDING,			/* system suspend is in progress */
>   	MAX_SBI_FLAG,
>   };
>   
> @@ -1757,6 +1759,7 @@ struct f2fs_sb_info {
>   	struct f2fs_rwsem sb_lock;		/* lock for raw super block */
>   	int valid_super_block;			/* valid super block no */
>   	unsigned long s_flag;				/* flags for sbi */
> +	struct notifier_block pm_nb;		/* for PM notifier */
>   	struct mutex writepages;		/* mutex for writepages() */
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 93bcb35a5b5d..86b2b29402a5 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -71,7 +71,8 @@ static int gc_thread_func(void *data)
>   		if (kthread_should_stop())
>   			break;
>   
> -		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE) {
> +		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE ||
> +			is_sbi_flag_set(sbi, SBI_IS_SUSPENDING)) {
>   			increase_sleep_time(gc_th, &wait_ms);
>   			stat_other_skip_bggc_count(sbi);
>   			continue;
> @@ -1064,8 +1065,9 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
>   		struct node_info ni;
>   		int err;
>   
> -		/* stop BG_GC if there is not enough free sections. */
> -		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
> +		/* stop BG_GC if there is not enough free sections or suspending. */
> +		if (gc_type == BG_GC && (has_not_enough_free_secs(sbi, 0, 0) ||
> +					is_sbi_flag_set(sbi, SBI_IS_SUSPENDING)))
>   			return submitted;
>   
>   		if (check_valid_map(sbi, segno, off) == 0)
> @@ -1611,7 +1613,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>   		 * Or, stop GC if the segment becomes fully valid caused by
>   		 * race condition along with SSR block allocation.
>   		 */
> -		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
> +		if ((gc_type == BG_GC && (has_not_enough_free_secs(sbi, 0, 0) ||
> +					is_sbi_flag_set(sbi, SBI_IS_SUSPENDING))) ||
>   			(!force_migrate && get_valid_blocks(sbi, segno, true) ==
>   							CAP_BLKS_PER_SEC(sbi)))
>   			return submitted;
> @@ -2015,7 +2018,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   		goto stop;
>   	}
>   retry:
> -	if (unlikely(freezing(current))) {

Shouldn't we keep original freezing logic? in case filesystem are frozen
when low device snapshot is triggered?

> +	if (is_sbi_flag_set(sbi, SBI_IS_SUSPENDING)) {
>   		ret = 0;
>   		goto stop;
>   	}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d70dc5ef3de4..e27197953356 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1300,7 +1300,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>   	if (dc->state != D_PREP)
>   		return 0;
>   
> -	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
> +	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
> +		is_sbi_flag_set(sbi, SBI_IS_SUSPENDING))
>   		return 0;
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
> @@ -1341,6 +1342,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>   		unsigned long flags;
>   		bool last = true;
>   
> +		if (is_sbi_flag_set(sbi, SBI_IS_SUSPENDING))
> +			break;
> +
>   		if (len > max_discard_blocks) {
>   			len = max_discard_blocks;
>   			last = false;
> @@ -1615,7 +1619,7 @@ static void __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>   		if (dc->state != D_PREP)
>   			goto next;
>   
> -		if (*issued > 0 && unlikely(freezing(current)))

Ditto,

> +		if (is_sbi_flag_set(sbi, SBI_IS_SUSPENDING))
>   			break;
>   
>   		if (dpolicy->io_aware && !is_idle(sbi, DISCARD_TIME)) {
> @@ -1688,7 +1692,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>   		list_for_each_entry_safe(dc, tmp, pend_list, list) {
>   			f2fs_bug_on(sbi, dc->state != D_PREP);
>   
> -			if (issued > 0 && unlikely(freezing(current))) {

Ditto,

Thanks,

> +			if (is_sbi_flag_set(sbi, SBI_IS_SUSPENDING)) {
>   				suspended = true;
>   				break;
>   			}
> @@ -1955,7 +1959,8 @@ static int issue_discard_thread(void *data)
>   			continue;
>   		if (kthread_should_stop())
>   			return 0;
> -		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
> +		if (is_sbi_flag_set(sbi, SBI_IS_SUSPENDING) ||
> +			is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
>   			!atomic_read(&dcc->discard_cmd_cnt)) {
>   			wait_ms = dpolicy.max_interval;
>   			continue;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d5dc83e613e2..536f3ffe5354 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1979,6 +1979,26 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>   	kvfree(sbi->devs);
>   }
>   
> +static int f2fs_pm_notifier(struct notifier_block *nb,
> +			    unsigned long action, void *ptr)
> +{
> +	struct f2fs_sb_info *sbi = container_of(nb, struct f2fs_sb_info, pm_nb);
> +
> +	switch (action) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_SUSPEND_PREPARE:
> +	case PM_RESTORE_PREPARE:
> +		set_sbi_flag(sbi, SBI_IS_SUSPENDING);
> +		break;
> +	case PM_POST_SUSPEND:
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_RESTORE:
> +		clear_sbi_flag(sbi, SBI_IS_SUSPENDING);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
>   static void f2fs_put_super(struct super_block *sb)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> @@ -1986,6 +2006,8 @@ static void f2fs_put_super(struct super_block *sb)
>   	int err = 0;
>   	bool done;
>   
> +	unregister_pm_notifier(&sbi->pm_nb);
> +
>   	/* unregister procfs/sysfs entries in advance to avoid race case */
>   	f2fs_unregister_sysfs(sbi);
>   
> @@ -5472,6 +5494,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>   
>   	f2fs_restore_device_alias(sbi);
>   
> +	sbi->pm_nb.notifier_call = f2fs_pm_notifier;
> +	register_pm_notifier(&sbi->pm_nb);
> +
>   	sbi->umount_lock_holder = NULL;
>   	return 0;
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
