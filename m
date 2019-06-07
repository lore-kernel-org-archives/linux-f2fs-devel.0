Return-Path: <SRS0=GJfp=UG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBE4C2BCA1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:15:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79A720868;
	Fri,  7 Jun 2019 18:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fauD5sA+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="iXW7A6Gm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq4lNXkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79A720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hZJOY-0007CU-6A; Fri, 07 Jun 2019 18:15:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hZJOP-0007Bg-OO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 07 Jun 2019 18:15:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uI3GCW+xvV8vARfjViU9cOCzbpa3M0XtSZe0nK48zrc=; b=fauD5sA+4uKVoa49gb/ojZjCCa
 +eS0FVdXpFIlPqXHrRerypeE+wVJlLG/CmxKwujugXLpurgqeBVvGhmev21PjFxRDIhWxHcNrgJKw
 TfeLHg6cmdoNT5Wx+toQWn00VT48SUNY5E5dz3bYasQVy/+R/BIDLVdzhj89DbAd1P3g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uI3GCW+xvV8vARfjViU9cOCzbpa3M0XtSZe0nK48zrc=; b=iXW7A6GmHCUcxW3AHL55jA1Dog
 xZZcBgXtJz0DL5/FEx1m4rgzqgTJMoh1W+eBybcJ1RQdzBb2UhnrjUkF+T+Nuqkg2hrF6kDJuKmsD
 OmuyY7I3iFxfe1poAxkV0mLOJAUzQtLWzLV4MOTEgbqLId0mwj9+7ULH05yun/T+SH2I=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hZJOH-009VEj-Bi
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 07 Jun 2019 18:15:05 +0000
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D5E0F20868;
 Fri,  7 Jun 2019 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1559931294;
 bh=LxudLXFwIaUztX21uuzZxR9BQPiNn2gcYe1CrVHlIpQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vq4lNXknvXpojbbxwVutq1e98PNZ+2cktRMP5UB2b11YqzlHrohjFwN8gPSG8R5if
 4VqGZgob+EB/5hghf/MtYAXLfyg69xNUfQ8iFxDLxwNOpEoe3brLCVjZNmUqu8LzwM
 z27fVAL1tuQ3twRpu2UIwQgou4aAu0ofhEdWHetI=
Date: Fri, 7 Jun 2019 11:14:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Wang Shilong <wshilong@ddn.com>
Message-ID: <20190607181452.GC648@sol.localdomain>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <20190606224525.GB84833@gmail.com>
 <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Headers-End: 1hZJOH-009VEj-Bi
Subject: Re: [f2fs-dev] =?utf-8?b?5Zue5aSNOiAgW1BBVENIIDEvMl0gZXh0NDogb25s?=
 =?utf-8?q?y_set_project_inherit_bit_for_directory?=
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
Cc: Andreas Dilger <adilger@dilger.ca>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 Wang Shilong <wangshilong1991@gmail.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-ID: <20190607181452.y5fyUSeAVU7OJ0ZEQ4mMSPsMgHzA13rcVyc9LRq5Aw8@z>

On Fri, Jun 07, 2019 at 07:51:18AM +0000, Wang Shilong wrote:
> Hi,
> =

> > --
> > 2.21.0
> =

> Won't this break 'chattr' on files that already have this flag set?
> FS_IOC_GETFLAGS will return this flag, so 'chattr' will pass it back to
> FS_IOC_SETFLAGS which will return EOPNOTSUPP due to this:
> =

> =A0 =A0 =A0 =A0 if (ext4_mask_flags(inode->i_mode, flags) !=3D flags)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
> =

> >>>>
> =

> You are right for this and we also need take care of this in EXT4_IOC_FSS=
ETXATTR/
> this is a bit strange behavior as chattr read existed flags
> but could not set them again, there are several possible ways that I coul=
d think
> of to fix the issue?
> =

> 1) change chattr to filter Project inherit bit before call FS_IOC_SETFLAGS
> =

> 2) we automatically fixed the flag before mask check, something like:
> if reg:
>      flags &=3D ~PROJECT_INHERT;
>       if (ext4_mask_flags(inode->i_mode, flags) !=3D flags)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
> But this might be not good..
> =

> I would prefer solution 1)
> What do you think?

Existing versions of chattr can't be changed, and people don't necessarily
upgrade the kernel and e2fsprogs at the same time.  So (1) wouldn't really =
work.

A better solution might be to make FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR ne=
ver
return the project inherit flag on regular files.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
