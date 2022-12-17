Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AE8C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 17 Dec 2022 01:14:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p6LmT-0007a4-57;
	Sat, 17 Dec 2022 01:14:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1p6LmS-0007Zy-6c
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Dec 2022 01:14:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oMgnpMSAcMZnvqMMtqIfR9NyzHHGz55tUfCgNqteyok=; b=EKw/+xXPBMN5i1GvtxfqBevGR4
 yTh6+mcenogx0R9haxi4g7I5VWrSinBhFL5sx5D4umstExWfHEvuYnNobxWs5sYgKER2B3rWz5rv7
 +HavK/QqYgBL8AiVPa8NAk/+TTGEkcurAx+Je6NHBkR9s6tDOZf+o921qTOHNEBDKqGg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oMgnpMSAcMZnvqMMtqIfR9NyzHHGz55tUfCgNqteyok=; b=gM4Tx+0oKG9IROZSTxyDlKWyYD
 NRlVivxE6Dp8X/kVSAxR8lLcULxp1zzq0W8shc4qwrjmEd+qVeia6okSPTIPygqNJ+oN/5WPxs/PO
 +PM1uI70wcXHzMUts8TnxkH0j5eqmXCgZqCqDaJzY7l3uNrAbhpM1q/CR9uxl1IRPk2E=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p6LmR-001wI0-6D for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Dec 2022 01:14:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8177F62295;
 Sat, 17 Dec 2022 01:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3488C433D2;
 Sat, 17 Dec 2022 01:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671239656;
 bh=XQs9wEArOAjfkpOf9evtR3fsz46BwnN0f73p8uara+U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NN0pK48o5qpl6Po0hECTTtkQlyc7Bs9p7cAtQsj781QP8fwQbiRgZw8YEAMJ+WyTZ
 tVmTje9hukeqfo77qR4GOBLsC+TO/LEbYyOYt/zB27Y+xAaQalV9p09ir/BO5nhtJ1
 Lzf7Dz8TQAsjsNIJjQHH065cFCap9tgHPLPHXbBujmNRt402AVbBSdzy4jVqUkEYpJ
 RgV1Yqiphd6SGVtmJH9x4wqhiBTOZYvz6oLU8xmxnKfvS7YPxZ7c/wOlz5n3hamqlj
 e79tBzyc7XvKqNqTyBJomYZNViQQS7NecIGWBwFM82Zf5XAs1TAI8bx0LfEhF/fFll
 GDusB3ZM9pn8A==
Message-ID: <0377292c-ba43-06cd-2638-8e41e2e75f3a@kernel.org>
Date: Sat, 17 Dec 2022 09:14:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <a2c286e1-470f-ff83-196a-f7ea490096ff@kernel.org>
 <20221216193248.71333-1-frank.li@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221216193248.71333-1-frank.li@vivo.com>
X-Headers-End: 1p6LmR-001wI0-6D
Subject: Re: [f2fs-dev] [PATCH] f2fs: merge f2fs_show_injection_info() into
 time_to_inject()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/12/17 3:32, Yangtao Li wrote:
> Hi Chao,
> 
>> After moving f2fs_show_injection_info() core functionality into time_to_inject(),
>> __builtin_return_address(0) result changes from return address of caller of
>> f2fs_show_injection_info() to return address of time_to_inject().
> 
> It seems you are wrong, and the original patch didn't change the logic here.
> Because time_to_inject is an inline function, __builtin_return_address(0)
> has not return address of time_to_inject().

Yeah, but it depends on compile option, right? If user use -O0 or -fno-inline
option, inline function will not be expanded...

How about using deterministic implementation?

Thanks,

> 
> My test:
> 
> (1). w/ below patch, we found that the value of __builtin_return_address(0) in
> 	__time_to_inject() is the same as that in f2fs_show_injection_info().
> 
> # mount -t f2fs -o fault_type=0xffff,fault_injection=1 /mnt/9p/f2fs.img /mnt/f2fs
> [   19.739661] loop0: detected capacity change from 0 to 2097152
> [   19.749759]  new F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_fill_super+0x7eb/0x1780
> [   19.750313] raw F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_fill_super+0x7eb/0x1780
> mount: mounting /dev/loop0 on /mnt/f2fs failed: Cannot allocate memory
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4035dab1f570..1e5030633f4d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1876,11 +1876,13 @@ struct f2fs_sb_info {
> 
>   #ifdef CONFIG_F2FS_FAULT_INJECTION
>   #define f2fs_show_injection_info(sbi, type)                                    \
> -       printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n", \
> +       printk_ratelimited("%sraw F2FS-fs (%s) : inject %s in %s of %pS\n",     \
>                  KERN_INFO, sbi->sb->s_id,                               \
>                  f2fs_fault_name[type],                                  \
>                  __func__, __builtin_return_address(0))
> -static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
> +
> +#define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__)
> +static inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type, const char *func_name)
>   {
>          struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
> 
> @@ -1893,6 +1895,10 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
>          atomic_inc(&ffi->inject_ops);
>          if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
>                  atomic_set(&ffi->inject_ops, 0);
> +               printk_ratelimited("%s new F2FS-fs (%s) : inject %s in %s of %pS\n",
> +                       KERN_INFO, sbi->sb->s_id,
> +                       f2fs_fault_name[type],
> +                       func_name, __builtin_return_address(0));
>                  return true;
>          }
>          return false;
> 
> (2). w/ below patch(remove inline form __time_to_inject()), we found that the value of
> 	__builtin_return_address(0) in __time_to_inject() is different from that in
> 	f2fs_show_injection_info().
> 
> # mount -t f2fs -o fault_type=0xffff,fault_injection=1 /mnt/9p/f2fs.img /mnt/f2fs
> [   81.019451] loop0: detected capacity change from 0 to 2097152
> [   81.031058]  new F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_init_write_merge_io+0x35/0x1c0
> [   81.031745] raw F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_fill_super+0x7eb/0x1710
> mount: mounting /dev/loop0 on /mnt/f2fs failed: Cannot allocate memory
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4035dab1f570..f15001b5d73b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1876,11 +1876,13 @@ struct f2fs_sb_info {
> 
>   #ifdef CONFIG_F2FS_FAULT_INJECTION
>   #define f2fs_show_injection_info(sbi, type)                                    \
> -       printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n", \
> +       printk_ratelimited("%sraw F2FS-fs (%s) : inject %s in %s of %pS\n",     \
>                  KERN_INFO, sbi->sb->s_id,                               \
>                  f2fs_fault_name[type],                                  \
>                  __func__, __builtin_return_address(0))
> -static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
> +
> +#define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__)
> +static bool __time_to_inject(struct f2fs_sb_info *sbi, int type, const char *func_name)
>   {
>          struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
> 
> @@ -1893,6 +1895,10 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
>          atomic_inc(&ffi->inject_ops);
>          if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
>                  atomic_set(&ffi->inject_ops, 0);
> +               printk_ratelimited("%s new F2FS-fs (%s) : inject %s in %s of %pS\n",
> +                       KERN_INFO, sbi->sb->s_id,
> +                       f2fs_fault_name[type],
> +                       func_name, __builtin_return_address(0));
>                  return true;
>          }
>          return false;
> 
> Thx,
> Yangtao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
