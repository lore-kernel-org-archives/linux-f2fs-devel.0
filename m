Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C68C44501
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UYKGkDPhyJTxIkki0aTKZCL93TBev/wtSXzjILVjj/M=; b=AogPUcoCwNwa8lkm0nr8Xj08pX
	+AzF5Jb81+/txTn65hkYVy/GKrwmU2Qc15eO0FjpDelxQcNLIsGyPWgrCIu4f1zrpLxtHHtYNorh1
	TxOrkRKqRKqdiDg6AwZb64mrwCtqh/fOtnPijbkcuY6bT50AiNTQ4OWIle9p8blPHcRY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjBqV-0004ZP-1U;
	Mon, 13 Jul 2026 08:16:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1wjBqQ-0004ZD-08
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 08:16:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qitVlXfkVbLZ19rYAoRnVT8+321wabtilZzFTJ/EX/8=; b=MC6eN3paqcoZBw/nc8ahRoq3Lo
 jDEkTFIrKBzx+3ocOXkq+0FBT2Vux0qFw2PwpEZx9aiSUN7mK07xWFNCqGpgyz//g1EHwB8ZzwM1A
 05Hl6ZuL5JZRqSEW0GyuPoC1H2uhlGGIOaK0wxNctvi/dTzh/QPdcmtZ4PA+pOXotoXA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qitVlXfkVbLZ19rYAoRnVT8+321wabtilZzFTJ/EX/8=; b=ghy4BA/Xrcab2CvzjVEJhKfI0r
 W7/xi3FfVEWhKOEYyK0O0XJtShdoofnRv0EaP6TLM980jAQWrKbH9nUyEJ5XTcL0B09prBvyfubqK
 IJAHAqlh65lkiVFxXaYVifMwFb85fwkbfytjrslwVkv2UZTCU513kgzZE030jkxjNP/M=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjBqQ-0006iF-6M for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 08:16:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783930603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qitVlXfkVbLZ19rYAoRnVT8+321wabtilZzFTJ/EX/8=;
 b=IjF7/HKCR/qjv96qzWsH/k/tx49fge58hjdVAHConhqrDl86W5cPt2iFUp2k1UE/Qx3yxL
 xr4vRNSk3dsg4EUn+pXuvRgZVdXwaVC9u2FU/o9w7vDsMy4mxdw7MeYpxBZ9r2ZvUzr5P/
 lM2yq/fojRNb32FyWCqzGiF1E0S+7Bw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-l-0L2MHfMf6li_u_BGH6ug-1; Mon, 13 Jul 2026 04:16:42 -0400
X-MC-Unique: l-0L2MHfMf6li_u_BGH6ug-1
X-Mimecast-MFC-AGG-ID: l-0L2MHfMf6li_u_BGH6ug_1783930601
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767b782so28325115e9.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 01:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783930601; x=1784535401;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qitVlXfkVbLZ19rYAoRnVT8+321wabtilZzFTJ/EX/8=;
 b=dbXKM2VR0/OHlnu2/uUf02y7mkd3+Rnf0fsGEYzZivzRULS3MJM/lN4L3msEuCXezO
 nLsyEMszyxNX/oC7bzcUptmshzK78ZZ6RtwLEkLy5bpfPyh12NLgmVpR7TIfd0y8zylB
 Z4YNCdla9LLIXjNNsGt58IhyDwKm6nlPJ5PrAVtNWR/iGs4cEcuOgjNgXRDjPhuubCWe
 x7NFxHxegsZTJXW2VeYh6XrwfAtG1/CcB46YxiKdl3Ruej3tD276qAvBPIl/BAHVi67r
 COL32mRHei+gdKLHAIMZJ6tAtzQIJQYzPpPNnm0ZeEmR9uRcxRNNDQ7cdaEYW6zqQE7H
 F4Eg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrA2vGro8YyiyTE3/mRJPcVtYBoiMFnKbamLz3vmjbjHQ0WPOVZpwbE0iwjYPxuH8ZjBi56G3MgxU1mz3Nj5KoJ@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw7naU5PG6IzCMXbO+WmCYtQG85nXGG0bBiFcfZNTd8qUQMF7Nl
 FcpUfPAqZi6sSOInfRdgmx3mQH0SiZGGVxtl1cAMN/HGyWztclZiJUmlkKqNeYwKEXt/Hd4L+dW
 w6kHl4A8TMgAnysNmsJlDC7isuzp+Z0HBlymAX5K0tpIOJKq0zPfRjPJ7V8ehqUNpk8DRwcngTu
 k1TA==
X-Gm-Gg: AfdE7clfkLXsg+G2LX6qnE+2K1X5WQnZPGQEUvxgq2BFXkM1DFpoh4SeH9dfUc0pWej
 CkNP33zhk+54rrrtG32e0NNt4/28eX0KUh7UEgoGir8rYPw2XxUiVW57ZZ8JzXfB/ekiqkKeJrz
 AGasp49Iu7EO/ykJ51WIZ6TqLGM7NynvAGsYN8nzVugk2czzsjIlKwRIl69ohXR0CX1X3IsJIm5
 /vXZnbOMMU6gShst6xdDux1ZRiSb8w7T50G1tZmlgFEHZCaAlTX5SV5PxHY7xlkw3yRIT6Qjj1Z
 caLmyJySJWld0/K51y5A/wbTPt4xex3CUMVejni8wHpXw5ITvm/VgAzhHbT6zVCIx1l+zriLuHi
 5RnEizik2NxF08cxs2/UtCi++Af0yjAlGvqiZrZOck5SuGA==
X-Received: by 2002:a05:600c:674a:b0:493:f80c:5455 with SMTP id
 5b1f17b1804b1-493f87d85a9mr80792565e9.5.1783930600531; 
 Mon, 13 Jul 2026 01:16:40 -0700 (PDT)
X-Received: by 2002:a05:600c:674a:b0:493:f80c:5455 with SMTP id
 5b1f17b1804b1-493f87d85a9mr80792235e9.5.1783930600066; 
 Mon, 13 Jul 2026 01:16:40 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e785sm82014266f8f.8.2026.07.13.01.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 01:16:39 -0700 (PDT)
Date: Mon, 13 Jul 2026 10:16:39 +0200
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <alSdUBiA6n40PKim@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260710085256.3464201-1-aalbersh@kernel.org>
 <20260710085256.3464201-7-aalbersh@kernel.org>
 <20260710234643.GF1911@quark>
MIME-Version: 1.0
In-Reply-To: <20260710234643.GF1911@quark>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oqksOVZmnKwO6ec7P-ELl7RU2a741hG4HahE2mA4IOk_1783930601
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1wjBqQ-0006iF-6M
Subject: Re: [f2fs-dev] [PATCH v11 06/20] fsverity: don't allow setting DAX
 file attribute on fsverity files
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 djwong@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-07-10 19:46:43, Eric Biggers wrote:
> On Fri, Jul 10, 2026 at 10:52:34AM +0200, Andrey Albershteyn wrote:
> > When fsverity is enabled on the file, with FS_IOC_ENABLE_VERITY ioctl(),
> > it checks if file has DAX enabled and fails if that's true. However, the
> > opposite case is not checked.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/file_attr.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > index bfb00d256dd5..5424ec4e3949 100644
> > --- a/fs/file_attr.c
> > +++ b/fs/file_attr.c
> > @@ -246,6 +246,11 @@ static int fileattr_set_prepare(struct inode *inode,
> >  	if (fa->fsx_cowextsize == 0)
> >  		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> >  
> > +	/* Can not enable DAX on fsverity file */
> > +	if ((old_ma->fsx_xflags & FS_XFLAG_VERITY) &&
> > +			fa->fsx_xflags & FS_XFLAG_DAX)
> > +		return -EINVAL;
> > +
> 
> This sounds like a bug fix.  But actually ext4 already checks this in
> dax_compatible(), and the other filesystems that already supported
> fsverity (f2fs and btrfs) don't support DAX.  So I guess this is really
> lifting that to common code?  

yes

> But the existing check is still being left
> in place because it's still needed for ext4 specific flags anyway?

The flag mask seems to be used only in dax_compatible(), but I
suppose this's fine to leave verity flag if EXT4_DAX_MUT_EXCL will
be used elsewhere in future.

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
