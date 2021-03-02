Return-Path: <SRS0=fkhx=IA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5758C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Mar 2021 18:44:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6C364F23;
	Tue,  2 Mar 2021 18:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6C364F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lHA0l-0003pu-3A; Tue, 02 Mar 2021 18:44:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lHA0f-0003pe-7g
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Mar 2021 18:44:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=duFrThFL0/xAdpZtMz38t5joplZpwBlVJfElr2prT/g=; b=HshLyT+jSX6HVVr5O2vmXiD9xs
 Ww5TnCkDgxOg+GzmtI2LYa5qoaIELiyZFBEmtyHBZCQ6RZUcYThHa24FAY3+wVeyrYtWPsfRzBN/b
 g7K80nmIsVEi4BxG75qDVnersFjGtCPbOQnioxbaMPGWVS/MusW0Vyw3OCbeSL/xpsrs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=duFrThFL0/xAdpZtMz38t5joplZpwBlVJfElr2prT/g=; b=OOBbM2GOGVRtLNg5Su3MJbAQm4
 MD47WgunTkTE/Pk4LD5Y0Vi6AvkWy4wUGmuWyQWJIHSa13eqs9z2X3GbpXDGdrbPGLe1s4ZQPCna6
 JB8JyAP97MPtBb7N/Ya4PwlXrwLVjMGfrZ/u9Tqdi+eCGZWqwvMzzCAV/rJuoRHUqnfo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lHA0a-00BZkp-Px
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Mar 2021 18:44:41 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1208860234;
 Tue,  2 Mar 2021 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614710671;
 bh=Jez+zQ5zpYVsw8ZRUjYBKwlw+LBdVJxKIm2weKJgcAg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QgZZ/lRmbVso3uOmcSejiJnTRnZ9yzOkv44srGRjw/oqUQ1P0VDt2zzCALLelceGo
 nw1tWuK7MoM0hFugbabeY0B5prc0uOBz03Lk8MBDqNZr6MWJlRcn1Nezxv6oq22VRD
 jhw43n4UcLZW3U1hwlLeLafkoa2kwp+aTLfoSfboU94jjFoDR95VYZRES2VvypK+0p
 9OzgwLwHWBmpsvkAwJ9lzXrabW99SsSoeKK/NoyDWWvim42iDimyshbHxW1kUWkZ+N
 le0+e4MqcombT7q3wAvDr6wY4HdRdDrM9LWDEdrTblZ8Ho16yUzggqoOg6Cw0zO7uG
 2KMWdlHAWERug==
Date: Tue, 2 Mar 2021 10:44:29 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <YD6HjZG7QMS6Z3Tb@google.com>
References: <20210302054233.3886681-1-jaegeuk@kernel.org>
 <920469a9-45d3-68e3-1f8d-a436bdd60cfe@huawei.com>
 <YD5wQRX+HnltBvEM@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YD5wQRX+HnltBvEM@google.com>
X-Headers-End: 1lHA0a-00BZkp-Px
Subject: Re: [f2fs-dev] [PATCH] f2fs: expose # of overprivision segments
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/02, Jaegeuk Kim wrote:
> On 03/02, Chao Yu wrote:
> > On 2021/3/2 13:42, Jaegeuk Kim wrote:
> > > This is useful when checking conditions during checkpoint=disable in Android.
> > 
> > This sysfs entry is readonly, how about putting this at
> > /sys/fs/f2fs/<disk>/stat/?
> 
> Urg.. "stat" is a bit confused. I'll take a look a better ones.

Taking a look at other entries using in Android, I feel that this one can't be
in stat or whatever other location, since I worry about the consistency with
similar dirty/free segments. It seems it's not easy to clean up the existing
ones anymore.

> 
> > 
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >   fs/f2fs/sysfs.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > index e38a7f6921dd..254b6fa17406 100644
> > > --- a/fs/f2fs/sysfs.c
> > > +++ b/fs/f2fs/sysfs.c
> > > @@ -91,6 +91,13 @@ static ssize_t free_segments_show(struct f2fs_attr *a,
> > >   			(unsigned long long)(free_segments(sbi)));
> > >   }
> > > +static ssize_t ovp_segments_show(struct f2fs_attr *a,
> > > +		struct f2fs_sb_info *sbi, char *buf)
> > > +{
> > > +	return sprintf(buf, "%llu\n",
> > > +			(unsigned long long)(overprovision_segments(sbi)));
> > > +}
> > > +
> > >   static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
> > >   		struct f2fs_sb_info *sbi, char *buf)
> > >   {
> > > @@ -629,6 +636,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
> > >   F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
> > >   F2FS_GENERAL_RO_ATTR(dirty_segments);
> > >   F2FS_GENERAL_RO_ATTR(free_segments);
> > > +F2FS_GENERAL_RO_ATTR(ovp_segments);
> > 
> > Missed to add document entry in Documentation/ABI/testing/sysfs-fs-f2fs?
> 
> Yeah, thanks.
> 
> > 
> > Thanks,
> > 
> > >   F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> > >   F2FS_GENERAL_RO_ATTR(features);
> > >   F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
> > > 
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
