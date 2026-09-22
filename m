Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BD2C982FF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KdEWFeWIaYCCZlOeuL3bMkC05NGB5FEM7jVu8mEBDyU=; b=CR60x5gkItTK5CYekgLXTWfezd
	F4Z0JBjUB8kGJXRPKaOo2xn90qbbgSaX9J8UwI1DF6gc7KUQI5nEdh5jg/8VZ4ZkDAZrliqqh9jd4
	LCQlAkvHaWY8L6qlIGzuli4D8FK6chjxhM5J8O1adPqin+PZjiY+VOL1wP2GmBg3dEH0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8wIh-0004Z0-CS;
	Tue, 22 Sep 2026 08:56:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1x8wIX-0004Yo-JD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 08:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ovEqrxQiNC1fApdCYwkn/e/ow08kQkdi30NnfIiXj3g=; b=cupOEnbJHythYnuvdBvJ0IV0Kc
 oOI+RMEq7X2Za0rmsZQxiEHx3q1xRGOti1qc1fyFMerbkE8R5LWcfXhNW/U4dz9mb3h/lBPjW29XK
 t20zhTKTkhEs2yfXFG6oPvEE+0AImG3i+B6my7oI53tuscBiriMOzf/QN3AHtWREPfb4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ovEqrxQiNC1fApdCYwkn/e/ow08kQkdi30NnfIiXj3g=; b=hT3+V5HBPodeA6DN4RhnWiASS7
 x56Rc5GPNESXOPWsNHSoO98fasnuA0vzc7gPs5BGTI/4RS7bqdZvzfVVuiawXAHTvqGzBXezXUMsv
 2XzhU9P4llRpk0vERyrKT0TeH84M2WC7koiBlSyiTan9nfERZ6Ca8n28aEjfoJjY4eOs=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8wIX-0003SE-PW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 08:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790067375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ovEqrxQiNC1fApdCYwkn/e/ow08kQkdi30NnfIiXj3g=;
 b=PoYEMg4xgpD82I1/3VKm5OIVh16Wbys/KxeOlU/iQ98sOKzrjvZJdI4EPX3bx+wKrbO1fS
 CSw/KpoIOYrFVydf7397n9ktvov65gIZ03mBMTfo5p1DQmMLQ8LLc+ie3EHxzZ83KOu74r
 XwVdBz21gpjxJSCh1nQxfojxWt5Lyyw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-3qnd9xuWMcCXXkVfGb4adA-1; Tue, 22 Sep 2026 04:56:12 -0400
X-MC-Unique: 3qnd9xuWMcCXXkVfGb4adA-1
X-Mimecast-MFC-AGG-ID: 3qnd9xuWMcCXXkVfGb4adA_1790067371
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486f52ac21eso2553106f8f.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 01:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790067371; x=1790672171;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ovEqrxQiNC1fApdCYwkn/e/ow08kQkdi30NnfIiXj3g=;
 b=HmxC65/n5pQ2T3mOleiL70M4ijbB2WoAW5/BllHPwdArskURpR4TJV9PJlU97w/uFu
 J4lhsy+AB34gi++U4T4AfkOMxNDB7HZk+DWoDfnU4P65t4h4eyrCaYmEgk4zLrjX5yqp
 nqMBkvO4QZ9G4ZeX6e7Xi5xFaoawAB0aVy5moeRCkkLN0Bh2TV5QA7yv1Fozi69H1bDC
 QkUlYmlSAzeuT2IrU5Z1v+RKoNo7YO8qBTBSw+Yf2hnXc/WQ1pfo+AvEQ9T7zu8WJf8r
 EQG5Nrtwos14tPo9bGhmklsEw9xEK9mRTnb79IwdyTF4ej5Lumb1bDBCpWtKJ2Bt4DCQ
 xPvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3HwAK8nF+82x0bDAKYnLmGqB0xzu9r8x/Ivl2TflD9kXD2glHVGFOJv2cjW9bhf8ri5V9KwWFNszSUrHFZ4vP@lists.sourceforge.net
X-Gm-Message-State: AFuF++lPDBXBr4k3G8W4e/JPXwZt2qEJlmxNtrhRMX6TtS2U6DUEQVN3
 DdnfCdRIH0GdK54y3qPfUhZcmojns4p+AVWvM954XADBjOXZjY0RWAzdTQOWZfuVn1s6bk+bRWh
 cyKEz3HKU1mnHqOi/GKqjrae8PIKiwTQeFa58iCJ6Bqa7o4gHCNUbHaDs9PheNTJFEphZgMztsI
 qldA==
X-Gm-Gg: AYBFou2I1DyJxv1bkJL0ih2hpBsou2R0Z+O1fOsIuhS5KgUKgAAQWTNw0Br78kThxkr
 Lh7i6rdiEdKbXb91TJnI5yO6F6hFc+Rf/R7qor3xlWxbMgqtSOtG4ml0zwH0nEeLAqu6kLT2VhQ
 XYfFN2pLt8zl4+Qw8otmKzvD3T84eplTwC6h7zQM4JsOfX6cB3sIGdTymrQ0M8RsuaSG8/fyXiC
 aVjqSHfp5NDzm0+ibb/RzpUqcX5r5bxdbcEvPsjBGoD3nFfhKCFUJviBf635Yz9Z6Fn1VSmEe6K
 Bwf1t174XdGGcSAQeYGqOeGtShBFdujwUXVM0dco3R7W0Ul4kanKucMw5CiLo1hCKrkZYAWqWMv
 YhKqipL89RPEvKZhUK0w5eLIRKCXh8YV1UA==
X-Received: by 2002:a5d:64e8:0:b0:484:3310:f394 with SMTP id
 ffacd0b85a97d-4871e25c7f7mr20485477f8f.23.1790067370988; 
 Tue, 22 Sep 2026 01:56:10 -0700 (PDT)
X-Received: by 2002:a5d:64e8:0:b0:484:3310:f394 with SMTP id
 ffacd0b85a97d-4871e25c7f7mr20485428f8f.23.1790067370461; 
 Tue, 22 Sep 2026 01:56:10 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862795083sm3236382f8f.33.2026.09.22.01.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:56:10 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:56:09 +0200
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <arI-5Ejg0Xw7OVmH@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-16-aalbersh@kernel.org>
 <arIszDCcy0VbRVFp@infradead.org>
MIME-Version: 1.0
In-Reply-To: <arIszDCcy0VbRVFp@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QYH_2cCLNROHDPwKxDUrw0y4N5mSlBlc4gcsEcN_nIg_1790067371
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1x8wIX-0003SE-PW
Subject: Re: [f2fs-dev] [PATCH v16 15/21] xfs: add fs-verity support
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
 hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-09-22 00:22:52, Christoph Hellwig wrote:
> On Fri, Sep 18, 2026 at 01:15:27PM +0200, Andrey Albershteyn wrote:
> > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > +	xfs_trans_ijoin(tp, ip, 0);
> > +
> > +	truncate_inode_pages(VFS_I(ip)->i_mapping, XFS_ISIZE(ip));
> 
> We can't call truncate_inode_pages with the ilock held.
> 
> I also don't see what this is trying to protect to start with.
> 

I added this to remove stale pages created post-EOF, so, writeback
doesn't try to flush them latter (but now I see that writeback will
fail to map them to extents anyway). Also, if EOF gets extended
these pages would be exposed as they are up-to-date which would be
unexpected garbage.

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
