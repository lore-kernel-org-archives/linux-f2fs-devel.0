Return-Path: <SRS0=AzvF=E5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCED6C2D0E4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2020 23:30:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFF420717;
	Mon, 23 Nov 2020 23:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Y8X1Hd08";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="KyJ7YhiR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DX9OYx+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFF420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1khLHr-0005ef-7M; Mon, 23 Nov 2020 23:30:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1khLHp-0005eR-Uv
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Nov 2020 23:30:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fkLJak7DiWMIYyaoejg7zVt1mIt7FXcH0PopttQU14w=; b=Y8X1Hd08G3zN1uv+2oMiYmLU5d
 Q4UONfGfC6WHd9DynC/SkMImL1Z/32HSEYcev42GfkhNwuaYzKGrT3ktDeFYz5XF9jabAHne1q/1a
 nk1UJZHhv6vtKSv1fIU0Vgp4Mvyw+5A8pNhyQc3jFatN8BpstHec67rx+uvLJY1quAX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fkLJak7DiWMIYyaoejg7zVt1mIt7FXcH0PopttQU14w=; b=KyJ7YhiRz2Je1N5mFnXiTeSw0O
 pmzaAA1FmZu68Vm2/rQuFGd+CUa0LAitr1KowNsgc5Gyz+TDNSUXP/XXkEqF20bmBbBi1JnainC/G
 UiTJhKAVwq4z343O5e14+yYbdw3vBe8D5HMLdc/pTqKAS5Mc/IZI6AotR1DcuPjIlaBM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1khLHi-001Fb4-Ec
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Nov 2020 23:30:21 +0000
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net
 [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CCA3720717;
 Mon, 23 Nov 2020 23:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606174196;
 bh=shHEZAcsfJx7Tv0vz0iSz7SQorKsGx54gtCekwl4J14=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DX9OYx+yUVf++0Ni+ebQf3EyOiDt/8qqb9L/Xcd3gEXOZXc+TOCb424vDJpetNgpG
 cjdP6AZlmx3D3C/LLeUSF0mLFUkpd9M2Mlt2ZnCnN96qxIc3wk98MQbDjSv/yMHPmf
 YS9VdrEwp0jfrT3zO9s84zIZNPkwo0+fUSGr6PDU=
Date: Mon, 23 Nov 2020 15:29:55 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <X7xF8+jko5d71CKq@sol.localdomain>
References: <20201123031751.36811-1-daeho43@gmail.com>
 <20201123031751.36811-2-daeho43@gmail.com>
 <20201123184821.GB3694916@gmail.com>
 <CACOAw_xEe=3H60njSfwJSToFnVbOHabUd2Nt=uZJLvCfxFgM4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACOAw_xEe=3H60njSfwJSToFnVbOHabUd2Nt=uZJLvCfxFgM4Q@mail.gmail.com>
X-Headers-End: 1khLHi-001Fb4-Ec
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and
 F2FS_IOC_COMPRESS_FILE
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Nov 24, 2020 at 08:02:21AM +0900, Daeho Jeong wrote:
> Jaegeuk,
> 
> My mistake~
> 
> Eric,
> 
> What I want is like do_page_cache_ra(), but I used
> page_cache_ra_unbounded() directly, because we already checked that
> read is within i_size.
>
> Or we could use do_page_cache_ra(), but it might do the same check in it again.
> What do you think?

page_cache_ra_unbounded() is basically a quirk for how fs-verity is implemented
in ext4 and f2fs.  I don't think people would be happy if it's used in other
cases, where it's not needed.  Checking against i_size multiple times is fine.

> 
> I could add some description about these in
> Documentation/filesystems/f2fs.rst and I implemented tests internally.

Documentation in f2fs.rst sounds good.  All the f2fs ioctls should be
documented there.

The tests should be runnable by any kernel developer; "internal" tests aren't
very useful.  Could you add tests to xfstests?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
