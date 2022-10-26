Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DDBC38A2D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Oct 2022 17:05:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1onjq4-0001SQ-1K;
	Wed, 26 Oct 2022 17:05:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1onjq1-0001SK-RF
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Oct 2022 17:05:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zxmpHRfDFHUhiMRwHCT097VDEX9SLvjDK4DVttdFLvM=; b=GNLk2qCXAURrPleOP5/FWQiYwx
 OXN4Qe96RJsf/7eOnln8NSEMAmOIuUbZikwtA9qomG29JYskrk67Tb622BZPz7CiqBrXwr2qxw9eQ
 GJhPzNqR+a0xnB3Q5WQ3expC75FBwK5sb+vryFcJv8C+F1LKkyWyON1lFdYeYXtExVxk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zxmpHRfDFHUhiMRwHCT097VDEX9SLvjDK4DVttdFLvM=; b=Mrane7o9GVxIeHqrVqSag49Hl8
 7ewI2N6aEo8UxVCqhheKWwGH42u4ILVlPyprhr2DNbaHWKAsKn8mT4hwmMsice2/rRGJyEOvpyGI5
 Xk9/L60a38TsvuBnQXNBSMKmhXYSrxIHBcnIFoAXjy18gDfw99LqtYo0ntecc3Da38h8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1onjpx-0002ua-Fd for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Oct 2022 17:05:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D8BF061FE1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Oct 2022 17:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30064C433D6;
 Wed, 26 Oct 2022 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666803896;
 bh=Q8RhGmve0EqK5guDgkRGYNKHoxwkXq/IG+Ua0iv00Ik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rCieFf8WqL2FpAcgU+cOs2w22J1Y6niUHB/uor+xLGDg/Mv/XH/ITS864Z9S8pEQv
 +Wkrt4CQsoKa+AAENjkfcOn4tIvDR73oyBgxUt55EZ6u0fvXko1Ls22bBspx62KBj/
 wFlWgKu2oF5k04p4+QHTSAXetBfsErFAXpAQGXcjESpgFO7b5PUJT1H12hk2YYk6GH
 /XEuJKVjDmeJHRgP6IHVT1Es3picTCllSIcpDo31ZKSrjCqiEQKh8THaDm1qNtFwKV
 Qj4edN7/N+rxE5qx3bt4rQ4b+0drMyjOVATc/dD7CzIhkAIkK1NVpVEXMXvnH3yAyM
 eUJuKBvbll06A==
Date: Wed, 26 Oct 2022 10:04:54 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Y1lotu35Z/l6YzwR@google.com>
References: <20221024233634.803695-1-jaegeuk@kernel.org>
 <ae5f7c6e-248b-3cf7-b111-a4ddc85dd411@kernel.org>
 <Y1gg6P6CO9KbDO0O@google.com>
 <0a339e33-d79a-19e4-fadd-bb37a5a9f79d@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a339e33-d79a-19e4-fadd-bb37a5a9f79d@kernel.org>
X-Headers-End: 1onjpx-0002ua-Fd
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow to set compression for inlined
 file
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

On 10/26, Chao Yu wrote:
> On 2022/10/26 1:46, Jaegeuk Kim wrote:
> > On 10/25, Chao Yu wrote:
> > > On 2022/10/25 7:36, Jaegeuk Kim wrote:
> > > > The below commit disallows to set compression on empty created file which
> > > > has a inline_data. Let's fix it.
> > > > 
> > > > Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >    fs/f2fs/file.c | 3 +++
> > > >    1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > index 1c4004c9245f..304fe08edc61 100644
> > > > --- a/fs/f2fs/file.c
> > > > +++ b/fs/f2fs/file.c
> > > > @@ -1915,6 +1915,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> > > >    			if (!f2fs_disable_compressed_file(inode))
> > > >    				return -EINVAL;
> > > >    		} else {
> > > > +			/* try to convert inline_data to support compression */
> > > > +			f2fs_convert_inline_inode(inode);
> > > 
> > > It needs to check return value of f2fs_convert_inline_inode()?
> > 
> > I intended to catch that in the below checks?
> 
> But it may hide the real error number, e.g. -ENOMEM returned from
> f2fs_convert_inline_inode()?

Fair enough. Let me send v2.

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > +
> > > >    			if (!f2fs_may_compress(inode))
> > > >    				return -EINVAL;
> > > >    			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
