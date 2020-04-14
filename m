Return-Path: <SRS0=IxPS=56=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D97CC2BA19
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Apr 2020 14:09:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E6E20578;
	Tue, 14 Apr 2020 14:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PjEDjJyK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JHP2sKkm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpYySLlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E6E20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jOMFY-0001I7-0E; Tue, 14 Apr 2020 14:09:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jOMFU-0001Hr-L0
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Apr 2020 14:09:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3ByPDOuB813abw9IMY/T0f1UZmK1JD+i2M/x5NAslTo=; b=PjEDjJyKccPIfbmrKZm4Gp+CL5
 2nZBtLxsw/YNh23OgmJsu64Tt/NH836nDhJPpmue57KAfKp/bMOD+jbzVPsUzye+4JvmkurBc9M9M
 0M9/Ugfs30F7RooFMjI0QxQ8+IjdFSmbsBqGTOXfeBZ6v76i3vVEKAc1pvQYyfpr3gS8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3ByPDOuB813abw9IMY/T0f1UZmK1JD+i2M/x5NAslTo=; b=JHP2sKkmckokUJiB2HkPq8d8F4
 QFAmp/3UZqmsVvvTR8yb5UuZBTVpvF5rjDVTNxHiJEJisXaS2EdBNY8T14JZdXRzyeffM9FlcbhHl
 4fLVkY9l+b4j3U7jGeUnYRUGb46ePuJLtwLB93qi2Oc0JaXnbpJ6MWoxUS8fEYHSYtC4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jOMFR-00EjyR-UR
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Apr 2020 14:09:12 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4968D20578;
 Tue, 14 Apr 2020 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586873344;
 bh=iXnCqftxxwSZjM/fI9fk8C7dkHJQr+n8AyLdmpFYOR8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mpYySLlSZz6rLquXQVEKgafZJwkbbcf22rRWobPftFGYZAyLXaGzcy57iXxKlRPPO
 /i6d+WnNODbNYmeqLxFAkYOEo3S3iduPryKVYXyauVaNxn4WEOzrZi73SFytdhDa8o
 iadEspjtGDImIgeSMMBVaJBFOIhy8FNnW1hGui90=
Date: Tue, 14 Apr 2020 07:09:03 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Tim Walker <timtwalker@outlook.com>
Message-ID: <20200414140903.GB69282@google.com>
References: <BN6PR02MB3379134F5821A8D6995E3084DEDA0@BN6PR02MB3379.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN6PR02MB3379134F5821A8D6995E3084DEDA0@BN6PR02MB3379.namprd02.prod.outlook.com>
X-Headers-End: 1jOMFR-00EjyR-UR
Subject: Re: [f2fs-dev] [question] ZBC/ZAC Offline/read-only zone support
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
Cc: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/14, Tim Walker wrote:
> Hello-
> 
> I am trying to determine how f2fs handles an offline (or read-only) zone when it is backed by a host-managed SMR HDD. I haven't been able to find any specific code path that places an offline zone into a separate list, or a path that checks the zone condition. Do we support a zone going read-only or offline? Thanks for the info.

Which scenario do we need to see ro or offline zones? Can we expect some
when mounting the filesystem? Or, does setting a zone to readonly happen
in runtime? If we detect them at mount time like former one, we need to
treat the discarded blocks in the zone with unusable space, and set
allocation bits to avoid GC.

> 
> Best regards,
> Tim Walker
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
