Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C60C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 Apr 2022 16:22:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nefl3-0002kZ-4p; Wed, 13 Apr 2022 16:22:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nefl1-0002kS-Jm
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Apr 2022 16:22:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E1I/+YR8ZUop32veMyrU0Qk3F6r/VGY3T9MYhl/Lasc=; b=UV2R9+pohnA+fMWt5rh906lFG1
 L8LWvcD8wLwryYVPHljMIKQo5SIz9yZMYAB92npANxnmbNNUjigfuxrBbsLStuBCuCNhQGNPiqZYv
 Retw39rE6va6FCJGNl7doyfJgjBl8Wi6UzhDzAsgGZPtFZ55rKfD5nCpRoRcfM/2H2pQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E1I/+YR8ZUop32veMyrU0Qk3F6r/VGY3T9MYhl/Lasc=; b=RGfrwnJmn2wWtKVrlaNvn8GaM5
 t/+6Fuks2SW6gIxixzxR3nPhTyzoXpHmRZA6k038rb5TREqfIgkEhNgb4lq85M2H+OOQzsP/v6paU
 e+rQ0Pc81bUdA/PbCRtpM6I4SISUPGA2Y7xl726SGuDahoa10rkk6Ek3U/aQTZiz2GsE=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nefky-0003cD-SM
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Apr 2022 16:22:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8DD4EB82191;
 Wed, 13 Apr 2022 16:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009F1C385A4;
 Wed, 13 Apr 2022 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649866925;
 bh=VZDR59+DeUqrH5i0jXdVwBwkcBAts9Ory0mSf3AlUFI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UMPyfE6RFVZ25PB6fZ5zd6Hdk1kiSEqV8iWixosINFJMqX1FOJWm1OYKOw6QnNaLE
 NRkWY9Z+B/XH3YVQSriaBIwzhFhLjMe02TI+J4BgV8h9j0z2N+2w15IwYYiqRZMF5k
 1GjPCFaWlVvuIUOmoC4LID8gDGDPNLM9K/aR0qzal1E/0FJ/KnAz4j4E9NzRVZjrK0
 N1QD3h/T96qhPXLQ9zIRMIBQmk7lpB8evwoCRCvlE0WKRIuA3ACF7m7T7nAn5rzPgI
 eG9Vb2mz8G2ws1B4C1P+HGv+mB+OzlUs59oqrDJ8TP2uXK164GvTTAIiyAQV766ba1
 YoaQfhAvnV8qQ==
Date: Wed, 13 Apr 2022 09:22:03 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Message-ID: <Ylb4q4MKk/07Mwne@google.com>
References: <CGME20220412112746eucas1p14f52961641ef07fdc7274e75887da9ad@eucas1p1.samsung.com>
 <20220412112745.44108-1-p.raghav@samsung.com>
 <YlWp468pKUrRLFTH@google.com>
 <5a86b90d-ec5d-6c83-e8dd-0ced976059fe@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5a86b90d-ec5d-6c83-e8dd-0ced976059fe@samsung.com>
X-Headers-End: 1nefky-0003cD-SM
Subject: Re: [f2fs-dev] [PATCH 0/3] f2fs-tools: return error for zoned
 devices with non power-of-2 zone size
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
Cc: javier.gonz@samsung.com, Damien.LeMoal@wdc.com, mcgrof@kernel.org,
 pankydev8@gmail.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Pankaj,

On 04/13, Pankaj Raghav wrote:
> Hi Jaegeuk,
> 
> On 2022-04-12 18:33, Jaegeuk Kim wrote:
> > On 04/12, Pankaj Raghav wrote:
> >> F2FS only works for zoned devices with power-of-2 zone sizes as the
> >> f2fs section needs to be a power-of-2.
> > 
> > The section size actually supports multiple 2MBs, not PO2.
> > 
> Thanks a lot for the clarification. I will remove this statement in the
> next revision.
> 
> I was partially misled by [1] where it is stated "Segments are collected
> into sections. There is genuine flexibility in the size of a section,
> though it must be a power of two.".
> 
> Just FYI, when I did a quick check, there are some assumptions in the
> zoned support for f2fs which assumes the zoned device size is a power of
> 2 such as in the __f2fs_issue_discard_zone. So if I am not wrong, when
> we remove those assumptions in f2fs for zone size, then everything
> should work fine provided the zone size is a multiple of 2MB. Am I
> missing something here?

All the implementaion assumes PO2 by block layer in kernel, but basically
f2fs could support 2MBs. So, I remember there's no PO2 check in f2fs as such.

> 
> I am new to f2fs but is there testsuite that I can run for f2fs apart
> from the two tests listed in (x)fstests?

I usually run 1) full xfstests, 2) loop of fsstress + shutdown. You can find
a script here. :)

https://github.com/jaegeuk/xfstests-f2fs/blob/f2fs/run.sh

> 
> [1] [https://lwn.net/Articles/518988/](An f2fs teardown)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
