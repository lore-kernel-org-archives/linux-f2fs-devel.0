Return-Path: <SRS0=Ksgo=FM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99E3C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Dec 2020 07:08:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FCC23A75;
	Tue,  8 Dec 2020 07:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FCC23A75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmX6e-0007da-45; Tue, 08 Dec 2020 07:08:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kmX6d-0007dN-5r
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Dec 2020 07:08:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R2lA/L7hpQSPdLrqBoeEsw+1B5D/qHsTooQ1+ueaqOA=; b=jXOVbtlhWavq8pxJDCbO9ZuI37
 Wc6yOGphGoJKxfRd81lOKypfaG9T7II65Ga/B3as2TYzqlka2wp1631FGJpqJqRfu4PVNT1P5Mqn+
 g3m2Jthvpxukn4z2dpmRWCiGiKSi3LQWpl0SCs2PlqsDNwnDX1miUzR1VApntGp87qFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R2lA/L7hpQSPdLrqBoeEsw+1B5D/qHsTooQ1+ueaqOA=; b=e9141TjkSjCN97uVmD0oBdCNdw
 iO0KRa19onIM/xyyX8Tc0EBsGuDB3UV2IB36bMF1tTPwU946YBVCKzcw5es8FOYBKj1eFx+UD7JP8
 uzeoUe+z0tgKuEVyjoCSixJ7wGyNENxB4NupiHJ7LvHlQSWDnuQyXT3Kii6exv3vu1bU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kmX6Y-006GQg-Ss
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Dec 2020 07:08:15 +0000
Date: Mon, 7 Dec 2020 23:07:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607411280;
 bh=9Zz5bCZbGSDAEH+G2flLc2O6QOJcCQI0mx52UaaRXmI=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=QrtmZwf1HP1pHUf3tLKJj6dbBtIHnWXNpzxm99Oga3Za1CbgPtZn/h6ikLfLjlUtd
 dHryGxpzynMSfPRHNDXnIoFMqouMplWUZdgLRQyWP9bkJef9wwAQMzgj+NautL50+9
 YWJOpqrq0Znl+SWbadvMkV+0/YQZr5jtQu+AycZSc1rEQAUTjxhbQmvnjSBCJpSHD4
 //BHFTuc3BA9KgQLZH/mVLNspczxZ/HruYQTCvsWhzXxHWzAeBIxvbNvJGu7Zl/ATl
 zw1J9T8hOlSAkzSSA0PPktYpsv4Y0GgYlTOWhI8N6/EE3c8mPzBFfrDC5+k/T/c+xa
 fp3Bylt3e2SyA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <X88mThRozv5cjCFD@google.com>
References: <20201207120114.25642-1-jack.qiu@huawei.com>
 <20201207120114.25642-3-jack.qiu@huawei.com>
 <X85dFjmqLmo/RsQn@google.com>
 <529dd167-3951-1fb9-a1c3-9ae6cdbc8dfb@huawei.com>
 <X87ZENVuVkTFGdRe@google.com>
 <1c0006ea-3bb9-93ef-914b-69a8b06f902e@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c0006ea-3bb9-93ef-914b-69a8b06f902e@huawei.com>
X-Headers-End: 1kmX6Y-006GQg-Ss
Subject: Re: [f2fs-dev] [PATCH v3 2/3] f2fs: inline: remove redundant
 FI_DATA_EXIST set
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/08, Chao Yu wrote:
> On 2020/12/8 9:38, Jaegeuk Kim wrote:
> > On 12/08, Chao Yu wrote:
> > > On 2020/12/8 0:49, Jaegeuk Kim wrote:
> > > > On 12/07, Jack Qiu wrote:
> > > > > FI_DATA_EXIST has been set in recover_inline_flags, no need set in
> > > > > f2fs_recover_inline_data again. Just remove it.
> > > > > 
> > > > > Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
> > > > > ---
> > > > >    fs/f2fs/inline.c | 1 -
> > > > >    1 file changed, 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> > > > > index 0399531efcd3..0a8f7eefca7d 100644
> > > > > --- a/fs/f2fs/inline.c
> > > > > +++ b/fs/f2fs/inline.c
> > > > > @@ -286,7 +286,6 @@ int f2fs_recover_inline_data(struct inode *inode, struct page *npage)
> > > > >    		memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
> > > > > 
> > > > >    		set_inode_flag(inode, FI_INLINE_DATA);
> > > > > -		set_inode_flag(inode, FI_DATA_EXIST);
> > > > 
> > > > Wait, recover_inline_flags() sets this based on on-disk flag, but this tries to
> > > > recover it back.
> > > 
> > > Should this flag only be recovered with the way like __recover_inline_status()?
> > > otherwise, the data_exist status may be not be consistent with real condition.
> > 
> > Well, we cannot say consistency on this, since user can write zero data. This
> 
> I can see that FI_DATA_EXIST flag only decide that whether f2fs_convert_inline_page()
> will copy inline data into first page, if user write all zero data in inline area,
> there is no need to do the copy, as first page contains all zero already.
> 
> So, IMO, the flag indicates more like a FI_NON_ZERO_DATA_EXIST status? that would be
> consistent with our implementation in __recover_inline_status().

IIRC, original intention is FI_DATA_EXIST, and non-zero case was added to avoid
potential inconsistency case. So, it's not intened for FI_NON_ZERO_DATA_EXIST.
Still I don't see any problem on this, but  looking at the iteration overhead on
   do_read_inode() -> __recover_inlint_status().

> 
> Thanks,
> 
> > can avoid __recover_inline_state() regardless of there-in data which is zero or
> > not.
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > >    		set_page_dirty(ipage);
> > > > >    		f2fs_put_page(ipage, 1);
> > > > > --
> > > > > 2.17.1
> > > > > 
> > > > > 
> > > > > 
> > > > > _______________________________________________
> > > > > Linux-f2fs-devel mailing list
> > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > 
> > > > 
> > > > _______________________________________________
> > > > Linux-f2fs-devel mailing list
> > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > .
> > > > 
> > .
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
