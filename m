Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA74C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Feb 2022 11:22:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nOe75-0008Cv-Ab; Mon, 28 Feb 2022 11:22:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <asmadeus@codewreck.org>)
 id 1nOe74-0008Bs-4a; Mon, 28 Feb 2022 11:22:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nbIjFrzgDVTmB4SrJnZGd7fIFmdwChwe2lL83Uag4us=; b=h8/DKw7aHHlS8pyZHNrjqIbn9/
 yb2baDJJmIDCMqZaqHphleZJaDi2aTlfIWFbfnSkcr2mXHGqu1WYhjXQyxK9a1AVZeatLsdpXqG2X
 Y7mYwhnmzxeuSiYog4GLwLuIZnduQFS6p9WZqOZ0bdF4hiPJjcA79oUrPrBBFFeJxZa4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nbIjFrzgDVTmB4SrJnZGd7fIFmdwChwe2lL83Uag4us=; b=PtH8wZELmOLsPQKPtFx6mzPceg
 oOP/0Je2BnWDBJTzpw3nqk6y62Bub519li4xBqeciEg+fYImUgC/ThT+Vdr4hy1KjgYq4xz9HUdHR
 EWkams/UmS7vslHe+FWTY2uLUAnjoFDkwpH4haExGlaqc8AEcLx9WGsz1o5iQbOQ2OzM=;
Received: from nautica.notk.org ([91.121.71.147])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nOe6z-0008Gl-PZ; Mon, 28 Feb 2022 11:22:43 +0000
Received: by nautica.notk.org (Postfix, from userid 108)
 id 69D16C01A; Mon, 28 Feb 2022 12:22:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
 t=1646047355; bh=nbIjFrzgDVTmB4SrJnZGd7fIFmdwChwe2lL83Uag4us=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RT/IL34ZMb4wE13ecGpP0cPYfvUALLBHI3h+Nwqjk6un5A9pkdgT4k1/FqMlC2j9j
 5rXnbfX9CeRpV2BF45XH/gyMBAIlLBsJthcQL9g53J0izMt9+z9BAyzbfmHq+6LfSX
 iY61zvlTrG45WH2waKu+VWh33WBy571UkxI0mCXre32lMHSogGum3oUpiCiQjYBFm0
 UrVmOxcDfy2+XRbr8yw+xW4xvsCb62na1mVOfycyKoB6ejlKrB2T4jQrMTugRWsRaP
 9QmdpahZrSpqJLY1nBe2woUd/0EuRh0B46d3WvFe6/e41bNLFb+98ZtIxTmDiQp/ER
 KjOOwgzjanHhA==
Received: from odin.codewreck.org (localhost [127.0.0.1])
 by nautica.notk.org (Postfix) with ESMTPS id 6162EC009;
 Mon, 28 Feb 2022 12:22:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
 t=1646047353; bh=nbIjFrzgDVTmB4SrJnZGd7fIFmdwChwe2lL83Uag4us=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E7ShsxTdVoGEbpDYFF27HXnsiskOzo+90fWYK/YK/pcgewcio/aI2ukKBbk8Ggf8c
 PSXNNRohBAnroHDgJmzD26WOCBS51v3CgaeWJoVRlz3gzi1Wk2c722FgVeG9ZC8Gq1
 VxeMBZJsJJ2s49Z0zkRuzCFT0FdEMmJ4Jlg8so5xUNkI1Pmhr9T77hNpqbhc5MUSIm
 Vf9CZqLUP+U5LMthWxqmxcIfa+qcI6C/HHTtBGWVbD6UPJLDQeI2MK30nqaJN3mP3G
 MxeZ4iTWnejwYcukxHfaPz9ZlYf9Zxp1r7k3O+mRBYZR8EPZsNImCl3hToWu78+1r5
 3QpJ5t/64l3TQ==
Received: from localhost (odin.codewreck.org [local])
 by odin.codewreck.org (OpenSMTPD) with ESMTPA id 8186bc45;
 Mon, 28 Feb 2022 11:22:16 +0000 (UTC)
Date: Mon, 28 Feb 2022 20:22:01 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jakob Koschel <jakobkoschel@gmail.com>
Message-ID: <YhywWTEIY7UnCYtL@codewreck.org>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-7-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220228110822.491923-7-jakobkoschel@gmail.com>
X-Headers-End: 1nOe6z-0008Gl-PZ
Subject: Re: [f2fs-dev] [PATCH 6/6] treewide: remove check of list iterator
 against head past the loop body
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
Cc: alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-iio@vger.kernel.org,
 nouveau@lists.freedesktop.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 dri-devel@lists.freedesktop.org, Cristiano Giuffrida <c.giuffrida@vu.nl>,
 amd-gfx@lists.freedesktop.org, samba-technical@lists.samba.org,
 linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
 linux-arch <linux-arch@vger.kernel.org>, linux-cifs@vger.kernel.org,
 kvm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
 Jason Gunthorpe <jgg@ziepe.ca>, intel-wired-lan@lists.osuosl.org,
 kgdb-bugreport@lists.sourceforge.net, bcm-kernel-feedback-list@broadcom.com,
 Dan Carpenter <dan.carpenter@oracle.com>, linux-media@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, Arnd Bergman <arnd@arndb.de>,
 linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 v9fs-developer@lists.sourceforge.net, linux-tegra@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-sgx@vger.kernel.org,
 linux-block@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 tipc-discussion@lists.sourceforge.net, linux-crypto@vger.kernel.org,
 netdev@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This is a bit more work (and a lot more noise), but I'd prefer if
this were split into as many patches as there are components.

I'm not going to review the parts of the patches that don't concern me,
and if something turns out to be a problem later one (it shouldn't but
one never knows) it'll be much easier to revert or put the blame on an
individual smaller commit than on this...

With that being said, ultimately I don't care that much and will leave
that to people who do :)

Jakob Koschel wrote on Mon, Feb 28, 2022 at 12:08:22PM +0100:
>  net/9p/trans_xen.c                            | 11 +++--

This 9p change looks good to me.

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org> # 9p

-- 
Dominique


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
