Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C492CD5BAC
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2026 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZhkiS2RT2b73rXjdk1HG4DVgkBcS1BuMaKAeLqvWCAg=; b=AuYwWoOH+qxK6HA188tDhXeYwC
	7sNJIkJWGS4A/spZ3yCSq49YFZGC/7c61OrsVm+5vRLuqUPhcSenm37lEuWGC4UpRn5N6eG6P0sps
	qIHrhbtkjEHGShjWv8xWim8HmVzA+Iw2/iRoh9bl3fU91po0xC2v7MP7GNkFZLYo2pM8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPzv9-00026u-49;
	Thu, 21 May 2026 09:42:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1wPzv7-00026n-F9
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 09:42:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0WzMLsQukLw8E3UhBm+/KFb/Fo3mZZq0u+Zrumr4RyU=; b=ksiWmWt+RpukxAZCDxS/5jwOfi
 m6toECC1uMu4C8mZK1R52oHPFcrDOzBWadu4GCqgMumBWqyzNFYSbQYohUKTUxEj1uS0bC4QdJwDa
 wrJLgsEgCGRsGC2dDDMMjlY/jPkryDqPQtT2B2bYiyY4JVnVswBCbJRvp3H6/Bymptx0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0WzMLsQukLw8E3UhBm+/KFb/Fo3mZZq0u+Zrumr4RyU=; b=go4CZMICJ3hEx/qPhmJQi4M3Wz
 xdPoFRe+Dp1MhXtkm4T42vE2yl+hKATin7G8zklaXTa53137Ma+yqjzY7Ss3TjYoFY5rZgIWO7ZqD
 YFbIyJLgOiWQSkuhLhb/UiPBYAFxegynMDWpl+LwhRPaJh1uXLB+0aQDg/yiF/qXAvkE=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPzv7-0003qe-8L for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 09:42:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779356539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WzMLsQukLw8E3UhBm+/KFb/Fo3mZZq0u+Zrumr4RyU=;
 b=bGcQDpYvPLEbfBQZC3lTQsyr+3H+rvNlLXE3wyLChrVgz3Apo2altjc2wB8pfFOfDsNfFa
 UadquxiGdIqFnEDcyI2HQZx4+8VlVdn7CmW1otNXES/tIBRVaUSEV1co+/vet7wFiJPgDJ
 a/dekJKAtWfO86M4E3Kz6p0phUb113Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-14S6lH1QMICcZm1ZJSamJg-1; Thu, 21 May 2026 05:42:17 -0400
X-MC-Unique: 14S6lH1QMICcZm1ZJSamJg-1
X-Mimecast-MFC-AGG-ID: 14S6lH1QMICcZm1ZJSamJg_1779356536
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ea38c03a1so598229f8f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 May 2026 02:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779356536; x=1779961336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WzMLsQukLw8E3UhBm+/KFb/Fo3mZZq0u+Zrumr4RyU=;
 b=k8JTbs3qFFHl9Bt37uDC9RfbiZcgM7D1S3NdooJV4ZdJAAWOQYQbf8st/nr0JIoJbT
 eVwqfnug48f2amnpB9P60Yztl8fvzqv3ApT8T7ylYqq0fybuQ+7XSvp8NKQ0aX0+0bqt
 YmUVqxCnAZ3SBTCRcuXnD3N3sUP/dmUZ8WJOKclIsPqaSj9Z3kIz0Rw4O0T/jbE5mmfp
 e3XYE+F147iDocm+frRPpX8ohoDCl+x4YGv4+GalNUz8stB/J0bLi9bZzySiByjZ1qgH
 BBvFG3m9omsIahJfN1lxpFfY/JzE3g6Nyb+fq3duVoGhHSugYEY+0DUHRw+zNm9yQJaL
 ElSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Xcc2T2ywDC9YE94UR7dammb9qQH2gpcfWpbpzes98H+ECwW0wNOVUj4TfaeaR8KE0lyT2TjnQpIItnfE8bMnB@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxfUKILJQ2auEyZVklmshCSbMjDOvL6T39sAem2BPDTHVaepiUM
 1bTIPG+XwCWwTNopk0Pa13r+0QxBFqImtXZEKBTWVXPr3MV11VMGXycc+3Ug4uDB6SkCVfrJQ1P
 /lxr18cbIpmCgEzHUxtsG6FPvrZxbferPWR9E80g2v4mKhQlvCHaKutjdLKL0SsukJypL+qIUMR
 ef5g==
X-Gm-Gg: Acq92OHrOx9H2e8RPZkVEIlRYZoniLD5eKO2jCNQV9JLlUV350ZEdYnPaQibepkWLRT
 ggnZTEz3fjgXHBtPy4vdPjQtDKCIknkY4J/jFgxydqXg/XICXqoreT7BNtCx/BntXVPEK97+t4s
 Q6oTetucLJZFXs7tdLzCnlXv71sfcijPi++L2+pD9+sQdS9YY2hkh5snYng2w0gwk8wdO07/2NR
 Nqvvio0d4TEUVYqLAL7ZcZnfRdwgbSTrxIVvAQwnZ5V8ALMLGtqcNBpmOdakP2Zv8SHfr4Awmbo
 biDmj9EBG7327R5XIXcRHePREK+/bAYOKrq4wPHH4kUysIbOLWA/CrX0DgTY+2xVvesamA9Oc3X
 gLSpoOMIIqo4Y740frxCHz836tyY0oM5xt64vPr6eKHiA8UG0sTf8lbg=
X-Received: by 2002:a05:600c:81c9:b0:490:3cec:52f5 with SMTP id
 5b1f17b1804b1-4903cec55f5mr9775985e9.2.1779356536307; 
 Thu, 21 May 2026 02:42:16 -0700 (PDT)
X-Received: by 2002:a05:600c:81c9:b0:490:3cec:52f5 with SMTP id
 5b1f17b1804b1-4903cec55f5mr9775515e9.2.1779356535822; 
 Thu, 21 May 2026 02:42:15 -0700 (PDT)
Received: from thinky (178-221-68-189.dynamic.isp.telekom.rs. [178.221.68.189])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903c9abbadsm13930015e9.8.2026.05.21.02.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 02:42:15 -0700 (PDT)
Date: Thu, 21 May 2026 11:42:13 +0200
To: Christoph Hellwig <hch@lst.de>
Message-ID: <gcw7zcg6p4s2egpufwizfig72g6ren7jfmuz5mqskkpb7xepww@e3v35j7bk7dc>
References: <20260520123722.405752-1-aalbersh@kernel.org>
 <20260521090705.GA14254@lst.de>
MIME-Version: 1.0
In-Reply-To: <20260521090705.GA14254@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oTkuhSzM-MkennR0paJNrK0DV-FWeo2SjifVSGeYc2w_1779356536
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1wPzv7-0003qe-8L
Subject: Re: [f2fs-dev] [PATCH v10 00/22] fs-verity support for XFS with
 post EOF merkle tree
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-05-21 11:07:05, Christoph Hellwig wrote:
> On Wed, May 20, 2026 at 02:36:58PM +0200, Andrey Albershteyn wrote:
> > This series based on v7.1-rc4.
> 
> How are we going to merge this?  It touches at three subsystem trees
> (fsverity, vfs/iomap, xfs) so some coordination will be needed.

As most of the patches are xfs, it's probably make sense to go
through xfs tree

Carlos, what do you think?

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
