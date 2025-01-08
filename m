Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E927E7719A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:23:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tVYqA-0004MD-NM;
	Wed, 08 Jan 2025 16:23:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qasdev00@gmail.com>) id 1tVYq9-0004M1-E6
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jan 2025 16:23:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fIlNzfSho9TcO5quuiuSVHCQ+W+FAtjTNaDtG9jzbf0=; b=dGI6kjM9erBHPuqcx2qYYfJW4L
 qkX9WlUSCS8C+t4Dype0YQBymhvOh2PAyLmGiIiwSB+FD24jQDj+spKAyqDcOnm7WssyNHvebiKBD
 DyU/Z0hEPNpj4JE7bBrlzIP77gQJlss6taBCV5wkaU628e7ViRMo7ZK/+aWJCFlz4O1c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fIlNzfSho9TcO5quuiuSVHCQ+W+FAtjTNaDtG9jzbf0=; b=Z
 YBWKNZLiFIIKntUWLYVVkxv96QXiRdL+rdsla2SwfXGMaVuBMGpsp52cSt66WwkN5Z7CTSazXCVet
 aOun8xUUDRlBluJX6Y+Lo+oNtqvBYH5xGJIOKr4a6i+Vqw1CqlXzb0iBAlVKbd7qYxe4+s0VlXHHq
 Dts/WRCHt5L9bwWo=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tVYq8-0007xj-Fv for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jan 2025 16:23:29 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-aaf57c2e0beso221066b.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 08 Jan 2025 08:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736353397; x=1736958197; darn=lists.sourceforge.net;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fIlNzfSho9TcO5quuiuSVHCQ+W+FAtjTNaDtG9jzbf0=;
 b=h6u0sniaTKPZcWRFfsKnuvA0HXk7j/EoS/MsFbbndZoDf1b9LFkJDMBatg+SyvbjtT
 QybJnKbSS7X4FxkcKPJI+v9N1A7vilczrTLQd4gBy3eDVi2R5SoU6tCmdz4HCHcEGEy3
 z5DRSipP5xb61qWrtxpSq80nLSo3F4qWuHPkTfUp+mW0JJBgq2ersbYvBuzWWLYPjqYb
 0dDVV2YevNpGpb+0VIky/Dx/65AlTfFl7BPk84nYFLXBDozzGLeS1CVb7dFbzpWcxA7m
 gBa+Fx592In1srr+CG0OsjS5EgBYVTN9fsUP78nmM7kQ0l8L+IOGSFxDiGZz1OoTb01U
 j/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736353397; x=1736958197;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fIlNzfSho9TcO5quuiuSVHCQ+W+FAtjTNaDtG9jzbf0=;
 b=Ye4mmvS6BaeCFKOkAEBzV+z80l1A/oY194Cmgvvlc7rrLf3ffDw6VAHstKtGtEG7jg
 /kM/nXG2Sv+3QQlRajiUmPhbphPY0Wu9hGo7K1vS1tWXA0jcQ878TqhbCy70n8S7Z6jk
 1fIDubZSbzKvrfXF0JBIvZ14KaCervICki2gqUgZ+WM8gEGBExLoEQhs+iZIf7+0wOUg
 Vv+u+uWQa2Ych/9wGOnhziC4ZT7JRYbmgG/+qEhM0NZpsqSu94zHytQ+qaLFpVj2ZvPq
 /D5l0MQE52S1q3lvVePdjovzrmfls0lYU7OuRubt9rBtLWU71vNRxFzmY3bUoHx8R/Xw
 L0IQ==
X-Gm-Message-State: AOJu0YzVdmkPCovnse5viKW5juGdSJ5QR4i52KHjO+EPYTA7EEZDrqIV
 mfewI9AqoPt7nDBJmfAlj9FYx8EV++nvBCyqmjxM8HMramQzaZa7
X-Gm-Gg: ASbGnctGXImztANlPS4YAmP/QMgR98xszFnodn8YoXlE3HH6KI3ZN7E35VUQ/bDedOh
 63e9XHnFkHXRE5Ftvi2fjUrw8V+mzUNB+mh1nmEISiPXHAyzEMu4t/Iy5SXi9DSkeclD6AQMJMC
 FPKmpOg4OAGHP+sJN0zB6dXV7X0OV+6zAz0nvJG9NMvxAPdZtnfy2Xlt2NCSBGCshXaax2BT/Rt
 eWsEhNUoXX0CvK0chUrrxh0UswVA6XU334sgwGHai5bkt6A59ESEosCK+Sl
X-Google-Smtp-Source: AGHT+IFMW75ZgOq6A/QHwpomDxzzlNhpQUd9+tA5eObmSaAFNrqWOZKQq/JaXK+HRIiJmrN2+CtBxg==
X-Received: by 2002:a17:907:971e:b0:aac:832:9bf7 with SMTP id
 a640c23a62f3a-ab2ab70a69cmr225023366b.24.1736353396649; 
 Wed, 08 Jan 2025 08:23:16 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:397e:3977:a415:a779])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e89617bsm2478228966b.76.2025.01.08.08.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 08:23:16 -0800 (PST)
Date: Wed, 8 Jan 2025 16:23:01 +0000
From: qasdev <qasdev00@gmail.com>
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <Z36iKVJjiufq_Q3x@qasdev.system>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1tVYq8-0007xj-Fv
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix slab-out-of-bounds Read KASAN bug
 in f2fs_getxattr()
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

On Wed, Jan 08, 2025 at 07:44:03PM +0800, Chao Yu wrote:
> Hi Qasim,
> 
> On 2025/1/8 07:03, qasdev wrote:
> > In f2fs_getxattr(), the function lookup_all_xattrs() allocates a 12-byte
> > (base_size) buffer for an inline extended attribute. However, when
> > __find_inline_xattr() calls __find_xattr(), it uses the macro
> > "list_for_each_xattr(entry, addr)", which starts by calling
> > XATTR_FIRST_ENTRY(addr). This skips a 24-byte struct f2fs_xattr_header
> > at the beginning of the buffer, causing an immediate out-of-bounds read
> > in a 12-byte allocation. The subsequent !IS_XATTR_LAST_ENTRY(entry)
> > check then dereferences memory outside the allocated region, triggering
> > the slab-out-of bounds read.
> > 
> > This patch prevents the out-of-bounds read by adding a check to bail
> > out early if inline_size is too small and does not account for the
> > header plus the 4-byte value that IS_XATTR_LAST_ENTRY reads.
> 
> Thank you very much for analyzing this issue, the root cause you figured out
> makes sense to me.
> 
> Can you please check the patch in below link? It seems it can fix this issue
> as well? IIUC.
> 
> https://lore.kernel.org/linux-f2fs-devel/20241216134600.8308-1-chao@kernel.org/
> 
> Thanks,

Hi Chao,

I tested the patch you linked on my machine and with syzbot, and both tests succeeded. The patch you linked works very well.
 
Here is the link to the results of the testing of both patches: https://syzkaller.appspot.com/bug?extid=f5e74075e096e757bdbf

Would it be possible to include me in the Tested-by header and any other contribution acknowledgments you feel appropriate?

Thanks!

Best regards,
Qasim

> 
> > 
> > Reported-by: syzbot <syzbot+f5e74075e096e757bdbf@syzkaller.appspotmail.com>
> > Closes: https://syzkaller.appspot.com/bug?extid=f5e74075e096e757bdbf
> > Tested-by: syzbot <syzbot+f5e74075e096e757bdbf@syzkaller.appspotmail.com>
> > Tested-by: Qasim Ijaz <qasdev00@gmail.com>
> > Fixes: 388a2a0640e1 ("f2fs: remove redundant sanity check in sanity_check_inode()")
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > ---
> >   fs/f2fs/xattr.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> > index 3f3874943679..cf82646bca0e 100644
> > --- a/fs/f2fs/xattr.c
> > +++ b/fs/f2fs/xattr.c
> > @@ -329,6 +329,9 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
> >   	if (!xnid && !inline_size)
> >   		return -ENODATA;
> > +	if (inline_size < sizeof(struct f2fs_xattr_header) + sizeof(__u32))
> > +		return -ENODATA;
> > +
> >   	*base_size = XATTR_SIZE(inode) + XATTR_PADDING_SIZE;
> >   	txattr_addr = xattr_alloc(F2FS_I_SB(inode), *base_size, is_inline);
> >   	if (!txattr_addr)
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
