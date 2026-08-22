Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A6AC5DF8C
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 22 Aug 2026 00:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bAJE73M4yMi1tJIRmGId08W5Kdk/OvzEDMkRpIDWooc=; b=jSXC0kd7KG+6bB+n3IkqZcwK8A
	Vn5qYe0ekWygLJwS0JdMitKPLp+2JmlqFFQIgy++QsOuRVCm1SvaeZpuK85SBMGObqF3RYI2/9MBa
	QFVvy2CrxCUGeeWwB/mx0i/Tgzlb12HgNeZHHB3vqgwvosjmN8hlIieYDAXgMPH5cfj0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxZLh-0005dW-MD;
	Sat, 22 Aug 2026 00:12:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wxZLZ-0005dM-Ek
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 00:12:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d2FbKGsrueBVUIH7/Kt3Vog6JqVelaagaHWOgYooyFA=; b=BP5rNdRC32hzqS90aZPDRXAA5u
 HGBMaGTxNh/RlyZe2jI7PkxAkeSdz3TGkHKoidA09X981WZrVkNXluswtFtd/EkPJRJnhyvHzckUN
 YU0H+OGGLL5Ku8TSc2ggXWrLRzY+q9f8nrFJBombrgLU0uLSjr4OLWvOftyjsCI0k9to=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d2FbKGsrueBVUIH7/Kt3Vog6JqVelaagaHWOgYooyFA=; b=Lulylg6qCGUg+yZ631fqOhmZ8M
 qe0LsJzlN8st1Ra30Sa0wcDXbhcJVGHmSSjJjT1hDJ9bOYHSeeHNeTFl0RzV7OkfR9yDE3x4woq1w
 wRDIYUGMGc3+pFpc9WcjAadC1ju/GY8m2zt+YL6ANck5RGgdOidvGLxBQsh4NYJ6ZYnI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxZLY-0003yD-M9 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 00:12:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC7E661126;
 Sat, 22 Aug 2026 00:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0C31F000E9;
 Sat, 22 Aug 2026 00:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787357542;
 bh=d2FbKGsrueBVUIH7/Kt3Vog6JqVelaagaHWOgYooyFA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jj1Xwpu4i2ChvIodjGsDYwk16peiJ1AtAwJe0jgLFpvyNdsWRv9LSHIuZ7BfGr/jt
 Th9cRdDw6+LYCTZk+Dp0+TqMIE2bl4grnHCCf17RrMAhQinLps/LiqZbW0sgAKuPV3
 ooDcqiBP6xN+8T7lwasCekGW2PsbNYyHr4W6W4+l26a4C8yzwHzxZIrYYo4BKLgyC6
 MurevPLB44fOMRZ0JfhZx2rFWKZjWC8OkBn50Zmb1AnxDGOYi1mEL2Tir2Q9+ICnD4
 XM6IRtHzxDKDvlgI/dBL1UQGERMtufgg/itWPneErBaKGI/EPr2eAVe9dHq3JwYSQz
 +PI1/BtLLe9lQ==
Date: Sat, 22 Aug 2026 00:12:20 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <aojpZFWIYAQ5Y-2W@google.com>
References: <20260821141742.2678300-1-daeho43@gmail.com>
 <aohuDgLbl5SSnJ9T@google.com>
 <b04fad97-89ea-43fc-a3b0-951c78838bcb@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b04fad97-89ea-43fc-a3b0-951c78838bcb@kernel.org>
X-Headers-End: 1wxZLY-0003yD-M9
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error handling on device alias
 check in rename and unlink
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, kernel-team@android.com,
 stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/22, Chao Yu wrote:
> On 8/21/26 23:26, Jaegeuk Kim via Linux-f2fs-devel wrote:
> > On 08/21, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > > 
> > > In f2fs_rename() and f2fs_unlink(), directly returning -EPERM when
> > > encountering a device aliasing file bypasses the cleanup path.
> > > 
> > > Fix this by setting err to -EPERM and jumping to the proper cleanup
> > > labels (out_dir and out) instead of returning immediately.
> > > 
> > > Fixes: a737e409a3d6 ("f2fs: support dynamic reserve/release for device aliasing")
> > > Cc: stable@kernel.org
> > 
> > Applied without Fixes and stable, since the original patch has not been
> > upstreamed.
> 
> Jaegeuk, if we don't plan to merge them, we'd better keep the Fixes and stable
> line, otherwise, once the two patches be upstreamed, we may missed to backport
> the fix one due to the missing lines?

My concern is the never existing hash in upstream. And, I don't think this will
go into any LTS.

> 
> Thanks,
> 
> > 
> > > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > Reviewed-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/namei.c | 12 ++++++++----
> > >   1 file changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > > index 784f636244e1..b9b15c5d28de 100644
> > > --- a/fs/f2fs/namei.c
> > > +++ b/fs/f2fs/namei.c
> > > @@ -571,8 +571,10 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> > >   	trace_f2fs_unlink_enter(dir, dentry);
> > > -	if (IS_DEVICE_ALIASING(inode))
> > > -		return -EPERM;
> > > +	if (IS_DEVICE_ALIASING(inode)) {
> > > +		err = -EPERM;
> > > +		goto out;
> > > +	}
> > >   	if (unlikely(f2fs_cp_error(sbi))) {
> > >   		err = -EIO;
> > > @@ -1025,8 +1027,10 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
> > >   	}
> > >   	if (new_inode) {
> > > -		if (IS_DEVICE_ALIASING(new_inode))
> > > -			return -EPERM;
> > > +		if (IS_DEVICE_ALIASING(new_inode)) {
> > > +			err = -EPERM;
> > > +			goto out_dir;
> > > +		}
> > >   		err = -ENOTEMPTY;
> > >   		if (old_is_dir && !f2fs_empty_dir(new_inode))
> > > -- 
> > > 2.55.0.766.g2966f0265a-goog
> > > 
> > > 
> > > 
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
