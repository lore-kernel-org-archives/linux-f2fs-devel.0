Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED96C3DA49
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jul 2024 18:09:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sXPNX-0000Ba-DA;
	Fri, 26 Jul 2024 18:09:19 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e745cedb76d36d7a47d5+7642+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1sXPNU-0000BG-TC for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jul 2024 18:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Y+bBdbxxKC2hf51b7J1S8qThB2b/5XgdfKw1OYTUmk=; b=cPX1L55jpbYZdGLaj8cMRYUQZS
 JM8CqPhyxCqBTM7XUq84jT46gxRHNEAFl4KgKgyC5bpVOHNh7BYHxpxnmnRv+jIU/+t3TfqY0LPbC
 5SU6lv9FaCFs9eKOe49GWghIdZEdPgWPq3el7tZo00nFo2iuk/VYjsX68qGAm7k/aZZ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5Y+bBdbxxKC2hf51b7J1S8qThB2b/5XgdfKw1OYTUmk=; b=UIOZN4lGs4VRx2zjotkG1gcgxX
 4oReedzAVMNCG41k1RVwZRQqtXJ1M6ZGOIJ8epqtgLNRtUa09OcPbMfDQ9gmaopfHS+qdGS3HohXd
 DiqUzUvP53isUdDBuZ7DJ58X/3VCQKzbA+P2Wg9NX4p5HvfXgyYPnqIao0bPQhO2lFLg=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sXPNU-0006D8-6i for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jul 2024 18:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5Y+bBdbxxKC2hf51b7J1S8qThB2b/5XgdfKw1OYTUmk=; b=oArlGx+Huj22K57mLVmHcbr0Xl
 MiQWzuEi4Bl7fRZsVt+B9ZKIiRlk60bv4A1VwbYD2R+Rij6yZOAmguXQjSY/MHCs+c5GLg+B3THb3
 3L32kWuUMtGuW5OmDt0vugl+4K77MJTbYl21N3h8WQHlnLaDt19jUm/cZTwsI/giT5Mdk2ZVaQSEi
 dAPaioHkwR/mfs6CveVJ30rbYPtXcU+9XwlzNWTKLLmrSaqNALfDlg5Bho5b/WSTNBGtSdnkr8Fxd
 Kg9ecy0O4QzGYhFP4PuJgMaBPF/t2ijbsQYxLefX5IusHSMB6Z92ApoMggnQ+t2OmX4XcWnwFI/4X
 MPHP0EfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1sXPNG-00000004cOz-4BYF;
 Fri, 26 Jul 2024 18:09:02 +0000
Date: Fri, 26 Jul 2024 11:09:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Message-ID: <ZqPmPufwqbGOTyGI@infradead.org>
References: <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
 <ZqJjsg3s7H5cTWlT@infradead.org>
 <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
 <ZqJwa2-SsIf0aA_l@infradead.org>
 <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
 <ZqOs84hdYkSV_YWd@infradead.org>
 <20240726152237.GH17473@twin.jikos.cz>
 <20240726175800.GC131596@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240726175800.GC131596@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1sXPNU-0006D8-6i
Subject: Re: [f2fs-dev] [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 Youling Tang <tangyouling@kylinos.cn>, linux-f2fs-devel@lists.sourceforge.net,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 kreijack@inwind.it, David Sterba <dsterba@suse.cz>,
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@infradead.org>,
 Chris Mason <clm@fb.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-btrfs@vger.kernel.org,
 Youling Tang <youling.tang@linux.dev>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 26, 2024 at 01:58:00PM -0400, Theodore Ts'o wrote:
> Yeah, that's my reaction as well.  This only saves 50 lines of code in
> ext4, and that includes unrelated changes such as getting rid of "int
> i" and putting the declaration into the for loop --- "for (int i =
> ...").  Sure, that saves two lines of code, but yay?
> 
> If the ordering how the functions gets called is based on the magic
> ordering in the Makefile, I'm not sure this actually makes the code
> clearer, more robust, and easier to maintain for the long term.

So you two object to kernel initcalls for the same reason and would
rather go back to calling everything explicitly?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
