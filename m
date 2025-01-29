Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6903FC02190
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jan 2025 15:42:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tdACn-00024p-Sp;
	Wed, 29 Jan 2025 15:42:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <mchehab+huawei@kernel.org>) id 1tdACh-00024f-7D
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jan 2025 15:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KtwLUm4ss8InPqHFXRIa43dw74xrqf2eZ5aONDws8Ng=; b=d6ENE0d8k9uc/KPelMA7c/b+TY
 dxSY8DZagZqfYAfm5DgHHFyhgqEhr1Vrd0oobkJEsraWhe7mNZhCy56uc4RIjhve0JWldbVoQKgVs
 SMxV1eAZx93giTQfAviwPsJzakTIWGiHwCwwmrJly4d1+McX688FI7/G6+23B5FHHeII=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KtwLUm4ss8InPqHFXRIa43dw74xrqf2eZ5aONDws8Ng=; b=AvDIL4QKsSzoIJyNNPYOhckFU3
 XUJ34W1OlIz3f68TqMYhv4GE95FfTXTGiOInkOdwHd3WL5JQLWOrt5cGYxkHno7hyoFxvgoNua8gm
 0lfP5Nx+XendmR640I3/U8shUrhrzdg9X9RqZu2IB4gyrc4U+EjWDfgoxnRWwlQs+QSw=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tdACg-00070b-Mq for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jan 2025 15:42:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4183DA41A26;
 Wed, 29 Jan 2025 15:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60928C4CED1;
 Wed, 29 Jan 2025 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738165324;
 bh=GplWvWETMezm9d36v4eAfoqt/au1TivnkJ+SWeO2lSg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aU7xY1/zYzJuaW6w9rNm1ubl5Xt+CWFtHsWN2RKDfRYDVbS6hoIF9qvqRPP/jdC+o
 n9sc28S2gI6BwQGNNkViJtfEuGMgf8yXViqR0bVptbi1JGdt4uZpDL3rC+zLYdD2R2
 LvRr+oYrBTHfe0N1TI7nLfb3oLUOcNMk6jlIoAg5MOCpNzo+MotUd8JaUv3wKoon4l
 tuVdgnNv0djOjt6DKfIc7gmEm0g5OKUWFx4Yfktshh9bhs5uK1rRKp5QLYBX+v7URg
 lc1VdYMtw06mrr+76GOR28iAJW7U2ehBlI2qXh9oSISs4oV4/EZifWpzvEERxf1Lkt
 yXZsdTh95S+vg==
Date: Wed, 29 Jan 2025 16:41:57 +0100
To: Jonathan Corbet <corbet@lwn.net>
Message-ID: <20250129164157.3c7c072d@foz.lan>
In-Reply-To: <87h65i7e87.fsf@trenco.lwn.net>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
 <87h65i7e87.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Headers-End: 1tdACg-00070b-Mq
Subject: Re: [f2fs-dev] [RFC v2 00/38] Improve ABI documentation generation
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
From: Mauro Carvalho Chehab via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-usb@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-hardening@vger.kernel.org,
 workflows@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Em Tue, 28 Jan 2025 15:42:00 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> [It's probably time to raise our minimum version again, especially now
> that current Sphinx has better performance.]

Last change was about one year ago, so it sounds fair to also
change Sphinx minimal version with about one year gap. What we have
currently is:

	2.4.4: minimal version
	3.4.3: suggested minimal version.

Looking at the relevant release dates, we have:

	Release 2.4.0 (released Feb 09, 2020)
	Release 2.4.4 (released Mar 05, 2020)
	Release 3.4.0 (released Dec 20, 2020)
	Release 3.4.3 (released Jan 08, 2021)

So, the ~one year gap is what it takes to raise the bar from 2.4.4 to
3.4.3.

In terms of Python, we're currently at 3.5:

	Python	Release date 
	3.5	2015-09-13
	3.6	2016-12-23
	3.7 	2018-06-27
	3.8 	2019-10-14
	3.9 	2020-10-05
	3.10	2021-10-04

	(according with https://en.wikipedia.org/w/index.php?title=History_of_Python) 

Python 3.6 is the first one with f-string support, with is something
that most Python programmers use those days. So, IMO, that would
be the absolute minimal version we should pick.

Yet, IMHO, we should aim to be backard-compatible with the tools 
available up to a certain date (Jan, 2021) - e. g. we'll aim to
support at least a 4 years old toolset for documentation build.

So, I'm proposing to change the minimal requirements to:
	- Sphinx 3.4.3;
	- Python 3.9

By setting Sphinx minimal version to 3.4.3, we can get rid of all
Sphinx backward-compatible code.

I have already patches with such changes for it on the top of this RFC. 
Will send it shortly as RFC, aiming to send the final version after -rc1.

Thanks,
Mauro


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
