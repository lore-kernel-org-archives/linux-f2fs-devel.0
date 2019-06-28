Return-Path: <SRS0=yuZv=U3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76248C4321A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:16:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F12420656;
	Fri, 28 Jun 2019 02:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="NIfLUEe6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hZi0mwi2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOltpbKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F12420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hggQc-0006Kt-3L; Fri, 28 Jun 2019 02:15:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hggQW-0006Ki-EI
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Jun 2019 02:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/p6dkVLTRAFsHuf0zB0m1fm8Kme5WiU7oPYF2kabM9M=; b=NIfLUEe6D6zEy0iG3Mja5C7c12
 IuF7eQo6+eFMhgtyUMr0ZikPE1DEoDv+PwHdIyraSrn8VtwZJj+qjay0eM59Azx/heYwmpiMv+2Gr
 te8dHZOmmKSHRzg3Aqn2nh0FqvhaiXwVUqvE0eLpvf7dEQtNQpMODEpVUhNyU6yHVYYc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/p6dkVLTRAFsHuf0zB0m1fm8Kme5WiU7oPYF2kabM9M=; b=hZi0mwi2BIbBw46LgnQBKbGXGu
 XRFgR93W44000zUJ5IB79THv27rf4wskKO+Z4vnWCboXjMhUfa3bg6Z4JO+LnLQj0OSda/T+UIkkW
 /DYmHugAg9xy0SwV3lRwMII1Wiv9phnkmeCYrNu6VAiDuRK29loakzcVk/bkgfhi+bfk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hggQf-000DxR-Lp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Jun 2019 02:15:58 +0000
Received: from localhost (unknown [104.132.1.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 07A5420656;
 Fri, 28 Jun 2019 02:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561688152;
 bh=SEuwoxb+YxWbpWoq3cFNrSyjo+k+UVoi+9JyvlZdzGc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FOltpbKkKBV0rOJa6nZeGdrmkjaKE6WFqbeQzX9IlBP2SZHVnBXF1ZOsrFaYwrkQ3
 DB+gGkb3utGJFCiFilbXlogi4SOSfcmEX41rtkbso5nEQZnlC0grFJqdEnK8JS6c5D
 9+Z+SLQ30czmAOHLUBVY89NRjpCAYYL7PXNeepEg=
Date: Thu, 27 Jun 2019 19:15:51 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20190628021551.GA10489@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190627170504.71700-1-jaegeuk@kernel.org>
 <f64cdddd-807e-2918-744b-56ced47a94dd@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f64cdddd-807e-2918-744b-56ced47a94dd@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1hggQf-000DxR-Lp
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate blocks for pinned file
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

On 06/28, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2019/6/28 1:05, Jaegeuk Kim wrote:
> > This patch allows fallocate to allocate physical blocks for pinned file.
> 
> Quoted from manual of fallocate(2):
> "
> Any subregion within the range specified by offset and len that did not contain
> data before the  call  will  be  initialized  to zero.
> 
> If  the  FALLOC_FL_KEEP_SIZE  flag  is specified in mode .... Preallocating
> zeroed blocks beyond the end of the file in this manner is useful for optimizing
> append workloads.
> "
> 
> As quoted description, our change may break the rule of fallocate(, mode = 0),
> because with after this change, we can't guarantee that preallocated physical
> block contains zeroed data
> 
> Should we introduce an additional ioctl for this case? Or maybe add one more
> flag in fallocate() for unzeroed block preallocation, not sure.

I thought like that, but this is a very corner case for the pinned file only in
f2fs. And, the pinned file is also indeed used by this purpose.

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index e7c368db8185..cdfd4338682d 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1528,7 +1528,12 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
> >  	if (off_end)
> >  		map.m_len++;
> >  
> > -	err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
> > +	if (f2fs_is_pinned_file(inode))
> > +		map.m_seg_type = CURSEG_COLD_DATA;
> > +
> > +	err = f2fs_map_blocks(inode, &map, 1, (f2fs_is_pinned_file(inode) ?
> > +						F2FS_GET_BLOCK_PRE_DIO :
> > +						F2FS_GET_BLOCK_PRE_AIO));
> >  	if (err) {
> >  		pgoff_t last_off;
> >  
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
