Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C33CD4851
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 21:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KOB+eR/0ZsdYy2Kyw3R3iGwjMjHSwHcpq0qCG5lRPig=; b=k5Ga5L+p4Nrcnhu+XSBC+33Cjk
	xaBOX8tHG0KVDStK5fJo9dmplbUgVJdhub1mhPZoUsL9hy5eodGGAtLPFpXXeJEeiCOBPRQVQ5zbd
	qd4NgNcEaWrUZJ4GxBZbqwApL4o8rvOOmCOmpVbJQp5pJ28Snn54KaPSwq5pp6z0ev+o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wO0YE-0008RI-W3;
	Fri, 15 May 2026 21:58:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chrisl@kernel.org>) id 1wO0YB-0008RB-JE
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 21:58:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/mHSzbEHbunn4Gv+x6uYZkpcvkpdkTON/QAE5a6at5M=; b=clOPuXXvfh7l3yUR0yjmY3U8vV
 zQo+imRiaQQb9B7cK9Q4NKwVh/mU0E8gFRmseW/3JAJuLyIM9716/j5mofE4kCpjUEcf/2zwnh9ty
 +zqXuE7JbHFEnCQRluyHRiO/abQWupS9XicmSsMvGLEZ26gxjuREyxagjH/65Ma/QQxY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/mHSzbEHbunn4Gv+x6uYZkpcvkpdkTON/QAE5a6at5M=; b=N+5hrZlnBc+7y1uWqvT5lmU5EW
 t0CrHgmXkUMwtofhwlgd4PgPHKuaP2CMS0Z6DntzGdgzW2CiE6k+WDtP9W9giAXnnUVbHMeT00EVY
 dyPiRgh4cOJ3HE0KqMsPHE0ZtHeooywI7NEIkrMmBhuRho9DH9yXVP2IWUyPCaKxuMNI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wO0Y8-00026c-Gx for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 21:58:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A5EA8445DA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 21:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FFFC2BCC9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 21:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778882298;
 bh=/mHSzbEHbunn4Gv+x6uYZkpcvkpdkTON/QAE5a6at5M=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YrySnH00B0W1qq5Wp87dlgYi2suFfNd57N2Uuth/vkCX1DrZ3IvFyxISLW0xoIF69
 hRjENHlGB/3ONaZlglJOc4ukuB0ctST7O4dj+rUVrdlnm1YanBPd1V+Bn1UhoHLW4E
 JXQ/kS1/ER7ObuNKR8I2hcUCtTBptWdMJXaZCExsraRoFD2Gyjk7NySzzJmUpzQ5cR
 j5a0wZY7iA7GqaZgUjtc+Taku3bBD9oUOyoWapVjk+PBcCyiTk7K5qE2vYSk/R3eiH
 nSUWFrQFAEnpEsEBNYMpxB2+u1QHKALgTRITtHr4Lpl3a/9KiTwUTCsF3mm9EJCbKa
 NZO40x8BvCEDg==
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-65c364b893aso670524d50.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 14:58:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+CUVGTIBGsm9R67Og2udJhkw/Hnr8UxrUIKOhGQQNhkBtyOTWlO96QTMNFXGUAOfEZOlMm0gCmUhEi/ruxaS1F@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzLYVD9ymGQZAMsowQqGBbb2HAFGOhLE0+cJpg3/RgEtMzH+CiC
 Z1/rie1bOoXg0w5sFZFrp7pJ76aYSRRc6n/4WslWnucnc8U/ircc8ZMd+lLc6Uxp0XxT97kdxrG
 g48aXGQzDswtTb6duJsTN++c+0H3LSNkai2u45OT7Wg==
X-Received: by 2002:a05:690e:1517:b0:65d:f308:b503 with SMTP id
 956f58d0204a3-65e22650c4amr5634144d50.1.1778882297534; Fri, 15 May 2026
 14:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-13-hch@lst.de>
In-Reply-To: <20260512053625.2950900-13-hch@lst.de>
Date: Fri, 15 May 2026 14:58:06 -0700
X-Gmail-Original-Message-ID: <CACePvbXhMm0nzXdTqbF5j57AC_7qOH-hMZ5pB6z0cZFfAixH5Q@mail.gmail.com>
X-Gm-Features: AVHnY4L_tQU_kPqgc-BeGp-d2068VNSoZvM02GkthxouKCr7BEGYMQdDLNaKcrQ
Message-ID: <CACePvbXhMm0nzXdTqbF5j57AC_7qOH-hMZ5pB6z0cZFfAixH5Q@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1wO0Y8-00026c-Gx
Subject: Re: [f2fs-dev] [PATCH 12/12] swap: move swap_info_struct to
 mm/swap.h
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
From: Chris Li via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chris Li <chrisl@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Kairui Song <kasong@tencent.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 linux-btrfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBNYXkgMTEsIDIwMjYgYXQgMTA6MzjigK9QTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4gd3JvdGU6Cj4KPiBzd2FwX2luZm9fc3RydWN0IGlzIG5vdyBpbnRlcm5hbCB0byB0
aGUgTU0gc3Vic3lzdGVtLCBzbyByZW1vdmUgaXQgZnJvbQo+IHRoZSBwdWJsaWMgaGVhZGVyLgo+
Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CgpBY2tlZC1i
eTogQ2hyaXMgTGkgPGNocmlzbEBrZXJuZWwub3JnPgoKQ2hyaXMKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
