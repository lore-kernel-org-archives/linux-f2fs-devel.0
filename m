Return-Path: <SRS0=Ehfl=YZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8070CA9ECF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Nov 2019 20:57:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72639217D9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Nov 2019 20:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Dxvs8r/H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SZvwiXLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72639217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iQdzS-00068s-P1; Fri, 01 Nov 2019 20:57:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1iQdzS-00068m-0G
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Nov 2019 20:57:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B2Wo++qvCAWopO2MVN1SxMuOaw9O5ooxGYbXrtTGoLc=; b=Dxvs8r/Ht7csxHNiFS+QVsrU/X
 qUlWfCmt9z67404bpLAnl2dAOKI2WDVaceVmU5Q+jvLLpMvUBBqOm8KIkd5OlFNkvEp9K6LYWYPY8
 Oy10zxEybe0ua4lA3DX+2Q95ZVoK6K1idf9YeSUI7oPH8XvimbU0pAqr44wAljRb4zL4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B2Wo++qvCAWopO2MVN1SxMuOaw9O5ooxGYbXrtTGoLc=; b=SZvwiXLODiQT1RUIsQpFHUQWvJ
 JfVXAXjl/NxyEjknUdPKMCIG5N1+djqjn42v5hJU1k7jfKwEaa6jY8CoWW12u9EUcvhAFIs9oQNkA
 I8QGlB6M6Py4KmVcWJNY7PTE4XwPXTwLAj0wU2xXdEwSO4lvR0dGdJdXNBUMZTuH6bak=;
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1iQdzQ-00D8U6-ID
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Nov 2019 20:57:49 +0000
Received: by mail-oi1-f194.google.com with SMTP id r27so9294664oij.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 01 Nov 2019 13:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B2Wo++qvCAWopO2MVN1SxMuOaw9O5ooxGYbXrtTGoLc=;
 b=KZhfPv4W/1/1QVZT+ysHXDCRkzpDTMdRZlF0CD/Nz+rzaC1mGZ303moBebEpBgYvLx
 ENj6NcAQv/sjCv5/pLMMzejrig4BfXbsFFhdlkM9M7hOrgiCCKm0e2JjRZXv75lo45AI
 pYbmrzSDO/4roq473IGmVPsbfN2ISRi9fnpLhXT/ng47w81H/bMtu3GFds1QgehBt6Sd
 CSfs+RChJl66qR3E5TjPFVpAEYI+uv7WPpBT7xre0DnXzL/YnzHLZutfVT1lk7jQwBfB
 xDoSJrBtH73xNdOsaRV0429kZzu1lxLTYk/P4RRU62aadNPB4PNFvtz0JIQDfJGZhIx+
 2eDQ==
X-Gm-Message-State: APjAAAWDQ4ULUem0x8yWyRpiwcK02U3F0pUPmpkhoiawGFeWTUrtgu8W
 luS1UWuuPrMdI5gqIDZyjJMvMFi919bbrdTvtbM=
X-Google-Smtp-Source: APXvYqyMPGVgSghm8B6Z8BliWMbf63SJMtQqkLmxrpCWnOLjhSTH18y22Nnv6Mk4zTGM1EgQgPb5eF27WcBVRETo4XE=
X-Received: by 2002:a05:6808:60a:: with SMTP id
 y10mr3730740oih.102.1572641862721; 
 Fri, 01 Nov 2019 13:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
In-Reply-To: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Nov 2019 21:57:31 +0100
Message-ID: <CAMuHMdXzyVBa4TZEc5eRaBzu50thgJ2TrHJLZqwhbQ=JASgWOA@mail.gmail.com>
To: Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Headers-End: 1iQdzQ-00D8U6-ID
Subject: Re: [f2fs-dev] [RFC] errno.h: Provide EFSCORRUPTED for everybody
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
Cc: driverdevel <devel@driverdev.osuosl.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, "Darrick J. Wong" <darrick.wong@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Gao Xiang <xiang@kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Valdis,

On Thu, Oct 31, 2019 at 2:11 AM Valdis Kletnieks
<valdis.kletnieks@vt.edu> wrote:
> Three questions: (a) ACK/NAK on this patch, (b) should it be all in one
> patch, or one to add to errno.h and 6 patches for 6 filesystems?), and
> (c) if one patch, who gets to shepherd it through?
>
> There's currently 6 filesystems that have the same #define. Move it
> into errno.h so it's defined in just one place.
>
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>

Thanks for your patch!

> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -98,6 +98,7 @@
>  #define        EINPROGRESS     115     /* Operation now in progress */
>  #define        ESTALE          116     /* Stale file handle */
>  #define        EUCLEAN         117     /* Structure needs cleaning */
> +#define        EFSCORRUPTED    EUCLEAN

I have two questions:
a) Why not use EUCLEAN everywhere instead?
    Having two different names for the same errno complicates grepping.
b) Perhaps both errors should use different values? Do they have the
   same semantics? I'm not a fs developer, so this is a bit fuzzy to me.
   According to Documentation/, one seems to originate in mtd, the
   other in xfs.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
