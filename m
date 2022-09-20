Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F2EECAAD8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Sep 2022 15:29:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oafBX-0008EY-8J;
	Tue, 20 Sep 2022 15:29:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oafBV-0008ES-D9
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Sep 2022 15:29:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pJ5RkueB0IgU3U95U8K4nSzEPRe+AQrCzUK1dc72z0A=; b=gheUs3b+9tk4PUp7fq29K7jztF
 Qi0tVmQa2Tk3FhWcQIDc47WSif4AXCDxK+n/Sh3n4wKPOUaZdgGLWTMHX8tnqswwabEcuYtfIpubL
 38wijh+WwQrvQR/DNEgIddA5fJqHG7iXAYqlGtLTHHZp1w+CDffPArDBofwp9it153vc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pJ5RkueB0IgU3U95U8K4nSzEPRe+AQrCzUK1dc72z0A=; b=gDVr3A+xwD7pBsVv6346HWi2M3
 ZEcz+E0F4wYIB0U0hLY7xIsaF6XUtd5YYZOdbBAxY3fC8n5nLwEuE88u8yF6SMxSt0NoQRMhMEisq
 8LV2eP2tKn+UR9h1xV2tDQtDJG3SPz6tqFOoe/yGTzR5naWcdywGwJhg4tKLuFhfgTx4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oafBU-00Ebpv-OV for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Sep 2022 15:29:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2E33B624D0;
 Tue, 20 Sep 2022 15:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCBAC433C1;
 Tue, 20 Sep 2022 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663687747;
 bh=iemDLGibnYPEk7i75AVZGHMGMYVcXO83jgs70f+7FdQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VAxAfo7Fi/OX46FTZhU+eAZJohoeaIbR3adQU2skZk43WqBOx9C0byz1p7r5TYDPR
 VBb2iS6ApBX6Ld/BIbTFba+t9pMLwYJDDVFSzgh/ytaIfv9cFWV+tF/vb9H02lpkeW
 A5VBd4N+3SkrBmh01BK2Sqch0oagthB/XE0IpCy3mVCMTaBGorh0ohJySjmvzQc6b4
 1WiNXIjLy3MXKLakH8dC3IKJ5jHVTjeogMx6mk6/rVtwkGzKZT/i46ILng19BLWX9e
 5yvYC3zD8YjvIp0DRbeKbmRJLvamsKcOUDVdBrjKmeGHRRkbvJGJYflVBB5+L4b57y
 IaWxm6LlDhEzg==
Message-ID: <fadeeb4e-2769-a0c9-aee5-612de712aec6@kernel.org>
Date: Tue, 20 Sep 2022 23:29:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: "zhiguo.niu" <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1663637258-21987-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1663637258-21987-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1oafBU-00Ebpv-OV
Subject: Re: [f2fs-dev] [PATCH V3] f2fs: fix some error handling case in gc
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
Cc: xiuhong.wang@unisoc.com, niuzhiguo84@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/9/20 9:27, zhiguo.niu wrote:
> During GC, if segment type stored in SSA and SIT is inconsistent,
> we set SBI_NEED_FSCK first and then stop checkpoint, this will
> cause the following issues:
> 1. SBI_NEED_FSCK can not be set to flash truly because of checkpoint
> has been stopped.
> 2. Will cause more EIO error if user use f2fs because of CP_ERROR_FLAG
> has been set in f2fs_stop_checkpoint, this is not reasonable.
> 
> So we fix this error handling case by recording current victim segment
> as invalid for gc and do not stop checkpoint.
> 1. SBI_NEED_FSCK will still be set but not do f2fs_stop_checkpoint for
> f2fs.fsck to have opportunity to fix the inconsistent segment type
> in SSA and SIT.
> 2. Let user can still use fs, avoid EIO error for some operations such
> as read and write,etc.
> 3. If current segment has inconsistent segment type in SSA and SIT,
> we add this segment segno in SIT_I(sbi)->invalid_segmap to skip this
> segment to avoid deadloop in gc,similar as commit bbf9f7d90f21 ("f2fs:
> Fix indefinite loop in f2fs_gc()")
> 
> Fixes: 793ab1c8a792 ("f2fs: fix to avoid deadloop in foreground GC")
> Signed-off-by: zhiguo.niu <zhiguo.niu@unisoc.com>
> ---
> changes of v3: keep "set SBI_NEED_FSCK and f2fs_err()" as before and
> do not depend on CONFIG_F2FS_CHECK_FS as Chao's suggestion.
> ---
> ---
>   fs/f2fs/gc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index d5fb426e0747..f354883872f6 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1703,7 +1703,10 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>   			f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
>   				 segno, type, GET_SUM_TYPE((&sum->footer)));
>   			set_sbi_flag(sbi, SBI_NEED_FSCK);
> -			f2fs_stop_checkpoint(sbi, false);

f2fs_stop_checkpoint() was added in commit 793ab1c8a792 ("f2fs: fix to avoid
deadloop in foreground GC"), in order to avoid deadlock issue reported in
bugzilla, it needs to check this patch w/ the fuzzed image.

Bug 203211:
https://bugzilla.kernel.org/show_bug.cgi?id=203211

Fuzzed image:
https://bugzilla.kernel.org/attachment.cgi?id=282203

Thanks,

> +#ifdef CONFIG_F2FS_CHECK_FS
> +			if (!test_bit(segno, SIT_I(sbi)->invalid_segmap))
> +				set_bit(segno, SIT_I(sbi)->invalid_segmap);
> +#endif
>   			goto skip;
>   		}
>   


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
