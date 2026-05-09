Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08763CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 May 2026 09:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E+2zNCbuIM0hTm771Q39x8FpLfu0Z1yCqm/BDuLKJ8g=; b=DRPHPn0xv8nFI+LhwMqycVou3R
	gJaYueUCn2SlL4/IkH4uPLRtTKnW3kJRSba2dQr9NESD8SMxIpyrCcTNvdZSeNsWJBX8yvQss36MX
	Gvq4S2tM8ILaf68+kSsk9lvTnCrdMJVsVwql4W7QKyKURvbD2LeuUKMB2eJbi5z3tOv8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLe1J-0006C9-CV;
	Sat, 09 May 2026 09:30:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wLe1H-0006Bs-OD
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 09:30:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EKMECffEJFTiwyGFiw8sWSIsp39np06keyrPeufElBI=; b=X2jxrMa9EpZhzhBQAlprmImN/y
 EpPvvEgsPBiy28UwXZqhtzM6HxegBipnYWva5JO29+VEJfvsZDi1PiySc3BgQGcVuY6G4hAh/PLRr
 litGP3C7OLrFDxdcSrIBe4jgkQIxsEzgow+E1MjhCX1LZb2EH/Ghzj1SNDiVatveCGWg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EKMECffEJFTiwyGFiw8sWSIsp39np06keyrPeufElBI=; b=aNJXPU2SNS9elQ159wHXSDxp2B
 37AqmKyE0zLobF26LegkOjZIFXJCCrCi4zMtGdl3DJ2m+Op+OGhITmKnpEN6zojBvNKzua7RJKRgu
 wFh0k2/BP3o8z0AoLmHiiBbfZhHwcsKevnQPq2XJ4wtfg+uqLwEb58VfJw45lQXNy/2o=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wLe1H-0000vj-R4 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 09:30:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 325D96024D;
 Sat,  9 May 2026 09:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307C9C2BCB2;
 Sat,  9 May 2026 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778319036;
 bh=81b5WURI9fUNup/0VVB0CxlYR9cvtEduJLubXW0id3A=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=NwLDJ2NhBZj/PXvy0rQjnWeZsrp0PpwgOLArgfwRODtgpGgySGD+HwbZFylzSczU2
 nP8ZWUSPP340Tku5svFI5h8ZmbrIYej3fOWjYPCgxol5gNKCYfgvJQqd/theHE5bG/
 ZrU7gz3zIVUw7gVkwWXsTN3+wMgNk4ztvhIeAOogS6ewNX6NIyPNsEoYVAd9G42AUi
 rSxoSRmIaiQLTiO2aYZdMfL1rr8/JNUF0QPPNrwlYx7cBSTXzKLWVYwQiZkk2lnc7x
 icAt15E9NVZvWTKJDo/DXewcA+UmhhDW+TOZqtOxFHSmbUBrFGHEk0p7Do/CJoLNSm
 QYNpuK61nHsuw==
Message-ID: <adbb350c-ae39-430d-8a2f-84c31150c3a2@kernel.org>
Date: Sat, 9 May 2026 17:30:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Deepanshu Kartikey <kartikey406@gmail.com>, jaegeuk@kernel.org
References: <20260509042239.87763-1-kartikey406@gmail.com>
Content-Language: en-US
In-Reply-To: <20260509042239.87763-1-kartikey406@gmail.com>
X-Headers-End: 1wLe1H-0000vj-R4
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize ino_entry_info before
 checkpoint load
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
Cc: syzbot+eec8f2693d71386bd600@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/9/26 12:22, Deepanshu Kartikey wrote:
> When f2fs_get_valid_checkpoint() fails during mount (e.g. due to an
> invalid checkpoint CRC on a malformed image), f2fs_fill_super() takes
> an error path that eventually calls iput() on the root inode. This
> invokes f2fs_drop_inode() -> f2fs_exist_written_data(), which acquires
> sbi->im[]->ino_lock. However, f2fs_init_ino_entry_info() has not run
> yet at this point, so the spinlock is uninitialized and lockdep
> complains:
> 
>    F2FS-fs (loop0): invalid crc value
>    F2FS-fs (loop0): Failed to get valid F2FS checkpoint
>    INFO: trying to register non-static key.
>    The code is fine but needs lockdep annotation, or maybe
>    you didn't initialize this object before use?
>    ...
>     f2fs_exist_written_data+0x53/0x90 fs/f2fs/checkpoint.c:787
>     f2fs_drop_inode+0xda/0xbf0 fs/f2fs/super.c:1852
>     iput+0x651/0xe80 fs/inode.c:2009
>     f2fs_fill_super+0x6047/0x7850 fs/f2fs/super.c:5461
> 
> Move f2fs_init_ino_entry_info() to before f2fs_get_valid_checkpoint()
> so that sbi->im[] is always fully initialized before any error path
> can trigger iput() -> f2fs_drop_inode(). The init function only
> depends on raw superblock fields (BLKS_PER_SEG, F2FS_CP_PACKS,
> NR_CURSEG_PERSIST_TYPE, __cp_payload), which are populated well
> before checkpoint load, so the move is safe.
> 

Cc: stable@kernel.org
Fixes: xxx

Otherwise, it looks good to me.

Thanks,

> Reported-by: syzbot+eec8f2693d71386bd600@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=eec8f2693d71386bd600
> Tested-by: syzbot+eec8f2693d71386bd600@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>   fs/f2fs/super.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index c6afdbd6e1cd..6a231a5b0d62 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -5140,6 +5140,13 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>   		goto free_page_array_cache;
>   	}
>   
> +	/*
> +	 * Initialize ino entry info early so f2fs_drop_inode ->
> +	 * f2fs_exist_written_data can safely take im->ino_lock if mount
> +	 * fails after this point and triggers iput on cleanup.
> +	 */
> +	f2fs_init_ino_entry_info(sbi);
> +
>   	err = f2fs_get_valid_checkpoint(sbi);
>   	if (err) {
>   		f2fs_err(sbi, "Failed to get valid F2FS checkpoint");
> @@ -5184,8 +5191,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>   
>   	f2fs_init_extent_cache_info(sbi);
>   
> -	f2fs_init_ino_entry_info(sbi);
> -
>   	f2fs_init_fsync_node_info(sbi);
>   
>   	/* setup checkpoint request control and start checkpoint issue thread */



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
