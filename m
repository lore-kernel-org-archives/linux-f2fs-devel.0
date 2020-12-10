Return-Path: <SRS0=2O7d=FO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63650C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:15:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BF123D67
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BF123D67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1knPWu-0008Mu-6Y; Thu, 10 Dec 2020 17:15:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1knPWI-0008Hv-4S
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Dec 2020 17:14:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8WioiudlfHi0LNAC05Olw13O8QdjnERD1vKxVPXzF5M=; b=G/BzvOT78t0i4qulunGzCngWIM
 V3BUBiFF0isslfaJFLtdn+EB7eaOtFUmhWWWimctdw2k4IyL6G1K8tqsodHYsG9SQW0pzGVJLpUmX
 0DkbS9RRZzusqVySaN7M3GZqHtGLrRy/8ohjOxh6pne+uJXyze7GqWMA55yRsA981tYM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8WioiudlfHi0LNAC05Olw13O8QdjnERD1vKxVPXzF5M=; b=Dde54NLKwss460M0n7Mlw5vIaN
 e/yH7RD0zD05/AaRXOR+V21I7NfM7bbTp2dSSZavd7HaLOiaV+J/DLwlmbDpdTuJmCz4qIP++CBKW
 bMtOhpwHCS3OXb5/u4mN8hJfhweS9FtVLDx1SjLe1QmbsYL0G6weTTYJ4k+1e0Ot6MxI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1knPWB-0099U1-VY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Dec 2020 17:14:22 +0000
Date: Thu, 10 Dec 2020 09:14:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607620450;
 bh=C8ZePt3ibAbn2SvFtGU1A5iTKaaZbj+6MMRq98SBmcU=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q+B6oE9CTJA941tPuIKqDfch69S2bGzwtXjWqqHxMMY1IC2xYsk21gF40MBfF0A/m
 r7JKPwAqsgKb1eZJCru3q4/vBWmoiGr/vuHh7fobGmhL65WNS5lTlQwFmz9utnmUCn
 g5q61hhlDSQG9xuMZIXHZIGwsblNfHBRtkBFSBpzNaHFF/KuOEHu5v/nBjkO2ycErx
 pnutbcVdilJl/571kXeF1BwrWCZuIgJZ3wKqgumtfs9/sU3FbGZHM/Q2sFetZbbo3G
 gadWh0H5i9gTLDl/OBCh2xi6JxIGCPFaAyzwDgFzZe86zVas2R5yunRhyAAY5OuqGp
 02eePrqdGorCw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <X9JXYAqaTwdtMABE@google.com>
References: <20201209181322.27932-1-anant.thazhemadam@gmail.com>
 <9e38608c-9fc3-1f94-d275-742facef3db3@huawei.com>
 <8d293b99-4414-1317-7426-79692bbaa715@gmail.com>
 <1215c353-3c3f-0a61-00a3-021f0c2f0032@huawei.com>
 <38c68ef8-4b9b-cfc1-d8ad-cfeb4c2de845@gmail.com>
 <e72ff237-9d9a-2dbe-6a31-65046db9ee64@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e72ff237-9d9a-2dbe-6a31-65046db9ee64@huawei.com>
X-Headers-End: 1knPWB-0099U1-VY
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: fix potential shift-out-of-bounds
 error in sanity_check_raw_super()
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
Cc: Anant Thazhemadam <anant.thazhemadam@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net,
 syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/10, Chao Yu wrote:
> Jaegeuk,
> 
> Could you please help to add signed-off of Anant manually in
> 
> f2fs: fix shift-out-of-bounds in sanity_check_raw_super()

Done. Thank you guys. :)

> 
> Thanks,
> 
> On 2020/12/10 10:14, Anant Thazhemadam wrote:
> > 
> > On 10/12/20 7:40 am, Chao Yu wrote:
> > > On 2020/12/10 10:00, Anant Thazhemadam wrote:
> > > > 
> > > > On 10/12/20 7:16 am, Chao Yu wrote:
> > > > > Hi Anant,
> > > > > 
> > > > > I've posted a patch a little earlier. :P
> > > > > 
> > > > > https://lore.kernel.org/linux-f2fs-devel/20201209084936.31711-1-yuchao0@huawei.com/T/#u
> > > > > 
> > > > Ah well, that's alright, especially considering that your patch looks better.
> > > > Glad that bug has been fixed nonetheless. :)
> > > 
> > > Anyway, thanks a lot for taking time to fix f2fs bug. :)
> > > 
> > > I prefer to add your Signed-off-by into "f2fs: fix shift-out-of-bounds
> > > in sanity_check_raw_super()" if you don't mind.
> > > 
> > > 
> > 
> > Sure, I'd appreciate that. Thank you! :D
> > 
> > Thanks,
> > Anant
> > 
> > .
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
