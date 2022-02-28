Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7DBC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Feb 2022 05:06:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nOYFH-0001UT-Td; Mon, 28 Feb 2022 05:06:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <akpm@linux-foundation.org>) id 1nOYFF-0001UI-Lt
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Feb 2022 05:06:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version
 :References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RO9dG8LvMdvB82bYxrCXTTwxd8wTKZ0nP9GBhKtJKXU=; b=kmX9csweMsi94KESdl/Gb8NrJv
 RI3Q8f8vYdcHWJfdPdE3DihZCYstILPeAxMvDnNNdCO2cQUJURKCdbrnx++Db6ExzV9ODm8nASFxE
 85axCL5IfaedklsrbMeLtwtYD/fjIQ/uhV4g/ol9GxqaKQRrd9b2VsA/MvzOI2Aw1Pf8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RO9dG8LvMdvB82bYxrCXTTwxd8wTKZ0nP9GBhKtJKXU=; b=FlC3as2Gmw5InQG1OrAjDMmN6B
 cXE0gHvXkOrN1aJcQ7aoHvKz5+k9GG3TJ7ECSjT1/s9WR79+NlOhI2CQzg2EBsxndqkoxashFB0ht
 YiePp+yC+IAEetTNQksjP+/Q79AtknQO4e4GOpccPTRvxBq0HJlNiIMENBUx6R7tAdz4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nOYFA-00HNDA-8Q
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Feb 2022 05:06:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6E6CC60748;
 Mon, 28 Feb 2022 04:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FC0C340E7;
 Mon, 28 Feb 2022 04:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1646023649;
 bh=G8sG7lhMtemU8UaIfAlQyFfdM52xrPiAjoIoRCmr5pk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oGPNq6p6XPM77SHgO9aQqRI1rnuXHCc+59DXZQ1WNrGmN3OQd6S99TorBGhKumdok
 /al88n7DG2J8BkHYEPTcnC3PkoeWXPmOgtseuFvQx3PRiJwblKmCI9fhBlhdsjcaOW
 hLr6Rg6R30jUXs/Md/sM9bDGeMUMnt9uzXly3vn0=
Date: Sun, 27 Feb 2022 20:47:28 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "NeilBrown" <neilb@suse.de>
Message-Id: <20220227204728.b2eb5dd94ecc3e86912bacad@linux-foundation.org>
In-Reply-To: <164602251992.20161.9146570952337454229@noble.neil.brown.name>
References: <164447124918.23354.17858831070003318849.stgit@noble.brown>
 <164447147257.23354.2801426518649016278.stgit@noble.brown>
 <20220210122440.vqth5mwsqtv6vjpq@quack3.lan>
 <164453611721.27779.1299851963795418722@noble.neil.brown.name>
 <20220224182622.n7abfey3asszyq3x@quack3.lan>
 <164602251992.20161.9146570952337454229@noble.neil.brown.name>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-Headers-End: 1nOYFA-00HNDA-8Q
Subject: Re: [f2fs-dev] [PATCH 02/11] MM: document and polish read-ahead
 code.
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
Cc: Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, drbd-dev@lists.linbit.com,
 Paolo Valente <paolo.valente@linaro.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nilfs@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, 28 Feb 2022 15:28:39 +1100 "NeilBrown" <neilb@suse.de> wrote:

> When writing documentation the intent of the author is of some interest,
> but the behaviour of the code is paramount.

uh, er, ah, no.  The code describes the behaviour of the code.  The
comments are there to describe things other than the code's behaviour.
Things such as the author's intent.

Any deviation between the author's intent and the code's behaviour is
called a "bug", so it's pretty important to understand authorial
intent, no?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
