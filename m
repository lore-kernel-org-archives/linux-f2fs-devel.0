Return-Path: <SRS0=hEcs=VA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C7AC0650E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:26:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4444E2184C;
	Wed,  3 Jul 2019 15:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="FtfWjfKw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Mj3k1wvz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="QH30ybb7";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="W1ELw492"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4444E2184C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oU+Cd7gv3BMOiPZEkV4kDlV+rbGp7x4IWskoFWXPQGQ=; b=FtfWjfKwlFHA0ihom5emnb9WH
	JQgEbQ8gup0+c5S1ejIS7qhCTPANqRa+59jfOuW3T/RgbW4JFceKzMlfoRY0F3/hrLaC+zqCs+KU0
	1S8uoe9OtgBbhoV5ndQZ2zq/9GC5WRhnek6L5g4i4TpNL9G37n0ZlM2Tk5xT3RYLZnXG8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hih92-0008MX-6E; Wed, 03 Jul 2019 15:26:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <oceanchen@google.com>) id 1hih91-0008MJ-01
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jul 2019 15:26:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=37hMmTyD0K9QDDKKnPyMk0IHgB8jdOaS9XE3nfECex0=; b=Mj3k1wvzsMJMKWu5DnjTtnXizU
 7WgB8b6nfV66rA1JDhogCFTwnocIuYykhP6D3b0OcPRYEH6f+R6DXZ0JSyhcqH/dWgsLDnwr9OivY
 e/aBwEX+5M3bQgOhTn8tFK0EKxbx9Hu/T+YXZMxtGFvovJZBZzHcM/rq9TIoRe6A67PQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=37hMmTyD0K9QDDKKnPyMk0IHgB8jdOaS9XE3nfECex0=; b=QH30ybb7estJwlR1vAB/E8Bq6d
 l98OBI2o3q/g9rUJZf1vPneDVE0AP70LtjUr2mfjEn6NKv7gNFo7NIOQNFt2qsE1vyj9UfwEJNMXe
 jo1WxuCfGyuT/gTKmqy/tzfloqkrsSdb7z0aLTXX+55btriAKpfXc2cWpwgpR77WYCOQ=;
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hih98-006pa9-0H
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jul 2019 15:26:11 +0000
Received: by mail-pl1-f195.google.com with SMTP id b7so1438106pls.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 03 Jul 2019 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=37hMmTyD0K9QDDKKnPyMk0IHgB8jdOaS9XE3nfECex0=;
 b=W1ELw492iBqoEtuhoj+Xfh9gtti36WkdD2hXoa2KDWc96yb8UiWQnigeqVyTLuF7ye
 ONFUjDSltojaY/UFcWhkASwrBe9gb9/TC3pGGR+yWqj/Ub03puBiLQtykpmrZ4tM9ScZ
 SL7gnwrYsbaxXauGom+a4ug9FcHtfKsStCAxBO3v77VVhio9J5PghtZ5/2p95o8jJPn/
 8iKAXv8/4Ker46cEHs7n3RFawBSdA+Gtq3sfAYnm3Y3VDuVnTuRMtDFTFEjNC41SJemG
 NtgvOJ0PGjLGb+dQvLVSAENhUOjQo1x7NQm0EdZlMmyhSRcoQaXgassd/7OX1Aoizock
 7X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=37hMmTyD0K9QDDKKnPyMk0IHgB8jdOaS9XE3nfECex0=;
 b=dKKEkME9gLv79/sfkrOSUP8zu3FBlkGktTa0307VRmKjxB6YIMrR6S2DLfDVPJRwp1
 bmSXmlGHm+3MbzkUNAwgOxYxvFLtosDe5vHl7vY+kgPjuXU6Be94fByplUQ2dqOI6f72
 8eCNGS4kJ+9Yoc38ELpFVQQd/s3kG2wiFHRg8+7xu0/4jKyEhoXLGT/eYyrI+pbSMk37
 1hTLVy0HWR+R824tIiKtCfMWtn8rBq6rMtfc1vbvRyWVpZ32pOJQGe2N6aH8O4bZVpL8
 9GkNL9wuBz3rXs9YK9MrtL3hnEDXSJdg2YhoqIOcDope1KuHx7bMbAXX7vr2AGYZaJQz
 wIAg==
X-Gm-Message-State: APjAAAWy2k4ABBGjaklyp9ShH4Yf0jUlDFBYKnfm05gJqq64B5OT4CbA
 z1p681E8Y6xGXnHTVO2kwMdkzNDXDd1wUsYo
X-Google-Smtp-Source: APXvYqzm9VoQdSLoR1RbyAFmag38CTXi0djAc26Mp2+tUxGdT79rlo3yhj0j6nK9BOMcpY8de6+dLA==
X-Received: by 2002:a17:902:d916:: with SMTP id
 c22mr43738767plz.195.1562166243044; 
 Wed, 03 Jul 2019 08:04:03 -0700 (PDT)
Received: from google.com ([2401:fa00:fd:2:3217:6d96:9ca7:b98b])
 by smtp.gmail.com with ESMTPSA id z20sm5179094pfk.72.2019.07.03.08.04.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 08:04:01 -0700 (PDT)
Date: Wed, 3 Jul 2019 23:03:55 +0800
To: yuchao0@huawei.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-ID: <20190703150355.GA182283@google.com>
References: <20190702080503.175149-1-oceanchen@google.com>
 <cfcd3737-3b03-87fe-39e8-566e545cab3a@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cfcd3737-3b03-87fe-39e8-566e545cab3a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hih98-006pa9-0H
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid out-of-range memory access
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
From: Ocean Chen via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Ocean Chen <oceanchen@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Yu Chao,

The cur_data_segno only was checked in mount process. In terms of
security concern, it's better to check value before using it. I know the
risk is low. IMHO, it can be safer.
BTW, I found we can only check blk_off before for loop instead of
checking 'j' in each iteratoin.

On Wed, Jul 03, 2019 at 10:07:11AM +0800, Chao Yu wrote:
> Hi Ocean,
> 
> If filesystem is corrupted, it should fail mount due to below check in
> f2fs_sanity_check_ckpt(), so we are safe in read_compacted_summaries() to access
> entries[0,blk_off], right?
> 
> 	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
> 		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
> 			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
> 			return 1;
> 
> Thanks,
> 
> On 2019/7/2 16:05, Ocean Chen wrote:
> > blk_off might over 512 due to fs corrupt.
> > Use ENTRIES_IN_SUM to protect invalid memory access.
> > 
> > v2:
> > - fix typo
> > Signed-off-by: Ocean Chen <oceanchen@google.com>
> > ---
> >  fs/f2fs/segment.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 8dee063c833f..a5e8af0bd62e 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3403,6 +3403,8 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
> >  
> >  		for (j = 0; j < blk_off; j++) {
> >  			struct f2fs_summary *s;
> > +			if (j >= ENTRIES_IN_SUM)
> > +				return -EFAULT;
> >  			s = (struct f2fs_summary *)(kaddr + offset);
> >  			seg_i->sum_blk->entries[j] = *s;
> >  			offset += SUMMARY_SIZE;
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
