Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9102AC5B574
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VU7znVg5ZePdMf/2fVU17NTFI9ceV97k3aTyjJZ9JIs=; b=NlpoIM56/HwNIesI/mcqhh0QNH
	+4VoqxD/ELtOba5CC7gN5mtwfSbQ6oR2pv42JO8jw+mrDmIzXxp3hEWA2j1lPQ16zFQM9WDqIQ5Gi
	62ezFZAEPumxqQds35ycd5ITd/wEJAmdNWSC2pYzie1j9ek8u1SX6DS9Xdgy8jbIuxYo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wthgm-0007MD-MZ;
	Tue, 11 Aug 2026 08:18:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1wthgk-0007M5-VH
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 08:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rQoYgawLl/uFdgKGximNInLlgWg1ECp2Ql+MmIdl1KM=; b=DjsNEhERdD8eM9+AnLkIliE4gh
 n1I3pWzEUtJRIWmUq3rNIekTypNhdh9gBcQyamzXcruNOTkMcUuANxc3hSUVOY2BGb+wDR3RUpcCx
 N0YaLOK+5/A6V3bZtB3RrsyUYEKn7NbTOdncnVyJ6GJTP+0NFH9ZUWB7dOh04g0GE4VM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rQoYgawLl/uFdgKGximNInLlgWg1ECp2Ql+MmIdl1KM=; b=ZKJ8JkxxelX9CsS62WT0ZWHCWT
 iAPN3BxmcQhpCBIqnaQoD+XypFJQhQ87Xq8rjuM7hrN2/i31WbtHG0f+iPZUi7sZlJYcNsxkyWA/b
 aGpYUxeP8utGe0baiN/9r9CSjc5nzHWOcROaqjgM0mHL4UwWmiSXraJ7GtAFmHBoHvRk=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wthgm-0005er-I5 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 08:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786436290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQoYgawLl/uFdgKGximNInLlgWg1ECp2Ql+MmIdl1KM=;
 b=jGk31qTMZe89vYcLuMtG1w29oh5Txnm9VLlzyTkNm3Pa+A6Hs3LmIVqpzk6aCJKSCVSHOF
 ZX08u9Tdo/pGoR9S45MDsa+weOr+Wf0SpIQrTFJPGqoru8QyDmOmNOR17nz7K4ThLaYpYe
 Lk1eI6MtKN+3gHV+Q9eWuJAvhVPG1x4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-SUe_0_SVOcmGbv_dcI-UEA-1; Tue, 11 Aug 2026 04:18:09 -0400
X-MC-Unique: SUe_0_SVOcmGbv_dcI-UEA-1
X-Mimecast-MFC-AGG-ID: SUe_0_SVOcmGbv_dcI-UEA_1786436288
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4957287363bso16397725e9.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 01:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786436288; x=1787041088;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rQoYgawLl/uFdgKGximNInLlgWg1ECp2Ql+MmIdl1KM=;
 b=gZsty+qOSBwr4eG0lxM6Spafr48X6bUm7WHAT4c8ZP1SZZfkfxaWuv4wXBJBcBhgHO
 qXPwhIqlHTIGasB2fnetbfn7PK9mD0OYoUZFl1ZHywWuv+b35lby9zz305hAiktiAEms
 DN2uh+HTWbRwP/igD0JRN8bun4gThpT3sRReLHXy0lrnuiOaQUA2IseyMNr8qFuaIzlB
 HCeMLVop0gnDPbv4n4OMELxzraHiM2szQJVOTiMGOGqnGVRefkY8KRHmaXPerGFpppqK
 JXQdatOdw+CwZZnoeunrGIEZtx7EMlLigjqsLz8C+unLFJkJ8zwUxbbmtqmzfY5rc7EK
 NpcA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBAz7jVuazXgkQEa6tDcrlbBVSv6EPBFmlJnpbaH4TZmYm+aBbRRBs0NFulHS40gyGc6wa5W7T2E1A1dU4UhTj@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzkcDfyEOAEeQJEyqcbI1jJVZx+UaVk0huI4qjARkEb7C5ALibq
 oT6tgfclIyu6wkUQkzASPSTVEkpewR7tHHNFqTP4vPcbElf6JKmNexan4Y2CHdHhO/bGF6OV4MD
 CM/Kr0QkSyODQhJ6AvHAhwZlB4LWsiAnald5ueEEg4scNviR72TqmGBLhwv/IT2NpNLg0w1wsM8
 uGOg==
X-Gm-Gg: AR+sD13ayj/RpcdyA80pZ/mXLEY0SNvbdp//Qf4NW5OYTAcTQDkzOhYCWBPEDVVG6V/
 a3jZS8ySwMSL5PuA62wkJFqexpruUl9Dwaek5rbyh1QhdxmcZ5Ge9cLo/vOXhNztw8IBaaa0lNN
 eMeDssWGuIh/2pd/QELhn+C3vmx6eyh2/0uF2xOS/7NbVFW5SZtnNNklvpBjw7lsC1F6CIoZAIX
 lt0iskqN6lJFbrdccy2I/eMMVTJh1JtgAOCbSl9J348bg1CvJBoUqoABJUdkmqKgAR78lpObUuM
 80/taf3SA2YXJsfcl8oo5GBTMNTHRbxUmVoaFEnWWQCOnoQFzop4lRIaT0XyL1K8KcE6NR3aN5H
 XmPuMMOZeT9lMzCoADAX/+rSJw6wf3lTFiz6o0g==
X-Received: by 2002:a05:600c:4683:b0:499:5210:c537 with SMTP id
 5b1f17b1804b1-4997842c1efmr23685935e9.1.1786436287859; 
 Tue, 11 Aug 2026 01:18:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4683:b0:499:5210:c537 with SMTP id
 5b1f17b1804b1-4997842c1efmr23685055e9.1.1786436287342; 
 Tue, 11 Aug 2026 01:18:07 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([91.245.205.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788f11b8sm26013505e9.10.2026.08.11.01.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 01:18:07 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:18:05 +0200
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <anrZR9SarXJMBLgI@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-14-aalbersh@kernel.org>
 <20260804183632.GO3556460@frogsfrogsfrogs>
 <anmNNNNy4YsV_KLB@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <20260810183102.GY3556460@frogsfrogsfrogs>
MIME-Version: 1.0
In-Reply-To: <20260810183102.GY3556460@frogsfrogsfrogs>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C6V51EvmV_NGFV-lujbnN9JFf3DngxCwrvE-vddSFpw_1786436288
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1wthgm-0005er-I5
Subject: Re: [f2fs-dev] [PATCH v14 13/21] xfs: use read ioend for fsverity
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> > > "If we have fsverity and block device integrity attached to this bio,
> > > we need to run both validations from the separate fsverity workqueue
> > > to avoid deadlocking due to fsverity issuing its own reads."
> > > 
> > > (Assuming I understand the fsverity && pi case correctly.)
> > > 
> > > One thing I'm not clear about -- why is it safe to do the fsverity
> > > validation here if PI isn't enabled?  Can't that also issue IO to pull
> > > in merkle tree blocks?
> > 
> > Without PI, fsverity metadata is read without XFS bio completion
> > path, we don't get here for the descriptor/metadata reads
> > (see xfs_get_iomap_read_ops()). So, we won't block the queue, as
> > data ioends won't be mixed with metadata ioends.
> > 
> > With PI, all fsverity reads goes through this path. We could get a
> > case that data ioend is waiting for metadata IO to be completed which
> > in turn is pending for data ioend to be finished (due to batch
> > processing of multiple BIOs in the bio_complete wq).
> > 
> > So, this will issue more IO, but this IO will not get onto this
> > queue (it will go through iomap_bio_submit_read()).
> 
> Ah, ok.  Maybe add to that comment:
> 
> "If we have fsverity enabled but block device integrity is not enabled,
> completion of the fsverity metadata reads does not require a workqueue
> so there is no deadlock potential."
> 
> then?
> 
> (Just echoing you to make sure I understand completely.)
> 

yes,

I've changed it to:

+       /*
+        * If we have fsverity and block device integrity attached to this bio,
+        * we need to run fsverity verification of data folios from a separate
+        * fsverity workqueue. This is necessary to avoid deadlocking due to
+        * fsverity issuing more reads of fsverity metadata which would be
+        * processed by the same worker in the BIO completion workqueue.
+        *
+        * Without device integrity, fsverity metadata IO will not use ioends for
+        * completion.
+        */


-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
