Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CA8C021BB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Feb 2025 17:57:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tmzBT-0002Bh-T1;
	Tue, 25 Feb 2025 17:57:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <carnil@debian.org>) id 1tmzBI-0002BR-CN
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Feb 2025 17:57:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q5fDlV41NdUg8Tmn3xh6VSQpPDs/TFWxiv7c4L0YZLE=; b=Ay7Yh+O3eTzeit7kMc+L8OLzJ2
 N6p4d6BgC6ojKzAqBgCT5T1Or13caIR32umwXY6pEAzyyaaJ8F49ojZUehRkeYyh3JMqggS/Ydkgy
 IW2/pwHuSnly5GzBqddopY7CzpcWEwRdwdSSv4Yey/cNT7WbKuFP9W0ouGix+a5pMmr0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q5fDlV41NdUg8Tmn3xh6VSQpPDs/TFWxiv7c4L0YZLE=; b=PzszO1CnRlSxx8HULngxHvoLw0
 7cb9MzPpgZmvJfWSNrCBd9ITpmzlH2DYQcIQjXaqVBd29g5nPUf/Dv6PJW9n2peSTPogKnF7lgif4
 1ME45R9w2147ZlXUulbqj1cTtGmEuV8auKvn/HI2viXzU3ZN7RnBBHjdneSaXCwvisJk=;
Received: from stravinsky.debian.org ([82.195.75.108])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tmzBG-0002Dp-VW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Feb 2025 17:57:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=q5fDlV41NdUg8Tmn3xh6VSQpPDs/TFWxiv7c4L0YZLE=; b=ZZpmhTqukx8yOC5UID7p+j/Wr4
 /xyFQQRHc4xo42P7nu0wxlp8PhOrg9dmzpeyOP7zW7vDi0j87rNWfR8a/UF3wm7ZL+weqf/FC4KcG
 Bj9fp9glf6IT9SE1cxEmzmHBciY5sRG3YFUCWDKWWFvbAMq/nEHoQ9jDyxtVNFhvZ3+rIcVbrrB2r
 IsfeqgaOmfhkx25HH5PazFSY8W0c2M/AFqdQHemT+W1LLLvvk5J7AScKnLap8IvVZta4mYKdUOi9w
 tprcu1csxJoBgLL8oAHp8xhs6Nria1+y5Eh5FqquJ+pbFKN4g1TGT5kLq9Y5F9g8NomKpt6B/KpUw
 dPyL/2tQ==;
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <carnil@debian.org>)
 id 1tmzB1-001Lcg-Ra; Tue, 25 Feb 2025 17:57:04 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
 id E1B05BE2DE0; Tue, 25 Feb 2025 18:57:02 +0100 (CET)
Date: Tue, 25 Feb 2025 18:57:02 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Message-ID: <Z74EbpqwFwwelUi7@eldamar.lan>
References: <b022c507-9bfe-b080-4247-2cb5b76a181d@arcor.de>
 <584c3164-0ebc-4402-bc84-6fcb8fc9aa80@arcor.de>
 <b022c507-9bfe-b080-4247-2cb5b76a181d@arcor.de>
 <Z7oW1khuNTx-jIw-@eldamar.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z7oW1khuNTx-jIw-@eldamar.lan>
X-Debian-User: carnil
X-Headers-End: 1tmzBG-0002Dp-VW
Subject: [f2fs-dev] >= Kernel 5.19 reports corrupted f2fs without apparent
 actual corruption
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
Cc: Heinz Repp <heinz.repp@arcor.de>, 1021927@bugs.debian.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi

I do realize the subject was badly choosed so replying again with a
better subject. The downstream Debian report can be found at
https://bugs.debian.org/1021927

On Sat, Feb 22, 2025 at 07:26:30PM +0100, Salvatore Bonaccorso wrote:
> Hi Jaegeuk, hi Chao
> 
> We got the following report in Debian (cf.
> https://bugs.debian.org/1021927) and quoted in the following:
> 
> On Sat, Feb 22, 2025 at 02:44:07PM +0100, Heinz Repp wrote:
> > Since kernel 5.19.x this bug is present in all newer kernels, up to 6.12.12.
> > On every boot, it prints:
> > 
> > > Info: Fix the reported corruption.
> > > Info: [/dev/sdb4] SanDisk SDSSDHTI
> > > Info: MKFS Version
> > >   "Linux version 4.3.0-1-amd64 (debian-kernel@lists.debian.org) (gcc version 5.3.1 20160101 (Debian 5.3.1-5) ) #1 SMP Debian 4.3.3-5 (2016-01-04)"
> > > Info: FSCK Version
> > >   from "Linux version 4.3.0-1-amd64 (debian-kernel@lists.debian.org) (gcc version 5.3.1 20160121 (Debian 5.3.1-7) ) #1 SMP Debian 4.3.5-1 (2016-02-06)"
> > >     to "Linux version 6.12.12-amd64 (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc 14 (Debian 14.2.0-16) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.90.20250127) #1 SMP PREEMPT_DYNAMIC Debian 6.12.12-
> > > 1 (2025-02-02)"
> > > Info: superblock features = 0 :
> > > Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
> > > Info: Segments per section = 1
> > > Info: Sections per zone = 1
> > > Info: Total FS sectors = 233906176 (114212 MB)
> > > Info: CKPT version = 4b0b40
> > > Info: checkpoint state = 42 :   crc orphan_inodes sudden-power-off
> > > Info: No error was reported
> > > [   10,619367]
> > 
> > First, there is a reported corruption. But then, it says "No error was
> > reported". That's a little bit crazy. This came up with kernel 5.19, without
> > changing f2fs, but maybe this bug lives in f2fs?
> > 
> > Greetings
> > 
> > Heinz Repp
> 
> Does this ring some bells to you?
> 

Does this ring some bell?

Regards,
Salvatore


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
