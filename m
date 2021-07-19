Return-Path: <SRS0=w7Yd=ML=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B4CC07E9B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Jul 2021 18:50:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E2C610F7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Jul 2021 18:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E2C610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m5YLE-0002EK-1W; Mon, 19 Jul 2021 18:50:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <jaegeuk@kernel.org>) id 1m5YLD-0002ED-0W
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Jul 2021 18:50:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FIACMyb6FxXKLX7whhx0ufYLHapnKBy4scCKXXrQwxE=; b=dehDho5MNCT0zlEV6cCGMM6QU4
 k7qKmLVkosa8opm+woTYvKxHD6Ayt/drpcukZNw/Hh3fvNJNL8FFzBPSxyxO9PljgPVECKE0D5IDM
 TrLt8noAHsChIsGy8w4c2is+Bwc/CmvR1QR7VNw3xlScplWfb6dv9ebwxwbfBKfcoj+I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FIACMyb6FxXKLX7whhx0ufYLHapnKBy4scCKXXrQwxE=; b=c3lyr89sa7z9HdQBjx7aCPI1Gb
 q95B/fJxr+q0LThQVWV12tjk15Q3eBPUH8zVFOdOSycAJC5p4T3PAJIcR1gwAbuSOCfHXaXSBd4pY
 0Opf5otMyRTL8tBEWPgDpEq1Ef0jh6WLRJT4i97xwL6lGR6xN9Yu7YYOwZ4gVfstdatc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m5YL5-00DuQl-Tp
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Jul 2021 18:50:10 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A9DE60232;
 Mon, 19 Jul 2021 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626720598;
 bh=rlRvHesfEjeUlsO8Hwp41C5FiOVzlwcYj70KV6aM430=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fSImICV0ySVrVR3XZl3Xw3ry0LlnwYEk3HBW7QQZP1TAwwbEfD4rRqaJDRZECY0ty
 yj3TjzDU7LJFtDv1ntxUu/Wgy9HkJRlMxH41e3Xx7TgwukhBsUaLjTMzz/laRHyh1j
 ElmgTbrKCPw+dxvtBExYdrNCh/QFokPSlt+kU6Clpm1wKLriflubYNMLVAx0zwGCVc
 NLE+EmS1Uq8kf0cJlKN3cWrliF+TM3429JfhU2Xg/XrrLknI9aFneYR42pdMaW5b2q
 bjGW99cfwJmAbIaalyugU8y0mZd/CQJ7ueKgZ5NMzZImmo0xsN1ianOQBbAbsSgept
 Uod9M75DXoOHA==
Date: Mon, 19 Jul 2021 11:49:57 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YPXJVWflOq1lwoL2@google.com>
References: <20210714231850.2567509-1-jaegeuk@kernel.org>
 <ae44f40d-4727-92af-9f0b-ffb8540da872@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ae44f40d-4727-92af-9f0b-ffb8540da872@kernel.org>
X-Headers-End: 1m5YL5-00DuQl-Tp
Subject: Re: [f2fs-dev] [PATCH] f2fs: let's keep writing IOs on SBI_NEED_FSCK
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/19, Chao Yu wrote:
> On 2021/7/15 7:18, Jaegeuk Kim wrote:
> > SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered, so it
> > is not fully critical to stop any IO writes. So, let's allow to write data
> > instead of reporting EIO forever given SBI_NEED_FSCK.
> 
> Well, it looks we need to check why there is SBI_NEED_FSCK flag.
> 
> If this patch breaks something, how about forcing OPU if SBI_NEED_FSCK
> was set?

Yea, let me take that.

> 
> > 
> > Fixes: 955772787667 ("f2fs: drop inplace IO if fs status is abnormal")
> > Cc: <stable@kernel.org> # v5.13+
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/segment.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 15cc89eef28d..f9b7fb785e1d 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3563,7 +3563,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
> >   		goto drop_bio;
> >   	}
> > -	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) || f2fs_cp_error(sbi)) {
> > +	if (f2fs_cp_error(sbi)) {
> >   		err = -EIO;
> >   		goto drop_bio;
> >   	}
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
