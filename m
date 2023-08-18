Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4072CC71144
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Aug 2023 13:15:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qWzK7-0005fI-Na;
	Fri, 18 Aug 2023 13:15:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <groeck7@gmail.com>) id 1qWzK4-0005fB-8a
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Aug 2023 13:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nWdua2aNf7LWb8lLYHXUopI0oGNwA2fUkiGeU253kbw=; b=IdSY0aXJkSVwm/UGp88/COpW7S
 7KAkoK100A8NjhpZNchuUKRcYtvXWrwawdd0jdw6UGNLdKLOpQJU+BIuYrKOVeoYBfCoCZMoQ7UBT
 64qkmxcGLFm6Jxfs/3RAT7/b0IIDg0chXexTX1jSNqFXrA7s1LvAO7DtZ2eKTd2um1Zc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nWdua2aNf7LWb8lLYHXUopI0oGNwA2fUkiGeU253kbw=; b=ODq9Ap/0JtV3N+gt+6aI3B2AmK
 kzte8fYPl6lFiApoZkiFBJ1DgtzqzOwp6CuFRQ1DOaENYrqT/k9fFi9dXtSVww//EkROrF1jSlwdV
 lubnNs6hIoZEoHG+pmCKuQsgA2MV3DHiGvl04ICb6hSO3AtbmyWullL9sxb5i74ZR81E=;
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qWzK1-0007vT-WA for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Aug 2023 13:15:28 +0000
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-55b0e7efb1cso691069a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Aug 2023 06:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692364519; x=1692969319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=nWdua2aNf7LWb8lLYHXUopI0oGNwA2fUkiGeU253kbw=;
 b=BryfroQ3BMICHVIBB+unjQhmg8oXJSqd1N4d9pf6fgp9ZZ2KDSQRqGW5L01CMlL7yt
 U19M1+inHDgD0xt28l2iq9eK+KSLfKgmTO4HEeihX8zPL1azOXZmia8XcZlYZxZyIPIy
 RRHWvdKREWQz4bF75Ob+KSm2yQUEVFkvCyPlL4Xug01tnX3zeHywN/QrENNyWamCnjnT
 UsSY7CLSe4B2VowTrBkegvH14LEVEQw0WZyZcZFZxabufFplN9+m1QpG9oTom9hZWGj5
 qfSOKHFpGmIBzofkUg7kWi9uQciugdcF/R4dndxdIedAsVJzjgc64TeHzQD4gJrhg7E1
 l+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692364519; x=1692969319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWdua2aNf7LWb8lLYHXUopI0oGNwA2fUkiGeU253kbw=;
 b=Z0GinNmut8fZNpzxGLYP56x2yoR1QM71wzJCu09whdqAnQpe78F0FDfZBWYNnSNydC
 AithT2jgWbGf82hNyRnjmmXigJZyV0V4yuhfN0eVpk5C2DoKgTg4mdc3acyD5nsBYxAO
 nlYeSo2b6Uk8MjOwRG/CdYxKJXNU62XVRBOk6SEadg2LriY8viJn34axgJUKtWofDLM0
 p7U227zJDEUE/bf96qQMyqLBY/0u2+5xhlJf4ot1+8ksJ3NpvgtKTUXUeLTNfTf8T/7W
 gkxbVuqScfqYIoCbOJbIkuxZqPK0Ltx1pAluzr+OQWsi2NJlALieCYjiS2WBE7jdt2hs
 NptQ==
X-Gm-Message-State: AOJu0Ywg0OkBTOQF8qXUS4WY01Z5tBisnE1qR8ijLhk9bNCbRksrAcZl
 8NPI4ZsK8XA1sqkhAVvU2DE=
X-Google-Smtp-Source: AGHT+IGlYhC2mhoSnb85XKkgHWNCP0YkgGrHPXRL0UBb5wk9pN72pUGHxlyxyaH1hLD1hvwH1P5/Yg==
X-Received: by 2002:a17:90a:4706:b0:268:17aa:8b78 with SMTP id
 h6-20020a17090a470600b0026817aa8b78mr2380459pjg.20.1692364519455; 
 Fri, 18 Aug 2023 06:15:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 7-20020a17090a004700b0025be7b69d73sm1633254pjb.12.2023.08.18.06.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 06:15:18 -0700 (PDT)
Date: Fri, 18 Aug 2023 06:15:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <700c2e58-d2fe-47c6-85a8-aa7f7b1613cf@roeck-us.net>
References: <ae78956b-0c55-4980-8ec4-5cccf7e69c16@roeck-us.net>
 <CAOtxgyeE+PLWVCTMHbr6OgwXY5MB1vPmauY2wcvEZdW8OhM-YQ@mail.gmail.com>
 <93fee6c4-fb2b-49eb-ab54-e77603289f6a@roeck-us.net>
 <CAOtxgychpamcvMDtOcX=ZGsL8WPfYfLAjCRg-YAnEHYDBva+7g@mail.gmail.com>
 <63722b9f-b510-50a7-8839-6ada783d2164@kernel.org>
 <20230817155319.GA1483@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230817155319.GA1483@sol.localdomain>
X-Headers-End: 1qWzK1-0007vT-WA
Subject: Re: [f2fs-dev] circular locking dependency warning in f2fs
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Aug 17, 2023 at 08:53:19AM -0700, Eric Biggers wrote:
> On Thu, Aug 17, 2023 at 10:26:12PM +0800, Chao Yu wrote:
> > > > >                                                     lock(new_inode#2->i_sem)
> > > > >                                                     lock(dir->i_xattr_sem)
> > > > > lock(new_inode#1->i_sem)
> > > > > 
> > > > > This looks fine to me.
> > > > > 
> > > > 
> > > > Based on your feedback, am I correct assuming that you don't plan
> > > > to fix this ?
> > > 
> > > I'm quite open to something that I may miss. Chao, what do you think?
> > 
> > Jaegeuk, I agree with you, it looks like a false alarm.
> > 
> 
> False positive lockdep reports still need to be eliminated, for example by
> fixing the lockdep annotations.  Otherwise it's impossible to distinguish them
> from true positives.
> 

Exactly, and that is why I don't test features with known lockdep annotation
issues. I'll drop f2fs from my list of features to test for the time being.

Guenter


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
