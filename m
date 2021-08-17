Return-Path: <SRS0=6Xs1=NI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B33C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Aug 2021 04:10:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AD660E90;
	Tue, 17 Aug 2021 04:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19AD660E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mFqQQ-0007Nv-8e; Tue, 17 Aug 2021 04:10:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <daeho43@gmail.com>) id 1mFqQP-0007Nk-5O
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 04:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e/+AlGAMlx4yUW9nHI050qxp1g/aooqfczJ22EUYudU=; b=A54agluU6QbMdanhLLb/jUv3Fh
 QmPeIdBsuYqK2dCS6gF17SvoN1uXOEJg3KUu7E2+bSlEF/hDIgx89qZKwHeeQwaOQifdy0aGmvEKN
 7LIMVcClDSFs5DtA0oVD9jjLqikaRBwzWJc2cbx9kij/E1ZTGY47FaBveFFJkBGU7uAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=e/+AlGAMlx4yUW9nHI050qxp1g/aooqfczJ22EUYudU=; b=TcuSEzogz+p8ye+znXcAppnb3G
 tkoJgr/HYvL/iG+xwNWrKmMWnoKEkhf0lM/wv1ekoBD06Z8sF7M41+1AE9pBh11NDVQlrmAPRgH4F
 nfbCO1f4j6A7BiEDgUNZzEAISxKANzI4cUbjRzH+TrVjEYRC/2cnsbDRk2QLtI4ZDirE=;
Received: from mail-lj1-f176.google.com ([209.85.208.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1mFqQN-00070A-74
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 04:10:05 +0000
Received: by mail-lj1-f176.google.com with SMTP id h17so30660044ljh.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Aug 2021 21:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e/+AlGAMlx4yUW9nHI050qxp1g/aooqfczJ22EUYudU=;
 b=opPuvYz+g6e8XhiS67aK3j5UAd879moOO4x4BCCtjoOEAjcI1CAIz6Kk7KvKu0Fkl0
 /dn3qgtxhFVpwhsHoXSLAKmX9TGrM0iyW25Eh41vIsYyoSF+3aGSveSR0QrTdhac3Qs0
 Dgawcb8/r2lznqWnrrbdEWftwRU/0kbdmf/++JBeasZ3sP8ZCtbzYkZBmE03YayHR1C2
 Njt5Jub2wemzDPU7Gm/aTE719FXQxIoQprJW9PRyNg2tKGZWJKHTIzXKfHzKa4Wl2MOt
 q2SC9Gni1BSOPtD4YCv+kfp6dryKhGmuW1sFraWhgzQumpLXIvrvZhjF4ZoUJQ3K0lgH
 MiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e/+AlGAMlx4yUW9nHI050qxp1g/aooqfczJ22EUYudU=;
 b=o65FIOEpnW8xyW0BcVLqGfpZ/Il+aXfPL4AxF2xfSxoe5YhFPQtZAvqOBC5S5x+19X
 eh3qED0FHBPjIzMh1lKRDeun5/02yFD417VlZtn9K9nTMkC2xBwoNZMz8i6Nc9H1WCiI
 evtrtxuqXEYUe6sGS8CHKgLfUYWF1YZHc9mM7J/tf1qQuU/7N9VSkXN610m7TRI9sqeY
 qcttcVcXfR8c95IoN9esROEQq5zOb/X8XMjhWPl3gadany8+Y9fAZ/bYQb8fO4b3orF4
 uP05r1ibClcGmLQEOhG/g+s+fBxpzY19737dTdvZFEWITaOXFvLFQQ4U88w4WAfHYzzp
 YETA==
X-Gm-Message-State: AOAM531K/pIy2gW93Q4y0qSK4NkC4KoWp+UO+6U9erIyTM8JroXAu/T3
 BH48x4scwvjtD1RH1o3BMjBo0F60PbmZ+lsGrAw=
X-Google-Smtp-Source: ABdhPJz6sl3lYo1fxmbsmZ1YfokwBgHDYsYZ+desNNfBCTBbkwUw4xr6k9o1BQGFs7pAz71ceu0WGPEsVTUzws5xoQU=
X-Received: by 2002:a2e:9b14:: with SMTP id u20mr1349419lji.21.1629173396648; 
 Mon, 16 Aug 2021 21:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210816073559.GA12039@kili>
In-Reply-To: <20210816073559.GA12039@kili>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 16 Aug 2021 21:09:45 -0700
Message-ID: <CACOAw_w3TC8ZM9AKE7frPHnMRcXTE8n1aQChEJR7L3tsJ-K0_w@mail.gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
X-Headers-End: 1mFqQN-00070A-74
Subject: Re: [f2fs-dev] [bug report] f2fs: introduce periodic iostat io
 latency traces
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Dan,

We don't use NR_PAGE_TYPE for the index.

Thank you,

On Mon, Aug 16, 2021 at 12:37 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Daeho Jeong,
>
> The patch f4b05791dda9: "f2fs: introduce periodic iostat io latency
> traces" from Aug 3, 2021, leads to the following
> Smatch static checker warnings:
>
> fs/f2fs/f2fs.h:3365 __update_iostat_latency() error: buffer overflow 'sbi->rd_sum_lat' 3 <= 3
> fs/f2fs/f2fs.h:3366 __update_iostat_latency() error: buffer overflow 'sbi->rd_bio_cnt' 3 <= 3
> fs/f2fs/f2fs.h:3367 __update_iostat_latency() error: buffer overflow 'sbi->rd_peak_lat' 3 <= 3
> fs/f2fs/f2fs.h:3368 __update_iostat_latency() error: buffer overflow 'sbi->rd_peak_lat' 3 <= 3
> fs/f2fs/f2fs.h:3370 __update_iostat_latency() error: buffer overflow 'sbi->wr_sum_lat[sync]' 3 <= 3
> fs/f2fs/f2fs.h:3371 __update_iostat_latency() error: buffer overflow 'sbi->wr_bio_cnt[sync]' 3 <= 3
> fs/f2fs/f2fs.h:3372 __update_iostat_latency() error: buffer overflow 'sbi->wr_peak_lat[sync]' 3 <= 3
> fs/f2fs/f2fs.h:3373 __update_iostat_latency() error: buffer overflow 'sbi->wr_peak_lat[sync]' 3 <= 3
>
> fs/f2fs/f2fs.h
>     3348 static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>     3349                                int rw, int sync)
>     3350 {
>     3351        unsigned long ts_diff;
>     3352        unsigned int iotype = iostat_ctx->type;
>     3353        unsigned long flags;
>     3354        struct f2fs_sb_info *sbi = iostat_ctx->sbi;
>     3355
>     3356        if (!sbi->iostat_enable)
>     3357                return;
>     3358
>     3359        ts_diff = jiffies - iostat_ctx->submit_ts;
>     3360        if (iotype >= META_FLUSH)
>                     ^^^^^^^^^^^^^^^^^^^^
> This means the highest value of "iotype" is NR_PAGE_TYPE.
>
>     3361                iotype = META;
>     3362
>     3363        spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>     3364        if (rw == 0) {
> --> 3365                sbi->rd_sum_lat[iotype] += ts_diff;
>                         ^^^^^^^^^^^^^^^^^^^^^^^
>     3366                sbi->rd_bio_cnt[iotype]++;
>                         ^^^^^^^^^^^^^^^^^^^^^^
> These arrays have NR_PAGE_TYPE elements so it's off by one.
>
>     3367                if (ts_diff > sbi->rd_peak_lat[iotype])
>     3368                        sbi->rd_peak_lat[iotype] = ts_diff;
>     3369        } else {
>     3370                sbi->wr_sum_lat[sync][iotype] += ts_diff;
>     3371                sbi->wr_bio_cnt[sync][iotype]++;
>     3372                if (ts_diff > sbi->wr_peak_lat[sync][iotype])
>     3373                        sbi->wr_peak_lat[sync][iotype] = ts_diff;
>     3374        }
>     3375        spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
>     3376 }
>
> regards,
> dan carpenter
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
