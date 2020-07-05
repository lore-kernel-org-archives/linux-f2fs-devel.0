Return-Path: <SRS0=wJ5N=AQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07AC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:35:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB51B20739;
	Sun,  5 Jul 2020 20:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="X0/tHYhD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bfM/PmZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB51B20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jsBMa-00030M-OA; Sun, 05 Jul 2020 20:35:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <corbet@lwn.net>) id 1jsBMZ-00030E-V7
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Jul 2020 20:35:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QUf/5hPL5MNJyjRYebrAhPwPUnEr4V6Tco5KAn4B3O4=; b=X0/tHYhDd2emJANgvdqwmMjR2k
 +Kb351ajTLHvDyHX+9ogqJvimzdSo4bDAejx4hvKlemJ1IZmDo7ncqW5lznv5bH372PaPW8/XBhaD
 UZ/WbLQOvZ2jic2xd7gNgF9XprSSw7quXH8Kr9HgXHfB0BM9Ap1R3VzFxC0/TGVfYRXo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QUf/5hPL5MNJyjRYebrAhPwPUnEr4V6Tco5KAn4B3O4=; b=bfM/PmZSDo7rVFqxmqJuoLXuc9
 xEVybifBj/sGR2aeGdp8ss2ZOF76Rpe0vWvB7TC4ictw4wkASTmATn2QLPyKcsFlK3A6gY8cG8OWo
 DrWo2usgnSkmmZC82gFyUNBZViSwv/TcbJl4zOXZXZHjgITABf68EK5/A42IoeV8fbUQ=;
Received: from ms.lwn.net ([45.79.88.28])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jsBMY-00ED6x-FT
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Jul 2020 20:35:47 +0000
Received: from lwn.net (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id DE4F0739;
 Sun,  5 Jul 2020 20:35:38 +0000 (UTC)
Date: Sun, 5 Jul 2020 14:35:37 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Eric Sandeen <sandeen@redhat.com>
Message-ID: <20200705143537.68055b16@lwn.net>
In-Reply-To: <c8271324-9132-388c-5242-d7699f011892@redhat.com>
References: <c8271324-9132-388c-5242-d7699f011892@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
X-Headers-End: 1jsBMY-00ED6x-FT
Subject: Re: [f2fs-dev] [PATCH] doc: cgroup: add f2fs and xfs to supported
 list for writeback
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
Cc: linux-xfs <linux-xfs@vger.kernel.org>, linux-mm@kvack.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, 29 Jun 2020 14:08:09 -0500
Eric Sandeen <sandeen@redhat.com> wrote:

> f2fs and xfs have both added support for cgroup writeback:
> 
> 578c647 f2fs: implement cgroup writeback support
> adfb5fb xfs: implement cgroup aware writeback
> 
> so add them to the supported list in the docs.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> TBH I wonder about the wisdom of having this detail in
> the doc, as it apparently gets missed quite often ...

Good question, but as long as it's there it might as well be correct;
applied, thanks.

jon


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
