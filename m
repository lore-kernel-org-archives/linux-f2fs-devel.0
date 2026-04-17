Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8806AF8E499
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Apr 2026 01:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ta2kVa6aAODttc2aQgDlcQjLw4jHvOqF53nxMOuCBWM=; b=Wu6jbpgfMWGnDzZIzl9T1MAlPx
	iZqBUXrZHmnZz4NFvDnMNjhMmYVUxnGc34jjsTv75IqCwC5FWy5ONF0/rXrFozPDm1mpallkVMwSk
	nMj8s0ZSgmAZ6hl9Hhl4P64hpnXhFMUKZ3qOZbOBUiIg6JH4eERjlVJdbv+mSevRlqOk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wDXyw-0003hx-A1;
	Fri, 17 Apr 2026 01:26:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wDXyv-0003hr-9X
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 01:26:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EeeiMczw1O7xAjLTzebKpwuzMASmwpzwgckD43IcSes=; b=cDLw0P/ydM+LfyoZhlLhMM9WJU
 ZaNC/oYjpoMHx79VKNEnJq07NOcqNFnanmxraA1fbtg8OoH8To1AnkA035JPO1jfFmex2PLaYUKoj
 zfI8iN7BngyQu/XTsK+6uZRc8dkE1eo9At2a8njF5NTZnyaNChOfa+zZ/xx2JLcayKTc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EeeiMczw1O7xAjLTzebKpwuzMASmwpzwgckD43IcSes=; b=DV1oPObktMC5rCNtalHFHFr7k1
 xMrwkXJtYFJXRb2RkKPvxqCpYHG101Y+lchcFF+72UDx7FZMtJ1LeyTbJHvRzmFv7tCyLtDt038vP
 KlgPBs28LrtP8met3ArSjE5aFKgMlxxe4qF6fvdgr0dtAGESlzrSDZc9ol+1BacevfiM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wDXyu-0001iV-Ku for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 01:26:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E703960128;
 Fri, 17 Apr 2026 01:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424B0C2BCAF;
 Fri, 17 Apr 2026 01:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776389201;
 bh=ztkTy/C+HUgBotWN2A6nKGoHE8JX8yIsOHRkQs9XtMg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=J/k5HUnhrYfH8+2sTpLPe/nwQf/zKapJ8NdHTU93AuD7tGEv+laIyNI1DiPlehIV+
 ft6/maihQVOm8lP70ywboD/cRbnWBxcUxvxzzaW0qZ4q1vUoGiRltE8CzareR79y6v
 3JbUWpX4t6/dpx4xnJThN1ivfUS6lGg+EIiyVfgLcsz1VrCnkSBdgN0dcz42d4go8c
 pEAGuUy/+k1R5AzFpzOQEgEPq04zXzdu9MmHxCKu04oxNd9pkCrl9knd/otkFMO1UD
 5Ox2b7Vxsjg3RIlNg6NtSJeiEU0JS70jsqeH9MjgYms8htd8S6SMqg4YCcvrX23Qra
 UCJ0S+aUV8ejw==
Message-ID: <d004abbf-c794-4103-a34d-1a8f52c5b65a@kernel.org>
Date: Fri, 17 Apr 2026 09:26:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
References: <20260415114237.3089952-1-jinbaoliu365@gmail.com>
Content-Language: en-US
In-Reply-To: <20260415114237.3089952-1-jinbaoliu365@gmail.com>
X-Headers-End: 1wDXyu-0001iV-Ku
Subject: Re: [f2fs-dev] [PATCH] [PATCH v2] f2fs: Add trace_f2fs_fault_report
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
Cc: shengyong1 <shengyong1@xiaomi.com>, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/15/2026 7:42 PM, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> Add trace_f2fs_fault_report to trigger reporting upon f2fs_bug_on,
> need_fsck, stop_checkpoint, and handle_eio. Since f2fs_bug_on and
> need_fsck can be triggered in hundreds of scenarios, define set_sbi_flag
> as a macro to help capture the effective fault function and line number.
> 
> Signed-off-by: shengyong1 <shengyong1@xiaomi.com>
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> ---
>   fs/f2fs/f2fs.h              | 18 +++++++++++++++++-
>   fs/f2fs/super.c             |  9 +++++++++
>   include/trace/events/f2fs.h | 28 ++++++++++++++++++++++++++++
>   3 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 56c4af4b1737..2249a68d6bf5 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -97,6 +97,15 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>   #define DEFAULT_FAILURE_RETRY_COUNT		1
>   #endif
>   
> +enum {
> +	REPORT_FAULT_NEED_FSCK,
> +	REPORT_FAULT_STOP_CP,
> +	REPORT_FAULT_MAX,
> +};
> +
> +void f2fs_fault_report(struct super_block *sb, unsigned int err_code,
> +			const char *func, unsigned int data);
> +
>   /*
>    * For mount options
>    */
> @@ -2278,11 +2287,18 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
>   	return test_bit(type, &sbi->s_flag);
>   }
>   
> -static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
> +static inline void __set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
>   {
>   	set_bit(type, &sbi->s_flag);
>   }
>   
> +#define set_sbi_flag(sbi, type)				\
> +do {							\
> +	__set_sbi_flag(sbi, type);			\
> +	if ((type) == SBI_NEED_FSCK)			\
> +		f2fs_fault_report(sbi->sb, REPORT_FAULT_NEED_FSCK, __func__, __LINE__);	\
> +} while (0)

It's minor, but, what about?

void f2fs_fault_report(struct super_block *sb, unsigned int err_code,
				const char *func, unsigned int data);
static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
{
	set_bit(type, &sbi->s_flag);
	if ((type) == SBI_NEED_FSCK)
		f2fs_fault_report(sbi->sb, REPORT_FAULT_NEED_FSCK, __func__, __LINE__);
}

Thanks,

> +
>   static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
>   {
>   	clear_bit(type, &sbi->s_flag);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ccf806b676f5..b431842751d6 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4724,9 +4724,18 @@ static void f2fs_handle_critical_error(struct f2fs_sb_info *sbi,
>   	 */
>   }
>   
> +void f2fs_fault_report(struct super_block *sb, unsigned int err_code,
> +			const char *func, unsigned int data)
> +{
> +	trace_f2fs_fault_report(sb, err_code, func, data);
> +}
> +
>   void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io,
>   						unsigned char reason)
>   {
> +	if (reason != STOP_CP_REASON_SHUTDOWN)
> +		f2fs_fault_report(sbi->sb, REPORT_FAULT_STOP_CP, __func__, reason);
> +
>   	f2fs_build_fault_attr(sbi, 0, 0, FAULT_ALL);
>   	if (!end_io)
>   		f2fs_flush_merged_writes(sbi);
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 9364e6775562..b97bc3bf499a 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -2582,6 +2582,34 @@ DEFINE_EVENT(f2fs_priority_update, f2fs_priority_restore,
>   	TP_ARGS(sbi, lock_name, is_write, p, orig_prio, new_prio)
>   );
>   
> +TRACE_EVENT(f2fs_fault_report,
> +
> +	TP_PROTO(struct super_block *sb, unsigned int err_code,
> +		const char *func, unsigned int data),
> +
> +	TP_ARGS(sb, err_code, func, data),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(unsigned int, err_code)
> +		__string(func, func)
> +		__field(unsigned int, data)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= sb->s_dev;
> +		__entry->err_code	= err_code;
> +		__assign_str(func, func);
> +		__entry->data		= data;
> +	),
> +
> +	TP_printk("dev = (%d,%d), err_code = %u, func = %s, data = %u",
> +		show_dev(__entry->dev),
> +		__entry->err_code,
> +		__get_str(func),
> +		__entry->data)
> +);
> +
>   #endif /* _TRACE_F2FS_H */
>   
>    /* This part must be outside protection */



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
