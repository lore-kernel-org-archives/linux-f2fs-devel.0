Return-Path: <SRS0=aOel=2N=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E439C2D0C0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:41:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA7F206B7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GmC7XHCI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="EZjp2gL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA7F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ijJHG-0002GY-Mt; Mon, 23 Dec 2019 08:41:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ijJHF-0002GE-6G
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Dec 2019 08:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cDv9UaL4HKxCZwOpeNm1xbtf2cmQl4fg1wQxfmqaPlY=; b=GmC7XHCIUBtBFBHa5LV98uzU8U
 MTCsFkgg7X7XzPwnannzmsIpNJuf8nmPMsi976hyXMpo/MdXW83nrFwVbBX22g8e+5nciVlhaP4yT
 23tJae2MsH8ap7ENYFUMdjIk+Dn5vUWj3WUA052ZPuVyelDLbW45j10plBm2Hsyz12j8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cDv9UaL4HKxCZwOpeNm1xbtf2cmQl4fg1wQxfmqaPlY=; b=EZjp2gL4xzaXl+/HAB5l7jwiRu
 LQkyswk3lg+MNGbpcbml6bUtwJl0CULBhokqMkDO0C+8tXP+LKBn4sYDLU0iZU+whL1AUOYVfrTdf
 iLxJ6sclp7jJbde8EWk2goiKyR/o1KmPnuRfU1oWO7DkHySzTuHOr3oXpSzIxA63dMfw=;
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1ijJHD-00Ct7m-6O
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Dec 2019 08:41:20 +0000
Received: by mail-ot1-f67.google.com with SMTP id b18so21229806otp.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Dec 2019 00:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cDv9UaL4HKxCZwOpeNm1xbtf2cmQl4fg1wQxfmqaPlY=;
 b=sFnSsN5i6LwMX+EcSo408c1Z7ZlQExJWGGnuJpsuF0uOlp3ypyyeXPJZvOyXOC8l4h
 dokz9A7U9BYn63T4JukT38pozDj9UMWvnL9eg/+NgCwhDXWv6gs5crtsW0OJPJ7YvgYG
 mrdX8R0pd6rDJGyhFzb9N7RZ2Jnaeuw2B8GXRODieOzpCqMuLBuHKsBSaiFvN78CwoGe
 6ZoYwbcEPq3LUVWjefByHIPd2GFm9+4dZ967ui1UU4GXaTdoroXcIDiQFTAF2/Z8yXAk
 yuLwunirnoI8oa7lDS7+n0uaTeUr105/vlHNYOqyRmclYm5SF//LEAP1bosZBgYqlwT9
 SeQg==
X-Gm-Message-State: APjAAAVuAP598/0E/3rER5Ks5MO5jsajK+s9+TpkBvLAkpc2tsPULqgX
 fl2vkD2Qj+l8ePBs41qXY12f9yM1wlRE2ZWM06k=
X-Google-Smtp-Source: APXvYqx2KCiv7cxuDdzBfA2c2NhXkW2xa7BGOvhzkGGauQ0VJ6aD6A5SkDirLFnjAg8AJrwmGlawMoHMEhNiYeHVBR4=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr31479287ots.250.1577090473314; 
 Mon, 23 Dec 2019 00:41:13 -0800 (PST)
MIME-Version: 1.0
References: <20191223040020.109570-1-yuchao0@huawei.com>
In-Reply-To: <20191223040020.109570-1-yuchao0@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Dec 2019 09:41:02 +0100
Message-ID: <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
To: Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1ijJHD-00Ct7m-6O
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce DEFAULT_IO_TIMEOUT_JIFFIES
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
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

CC linux-fsdevel

On Mon, Dec 23, 2019 at 5:01 AM Chao Yu <yuchao0@huawei.com> wrote:
> As Geert Uytterhoeven reported:
>
> for parameter HZ/50 in congestion_wait(BLK_RW_ASYNC, HZ/50);
>
> On some platforms, HZ can be less than 50, then unexpected 0 timeout
> jiffies will be set in congestion_wait().
>
> This patch introduces a macro DEFAULT_IO_TIMEOUT_JIFFIES to limit
> mininum value of timeout jiffies.
>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Thanks for your patch!

> ---
>  fs/f2fs/compress.c |  3 ++-
>  fs/f2fs/data.c     |  5 +++--
>  fs/f2fs/f2fs.h     |  2 ++
>  fs/f2fs/gc.c       |  3 ++-
>  fs/f2fs/inode.c    |  3 ++-
>  fs/f2fs/node.c     |  3 ++-
>  fs/f2fs/recovery.c |  6 ++++--
>  fs/f2fs/segment.c  | 12 ++++++++----
>  fs/f2fs/super.c    |  6 ++++--
>  9 files changed, 29 insertions(+), 14 deletions(-)
>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 1bc86a54ad71..ee4fe8e644aa 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -945,7 +945,8 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
>                         } else if (ret == -EAGAIN) {
>                                 ret = 0;
>                                 cond_resched();
> -                               congestion_wait(BLK_RW_ASYNC, HZ/50);
> +                               congestion_wait(BLK_RW_ASYNC,
> +                                       DEFAULT_IO_TIMEOUT_JIFFIES);
>                                 lock_page(cc->rpages[i]);
>                                 clear_page_dirty_for_io(cc->rpages[i]);
>                                 goto retry_write;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f1f5c701228d..78b5c0b0287e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2320,7 +2320,8 @@ int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
>                 /* flush pending IOs and wait for a while in the ENOMEM case */
>                 if (PTR_ERR(fio->encrypted_page) == -ENOMEM) {
>                         f2fs_flush_merged_writes(fio->sbi);
> -                       congestion_wait(BLK_RW_ASYNC, HZ/50);
> +                       congestion_wait(BLK_RW_ASYNC,
> +                                       DEFAULT_IO_TIMEOUT_JIFFIES);
>                         gfp_flags |= __GFP_NOFAIL;
>                         goto retry_encrypt;
>                 }
> @@ -2900,7 +2901,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>                                         if (wbc->sync_mode == WB_SYNC_ALL) {
>                                                 cond_resched();
>                                                 congestion_wait(BLK_RW_ASYNC,
> -                                                               HZ/50);
> +                                                       DEFAULT_IO_TIMEOUT_JIFFIES);
>                                                 goto retry_write;
>                                         }
>                                         goto next;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 16edbf4e05e8..4bdc20a94185 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -559,6 +559,8 @@ enum {
>
>  #define DEFAULT_RETRY_IO_COUNT 8       /* maximum retry read IO count */
>
> +#define        DEFAULT_IO_TIMEOUT_JIFFIES      (max_t(long, HZ/50, 1))
> +
>  /* maximum retry quota flush count */
>  #define DEFAULT_RETRY_QUOTA_FLUSH_COUNT                8
>

Seeing other file systems (ext4, xfs) and even core MM code suffers from
the same issue, perhaps it makes sense to move this into congestion_wait(),
i.e. increase the timeout to 1 if it's zero in the latter function?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
