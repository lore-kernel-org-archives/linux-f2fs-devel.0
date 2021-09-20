Return-Path: <SRS0=901F=OK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D438C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Sep 2021 22:58:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8C061184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Sep 2021 22:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD8C061184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mSSEk-0001PB-Jp; Mon, 20 Sep 2021 22:58:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1mSSEj-0001P5-DP
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Sep 2021 22:58:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d0Nemd4hHJgSVfWJNr3qQUJaMHliAtJbCFFPWym3UK8=; b=Hx2mv0SdeIfWgiy9I+bgy2VKOo
 +csf7mCQtedtsBkbuoaoAvnPg+T+pa+gIsCr7I0GRGubQtojHotNzMi+ZxTLva0vjI2Acc07Gec+c
 YdWYVZNRrN849n15tz2zwQolDB9RHiDwioBO0JaulYlLah7xzTgTS8hZ2xYF29D3otHM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d0Nemd4hHJgSVfWJNr3qQUJaMHliAtJbCFFPWym3UK8=; b=Xw0Y/ercu3w8uZLrcri8bBhC8v
 aj/aAkc3OFDn3njCY4CEVmQvZtiilsDSY+L1oUBudHcFIbhqC7kub+uZzQxVchd5A6D8wyMBIRi8n
 XyQJ0UnEBlqrGVjhLryRNX+8Ggo7vEZB5euZItVAj2cB2Ps3R+y0SF0Ny0Rgpwx6RBAY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mSSEh-00085J-82
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Sep 2021 22:58:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D02C0610A0;
 Mon, 20 Sep 2021 22:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632178677;
 bh=t32r/UNDAKqQ2H+2kaeKxyON17il0qBt5QdF2iYLzZU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZhosC+o0YPt67CpA3fw8kRB1RXniPzCZesIhuvdeBL+wpXNT4Sl12rr1CFkS9nmbI
 d/EANN9Fmgkf2bjeqEoaQ69Lk0rCKQZ7sBupWl+xvyoBVt5iKUeXYX8MqrTGnpXV0l
 Nm9MHTFMVrSLlj/twxw+Mm+bfJBRjYa3T1MV6IWH9SspASg2DiupGjmxNgTjQnH6jA
 skrE0+DL6T4dB3xXfOwTYXnZn03oHmUQeZjsPN/O0FKqhUIxTToRusKwhCLiP73ljK
 xa3YK3ozMBh78upKlfKDacQOxd2u8gi6mrSjGRvMNUaKyEGrP5Apo51dDt9/duXUEb
 0aRaK/ac7MQ2w==
Date: Mon, 20 Sep 2021 15:57:55 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YUkR84sklj0SgosC@google.com>
References: <20210902172404.3517626-1-daeho43@gmail.com>
 <YTvmhVhLlBPeASHT@google.com>
 <9f4a2954-e8c9-abc5-5df4-a7cec53433a3@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9f4a2954-e8c9-abc5-5df4-a7cec53433a3@kernel.org>
X-Headers-End: 1mSSEh-00085J-82
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
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
Cc: linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 09/12, Chao Yu wrote:
> On 2021/9/11 7:13, Jaegeuk Kim wrote:
> > Wait. Why do we need to add so many options here? I was expecting to see
> > performance difference when getting random segments or random blocks as
> > an extreme case. I don't get the point why we need the middle of those cases.
> 
> I guess we can simply the aging test procedure of filesystem by changing a bit
> based on this patch.

My question was on "fragment:fixed_block".

> 
> See comments in below thread.
> 
> https://lore.kernel.org/lkml/425daf77-8020-26ce-dc9f-019d9a881b78@kernel.org/
> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
