Return-Path: <SRS0=8R1c=FJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDE3C4361A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  5 Dec 2020 20:45:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BEA230F9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  5 Dec 2020 20:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BEA230F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kleQr-0001fJ-Un; Sat, 05 Dec 2020 20:45:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kleOb-0001ZI-Bf
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 05 Dec 2020 20:43:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i0LyxSM1LrvzFnlp2pasnuto+Sx9P195F9agpA//1l0=; b=Lf+2j/8Rgx0OcSqDWIQWDDq+Ld
 nT6kqMxjaWgEPctzX5ZLgqNpe6SBQFrx8ZTlWc/hK/luO+c/HUGMBLkl+J3pRO28hx2QsY0TOInaS
 JufOMBhicWtq3ZdwYyFNTELjH4as/tYDOb6sAZrZHVErmOS0O/uaJc08Un9+63DDlb1M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i0LyxSM1LrvzFnlp2pasnuto+Sx9P195F9agpA//1l0=; b=H5J9DCJoj5mrZrz65X0YqLhAeu
 qz5EhYU89ZBwxWJKhge+jmmGuFJ5ClXR4fgLaon4pHPo4Mj5lerwzovgr1SpLQURFS4Qa/TjiVPaI
 VvqYJgIwWHBuRIW0A/wzacinr2y5+BrTDLK1JIoMebF0oE2Q66n+1ef79jQ7qtSEffSA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kleOQ-003ZY8-S7
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 05 Dec 2020 20:43:08 +0000
Date: Sat, 5 Dec 2020 12:42:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607200968;
 bh=x7rofouDQwKdeiKgyOhN+pS04UY3hUFno5zmc3XEp/M=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=BSwp5oHxvRnU8AvzY71q/6TaPmFzAoz7cc+JBdhBHrVpHwV7K5lpf5geXcVR/3HVZ
 lVy7fctqxxWna3ecKA9hfPF+/xAFXbcj9DQbYnQ/IiHSuZEXZWuEil3xMiIKNaGbls
 pMyGXF5fDyJ3mAXndkox84Iogk8xxxVWjLuAvs1Zgl42IDkgYaXe1oCfuYA82BnUfl
 qlAWKyhOol094Rb9TB8cOLkV0DJBv+EqPRiBxgeVNgJzyHVqtCgCcv0HmUWuCJNYwF
 PAgaKmcD/6Ly61VLNqrCKnWFR6bxg5lplbaRDT1BGD87DAGJ0upT2EFvzD3Voy8aQA
 0iXtpasLtLXEA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <X8vwxtBuFGCD/IS/@google.com>
References: <20201127090118.84235-1-yuchao0@huawei.com>
 <af26ca56-1dbf-e59b-b7b0-63ce817fd94d@huawei.com>
 <X8p+rK6wQsXdcG33@google.com>
 <e35d3dde-db71-27dc-88fd-fd6e2cd2b02f@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e35d3dde-db71-27dc-88fd-fd6e2cd2b02f@kernel.org>
X-Headers-End: 1kleOQ-003ZY8-S7
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce a new per-sb directory in
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/05, Chao Yu wrote:
> On 2020/12/5 2:23, Jaegeuk Kim wrote:
> > On 12/03, Chao Yu wrote:
> > > Jaegeuk,
> > > 
> > > Can you comment on this patch?
> > 
> > Waiting for use-case? :)
> 
> How do you think of duplicating below stats into /sys/fs/f2fs/<devname>/stat/

We can't move them to /stat, since it requires lots of mess. Let's think
about new ones only.

> 
> F2FS_GENERAL_RO_ATTR(dirty_segments);
> F2FS_GENERAL_RO_ATTR(free_segments);
> F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> F2FS_GENERAL_RO_ATTR(features);
> F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
> F2FS_GENERAL_RO_ATTR(unusable);
> F2FS_GENERAL_RO_ATTR(encoding);
> F2FS_GENERAL_RO_ATTR(mounted_time_sec);
> F2FS_GENERAL_RO_ATTR(main_blkaddr);
> #ifdef CONFIG_F2FS_STAT_FS
> F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
> F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
> F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_foreground_calls, call_count);
> F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_background_calls, bg_gc);
> F2FS_GENERAL_RO_ATTR(moved_blocks_background);
> F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
> F2FS_GENERAL_RO_ATTR(avg_vblocks);
> #endif
> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
