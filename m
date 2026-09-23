Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCB4C98304
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Sep 2026 18:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ULYk11bLQmktXUcvnPEMGbZ/m+Xug/po7SvWEIJiegY=; b=EF4I463Qgh0dxFijZHQI/hotWW
	sChZl46qjvsysUSWKE91YUwKMfBGcTelyZZ4wyy5tf/wcBbnWZXDSZi1fbepjsiDkAdi3Y5zcqNRO
	tvjZrydYu616MDSUvoYj6dh3a6EuqOFoFsXP2wme1R4jmrwWYwpefvQrir4fgVGOUa9c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9SAV-0005Ld-C3;
	Wed, 23 Sep 2026 18:58:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <rdunlap@infradead.org>) id 1x9SAI-0005LG-HK
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 18:57:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SOx8Dva3HBzRw8/29K6Um9IaE2+mdF6DajAzu0PEF90=; b=UYSWm4Qkh78pWdzsVCTCfwCp7e
 dpOPmUEFYSXbswx0Wg0MXWgWRTQrxedyRg0ZfZX+eqUnjK85r0CbpfalO07dBTlB5ROyrD/JHJrZf
 yUnsB2gbmQKsGW6iuKCBcCAoVZsX6fk9BwH1G4fT8Opn71/LrRLAFjIo7zDYz8RM/HbE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SOx8Dva3HBzRw8/29K6Um9IaE2+mdF6DajAzu0PEF90=; b=It1prEgwKqvOEhHrjmMWPXIsWz
 cdB/UfkeTrwq5IFM5XbZ/7xKAoKfgt3CYhKU3NdFhm9W9jub81Wi+c64hKbX2tTB+sPU/GzogO+E0
 YoOPg5H59F4js78siQ25Vxt1pkpnFTVAXkJLWo0JA6pDD4cW1arN0ksHUE18ZIa0crEo=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9SAG-000599-6m for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 18:57:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=SOx8Dva3HBzRw8/29K6Um9IaE2+mdF6DajAzu0PEF90=; b=QO+KrlrTlwm8TfwQqlmBG2b3Dp
 +9+JPIM3lbv/xgAnONVrLF91mDoNd94gGvMPHmoT99BieEs2GB0ZlL0hvi1GoTag/17OF6UVnF7mq
 n1Z3SxARmukjsDExPUvQzWXOoIxlqzxa/C2m9l3AoEYghgT5h3FnY6N4qWdpusdzdLKdLjCgJNovo
 xel82r6ai6sb4Pd5av6SkwPUMm09lkkBjSOtavG9o04fMJLDGeHKcbVdf971C7ucQOILa4sXnGfMD
 fp1LneRI5kGvdZmCLvJxZ03hTLY9f9SZIscVNOi5FblqSwZk+2qUM8OEbsd2U9BFM3XYxVtbJQtHH
 x1groHQA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x9Rrm-00000009Ee1-1AQF; Wed, 23 Sep 2026 18:38:50 +0000
Message-ID: <111d8f8e-02f5-46fb-b8bb-45729d1e33c7@infradead.org>
Date: Wed, 23 Sep 2026 11:38:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Arnd Bergmann <arnd@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Jianan Huang <jnhuang95@gmail.com>
References: <20260917142222.1591270-1-arnd@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260917142222.1591270-1-arnd@kernel.org>
X-Headers-End: 1x9SAG-000599-6m
Subject: Re: [f2fs-dev] [PATCH] f2fs: quota: fix unused-label warning
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
Cc: Daeho Jeong <daehojeong@google.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, Kelvin Zhang <zhangxp1998@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 9/17/26 7:21 AM, Arnd Bergmann via Linux-f2fs-devel wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added label causes a warning when QUOTA is turned off:
> 
> fs/f2fs/super.c: In function '__f2fs_remount':
> fs/f2fs/super.c:3142:1: error: label 'restore_holder' defined but not used [-Werror=unused-label]
>  3142 | restore_holder:
>       | ^~~~~~~~~~~~~~
> 
> Fixes: 3f140a60c92a ("f2fs: quota: fix stale lock holder on remount failure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/f2fs/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 6a2f09c61dcd..8358cdefa859 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3139,7 +3139,9 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
>  	sbi->mount_opt = org_mount_opt;
>  	sb->s_flags = old_sb_flags;
>  
> +#ifdef CONFIG_QUOTA
>  restore_holder:
> +#endif
>  	sbi->umount_lock_holder = NULL;
>  	return err;
>  }

-- 
~Randy


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
