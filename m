Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C7BC982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IcUhaGsuA5HVk4ppQQ8VxqlBiY+vVtKdH8TmHQu7ao0=; b=XlLxOxyDCa0EKi3lOJeo8RSe4i
	Djvc7QzXY+dFzYZX/CfNpWyBy/XDpihQZ3T/G9bfl4MzmHprUW37aOb/IfGiICS/iDixil0O8rVBI
	y5j6zSogP0TbFzlbHz3Hwj38MlLPEZ3WEfXbHy0VHfc/XkUmHppJSheZfEWaM2zkl6ww=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8wZp-00006i-RW;
	Tue, 22 Sep 2026 09:14:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1x8wZo-00006P-GZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:14:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o4baz/6RzxjMCiX3WhcQq7uKFgXpKloXgi45FkMIoFs=; b=h35LOX4bFSzKjp6mffb7fcwo9c
 SLk2tCR0M7oRacZzagelHqGxFFBjPGP3e21uF1oMBvBlgZOw6I9fFx/r3/S1xZaaQNfW4gTIW5mKQ
 jvbFR2UWl3qgU3wrpFKRQGmBiwgJT+kdLh0VRkm3oeToMcDBcL+fz+vJfT9PZBOUPpmc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o4baz/6RzxjMCiX3WhcQq7uKFgXpKloXgi45FkMIoFs=; b=Chv0RGdgtVn/3k6pDycTq+LEJM
 ugzeP6TjhU3JIJNYa/rjD0FNcxIQn75dwAUiwtdhNKAf7uIrztBvbf8zQyApUNe7qqnBgEMditfSc
 Sekvg56JASgFm/gySTP/V5FvP/uXtwxWoEEakzmhc4Ewl4+mbFWP/Ur2LjJiV8sFJxVI=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8wZk-0007xB-EH for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:14:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790068442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4baz/6RzxjMCiX3WhcQq7uKFgXpKloXgi45FkMIoFs=;
 b=hV6zEvB9MV/3PE4+QjdWGdmy0XXPOKBVCJnmXFQ5JOXrGbDHeFWLPGTHqjxzbMaFja+Ihr
 MjApVfll9zcmaBufKgbyUckoVzu/5xbUJ3pM20+X/W7nYa3AsaCcpdeUN3FAIiMnFr1eWf
 V1fbIQ2Q4VxLadoS2/tuwaz/3Gly6mk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Uj2UcjVaNNeKY52eFm7AJg-1; Tue, 22 Sep 2026 05:14:00 -0400
X-MC-Unique: Uj2UcjVaNNeKY52eFm7AJg-1
X-Mimecast-MFC-AGG-ID: Uj2UcjVaNNeKY52eFm7AJg_1790068439
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e735659b7so31212325e9.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 02:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790068439; x=1790673239;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o4baz/6RzxjMCiX3WhcQq7uKFgXpKloXgi45FkMIoFs=;
 b=ydmTuc3Mctw05h55zXVh1CIa/i2HFRgHRku9zTZkj3Ku/qoSE0qfiMULAlIqPAkAcz
 W/2NMwaP0ujkmqQAF4xNDgepap95U4j9z9A24IjkvfCGAOP1ibPNItiCRVtdAl6mcqvE
 gu8EteTJnLSqJr8n8CG+T87me6x4F50870O8LzDLmiQ2FggEnJAQocub23SC0zU+FW4i
 PoRhnmjBzpL0WynsyoE0J/s6rfEsNLUCekrTQGTsDHdW8gnCRHWf1ykOyBWr8qez7Gyn
 vPq6QZylMG13hpZbHHZf8Sz+5zPJ8KLASAS8sXrof3MF/DPF7Q7czPaLJXoDzC4AhPH1
 TzsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBygqlUd5ZfARtnocGyiFJaNSfQwrbtdLabhix/MuRIdrw2g4E0ZlZvGZxQcrxQKURgEi1yJMe8wi42lNoA6GE5z@lists.sourceforge.net
X-Gm-Message-State: AFuF++m51yut7duE6yokqnifePswc7AE4/zlw7wWaJcweZuBUjIy5/em
 kSQHjuP6nBQy1OPPX4eMPAzOS1A59/sDSy1HM5N3zKAdFyaMCxsYERoxdqcV77cmDmK2cA1Lmpj
 9wzCEA2dN0g/FFu67hTGKhyNmGCU5+k/LvfGWfgTM5gIcyWwlCDumPEIrpK6dCC80qktkK7T/sR
 Ar6Q==
X-Gm-Gg: AYBFou1MIBHrqUVMhBnveAndJFdQgShjKXrRyGsbO6Q7ilDSIoItZluDV4zWan9QPO2
 xnnzitrfj1Zf1fx2KAeo7uAn8VT7hTrr++D5dgVYazDJ++nKMCH2mFjK+aRkgImBvwZ+fk7gUQY
 GC+vdt/opRcez3lzc8AXnyEgX1rms0FjIXti8yphJKdWZ1IdXw2jUU54LuwiLr0HWrhTFuL9K7f
 t0Paej+ic2ob1EjmdJEhWhKtvrnLvWHIknfO8iqf0J1+0RsYaZcuzXwO1MMZlWq2BOWH2g48DMx
 Y+Ca9hNCLd+H/wGT6TgygE6kL41PM4GyHNt8YNU9vpagtJyx/OuogkmsWzZQiEAJNph7+aUtS/d
 4/kUVpZaycsAbmBik16ldpfk+9ufgmXcjGw==
X-Received: by 2002:a05:600c:46c7:b0:49e:7a00:b9a5 with SMTP id
 5b1f17b1804b1-49fc56dbb20mr184454715e9.4.1790068438835; 
 Tue, 22 Sep 2026 02:13:58 -0700 (PDT)
X-Received: by 2002:a05:600c:46c7:b0:49e:7a00:b9a5 with SMTP id
 5b1f17b1804b1-49fc56dbb20mr184454405e9.4.1790068438389; 
 Tue, 22 Sep 2026 02:13:58 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaa4e47csm74372105e9.1.2026.09.22.02.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 02:13:58 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:13:57 +0200
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <arJFUV3WDkY6zmfD@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-13-aalbersh@kernel.org>
 <arIrtgZ3-9zNuru_@infradead.org>
MIME-Version: 1.0
In-Reply-To: <arIrtgZ3-9zNuru_@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N1RqYMZlpdpGEz2UEJIYlAbU0Uu3dgq4-lUz0mUr0eE_1790068439
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1x8wZk-0007xB-EH
Subject: Re: [f2fs-dev] [PATCH v16 12/21] xfs: use read ioend for fsverity
 data verification
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-09-22 00:18:14, Christoph Hellwig wrote:
> On Fri, Sep 18, 2026 at 01:15:24PM +0200, Andrey Albershteyn wrote:
> > +	if (IS_ENABLED(CONFIG_FS_VERITY) && !error && ioend->io_vi &&
> > +			xfs_fsverity_is_file_data(ip, ioend->io_offset)) {
> > +		if (ioend->io_flags & IOMAP_IOEND_INTEGRITY) {
> > +			fsv_ioend = kmem_cache_zalloc(xfs_fsverity_ioend_cache,
> > +					GFP_KERNEL);
> > +			if (!fsv_ioend) {
> 
> This needs a mempool to be deadlock safe.
> 
> > +				iomap_finish_ioends(ioend, -ENOMEM);
> > +				return;
> > +			}
> > +			fsv_ioend->ioend = ioend;
> > +			INIT_WORK(&fsv_ioend->work, xfs_end_fsverity_io_read);
> > +
> > +			fsverity_enqueue_verify_work(&fsv_ioend->work);
> > +			return;
> > +		}
> > +
> > +		fsverity_verify_bio(ioend->io_vi, &ioend->io_bio);
> > +		error = blk_status_to_errno(ioend->io_bio.bi_status);
> 
> And I think you always need to do the offload because fsverity can
> synchronously read metadata.
> 

hmmm not sure what case you see here.

Without integrity:
For data reads we get here. Here, while verifing data page, fsverity
requests reads of merkle tree pages which WILL NOT go through this
path as no read completion is done for them.

With integrity:
For data reads we get here. Here, while verifing data page, fsverity
requests reads of merkle tree pages which WILL go through this
path as they need integrity verification on the read completion.
Therefore, to use this workqueue for merkle tree pages integrity
verification we offload data block verification to fsverity
workqueue.

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
