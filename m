Return-Path: <SRS0=nR8U=5J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DA6C43331
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:43:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A797820714
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="llouse5q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="X2JsXCn1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db7a4hxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A797820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jGliJ-0000GL-7K; Tue, 24 Mar 2020 15:43:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jGliG-0000G8-Bx
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Mar 2020 15:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nm+gU9VKA730ZriGe3rKuK/ZdFwG1lvrE8H9tBhUCWk=; b=llouse5qYNqugwa3I//n/owLBS
 Qq6Dy31umLTM5WAkaRUWrfosJgkwxYAfn/hIswy/yybkhRvej6CLzxLWPgTx/sxT+xGvOmBn1GeVJ
 xzGlRYZ5JmNXhDBxMG3ddhOsnct9DFyr4W5Jf9kZB4d+FX0wyMPexaYZoDY+I8dF9Uc4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Nm+gU9VKA730ZriGe3rKuK/ZdFwG1lvrE8H9tBhUCWk=; b=X2JsXCn1wqvpMGYGjtyEDyr190
 mRBxMO1FNIOhFQJQ34W/YGhoav9oLxFu3yLDGpE/DC49zz7x20NgshGLp55PeYzBGpCHR677ssoZo
 fiBvWVWN72e9NBBjMO5saa+6m3GaAYUGvrI1EMDi8DxQraMO1ICZqbjx/ypvLqnjdeNU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jGliC-00FK0z-Fw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Mar 2020 15:43:32 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D41C020714;
 Tue, 24 Mar 2020 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585064602;
 bh=Qv9VoaJbPxXb6ifsksLylG5aLk2K8GMbJDDMXCV0fjc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Db7a4hxBMH6eTuRq4g4f/SP8qeiY1OeXIglgiiJ8R6LPnJmd0IqRJtQZ0/iNu3TxT
 F3t180Ea6Mp/IKTYldRu4jZnCH6mZkRdFBJveCbCVoHEkZbYNmAVhEadf1lKoCh02Z
 GoAT/zBpm+7YXYrUYpJszrUX/wfU13ebDuydDRgk=
Date: Tue, 24 Mar 2020 08:43:22 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200324154322.GB198420@google.com>
References: <20200229104906.12061-1-yuchao0@huawei.com>
 <6aab59b9-6e33-5b01-acf8-ccbacd9318e3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6aab59b9-6e33-5b01-acf8-ccbacd9318e3@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Headers-End: 1jGliC-00FK0z-Fw
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant compress inode check
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

On 03/24, Chao Yu wrote:
> Jaegeuk,
> 
> Missed to apply this patch?
> 
> On 2020/2/29 18:49, Chao Yu wrote:
> > due to f2fs_post_read_required() has did that.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/f2fs.h | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index f4bcbbd5e9ed..882f9ad3445b 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -4006,8 +4006,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
> >  		return true;
> >  	if (f2fs_is_multi_device(sbi))
> >  		return true;
> > -	if (f2fs_compressed_file(inode))
> > -		return true;

I thought that we can keep this to avoid any confusion when porting to old
production kernel which uses ICE.

> >  	/*
> >  	 * for blkzoned device, fallback direct IO to buffered IO, so
> >  	 * all IOs can be serialized by log-structured write.
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
