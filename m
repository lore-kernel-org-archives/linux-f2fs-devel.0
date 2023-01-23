Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA8BC05027
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Jan 2023 10:01:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pJte2-0003rX-51;
	Mon, 23 Jan 2023 10:01:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <glider@google.com>) id 1pJtdx-0003rQ-5w
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Jan 2023 10:01:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kF1LzxMibzarj0qOT+2x1suBEvLt2gV5iFkGqZc0IcU=; b=QOcsZgMFy/Q+JpUBcCCqMA05vu
 fp2fhEQX2JKpR6WdmgbX/CvtcFwltvKBGadCMQ53AUH6EKPcKXlO5HeWPOR2PCtfPoy/DMNWc6uKp
 Hj2gIS46W5TT6JDr0fyl3GchwR9LtyFe/LqV2R6zb9eXMR/SqOWiP7sUMTTkhIjb93lU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kF1LzxMibzarj0qOT+2x1suBEvLt2gV5iFkGqZc0IcU=; b=M5PBI5njD3AwACxCvc/vbzOwQ/
 TcMsOAncgOGWHEZb6tqN6qkZIujN7QgueXjOobQMmFlqc7TPVdiTS/LQOCYTfOJCkMk6woidaRfjU
 lj/A56Mf35rs1ylMF5js/KYD8SKBDn76Y74VL/zERporhUyGTuqB+kYLRKlcv6yabpFQ=;
Received: from mail-qt1-f179.google.com ([209.85.160.179])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pJtdv-00DCYw-4P for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Jan 2023 10:01:35 +0000
Received: by mail-qt1-f179.google.com with SMTP id j9so9254048qtv.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Jan 2023 02:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kF1LzxMibzarj0qOT+2x1suBEvLt2gV5iFkGqZc0IcU=;
 b=aODwONGw56OR7MEKA9tfyrteZM5lX/tEWnvjuEvBdCs68sJnW+8BxRffETOe/V4oLh
 3/ckkFlKt+uZ1DhAAOM00770klu640X3W8WOE4nAhkxfxezSFlPh3GxGbgfTsrKvVzeQ
 S14UQqdolgSI6trhpzVAGtYeKHSMIxTkp+HhXnNQ/gdyluhQYzc7hMxZAvLXtaAxf8iN
 PxEEvRXpEw6KB/5sXWLJgkFZZaVURmPbM4CZQ5dxWUACr9b3F/IlQggNroLpm5URfEfY
 do7uQLus7UzVZ9ZNFLsqKWQ2Xqerd8cvKylkQBe1TkOJVzAt2qoylXTBpVWksOfXzjoq
 uMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kF1LzxMibzarj0qOT+2x1suBEvLt2gV5iFkGqZc0IcU=;
 b=Rt6QodVFds+vVP8ZApVBoiswemVoB2kcLSUe1IOsxrxi0pIOJaHBvfRfsgPDLHrJNi
 9egqfO/h1gvpykbsrUmWndiFY8MjkSdUlZQbK4MppWywcITbfrHlYnx/b2fDvM39hCaV
 q+5BYaKtTfiftJ+D62+fHNcmM6+RhqU9KARzdhqsbI9KErtZSmerMI3rgB3xxCO2u+Ns
 EiQbKzlzWVAKb4a9RmdY9TXH8F/FRo9+l1Acqn4m6i0wyzt4GuZLnKC6ferHl9zE492u
 rubsUQ1vX4woxXQ8nHijyXkoJmniykG6okwDOYi0/NgPuA/hXP4irETP5LsXMBESFRt+
 dwzw==
X-Gm-Message-State: AFqh2kpc80ImlliTgT8EDF3s1Ujw/zWogsfWeEd86p8XN5yfWjuOOek5
 0Uo1FSb3ykQhjWB6BQ2+n/RPW1yL6irH6yZKh8TmlinhsLrO60Aw
X-Google-Smtp-Source: AMrXdXt2STLbSQ8wjfk7JX7AhPTudhsedLDcfWFEyy72Q7LGj3Vt5fSEPI02KOgjjOx4W+LQe+pUNemBf+kQCLXdjNI=
X-Received: by 2002:a05:6638:279b:b0:3a5:93e:989a with SMTP id
 dl27-20020a056638279b00b003a5093e989amr2274341jab.319.1674464340454; Mon, 23
 Jan 2023 00:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20230123070414.138052-1-ebiggers@kernel.org>
In-Reply-To: <20230123070414.138052-1-ebiggers@kernel.org>
Date: Mon, 23 Jan 2023 09:58:22 +0100
Message-ID: <CAG_fn=VNjkRMozdcQUSMTHvMQ26SG45oisxamJbEVrg2m41ngg@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1pJtdv-00DCYw-4P
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix information leak in
 f2fs_move_inline_dirents()
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
From: Alexander Potapenko via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Alexander Potapenko <glider@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 23, 2023 at 8:05 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> When converting an inline directory to a regular one, f2fs is leaking
> uninitialized memory to disk because it doesn't initialize the entire
> directory block.  Fix this by zero-initializing the block.
>
> This bug was introduced by commit 4ec17d688d74 ("f2fs: avoid unneeded
> initializing when converting inline dentry"), which didn't consider the
> security implications of leaking uninitialized memory to disk.
>
> This was found by running xfstest generic/435 on a KMSAN-enabled kernel.

Out of curiosity, did you add any extra annotations to detect uninit
writes to the disk?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
